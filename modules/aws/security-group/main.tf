//-----------------------------------
// Locals
//-----------------------------------
locals {
  security_group_ingress_rules = flatten([
    for _, v in var.security_group_ingress_rules : [{
      from_port   = v.from_port,
      to_port     = v.to_port,
      cidr_ipv4   = v.cidr_ipv4,
      ip_protocol = v.ip_protocol
      prefix_list = v.prefix_list
      target      = v.cidr_ipv4 == null ? v.prefix_list : v.cidr_ipv4
  }]])

  security_group_egress_rules = flatten([
    for _, v in var.security_group_egress_rules : [{
      from_port   = v.from_port,
      to_port     = v.to_port,
      cidr_ipv4   = v.cidr_ipv4,
      ip_protocol = v.ip_protocol
      prefix_list = v.prefix_list
      target      = v.cidr_ipv4 == null ? v.prefix_list : v.cidr_ipv4
  }]])

  prefix_lists = {
    s3 = data.aws_ec2_managed_prefix_list.s3
  }
}

//-----------------------------------
// Security Group
//-----------------------------------
resource "aws_security_group" "this" {
  name        = var.name
  description = var.description
  vpc_id      = var.vpc_id

  tags = {
    Name = var.name
  }
}

//-----------------------------------
// Prefix Lists
//-----------------------------------
data "aws_ec2_managed_prefix_list" "s3" {
  name = "com.amazonaws.${var.region}.s3"
}

//-----------------------------------
// Security Group Ingress Rule
//-----------------------------------
resource "aws_vpc_security_group_ingress_rule" "this" {
  for_each = {
    for _, v in local.security_group_ingress_rules : "${var.name}-${v.ip_protocol}-${v.target}-${v.from_port}-ingress-${v.to_port}" => v
  }

  security_group_id = aws_security_group.this.id
  cidr_ipv4         = each.value.cidr_ipv4
  from_port         = each.value.from_port
  ip_protocol       = each.value.ip_protocol
  to_port           = each.value.to_port
  prefix_list_id    = try(local.prefix_lists[each.value.prefix_list].id, null)
}

//-----------------------------------
// Security Group Egress Rule
//-----------------------------------
resource "aws_vpc_security_group_egress_rule" "this" {
  for_each = {
    for _, v in local.security_group_egress_rules : "${var.name}-${v.ip_protocol}-${v.target}-${v.from_port}-egress-${v.to_port}" => v
  }

  security_group_id = aws_security_group.this.id
  cidr_ipv4         = each.value.cidr_ipv4
  from_port         = each.value.from_port
  ip_protocol       = each.value.ip_protocol
  to_port           = each.value.to_port
  prefix_list_id    = try(local.prefix_lists[each.value.prefix_list].id, null)
}