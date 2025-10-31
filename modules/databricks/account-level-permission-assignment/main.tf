//-----------------------------------
// Databricks Account Level Permission Assignment
//-----------------------------------
resource "databricks_mws_permission_assignment" "this" {
  for_each = var.principal_ids

  permissions  = var.permissions
  principal_id = each.value
  workspace_id = var.workspace_id
}