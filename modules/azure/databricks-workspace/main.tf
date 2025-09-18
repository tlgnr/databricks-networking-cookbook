//-----------------------------------
// Databricks Workspace
//-----------------------------------
resource "azurerm_databricks_workspace" "this" {
  name                                  = var.name
  resource_group_name                   = var.resource_group_name
  sku                                   = var.sku
  managed_resource_group_name           = var.managed_resource_group_name
  public_network_access_enabled         = var.public_network_access_enabled
  network_security_group_rules_required = var.network_security_group_rules_required
  location                              = var.location
  tags                                  = var.tags

  dynamic "custom_parameters" {
    for_each = var.public_subnet_name != null && var.private_subnet_name != null ? [1] : []

    content {
      virtual_network_id                                   = var.virtual_network_id
      public_subnet_network_security_group_association_id  = var.public_subnet_network_security_group_association_id
      private_subnet_network_security_group_association_id = var.private_subnet_network_security_group_association_id
      no_public_ip                                         = var.no_public_ip
      public_subnet_name                                   = var.public_subnet_name
      private_subnet_name                                  = var.private_subnet_name
    }
  }
}