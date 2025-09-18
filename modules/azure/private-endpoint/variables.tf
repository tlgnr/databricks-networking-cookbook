//-----------------------------------
// Private Endpoint
//-----------------------------------
variable "location" {
  type = string
}

variable "name" {
  type = string
}

variable "private_connection_resource_id" {
  type = string
}

variable "private_dns_zone_id" {
  type = string
}

variable "private_dns_zone_group_name" {
  type = string
}

variable "private_service_connection_name" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "subresource_name" {
  type = string
}

variable "tags" {
  type = map(string)
}
