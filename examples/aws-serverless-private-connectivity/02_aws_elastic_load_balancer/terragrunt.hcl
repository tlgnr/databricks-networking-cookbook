//-----------------------------------
// Terraform
//-----------------------------------
terraform {
  source = "${get_repo_root()}/stacks/aws/elastic-load-balancer"
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
  aws_elastic_load_balancers = yamldecode(templatefile("../../../configs/serverless-private-connectivity/aws/elastic-load-balancers.yaml", {
    environment = local.env_vars.locals.environment
    region      = local.env_vars.locals.region
  }))
  aws_vpc_endpoint_services = yamldecode(templatefile("../../../configs/serverless-private-connectivity/aws/vpc-endpoints-services.yaml", {
    environment = local.env_vars.locals.environment
    region      = local.env_vars.locals.region
  }))
  aws_subnet_ids             = dependency.aws_vpc.outputs.aws_subnet_ids
  aws_security_group_ids     = dependency.aws_vpc.outputs.aws_security_group_ids
  aws_rds_instance_endpoints = dependency.aws_rds.outputs.aws_rds_instances
  aws_vpc_ids                = dependency.aws_vpc.outputs.aws_vpc_ids
  tags                       = merge(local.env_vars.locals.tags, { Owner = get_env("OWNER", "Databricks"), Module = basename(dirname(get_terragrunt_dir())) })
}