//-----------------------------------
// Databricks User
//-----------------------------------
data "databricks_user" "this" {
  user_name = var.user_name
}

//-----------------------------------
// Databricks User Assignment
//-----------------------------------
resource "databricks_mws_permission_assignment" "this" {
  workspace_id = var.workspace_id
  principal_id = data.databricks_user.this.id
  permissions  = ["ADMIN"]

  lifecycle {
    ignore_changes = [principal_id]
  }
}