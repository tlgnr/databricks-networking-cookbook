//-----------------------------------
// AWS
//-----------------------------------
provider "aws" {
  region = var.region

  default_tags {
    tags = var.tags
  }
}

//-----------------------------------
// Azure
//-----------------------------------
provider "azurerm" {
  subscription_id = var.subscription_id

  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}