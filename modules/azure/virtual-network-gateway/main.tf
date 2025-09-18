//-----------------------------------
// Virtual Network Gateway
//-----------------------------------
resource "azurerm_virtual_network_gateway" "this" {
  name                = var.name
  resource_group_name = var.resource_group_name
  type                = var.type
  vpn_type            = var.vpn_type
  active_active       = var.active_active
  enable_bgp          = var.enable_bgp
  sku                 = var.sku
  location            = var.location
  tags                = var.tags

  ip_configuration {
    name                          = "${var.ip_configurations_name}-001"
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = var.ip_configurations_first_public_ip_address_id
    subnet_id                     = var.ip_configurations_subnet_id
  }

  ip_configuration {
    name                          = "${var.ip_configurations_name}-002"
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = var.ip_configurations_second_public_ip_address_id
    subnet_id                     = var.ip_configurations_subnet_id
  }

  bgp_settings {
    asn = var.asn

    peering_addresses {
      apipa_addresses       = [var.apipa_addresses[0], var.apipa_addresses[1]]
      ip_configuration_name = "${var.ip_configurations_name}-001"
    }

    peering_addresses {
      apipa_addresses       = [var.apipa_addresses[2], var.apipa_addresses[3]]
      ip_configuration_name = "${var.ip_configurations_name}-002"
    }
  }
}