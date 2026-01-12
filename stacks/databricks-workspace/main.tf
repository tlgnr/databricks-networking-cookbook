# //-----------------------------------
# // Databricks Connections
# //-----------------------------------
# module "databricks_connection" {
#   source = "../../../../../../modules/databricks/connection"

#   providers = {
#     databricks = databricks.workspace
#   }

#   for_each = var.databricks_connections

#   comment         = each.value.comment
#   connection_type = each.value.connection_type
#   host            = split(":", var.aws_rds_instances[each.value.host].endpoint)[0]
#   name            = each.key
#   password        = var.aws_rds_instances[each.value.host].password
#   port            = each.value.port
#   user            = each.value.user
# }

//-----------------------------------
// Databricks External Location
//-----------------------------------
module "databricks_external_location" {
  source = "../../../../../../modules/databricks/external-location"

  providers = {
    aws        = aws
    databricks = databricks.workspace
  }

  for_each = var.databricks_external_locations

  databricks_account_id = var.databricks_account_id
  metastore_id          = var.databricks_metastores[each.value.metastore_name].id
  region                = var.region
  role_name             = each.value.role_name
  policy_name           = each.value.policy_name
  tags                  = var.tags
  bucket                = each.value.bucket
  force_destroy         = each.value.force_destroy
}