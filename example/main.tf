terraform {
  cloud {
    organization = "tfo-apj-demos"

    workspaces {
      project = "aaron-dev"
      name    = "my-first-vsphere-db"
    }
  }
}
module "postgres-virtual-machine" {
  source  = "app.terraform.io/tfo-apj-demos/postgres-virtual-machine/vsphere"
  version = "~> 1"

  backup_policy    = "daily"
  environment      = "prod"
  site             = "canberra"
  size             = "large"
  storage_profile  = "performance"
  tier             = "gold"
  database_profile = "public-access"
}

output "vm_name" {
  value = module.postgres-virtual-machine.virtual_machine_name
}