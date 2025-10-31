//-----------------------------------
// Security Group
//-----------------------------------
variable "region" {
  type = string
}

variable "security_group_egress_rules" {
  type = list(map(string))
}

variable "security_group_id" {
  type = string
}

variable "security_group_ingress_rules" {
  type = list(map(string))
}
