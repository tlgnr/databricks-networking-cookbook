//-----------------------------------
// Local Network Gateway
//-----------------------------------
variable "asn" {
  type = string
}

variable "bgp_peering_address" {
  type = string
}

variable "gateway_address" {
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

variable "tags" {
  type = map(string)
}