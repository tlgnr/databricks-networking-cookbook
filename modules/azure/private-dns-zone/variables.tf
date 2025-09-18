//-----------------------------------
// Private DNS Zone
//-----------------------------------
variable "name" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "tags" {
  type = map(string)
}

//-----------------------------------
// Private DNS Zone Virtual Network Link
//-----------------------------------
variable "virtual_network_id" {
  type = string
}

variable "virtual_network_link_name" {
  type = string
}
