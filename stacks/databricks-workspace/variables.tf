//-----------------------------------
// Dependencies
//-----------------------------------
variable "databricks_host" {
  type = string
}

variable "aws_rds_instances" {
  type = map(map(string))
}

//-----------------------------------
// AWS General
//-----------------------------------
variable "environment" {
  type = string
}

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
// Databricks Connections
//-----------------------------------
variable "databricks_connections" {
  type = map(object({
    comment         = string
    connection_type = string
    host            = string
    port            = number
    user            = string
  }))
}
