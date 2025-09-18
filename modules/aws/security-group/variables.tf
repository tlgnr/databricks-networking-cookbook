//-----------------------------------
// Security Group
//-----------------------------------
variable "description" {
  type = string
}

variable "name" {
  type = string
}

variable "region" {
  type = string
}

variable "security_group_egress_rules" {
  type = list(map(string))
}

variable "security_group_ingress_rules" {
  type = list(map(string))
}

variable "vpc_id" {
  type = string
}
