//-----------------------------------
// Databricks Network Configuration
//-----------------------------------
output "id" {
  value = databricks_mws_networks.this.network_id
}