//-----------------------------------
// Virtual Private Gateway Connection
//-----------------------------------
resource "aws_vpn_connection" "this" {
  vpn_gateway_id      = var.vpn_gateway_id
  customer_gateway_id = var.customer_gateway_id
  tunnel1_inside_cidr = var.tunnel1_inside_cidr
  tunnel2_inside_cidr = var.tunnel2_inside_cidr
  type                = "ipsec.1"

  tags = {
    Name = var.name
  }
}