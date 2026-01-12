//-----------------------------------
// External Location
//-----------------------------------
variable "bucket" {
  type = string
}

variable "databricks_account_id" {
  type = string
}

variable "force_destroy" {
  type = bool
}

variable "metastore_id" {
  type = string
}

variable "policy_name" {
  type = string
}

variable "region" {
  type = string
}

variable "role_name" {
  type = string
}

variable "tags" {
  type = map(string)
}

