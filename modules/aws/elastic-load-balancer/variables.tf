//-----------------------------------
// Elastic Load Balancer
//-----------------------------------
variable "enable_cross_zone_load_balancing" {
  type = bool
}

variable "enable_deletion_protection" {
  type = bool
}

variable "enforce_security_group_inbound_rules_on_private_link_traffic" {
  type = string
}

variable "internal" {
  type = bool
}

variable "load_balancer_type" {
  type = string
}

variable "name" {
  type = string
}

variable "security_groups" {
  type = list(string)
}

variable "subnets" {
  type = list(string)
}

//-----------------------------------
// Target Group
//-----------------------------------
variable "target_groups" {
  type = map(object({
    name        = string
    port        = number
    protocol    = string
    target_id   = string
    target_name = string
    target_type = string
    vpc_id      = string
    vpc_name    = string
  }))
}

//-----------------------------------
// Listener
//-----------------------------------
variable "listeners" {
  type = map(object({
    port              = number
    protocol          = string
    target_group_name = string
  }))
}