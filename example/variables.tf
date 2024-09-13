variable "TFC_WORKSPACE_ID" {}
variable "boundary_address" {}
variable "boundary_token" {}

variable "hostname" {
  description = "The hostname of the PostgreSQL virtual machine."
  type        = string
}

variable "backup_policy" {
  description = "The backup policy for the virtual machine (e.g., daily, weekly)."
  type        = string
}

variable "environment" {
  description = "The deployment environment (e.g., dev, test, prod)."
  type        = string
}

variable "site" {
  description = "The site location for the virtual machine (e.g., canberra)."
  type        = string
}

variable "size" {
  description = "The size specification of the virtual machine (e.g., small, medium, large)."
  type        = string
}

variable "storage_profile" {
  description = "The storage profile type (e.g., performance, standard)."
  type        = string
}

variable "tier" {
  description = "The service tier level (e.g., gold, silver, bronze)."
  type        = string
}

variable "database_profile" {
  description = "The database profile settings (e.g., public-access, private-access)."
  type        = string
}
