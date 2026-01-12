//-----------------------------------
// Databricks Workspaces
//-----------------------------------
output "databricks_workspaces" {
  value = module.databricks_workspace_configuration
}

output "databricks_metastores" {
  value = module.databricks_metastore
}