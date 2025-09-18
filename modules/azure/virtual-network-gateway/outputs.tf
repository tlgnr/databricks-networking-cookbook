//-----------------------------------
// Virtual Network Gateway
//-----------------------------------
output "asn" {
  value = azurerm_virtual_network_gateway.this.bgp_settings[0].asn
}

output "custom_bgp_addresses" {
  value = {
    first  = azurerm_virtual_network_gateway.this.bgp_settings[0].peering_addresses[0].apipa_addresses[0]
    second = azurerm_virtual_network_gateway.this.bgp_settings[0].peering_addresses[0].apipa_addresses[1]
    third  = azurerm_virtual_network_gateway.this.bgp_settings[0].peering_addresses[1].apipa_addresses[0]
    fourth = azurerm_virtual_network_gateway.this.bgp_settings[0].peering_addresses[1].apipa_addresses[1]
  }
}

output "all" {
  value = azurerm_virtual_network_gateway.this
}

output "id" {
  value = azurerm_virtual_network_gateway.this.id
}

output "tunnel_ip_addresses" {
  value = {
    first  = azurerm_virtual_network_gateway.this.bgp_settings[0].peering_addresses[0].tunnel_ip_addresses
    second = azurerm_virtual_network_gateway.this.bgp_settings[0].peering_addresses[1].tunnel_ip_addresses
  }
}
