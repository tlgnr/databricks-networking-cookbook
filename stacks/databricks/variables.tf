//-----------------------------------
// AWS General
//-----------------------------------
variable "region" {
  type = string
}

variable "tags" {
  type = map(string)
}

//-----------------------------------
// Databricks General
//-----------------------------------
variable "databricks_account_id" {
  type = string
}

variable "databricks_client_id" {
  type = string
}

variable "databricks_client_secret" {
  type = string
}

//-----------------------------------
// Databricks Credential Configurations
//-----------------------------------
variable "databricks_credential_configurations" {
  type = map(object({
    credential_name = string
  }))
}