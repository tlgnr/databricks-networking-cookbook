//-----------------------------------
// Provider Versions
//-----------------------------------
terraform {
  required_providers {
    databricks = {
      source  = "databricks/databricks"
      version = "~> 1.92"
    }
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
  }
}