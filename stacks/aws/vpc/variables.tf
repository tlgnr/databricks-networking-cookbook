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
// AWS NAT Gateways
//-----------------------------------
variable "aws_nat_gateways" {
  type = map(object({
    name        = string
    subnet_name = string
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
    internet_gateway_name  = optional(string, null)
    nat_gateway_name       = optional(string, null)
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
    description = string
    name        = string
    vpc_name    = string
  }))
}

//-----------------------------------
// AWS Security Group Rules
//-----------------------------------
variable "aws_security_group_rules" {
  type = map(object({
    security_group_egress_rules  = map(map(string))
    security_group_ingress_rules = map(map(string))
  }))
}

//-----------------------------------
// AWS VPC Endpoints
//-----------------------------------
variable "aws_vpc_endpoints" {
  type = map(object({
    name                 = string
    private_dns_enabled  = bool
    route_table_names    = list(string)
    security_group_names = list(string)
    service              = string
    service_name         = string
    service_regions      = list(string)
    service_type         = string
    subnet_names         = list(string)
    vpc_name             = string
  }))
}