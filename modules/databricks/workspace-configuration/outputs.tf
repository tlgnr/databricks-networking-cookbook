//-----------------------------------
// Databricks Workspace Configuration
//-----------------------------------
output "id" {
  value = databricks_mws_workspaces.this.workspace_id
}