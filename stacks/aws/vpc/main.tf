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
// AWS NAT Gateways
//-----------------------------------
module "aws_nat_gateway" {
  source = "../../../../../../modules/aws/nat-gateway"

  for_each = var.aws_nat_gateways

  name      = each.value.name
  subnet_id = module.aws_subnet[each.value.subnet_name].id
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
  gateway_id             = try(module.aws_internet_gateway[each.value.internet_gateway_name].id, null)
  nat_gateway_id         = try(module.aws_nat_gateway[each.value.nat_gateway_name].id, null)
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

  description = each.value.description
  name        = each.value.name
  vpc_id      = module.aws_vpc[each.value.vpc_name].id
}

//-----------------------------------
// AWS Security Group Rules
//-----------------------------------
module "aws_security_group_rule" {
  source = "../../../../../../modules/aws/security-group-rule"

  for_each = var.aws_security_group_rules

  security_group_egress_rules  = [for k, v in var.aws_security_group_rules[each.key].security_group_egress_rules : merge(v, { name = k, security_group_name = each.key, referenced_security_group_id = try(module.aws_security_group[v.referenced_security_group_name].id, null) })]
  security_group_id            = module.aws_security_group[each.key].id
  security_group_ingress_rules = [for k, v in var.aws_security_group_rules[each.key].security_group_ingress_rules : merge(v, { name = k, security_group_name = each.key, referenced_security_group_id = try(module.aws_security_group[v.referenced_security_group_name].id, null) })]
  region                       = var.region
}

//-----------------------------------
// AWS VPC Endpoints
//-----------------------------------
module "aws_vpc_endpoint" {
  source = "../../../../../../modules/aws/vpc-endpoint"

  for_each = var.aws_vpc_endpoints

  name                = each.value.name
  private_dns_enabled = each.value.private_dns_enabled
  route_table_ids     = try([for route_table_name in each.value.route_table_names : module.aws_route_table[route_table_name].id], null)
  security_group_ids  = try([for security_group_name in each.value.security_group_names : module.aws_security_group[security_group_name].id], null)
  service             = each.value.service
  service_name        = each.value.service_name
  service_regions     = each.value.service_regions
  service_type        = each.value.service_type
  subnet_ids          = try([for subnet_name in each.value.subnet_names : module.aws_subnet[subnet_name].id], null)
  vpc_id              = module.aws_vpc[each.value.vpc_name].id
}