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
  path   = find_in_parent_folders("root.hcl")
  expose = true
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
  databricks_credential_configurations = yamldecode(templatefile("${get_repo_root()}/configs/serverless-private-connectivity/databricks/credential-configurations.yaml", {
    environment = include.root.locals.environment
    region      = include.root.locals.region
  }))
  databricks_storage_configurations = yamldecode(templatefile("${get_repo_root()}/configs/serverless-private-connectivity/databricks/storage-configurations.yaml", {
    environment = include.root.locals.environment
    region      = include.root.locals.region
  }))
  databricks_network_configurations = yamldecode(templatefile("${get_repo_root()}/configs/serverless-private-connectivity/databricks/network-configurations.yaml", {
    environment = include.root.locals.environment
    region      = include.root.locals.region
  }))
  databricks_workspace_configurations = yamldecode(templatefile("${get_repo_root()}/configs/serverless-private-connectivity/databricks/workspace-configurations.yaml", {
    environment = include.root.locals.environment
    region      = include.root.locals.region
  }))
  databricks_metastores = yamldecode(templatefile("${get_repo_root()}/configs/serverless-private-connectivity/databricks/metastores.yaml", {
    region = include.root.locals.region
  }))
  databricks_ncc_configurations = yamldecode(templatefile("${get_repo_root()}/configs/serverless-private-connectivity/databricks/network-connectivity-configurations.yaml", {
    environment = include.root.locals.environment
    region      = include.root.locals.region
  }))
  databricks_groups = yamldecode(templatefile("${get_repo_root()}/configs/serverless-private-connectivity/databricks/groups.yaml", {
    owner = get_env("OWNER", "Databricks"),
  }))
  databricks_account_level_permission_assignments = yamldecode(templatefile("${get_repo_root()}/configs/serverless-private-connectivity/databricks/account-level-permission-assignments.yaml", {
    environment = include.root.locals.environment
    region      = include.root.locals.region
  }))
  tags = merge(
    include.root.locals.tags,
    {
      Owner  = get_env("OWNER", "Databricks"),
      Module = basename(dirname(get_terragrunt_dir())),
    }
  )
}