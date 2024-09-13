data "hcp_packer_artifact" "this" {
  bucket_name  = "postgres-ubuntu-2204"
  channel_name = "latest"
  platform     = "vsphere"
  region       = "Datacenter"
}

locals {
  // T-shirt size mappings for CPU and memory
  sizes = {
    "small"  = { cpu = 1, memory = 1024 }
    "medium" = { cpu = 2, memory = 2048 }
    "large"  = { cpu = 4, memory = 4096 }
  }

  // Environment to cluster mappings
  environments = {
    "dev"  = "cluster"
    "test" = "cluster"
    "prod" = "cluster"
  }

  // Site to datacenter mappings
  sites = {
    "sydney"    = "Datacenter"
    "canberra"  = "Datacenter"
    "melbourne" = "Datacenter"
  }

  // Tier to resource pool mappings
  tiers = {
    "gold"   = "Demo Workload"
    "silver" = "Demo Workload"
    "bronze" = "Demo Workload"
  }

  // Storage profiles to datastore mappings
  storage_profile = {
    "performance" = "vsanDatastore"
    "capacity"    = "vsanDatastore"
    "standard"    = "vsanDatastore"
  }
}