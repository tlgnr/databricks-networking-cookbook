//-----------------------------------
// General
//-----------------------------------
variable "environment" {
  type = string
}

variable "tags" {
  type = map(string)
}

//-----------------------------------
// AWS
//-----------------------------------
variable "region" {
  type = string
}

//-----------------------------------
// Azure
//-----------------------------------
variable "location" {
  type = string
}

variable "subscription_id" {
  type = string
}

//-----------------------------------
// Databricks
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