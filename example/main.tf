terraform {
  cloud {
    organization = "tfo-apj-demos"

    workspaces {
      project = "aaron-dev"
      name = "my-first-vm"
    }
  }
}
module "postgres-virtual-machine" {
  source  = "app.terraform.io/tfo-apj-demos/postgres-virtual-machine/vsphere"
  version = "~> 1"

  backup_policy    = "daily"
  environment      = "dev"
  site             = "sydney"
  size             = "medium"
  storage_profile  = "standard"
  tier             = "gold"
}

output "vm_name" {
    value = module.single-virtual-machine.virtual_machine_name
}