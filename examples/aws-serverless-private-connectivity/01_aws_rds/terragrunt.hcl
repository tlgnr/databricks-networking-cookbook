//-----------------------------------
// Terraform
//-----------------------------------
terraform {
  source = "${get_repo_root()}/stacks/aws/rds"
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

//-----------------------------------
// Inputs
//-----------------------------------
inputs = {
  aws_subnet_groups = yamldecode(templatefile("${get_repo_root()}/configs/serverless-private-connectivity/aws/subnet-groups.yaml", {
    environment = include.root.locals.environment
    region      = include.root.locals.region
  }))
  aws_rds_instances = yamldecode(templatefile("${get_repo_root()}/configs/serverless-private-connectivity/aws/rds-instances.yaml", {
    environment = include.root.locals.environment
    region      = include.root.locals.region
  }))
  aws_subnet_ids         = dependency.aws_vpc.outputs.aws_subnet_ids
  aws_security_group_ids = dependency.aws_vpc.outputs.aws_security_group_ids
  tags = merge(
    include.root.locals.tags,
    {
      Owner  = get_env("OWNER", "Databricks"),
      Module = basename(dirname(get_terragrunt_dir())),
    }
  )
}