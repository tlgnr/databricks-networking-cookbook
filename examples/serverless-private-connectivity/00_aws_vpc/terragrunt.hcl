//-----------------------------------
// Terraform
//-----------------------------------
terraform {
  source = "${get_repo_root()}/stacks/aws/vpc"
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
  aws_nat_gateways = yamldecode(templatefile("../../../configs/serverless-private-connectivity/aws/nat-gateways.yaml", {
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
  aws_vpc_endpoints = yamldecode(templatefile("../../../configs/serverless-private-connectivity/aws/vpc-endpoints.yaml", {
    environment = local.env_vars.locals.environment
    region      = local.env_vars.locals.region
  }))
  tags = merge(local.env_vars.locals.tags, { Owner = get_env("OWNER", "Databricks"), Module = basename(dirname(get_terragrunt_dir())) })
}