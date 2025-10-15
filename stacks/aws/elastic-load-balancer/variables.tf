//-----------------------------------
// AWS General
//-----------------------------------
variable "region" {
  type = string
}

variable "tags" {
  type = map(string)
}

//-----------------------------------
// Dependencies
//-----------------------------------
variable "aws_security_group_ids" {
  type = map(map(string))
}

variable "aws_subnet_ids" {
  type = map(map(string))
}

variable "aws_vpc_ids" {
  type = map(map(string))
}

variable "aws_rds_instance_endpoints" {
  type = map(map(string))
}

//-----------------------------------
// AWS Elastic Load Balancer
//-----------------------------------
variable "aws_elastic_load_balancers" {
  type = map(object({
    enable_cross_zone_load_balancing = bool
    enable_deletion_protection       = bool
    internal                         = bool
    listeners = map(object({
      port              = number
      protocol          = string
      target_group_name = string
    }))
    load_balancer_type   = string
    name                 = string
    security_group_names = list(string)
    subnet_names         = list(string)
    target_groups = map(object({
      name        = string
      port        = number
      protocol    = string
      target_name = string
      target_type = string
      vpc_name    = string
    }))
  }))
}

//-----------------------------------
// AWS VPC Endpoint Services
//-----------------------------------
variable "aws_vpc_endpoint_services" {
  type = map(object({
    acceptance_required         = bool
    allowed_principals          = list(string)
    name                        = string
    elastic_load_balancer_names = list(string)
  }))
}