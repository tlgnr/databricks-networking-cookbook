//-----------------------------------
// Root Configuration
//-----------------------------------
locals {
  region      = "us-east-1"
  location    = "eastus"
  environment = "dev"

  tags = {
    ManagedBy = "Terraform"
  }
}