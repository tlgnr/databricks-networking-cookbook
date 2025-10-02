//-----------------------------------
// Databricks Metastore
//-----------------------------------
resource "databricks_metastore" "this" {
  name = var.name
  storage_root = var.storage_container_name != null && var.storage_account_name != null ? format(
    "abfss://%s@%s.dfs.core.windows.net/",
    var.storage_container_name,
    var.storage_account_name
  ) : null
  owner         = var.owner
  region        = var.location
  force_destroy = var.force_destroy
}