//-----------------------------------
// Databricks Service Principal
//-----------------------------------
data "databricks_service_principal" "this" {
  count          = var.principal_type == "SERVICE_PRINCIPAL" ? 1 : 0
  application_id = var.principal_id
}

//-----------------------------------
// Databricks Permission Assignment
//-----------------------------------
resource "databricks_mws_permission_assignment" "this" {
  workspace_id = var.workspace_id
  principal_id = var.principal_type == "SERVICE_PRINCIPAL" ? data.databricks_service_principal.this[0].id : var.principal_id
  permissions  = var.permissions
}