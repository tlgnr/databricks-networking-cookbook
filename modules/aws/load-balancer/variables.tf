//-----------------------------------
// Load Balancer
//-----------------------------------
variable "enable_deletion_protection" {
  type = bool
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
// Load Balancer Target Group
//-----------------------------------
variable "target_groups" {
  type = map(map(string))
}