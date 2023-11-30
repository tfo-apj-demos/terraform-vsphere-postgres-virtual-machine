terraform {
  required_providers {
    boundary = {
      source  = "hashicorp/boundary"
      version = "1.1.10"
    }
  }
}

provider "boundary" {
  addr = var.boundary_addr
}

variable "boundary_addr" {
  type = string
}

variable "scope_id" {
  type        = string
  description = "The scope ID for the Boundary resources"
}

variable "credential_library_id" {
  type        = string
  description = "The ID of the credential library for injected application credentials"
}

resource "boundary_host_catalog_static" "this" {
  name        = "gcve"
  scope_id    = var.scope_id
  description = "Workloads Provisioned in the GCVE Environment"
}

resource "boundary_host_static" "this" {
  type            = "static"
  name            = module.postgres-virtual-machine.virtual_machine_name
  host_catalog_id = boundary_host_catalog_static.this.id
  address         = module.postgres-virtual-machine.ip_address
}

resource "boundary_host_set_static" "this" {
  type            = "static"
  name            = "my_host_set"
  host_catalog_id = boundary_host_catalog_static.this.id

  host_ids = [
    boundary_host_static.this.id,
  ]
}

resource "boundary_target" "ssh_this" {
  name         = "ssh_${module.postgres-virtual-machine.virtual_machine_name}"
  type         = "ssh"
  default_port = "22"
  scope_id     = var.scope_id
  host_source_ids = [
    boundary_host_set_static.this.id
  ]
  injected_application_credential_source_ids = [
    var.credential_library_id
  ]
  ingress_worker_filter = "\"vmware\" in \"/tags/platform\""
}

output "ssh_target_id" {
  value       = boundary_target.ssh_this.id
  description = "The ID of the SSH target in Boundary"
}