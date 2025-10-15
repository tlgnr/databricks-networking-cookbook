//-----------------------------------
// Databricks Credential Configuration
//-----------------------------------
output "id" {
  value = databricks_mws_credentials.this.credentials_id
}