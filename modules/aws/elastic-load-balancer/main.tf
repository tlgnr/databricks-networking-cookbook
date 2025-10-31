//-----------------------------------
// Elastic Load Balancer
//-----------------------------------
resource "aws_lb" "this" {
  enable_cross_zone_load_balancing                             = var.enable_cross_zone_load_balancing
  enable_deletion_protection                                   = var.enable_deletion_protection
  enforce_security_group_inbound_rules_on_private_link_traffic = var.enforce_security_group_inbound_rules_on_private_link_traffic
  internal                                                     = var.internal
  load_balancer_type                                           = var.load_balancer_type
  name                                                         = var.name
  security_groups                                              = var.security_groups
  subnets                                                      = var.subnets

  tags = {
    Name = var.name
  }
}

//-----------------------------------
// Target Group
//-----------------------------------
resource "aws_lb_target_group" "this" {
  for_each = var.target_groups

  name        = each.value.name
  port        = each.value.port
  protocol    = each.value.protocol
  target_type = each.value.target_type
  vpc_id      = each.value.vpc_id

  tags = {
    Name = each.value.name
  }
}

//-----------------------------------
// RDS Dynamic IP
//-----------------------------------
data "dns_a_record_set" "this" {
  for_each = var.target_groups

  host = each.value.target_id
}

//-----------------------------------
// Target Group Attachment
//-----------------------------------
resource "aws_lb_target_group_attachment" "this" {
  for_each = var.target_groups

  target_group_arn = aws_lb_target_group.this[each.value.name].arn
  target_id        = data.dns_a_record_set.this[each.value.name].addrs[0]
  port             = each.value.port
}

//-----------------------------------
// Listener
//-----------------------------------
resource "aws_lb_listener" "this" {
  for_each = var.listeners

  load_balancer_arn = aws_lb.this.arn
  port              = each.value.port
  protocol          = each.value.protocol

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this[each.value.target_group_name].arn
  }
}
