//-----------------------------------
// Virtual Private Gateway Connection
//-----------------------------------
variable "customer_gateway_id" {
  type = string
}

variable "name" {
  type = string
}

variable "tunnel1_inside_cidr" {
  type = string
}

variable "tunnel2_inside_cidr" {
  type = string
}

variable "vpn_gateway_id" {
  type = string
}