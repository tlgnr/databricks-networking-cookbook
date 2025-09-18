//-----------------------------------
// Network Security Group Rule
//-----------------------------------
variable "access" {
  type = string
}

variable "destination_address_prefix" {
  type = string
}

variable "destination_port_range" {
  type = string
}

variable "direction" {
  type = string
}

variable "name" {
  type = string
}

variable "network_security_group_name" {
  type = string
}

variable "priority" {
  type = number
}

variable "protocol" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "source_address_prefix" {
  type = string
}

variable "source_port_range" {
  type = string
}


