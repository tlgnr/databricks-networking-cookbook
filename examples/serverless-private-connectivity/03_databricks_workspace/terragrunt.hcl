//-----------------------------------
// Terraform
//-----------------------------------
terraform {
  source = "${get_repo_root()}/stacks/databricks"
}

//-----------------------------------
// Root
//-----------------------------------
include "root" {
  path = find_in_parent_folders("root.hcl")
}

//-----------------------------------
// Environment
//-----------------------------------
include "env" {
  path = find_in_parent_folders("env.hcl")
}

//-----------------------------------
// Dependencies
//-----------------------------------
dependency "aws_vpc" {
  config_path = "../00_aws_vpc"
}

dependency "aws_rds" {
  config_path = "../01_aws_rds"
}

//-----------------------------------
// Locals
//-----------------------------------
locals {
  env_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
}

//-----------------------------------
// Inputs
//-----------------------------------
inputs = {
  databricks_account_id    = get_env("DATABRICKS_ACCOUNT_ID")
  databricks_client_id     = get_env("DATABRICKS_CLIENT_ID")
  databricks_client_secret = get_env("DATABRICKS_CLIENT_SECRET")
  databricks_credential_configurations = yamldecode(templatefile("../../../configs/serverless-private-connectivity/databricks/credential-configurations.yaml", {
    environment = local.env_vars.locals.environment
    region      = local.env_vars.locals.region
  }))
  tags = merge(local.env_vars.locals.tags, { Owner = get_env("OWNER", "Databricks"), Module = basename(dirname(get_terragrunt_dir())) })
}