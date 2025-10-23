//-----------------------------------
// Databricks NCC
//-----------------------------------
resource "databricks_mws_network_connectivity_config" "this" {
  name   = var.name
  region = var.region
}

//-----------------------------------
// Databricks NCC Binding
//-----------------------------------
resource "databricks_mws_ncc_binding" "this" {
  network_connectivity_config_id = databricks_mws_network_connectivity_config.this.network_connectivity_config_id
  workspace_id                   = var.workspace_id
}