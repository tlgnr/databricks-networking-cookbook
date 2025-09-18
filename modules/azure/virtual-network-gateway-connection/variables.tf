//-----------------------------------
// Virtual Network Gateway Connection
//-----------------------------------
variable "primary_custom_bgp_address" {
  type = string
}

variable "secondary_custom_bgp_address" {
  type = string
}

variable "enable_bgp" {
  type = bool
}

variable "local_network_gateway_id" {
  type = string
}

variable "location" {
  type = string
}

variable "name" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "shared_key" {
  type = string
}

variable "tags" {
  type = map(string)
}

variable "virtual_network_gateway_id" {
  type = string
}