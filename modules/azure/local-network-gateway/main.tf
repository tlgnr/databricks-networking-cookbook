//-----------------------------------
// Local Network Gateway
//-----------------------------------
resource "azurerm_local_network_gateway" "this" {
  name                = var.name
  resource_group_name = var.resource_group_name
  gateway_address     = var.gateway_address
  tags                = var.tags
  location            = var.location

  bgp_settings {
    asn                 = var.asn
    bgp_peering_address = var.bgp_peering_address
  }
}