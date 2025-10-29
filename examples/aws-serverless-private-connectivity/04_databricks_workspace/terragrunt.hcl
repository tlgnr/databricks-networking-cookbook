//-----------------------------------
// Terraform
//-----------------------------------
terraform {
  source = "${get_repo_root()}/stacks/databricks-workspace"
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
dependency "aws_rds" {
  config_path = "../01_aws_rds"
}

dependency "databricks_account" {
  config_path = "../03_databricks_account"
}

//-----------------------------------
// Inputs
//-----------------------------------
inputs = {
  databricks_account_id    = get_env("DATABRICKS_ACCOUNT_ID")
  databricks_client_id     = get_env("DATABRICKS_CLIENT_ID")
  databricks_client_secret = get_env("DATABRICKS_CLIENT_SECRET")
  databricks_host          = dependency.databricks_account.outputs.databricks_workspaces["adb-workload-dev-us-east-1"].workspace_url
  databricks_connections = yamldecode(templatefile("${get_repo_root()}/configs/serverless-private-connectivity/databricks/connections.yaml", {
    environment = include.root.locals.environment
    region      = include.root.locals.region
  }))
  aws_rds_instances = dependency.aws_rds.outputs.aws_rds_instances
  tags = merge(
    include.root.locals.tags,
    {
      Owner  = get_env("OWNER", "Databricks"),
      Module = basename(dirname(get_terragrunt_dir())),
    }
  )
}