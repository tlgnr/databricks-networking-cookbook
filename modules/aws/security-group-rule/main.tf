//-----------------------------------
// Locals
//-----------------------------------
locals {
  security_group_ingress_rules = {
    for _, v in var.security_group_ingress_rules : "${v.security_group_name}-${v.name}" => v
  }

  security_group_egress_rules = {
    for _, v in var.security_group_egress_rules : "${v.security_group_name}-${v.name}" => v
  }

  prefix_lists = {
    s3 = data.aws_ec2_managed_prefix_list.s3
  }
}

//-----------------------------------
// Prefix List
//-----------------------------------
data "aws_ec2_managed_prefix_list" "s3" {
  name = "com.amazonaws.${var.region}.s3"
}

//-----------------------------------
// Security Group Ingress Rule
//-----------------------------------
resource "aws_vpc_security_group_ingress_rule" "this" {
  for_each = local.security_group_ingress_rules

  cidr_ipv4                    = try(each.value.cidr_ipv4, null)
  from_port                    = each.value.from_port
  ip_protocol                  = each.value.ip_protocol
  prefix_list_id               = try(local.prefix_lists[each.value.prefix_list].id, null)
  referenced_security_group_id = try(each.value.referenced_security_group_id, null)
  to_port                      = each.value.to_port
  security_group_id            = var.security_group_id
}

//-----------------------------------
// Security Group Egress Rule
//-----------------------------------
resource "aws_vpc_security_group_egress_rule" "this" {
  for_each = local.security_group_egress_rules

  cidr_ipv4                    = try(each.value.cidr_ipv4, null)
  from_port                    = each.value.from_port
  ip_protocol                  = each.value.ip_protocol
  prefix_list_id               = try(local.prefix_lists[each.value.prefix_list].id, null)
  referenced_security_group_id = try(each.value.referenced_security_group_id, null)
  security_group_id            = var.security_group_id
  to_port                      = each.value.to_port
}