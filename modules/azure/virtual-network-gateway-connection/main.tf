//-----------------------------------
// Virtual Network Gateway Connection
//-----------------------------------
resource "azurerm_virtual_network_gateway_connection" "this" {
  name                       = var.name
  resource_group_name        = var.resource_group_name
  type                       = "IPsec"
  enable_bgp                 = var.enable_bgp
  shared_key                 = var.shared_key
  virtual_network_gateway_id = var.virtual_network_gateway_id
  local_network_gateway_id   = var.local_network_gateway_id
  location                   = var.location
  tags                       = var.tags

  custom_bgp_addresses {
    primary   = var.primary_custom_bgp_address
    secondary = var.secondary_custom_bgp_address
  }
}