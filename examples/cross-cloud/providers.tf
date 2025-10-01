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

//-----------------------------------
// Databricks
//-----------------------------------
provider "databricks" {
  alias         = "azure_account"
  account_id    = var.databricks_account_id
  host          = "https://accounts.azuredatabricks.net"
  client_id     = var.databricks_client_id
  client_secret = var.databricks_client_secret
}