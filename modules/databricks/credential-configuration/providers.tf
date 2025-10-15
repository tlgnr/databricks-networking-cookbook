//-----------------------------------
// Provider Versions
//-----------------------------------
terraform {
  required_providers {
    databricks = {
      source  = "databricks/databricks"
      version = "~> 1.9"
    }
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
  }
}