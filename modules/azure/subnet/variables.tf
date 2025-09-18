//-----------------------------------
// Subnets
//-----------------------------------
variable "address_prefixes" {
  type = list(string)
}

variable "delegation" {
  type = object({
    name = string
    service_delegation = object({
      name    = string
      actions = list(string)
    })
  })
}

variable "name" {
  type = string
}

variable "network_security_group_id" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "route_table_id" {
  type = string
}

variable "service_endpoints" {
  type = list(string)
}

variable "virtual_network_name" {
  type = string
}

