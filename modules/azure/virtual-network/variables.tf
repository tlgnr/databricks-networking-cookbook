//-----------------------------------
// Virtual Network
//-----------------------------------
variable "address_space" {
  type = list(string)
}

variable "dns_servers" {
  type = list(string)
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
