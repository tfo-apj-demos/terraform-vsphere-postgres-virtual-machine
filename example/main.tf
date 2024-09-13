module "postgres-vm" {
  source  = "app.terraform.io/tfo-apj-demos/postgres-virtual-machine/vsphere"
  version = "~> 1"

  hostname         = "aaron-db-demo"
  backup_policy    = "daily"
  environment      = "prod"
  site             = "canberra"
  size             = "large"
  storage_profile  = "performance"
  tier             = "gold"
  database_profile = "public-access"
}

# --- Add to DNS
module "dns" {
  source  = "app.terraform.io/tfo-apj-demos/domain-name-system-management/dns"
  version = "~> 1.0"

  a_records = [
    {
      name = module.postgres-vm.virtual_machine_name
      addresses = [
        module.postgres-vm.ip_address
      ]
    }
  ]
}

module "database_secrets" {
  source = "github.com/tfo-apj-demos/terraform-vault-postgres-connection?ref=0.0.2"

  vault_mount_postgres_path = "postgres"
  database_connection_name  = "${var.TFC_WORKSPACE_ID}-postgres"

  database_addresses = [module.postgres-vm.ip_address]
  database_username  = "vault"
  database_password  = "supersecret"
  database_name      = "postgres"
  database_roles = [
    {
      name = "${var.TFC_WORKSPACE_ID}-read"
      creation_statements = [
        "CREATE ROLE \"{{name}}\" WITH LOGIN PASSWORD '{{password}}' VALID UNTIL '{{expiration}}'; GRANT SELECT ON ALL TABLES IN SCHEMA public TO \"{{name}}\";"
      ]
    }
  ]
}

# --- Create Boundary targets for the postgres nodes
module "boundary_target" {
  source  = "app.terraform.io/tfo-apj-demos/target/boundary"
  version = "1.5.7"

  project_name           = "CloudbrokerAz"
  hostname_prefix        = "On-Prem Postgres Database"
  credential_store_token = module.database_secrets.token
  vault_address          = "https://vault.hashicorp.local:8200"

  hosts = [{
    "hostname" = module.postgres-vm.virtual_machine_name,
    "address"  = module.postgres-vm.ip_address
  }]

  services = [{
    name             = "postgres",
    type             = "tcp",
    port             = "5432",
    credential_paths = module.database_secrets.credential_paths
  }]
}
