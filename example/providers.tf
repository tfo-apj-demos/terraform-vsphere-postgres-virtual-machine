terraform {
  cloud {
    organization = "tfo-apj-demos"

    workspaces {
      project = "20 - gcve-demo-workloads"
      name    = "on-prem-postgres"
    }
  }
  required_providers {
    nsxt = {
      source  = "vmware/nsxt"
      version = "~> 3.4"
    }
    vsphere = {
      source  = "hashicorp/vsphere"
      version = "~> 2"
    }
    boundary = {
      source  = "hashicorp/boundary"
      version = "~> 1"
    }
    dns = {
      source  = "hashicorp/dns"
      version = "~> 3.3"
    }
    vault = {
      source  = "hashicorp/vault"
      version = "~> 3"
    }
  }
}

provider "boundary" {
  addr  = var.boundary_address
  token = var.boundary_token
}

provider "dns" {
  update {
    gssapi {}
  }
}

data "tfe_outputs" "this" {
  organization = "tfo-apj-demos"
  workspace    = "vsphere-vault-config"
}