//-----------------------------------
// VPC Endpoint
//-----------------------------------
variable "name" {
  type = string
}

variable "private_dns_enabled" {
  type = bool
}

variable "route_table_ids" {
  type = list(string)
}

variable "security_group_ids" {
  type = list(string)
}

variable "service" {
  type    = string
  default = null
}

variable "service_name" {
  type    = string
  default = null
}

variable "service_regions" {
  type = list(string)
}

variable "service_type" {
  type = string
}

variable "subnet_ids" {
  type = list(string)
}

variable "vpc_id" {
  type = string
}




