//-----------------------------------
// Virtual Private Gateway Route Propagation
//-----------------------------------
resource "aws_vpn_gateway_route_propagation" "this" {
  vpn_gateway_id = var.vpn_gateway_id
  route_table_id = var.route_table_id
}