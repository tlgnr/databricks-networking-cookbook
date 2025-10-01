//-----------------------------------
// Databricks Metastore
//-----------------------------------
variable "force_destroy" {
  type = bool
}

variable "name" {
  type = string
}

variable "owner" {
  type    = string
  default = null
}

variable "location" {
  type = string
}

variable "storage_container_name" {
  type    = string
  default = null
}

variable "storage_account_name" {
  type    = string
  default = null
}


