//-----------------------------------
// Databricks Workspace
//-----------------------------------
output "id" {
  value = azurerm_databricks_workspace.this.id
}

output "workspace_id" {
  value = azurerm_databricks_workspace.this.workspace_id
}