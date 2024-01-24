terraform {
  cloud {
    organization = "tfo-apj-demos"

    workspaces {
      project = "20 - gcve-demo-workloads"
      name    = "my-first-vsphere-db"
    }
  }
}

module "postgres-virtual-machine" { 
  source = "app.terraform.io/tfo-apj-demos/postgres-virtual-machine/vsphere"
  version = "~> 1"
  
  backup_policy    = "daily"
  environment      = "prod"
  site             = "canberra"
  size             = "large"
  storage_profile  = "performance"
  tier             = "gold"
  database_profile = "public-access"
}

output "name" {
  value = module.postgres-virtual-machine.virtual_machine_name
}

output "virtual_machine_details" {
  value = module.postgres-virtual-machine.virtual_machine_details
}

/*module "domain-name-system-management" {
  source  = "app.terraform.io/tfo-apj-demos/domain-name-system-management/dns"
  version = "~> 1.0"

  a_records = [{
    name      = module.postgres-virtual-machine.virtual_machine_name
    addresses = [module.postgres-virtual-machine.ip_address]
  }]
  a_records = [ for vm in module.postgres-virtual-machine.virtual_machine: {
    "name" = vm.virtual_machine_name
    "addresses" = [vm.ip_address]
  }]
}*/


/*
variable "boundary_address" {
  type = string
}
variable "boundary_token" {
  type = string
}

provider "boundary" {
  addr = var.boundary_address
  token = var.boundary_token
}

module "boundary_target" {
  source  = "app.terraform.io/tfo-apj-demos/target/boundary"
  version = "~> 0.0"

   hosts = [ for vm in module.postgres-virtual-machine.virtual_machine_details : {
    "hostname" = vm.virtual_machine_name
    "address" = vm.ip_address
  }]

  services = [
    { 
      name = "postgresql",
      type = "tcp",
      port = "5432"
    }
  ]
  project_name = "grantorchard"
  host_catalog_id = "hcst_7B2FWBRqb0"
  hostname_prefix = "postgres-access"
  injected_credential_library_ids = []
}*/