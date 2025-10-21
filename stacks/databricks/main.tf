//-----------------------------------
// Databricks Credential Configurations
//-----------------------------------
module "databricks_credential_configuration" {
  source = "../../../../../../modules/databricks/credential-configuration"

  providers = {
    aws        = aws
    databricks = databricks.account
  }

  for_each = var.databricks_credential_configurations

  credential_name       = each.value.credential_name
  databricks_account_id = var.databricks_account_id
  region                = var.region
  tags                  = var.tags
}

//-----------------------------------
// Databricks Storage Configurations
//-----------------------------------
module "databricks_storage_configuration" {
  source = "../../../../../../modules/databricks/storage-configuration"

  providers = {
    aws        = aws
    databricks = databricks.account
  }

  for_each = var.databricks_storage_configurations

  account_id                 = var.databricks_account_id
  bucket                     = each.value.bucket
  force_destroy              = each.value.force_destroy
  storage_configuration_name = each.value.storage_configuration_name
}

//-----------------------------------
// Databricks Network Configuration
//-----------------------------------
module "databricks_network_configuration" {
  source = "../../../../../../modules/databricks/network-configuration"

  providers = {
    databricks = databricks.account
  }

  for_each = var.databricks_network_configurations

  account_id                   = var.databricks_account_id
  aws_security_group_ids       = [for security_group_name in each.value.security_group_names : var.aws_security_group_ids[security_group_name].id]
  aws_subnet_ids               = [for subnet_name in each.value.subnet_names : var.aws_subnet_ids[subnet_name].id]
  aws_vpc_endpoint_relay_id    = var.aws_vpc_endpoint_ids[each.value.vpc_endpoint_relay_name].id
  aws_vpc_endpoint_rest_api_id = var.aws_vpc_endpoint_ids[each.value.vpc_endpoint_rest_api_name].id
  aws_vpc_id                   = var.aws_vpc_ids[each.value.vpc_name].id
  environment                  = var.environment
  network_name                 = each.key
  region                       = var.region
}

//-----------------------------------
// Databricks Workspace Configuration
//-----------------------------------
module "databricks_workspace_configuration" {
  source = "../../../../../../modules/databricks/workspace-configuration"

  providers = {
    databricks = databricks.account
  }

  for_each = var.databricks_workspace_configurations

  account_id                  = var.databricks_account_id
  credentials_id              = module.databricks_credential_configuration[each.value.credential_configuration_name].id
  network_id                  = module.databricks_network_configuration[each.value.network_configuration_name].id
  pricing_tier                = each.value.pricing_tier
  private_access_setting_name = each.value.private_access_setting_name
  public_access_enabled       = each.value.public_access_enabled
  region                      = var.region
  storage_configuration_id    = module.databricks_storage_configuration[each.value.storage_configuration_name].id
  workspace_name              = each.value.workspace_name
}

//-----------------------------------
// Databricks Metastore
//-----------------------------------
module "databricks_metastore" {
  source = "../../../../../../modules/databricks/metastore"

  providers = {
    databricks = databricks.account
  }

  for_each = var.databricks_metastores

  name                   = each.value.name
  force_destroy          = each.value.force_destroy
  location               = var.region
  owner                  = each.value.owner
  storage_account_name   = each.value.storage_account_name
  storage_container_name = each.value.storage_container_name
}

//-----------------------------------
// Databricks Metastore Assignment
//-----------------------------------
module "databricks_metastore_assignment" {
  source = "../../../../../../modules/databricks/metastore-assignment"

  providers = {
    databricks = databricks.account
  }

  for_each = var.databricks_workspace_configurations

  workspace_id = module.databricks_workspace_configuration[each.value.workspace_name].id
  metastore_id = module.databricks_metastore[each.value.metastore_name].id
}

//-----------------------------------
// Databricks User Assignments
//-----------------------------------
module "databricks_user_assignment" {
  source = "../../../../../../modules/databricks/user-assignment"

  providers = {
    databricks = databricks.account
  }

  for_each = var.databricks_workspace_configurations

  user_name    = var.tags["Owner"]
  workspace_id = module.databricks_workspace_configuration[each.value.workspace_name].id
}