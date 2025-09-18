//-----------------------------------
// Private DNS Zone
//-----------------------------------
resource "azurerm_private_dns_zone" "this" {
  name                = var.name
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

//-----------------------------------
// Private DNS Zone Virtual Network Link
//-----------------------------------
resource "azurerm_private_dns_zone_virtual_network_link" "this" {
  name                  = var.virtual_network_link_name
  private_dns_zone_name = azurerm_private_dns_zone.this.name
  resource_group_name   = var.resource_group_name
  virtual_network_id    = var.virtual_network_id
  tags                  = var.tags
}