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
// Databricks Network Configurations
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
// Databricks Workspace Configurations
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
// Databricks Groups
//-----------------------------------
module "databricks_group" {
  source = "../../../../../../modules/databricks/group"

  providers = {
    databricks = databricks.account
  }

  for_each = var.databricks_groups

  display_name            = each.value.display_name
  service_principal_names = each.value.service_principal_names
  user_names              = each.value.user_names
}

//-----------------------------------
// Databricks Metastores
//-----------------------------------
module "databricks_metastore" {
  source = "../../../../../../modules/databricks/metastore"

  depends_on = [
    module.databricks_group,
  ]

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
// Databricks Metastore Assignments
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
// Databricks Account Level Permission Assignments
//-----------------------------------
module "databricks_account_level_permission_assignment" {
  source = "../../../../../../modules/databricks/account-level-permission-assignment"

  depends_on = [
    module.databricks_workspace_configuration,
    module.databricks_group,
  ]

  providers = {
    databricks = databricks.account
  }

  for_each = var.databricks_account_level_permission_assignments

  permissions   = each.value.permissions
  principal_ids = { for group_name in each.value.group_names : group_name => module.databricks_group[group_name].id }
  workspace_id  = module.databricks_workspace_configuration[each.value.workspace_name].id
}

//-----------------------------------
// Databricks NCC
//-----------------------------------
module "databricks_ncc" {
  source = "../../../../../../modules/databricks/network-connectivity-configuration"

  providers = {
    databricks = databricks.account
  }

  for_each = var.databricks_ncc_configurations

  name         = each.value.name
  region       = var.region
  workspace_id = module.databricks_workspace_configuration[each.value.workspace_name].id
}

//-----------------------------------
// Databricks Private Endpoint Rules
//-----------------------------------
module "databricks_private_endpoint_rule" {
  source = "../../../../../../modules/databricks/private-endpoint-rule"

  providers = {
    databricks = databricks.account
  }

  for_each = var.databricks_private_endpoint_rules

  network_connectivity_config_id = module.databricks_ncc[each.value.network_connectivity_config_name].id
  endpoint_service               = var.aws_vpc_endpoint_services[each.value.vpc_endpoint_service_name].service_name
  domain_names                   = [for resource in each.value.resources : split(":", var.aws_rds_instance_fqdns[resource].endpoint)[0]]
}