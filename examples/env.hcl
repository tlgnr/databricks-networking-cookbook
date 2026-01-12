//-----------------------------------
// Environment Configuration
//-----------------------------------
locals {
  region      = "us-east-2"
  location    = "eastus"
  environment = "dev"

  tags = {
    ManagedBy = "Terraform"
  }
}