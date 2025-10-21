//-----------------------------------
// Databricks Private Access Setting
//-----------------------------------
resource "databricks_mws_private_access_settings" "this" {
  private_access_settings_name = var.private_access_setting_name
  public_access_enabled        = var.public_access_enabled
  region                       = var.region
}

//-----------------------------------
// Databricks Workspace Configuration
//-----------------------------------
resource "databricks_mws_workspaces" "this" {
  account_id                 = var.account_id
  aws_region                 = var.region
  credentials_id             = var.credentials_id
  network_id                 = var.network_id
  pricing_tier               = var.pricing_tier
  private_access_settings_id = databricks_mws_private_access_settings.this.private_access_settings_id
  storage_configuration_id   = var.storage_configuration_id
  workspace_name             = var.workspace_name
}