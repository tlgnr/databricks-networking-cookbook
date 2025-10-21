//-----------------------------------
// Databricks Storage Configuration
//-----------------------------------
output "id" {
  value = databricks_mws_storage_configurations.this.storage_configuration_id
}