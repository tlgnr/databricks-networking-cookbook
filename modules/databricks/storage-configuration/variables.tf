//-----------------------------------
// Databricks Storage Configuration
//-----------------------------------
variable "account_id" {
  type = string
}

variable "storage_configuration_name" {
  type = string
}

//-----------------------------------
// Root Bucket
//-----------------------------------
variable "bucket" {
  type = string
}

variable "force_destroy" {
  type = bool
}

