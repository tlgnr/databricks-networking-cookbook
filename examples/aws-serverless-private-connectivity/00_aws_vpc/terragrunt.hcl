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
  path   = find_in_parent_folders("root.hcl")
  expose = true
}

//-----------------------------------
// Inputs
//-----------------------------------
inputs = {
  aws_vpcs = yamldecode(templatefile("${get_repo_root()}/configs/serverless-private-connectivity/aws/vpcs.yaml", {
    environment = include.root.locals.environment
    region      = include.root.locals.region
  }))
  aws_internet_gateways = yamldecode(templatefile("${get_repo_root()}/configs/serverless-private-connectivity/aws/internet-gateways.yaml", {
    environment = include.root.locals.environment
    region      = include.root.locals.region
  }))
  aws_nat_gateways = yamldecode(templatefile("${get_repo_root()}/configs/serverless-private-connectivity/aws/nat-gateways.yaml", {
    environment = include.root.locals.environment
    region      = include.root.locals.region
  }))
  aws_route_tables = yamldecode(templatefile("${get_repo_root()}/configs/serverless-private-connectivity/aws/route-tables.yaml", {
    environment = include.root.locals.environment
    region      = include.root.locals.region
  }))
  aws_route_table_rules = yamldecode(templatefile("${get_repo_root()}/configs/serverless-private-connectivity/aws/route-table-rules.yaml", {
    environment = include.root.locals.environment
    region      = include.root.locals.region
  }))
  aws_subnets = yamldecode(templatefile("${get_repo_root()}/configs/serverless-private-connectivity/aws/subnets.yaml", {
    environment = include.root.locals.environment
    region      = include.root.locals.region
  }))
  aws_security_groups = yamldecode(templatefile("${get_repo_root()}/configs/serverless-private-connectivity/aws/security-groups.yaml", {
    environment = include.root.locals.environment
    region      = include.root.locals.region
  }))
  aws_vpc_endpoints = yamldecode(templatefile("${get_repo_root()}/configs/serverless-private-connectivity/aws/vpc-endpoints.yaml", {
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