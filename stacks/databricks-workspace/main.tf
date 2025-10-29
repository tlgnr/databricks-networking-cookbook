//-----------------------------------
// Databricks Connections
//-----------------------------------
module "databricks_connection" {
  source = "../../../../../../modules/databricks/connection"

  providers = {
    databricks = databricks.workspace
  }

  for_each = var.databricks_connections

  comment         = each.value.comment
  connection_type = each.value.connection_type
  host            = split(":", var.aws_rds_instances[each.value.host].endpoint)[0]
  name            = each.key
  password        = var.aws_rds_instances[each.value.host].password
  port            = each.value.port
  user            = each.value.user
}