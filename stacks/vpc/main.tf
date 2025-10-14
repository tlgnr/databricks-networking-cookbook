//-----------------------------------
// AWS VPCs
//-----------------------------------
module "aws_vpc" {
  source = "../../../../../../modules/aws/vpc"

  for_each = var.aws_vpcs

  name                 = each.value.name
  cidr_block           = each.value.cidr_block
  enable_dns_hostnames = each.value.enable_dns_hostnames
  enable_dns_support   = each.value.enable_dns_support
}

//-----------------------------------
// AWS Internet Gateways
//-----------------------------------
module "aws_internet_gateway" {
  source = "../../../../../../modules/aws/internet-gateway"

  for_each = var.aws_internet_gateways

  name   = each.value.name
  vpc_id = module.aws_vpc[each.value.vpc_name].id
}

//-----------------------------------
// AWS Route Tables
//-----------------------------------
module "aws_route_table" {
  source = "../../../../../../modules/aws/route-table"

  for_each = var.aws_route_tables

  name   = each.value.name
  vpc_id = module.aws_vpc[each.value.vpc_name].id
}

//-----------------------------------
// AWS Route Table Rules
//-----------------------------------
module "aws_route_table_rule" {
  source = "../../../../../../modules/aws/route-table-rule"

  for_each = var.aws_route_table_rules

  destination_cidr_block = each.value.destination_cidr_block
  gateway_id             = module.aws_internet_gateway[each.value.internet_gateway_name].id
  route_table_id         = module.aws_route_table[each.value.route_table_name].id
}

//-----------------------------------
// AWS Subnets
//-----------------------------------
module "aws_subnet" {
  source = "../../../../../../modules/aws/subnet"

  for_each = var.aws_subnets

  availability_zone = each.value.availability_zone
  cidr_block        = each.value.cidr_block
  name              = each.value.name
  route_table_id    = module.aws_route_table[each.value.route_table_name].id
  vpc_id            = module.aws_vpc[each.value.vpc_name].id
}

//-----------------------------------
// AWS Security Groups
//-----------------------------------
module "aws_security_group" {
  source = "../../../../../../modules/aws/security-group"

  for_each = var.aws_security_groups

  description                  = each.value.description
  name                         = each.value.name
  region                       = var.region
  security_group_egress_rules  = each.value.security_group_egress_rules
  security_group_ingress_rules = each.value.security_group_ingress_rules
  vpc_id                       = module.aws_vpc[each.value.vpc_name].id
}