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
  aws_vpc_ids              = dependency.aws_vpc.outputs.aws_vpc_ids
  aws_subnet_ids           = dependency.aws_vpc.outputs.aws_subnet_ids
  aws_security_group_ids   = dependency.aws_vpc.outputs.aws_security_group_ids
  aws_vpc_endpoint_ids     = dependency.aws_vpc.outputs.aws_vpc_endpoint_ids
  databricks_credential_configurations = yamldecode(templatefile("../../../configs/serverless-private-connectivity/databricks/credential-configurations.yaml", {
    environment = local.env_vars.locals.environment
    region      = local.env_vars.locals.region
  }))
  databricks_storage_configurations = yamldecode(templatefile("../../../configs/serverless-private-connectivity/databricks/storage-configurations.yaml", {
    environment = local.env_vars.locals.environment
    region      = local.env_vars.locals.region
  }))
  databricks_network_configurations = yamldecode(templatefile("../../../configs/serverless-private-connectivity/databricks/network-configurations.yaml", {
    environment = local.env_vars.locals.environment
    region      = local.env_vars.locals.region
  }))
  databricks_workspace_configurations = yamldecode(templatefile("../../../configs/serverless-private-connectivity/databricks/workspace-configurations.yaml", {
    environment = local.env_vars.locals.environment
    region      = local.env_vars.locals.region
  }))
  databricks_metastores = yamldecode(templatefile("../../../configs/serverless-private-connectivity/databricks/metastores.yaml", {
    region = local.env_vars.locals.region
  }))
  environment = local.env_vars.locals.environment
  region      = local.env_vars.locals.region
  tags        = merge(local.env_vars.locals.tags, { Owner = get_env("OWNER", "Databricks"), Module = basename(dirname(get_terragrunt_dir())) })
}