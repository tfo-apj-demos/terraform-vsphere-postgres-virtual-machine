terraform {
  required_providers {
    vsphere = {
      source  = "hashicorp/vsphere"
      version = "~> 2"
    }
    hcp = {
      source  = "hashicorp/hcp"
      version = "~> 0"
    }
  }
}