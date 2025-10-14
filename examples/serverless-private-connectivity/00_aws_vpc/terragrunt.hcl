//-----------------------------------
// Terraform
//-----------------------------------
terraform {
  source = "../../../stacks/vpc"
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
// Locals
//-----------------------------------
locals {
  env_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
}

//-----------------------------------
// Inputs
//-----------------------------------
inputs = {
  aws_vpcs = yamldecode(templatefile("../../../configs/serverless-private-connectivity/aws/vpcs.yaml", {
    environment = local.env_vars.locals.environment
    region      = local.env_vars.locals.region
  }))
  aws_internet_gateways = yamldecode(templatefile("../../../configs/serverless-private-connectivity/aws/internet-gateways.yaml", {
    environment = local.env_vars.locals.environment
    region      = local.env_vars.locals.region
  }))
  aws_route_tables = yamldecode(templatefile("../../../configs/serverless-private-connectivity/aws/route-tables.yaml", {
    environment = local.env_vars.locals.environment
    region      = local.env_vars.locals.region
  }))
  aws_route_table_rules = yamldecode(templatefile("../../../configs/serverless-private-connectivity/aws/route-table-rules.yaml", {
    environment = local.env_vars.locals.environment
    region      = local.env_vars.locals.region
  }))
  aws_subnets = yamldecode(templatefile("../../../configs/serverless-private-connectivity/aws/subnets.yaml", {
    environment = local.env_vars.locals.environment
    region      = local.env_vars.locals.region
  }))
  aws_security_groups = yamldecode(templatefile("../../../configs/serverless-private-connectivity/aws/security-groups.yaml", {
    environment = local.env_vars.locals.environment
    region      = local.env_vars.locals.region
  }))
}