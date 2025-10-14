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
// Locals
//-----------------------------------
locals {
  env_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
}

//-----------------------------------
// Inputs
//-----------------------------------
inputs = {
}