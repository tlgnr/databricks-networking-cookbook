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
  path = find_in_parent_folders("root.hcl")
}

//-----------------------------------
// Environment
//-----------------------------------
include "env" {
  path = find_in_parent_folders("env.hcl")
}

//-----------------------------------
// Dependency
//-----------------------------------
dependency "aws_vpc" {
  config_path = "../00_aws_vpc"
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
  aws_subnet_groups = yamldecode(templatefile("../../../configs/serverless-private-connectivity/aws/subnet-groups.yaml", {
    environment = local.env_vars.locals.environment
    region      = local.env_vars.locals.region
  }))
  subnet_ids = dependency.aws_vpc.outputs.subnet_ids
}