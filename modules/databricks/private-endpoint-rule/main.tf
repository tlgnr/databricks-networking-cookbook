//-----------------------------------
// Databricks Private Endpoint Rule
//-----------------------------------
resource "databricks_mws_ncc_private_endpoint_rule" "this" {
  network_connectivity_config_id = var.network_connectivity_config_id
  endpoint_service               = var.endpoint_service
  domain_names                   = var.domain_names
}