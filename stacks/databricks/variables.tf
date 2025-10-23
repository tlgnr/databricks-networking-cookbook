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
// Dependencies
//-----------------------------------
variable "aws_security_group_ids" {
  type = map(map(string))
}

variable "aws_subnet_ids" {
  type = map(map(string))
}

variable "aws_vpc_endpoint_ids" {
  type = map(map(string))
}

variable "aws_vpc_ids" {
  type = map(map(string))
}

variable "aws_rds_instance_fqdns" {
  type = map(map(string))
}

variable "aws_vpc_endpoint_services" {
  type = map(map(string))
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

//-----------------------------------
// Databricks Storage Configurations
//-----------------------------------
variable "databricks_storage_configurations" {
  type = map(object({
    bucket                     = string
    storage_configuration_name = string
    force_destroy              = bool
  }))
}

//-----------------------------------
// Databricks Network Configurations
//-----------------------------------
variable "databricks_network_configurations" {
  type = map(object({
    security_group_names       = list(string)
    subnet_names               = list(string)
    vpc_endpoint_relay_name    = string
    vpc_endpoint_rest_api_name = string
    vpc_name                   = string
  }))
}

//-----------------------------------
// Databricks Workspace Configurations
//-----------------------------------
variable "databricks_workspace_configurations" {
  type = map(object({
    credential_configuration_name = string
    metastore_name                = string
    network_configuration_name    = string
    pricing_tier                  = string
    private_access_setting_name   = string
    public_access_enabled         = bool
    storage_configuration_name    = string
    workspace_name                = string
  }))
}

//-----------------------------------
// Databricks Metastores
//-----------------------------------
variable "databricks_metastores" {
  type = map(object({
    name                   = string
    force_destroy          = bool
    region                 = string
    owner                  = string
    storage_account_name   = string
    storage_container_name = string
  }))
}

//-----------------------------------
// Databricks NCCs
//-----------------------------------
variable "databricks_ncc_configurations" {
  type = map(object({
    name           = string
    workspace_name = string
  }))
}

//-----------------------------------
// Databricks Groups
//-----------------------------------
variable "databricks_groups" {
  type = map(object({
    display_name            = string
    user_names              = list(string)
    service_principal_names = list(string)
  }))
}

//-----------------------------------
// Databricks Account Level Permission Assignments
//-----------------------------------
variable "databricks_account_level_permission_assignments" {
  type = map(object({
    group_names    = list(string)
    permissions    = list(string)
    workspace_name = string
  }))
}

//-----------------------------------
// Databricks Private Endpoint Rules
//-----------------------------------
variable "databricks_private_endpoint_rules" {
  type = map(object({
    network_connectivity_config_name = string
    resources                        = list(string)
    vpc_endpoint_service_name        = string
  }))
}