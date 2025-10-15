//----------------------------------------------
// Locals
//----------------------------------------------
locals {
  env_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
}

//-----------------------------------
// Providers Generation
//-----------------------------------
generate "providers" {
  path      = "providers.tf"
  if_exists = "overwrite"
  contents  = file("${get_terragrunt_dir()}/providers.tf")
}

//-----------------------------------
// Versions Generation
//-----------------------------------
generate "versions" {
  path      = "versions.tf"
  if_exists = "overwrite"
  contents  = <<EOF
    terraform {
      required_providers {
        aws = {
          source  = "hashicorp/aws"
          version = "~> 6.0"
        }
        azurerm = {
          source  = "hashicorp/azurerm"
          version = "~> 4.0"
        }
        databricks = {
          source  = "databricks/databricks"
          version = ">= 1.0"
        }
      }
  }
  EOF
}

//----------------------------------------------
// Variable Configuration
//----------------------------------------------
inputs = {
  environment = local.env_vars.locals.environment
  region      = local.env_vars.locals.region
  tags        = local.env_vars.locals.tags
}