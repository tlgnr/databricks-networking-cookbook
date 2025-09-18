//-----------------------------------
// Route Table Rule
//-----------------------------------
variable "destination_cidr_block" {
  type    = string
  default = null
}

variable "destination_prefix_list_id" {
  type    = string
  default = null
}

variable "gateway_id" {
  type    = string
  default = null
}

variable "nat_gateway_id" {
  type    = string
  default = null
}

variable "network_interface_id" {
  type    = string
  default = null
}

variable "route_table_id" {
  type = string
}

variable "vpc_endpoint_id" {
  type    = string
  default = null
}