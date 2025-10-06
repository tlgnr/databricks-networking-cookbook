//-----------------------------------
// Databricks Catalog
//-----------------------------------
resource "databricks_catalog" "this" {
  name            = var.name
  comment         = var.comment
  connection_name = var.connection_name
  isolation_mode  = var.isolation_mode
  options         = var.options
}