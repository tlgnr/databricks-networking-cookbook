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
// Databricks Account
//-----------------------------------
provider "databricks" {
  alias         = "account"
  account_id    = var.databricks_account_id
  host          = "https://accounts.cloud.databricks.com"
  client_id     = var.databricks_client_id
  client_secret = var.databricks_client_secret
}