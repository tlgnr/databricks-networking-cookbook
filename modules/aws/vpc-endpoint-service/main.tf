//-----------------------------------
// VPC Endpoint Service
//-----------------------------------
resource "aws_vpc_endpoint_service" "this" {
  allowed_principals         = var.allowed_principals
  acceptance_required        = var.acceptance_required
  network_load_balancer_arns = var.network_load_balancer_arns

  tags = {
    Name = var.name
  }
}