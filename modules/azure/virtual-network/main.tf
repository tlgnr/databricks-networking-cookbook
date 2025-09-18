//-----------------------------------
// Virtual Network
//-----------------------------------
resource "azurerm_virtual_network" "this" {
  name                = var.name
  resource_group_name = var.resource_group_name
  address_space       = var.address_space
  dns_servers         = var.dns_servers
  location            = var.location
  tags                = var.tags
}