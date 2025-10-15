//-----------------------------------
// Databricks Credential Configuration
//-----------------------------------
variable "credential_name" {
  type = string
}

variable "databricks_account_id" {
  type = string
}

variable "region" {
  type = string
}

variable "tags" {
  type = map(string)
}

