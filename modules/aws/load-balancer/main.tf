//-----------------------------------
// Load Balancer
//-----------------------------------
resource "aws_lb" "this" {
  name                       = var.name
  internal                   = var.internal
  load_balancer_type         = var.load_balancer_type
  subnets                    = var.subnets
  enable_deletion_protection = var.enable_deletion_protection
  security_groups            = var.security_groups

  tags = {
    Name = var.name
  }
}