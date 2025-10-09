//-----------------------------------
// VPC Endpoint Service
//-----------------------------------
variable "allowed_principals" {
  type = list(string)
}

variable "acceptance_required" {
  type = bool
}

variable "network_load_balancer_arns" {
  type = list(string)
}

variable "name" {
  type = string
}