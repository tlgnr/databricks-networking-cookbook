//-----------------------------------
// VPC
//-----------------------------------
variable "name" {
  type = string
}

variable "cidr_block" {
  type = string
}

variable "enable_dns_hostnames" {
  type = bool
}

variable "enable_dns_support" {
  type = bool
}


