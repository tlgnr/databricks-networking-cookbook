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
// AWS VPCs
//-----------------------------------
variable "aws_vpcs" {
  type = map(object({
    name                 = string
    cidr_block           = string
    enable_dns_hostnames = bool
    enable_dns_support   = bool
  }))
}

//-----------------------------------
// AWS Internet Gateways
//-----------------------------------
variable "aws_internet_gateways" {
  type = map(object({
    name     = string
    vpc_name = string
  }))
}

//-----------------------------------
// AWS Route Tables
//-----------------------------------
variable "aws_route_tables" {
  type = map(object({
    name     = string
    vpc_name = string
  }))
}

//-----------------------------------
// AWS Route Table Rules
//-----------------------------------
variable "aws_route_table_rules" {
  type = map(object({
    destination_cidr_block = string
    internet_gateway_name  = string
    route_table_name       = string
  }))
}

//-----------------------------------
// AWS Subnets
//-----------------------------------
variable "aws_subnets" {
  type = map(object({
    availability_zone = string
    cidr_block        = string
    name              = string
    route_table_name  = string
    vpc_name          = string
  }))
}

//-----------------------------------
// AWS Security Groups
//-----------------------------------
variable "aws_security_groups" {
  type = map(object({
    name                         = string
    description                  = string
    security_group_egress_rules  = list(map(string))
    security_group_ingress_rules = list(map(string))
    vpc_name                     = string
  }))
}