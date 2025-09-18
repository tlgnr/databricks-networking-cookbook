//-----------------------------------
// Virtual Network Gateway
//-----------------------------------
variable "active_active" {
  type = bool
}

variable "apipa_addresses" {
  type = list(string)
}

variable "asn" {
  type = string
}

variable "enable_bgp" {
  type = bool
}

variable "ip_configurations_name" {
  type = string
}

variable "ip_configurations_first_public_ip_address_id" {
  type = string
}

variable "ip_configurations_second_public_ip_address_id" {
  type = string
}

variable "ip_configurations_subnet_id" {
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

variable "sku" {
  type = string
}

variable "tags" {
  type = map(string)
}

variable "type" {
  type = string
}

variable "vpn_type" {
  type = string
}