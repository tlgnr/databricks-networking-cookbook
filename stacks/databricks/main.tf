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

# //-----------------------------------
# // Databricks Storage Configurations
# //-----------------------------------
# module "databricks_storage_configuration" {
#   source = "../../../modules/databricks/storage-configuration"

#   providers = {
#     aws        = aws
#     databricks = databricks.account
#   }

#   for_each = local.databricks_storage_configurations

#   account_id                 = var.databricks_account_id
#   bucket                     = each.value.bucket
#   storage_configuration_name = each.value.storage_configuration_name
#   force_destroy              = each.value.force_destroy
# }

# //-----------------------------------
# // Databricks Network Configuration
# //-----------------------------------
# module "databricks_network_configuration" {
#   source = "../../../modules/databricks/network-configuration"

#   providers = {
#     databricks = databricks.account
#   }

#   for_each = local.databricks_network_configurations

#   account_id               = var.databricks_account_id
#   region                   = var.region
#   environment              = var.environment
#   network_name             = each.key
#   security_group_ids       = [for _, v in each.value.security_group_names : module.security_group[v].id]
#   subnet_ids               = [for _, v in each.value.subnet_names : module.subnet[v].id]
#   vpc_id                   = module.vpc[each.value.vpc_name].id
#   vpc_endpoint_relay_id    = module.vpc_endpoint["ept-databricks-relay-interface-${var.environment}-${var.region}"].id
#   vpc_endpoint_rest_api_id = module.vpc_endpoint["ept-databricks-rest-interface-${var.environment}-${var.region}"].id
# }

# //-----------------------------------
# // Databricks Workspace Configuration
# //-----------------------------------
# module "databricks_workspace_configuration" {
#   source = "../../../modules/databricks/workspace-configuration"

#   providers = {
#     databricks = databricks.account
#   }

#   for_each = local.databricks_workspace_configurations

#   account_id                  = var.databricks_account_id
#   region                      = var.region
#   workspace_name              = each.value.name
#   private_access_setting_name = each.value.private_access_setting_name
#   credentials_id              = module.databricks_credential_configuration[each.value.credential_configuration_name].id
#   storage_configuration_id    = module.databricks_storage_configuration[each.value.storage_configuration_name].id
#   network_id                  = module.databricks_network_configuration[each.value.network_configuration_name].id
# }

# # TODO: create a separate config file for this
# //-----------------------------------
# // Databricks Metastore
# //-----------------------------------
# module "databricks_metastore" {
#   source = "../../../modules/databricks/metastore"

#   providers = {
#     databricks = databricks.account
#   }

#   for_each = local.databricks_workspace_configurations

#   region                          = var.region
#   environment                     = var.environment
#   user_name                       = each.value.user_name
#   workspace_id                    = module.databricks_workspace_configuration[each.key].id
#   delta_sharing_organization_name = each.value.delta_sharing_organization_name
# }

# //-----------------------------------
# // Databricks User Assignments
# //-----------------------------------
# module "databricks_user_assignment" {
#   source = "../../../modules/databricks/user-assignment"

#   providers = {
#     databricks = databricks.account
#   }

#   for_each = local.databricks_user_assignments

#   user_name    = each.value.user_name
#   workspace_id = module.databricks_workspace_configuration[each.value.workspace_name].id
# }

# //-----------------------------------
# // Databricks External Location
# //-----------------------------------
# module "databricks_external_location" {
#   source = "../../../modules/databricks/external-location"

#   providers = {
#     aws        = aws
#     databricks = databricks.workspace
#   }

#   for_each = local.databricks_external_locations

#   databricks_account_id = var.databricks_account_id
#   metastore_id          = module.databricks_metastore[each.value.workspace_name].id
#   region                = var.region
#   role_name             = each.value.role_name
#   policy_name           = each.value.policy_name
#   tags                  = var.tags
#   bucket                = each.value.bucket
#   force_destroy         = each.value.force_destroy
# }