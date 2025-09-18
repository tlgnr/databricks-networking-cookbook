//-----------------------------------
// Route Table Rule
//-----------------------------------
resource "aws_route" "this" {
  route_table_id             = var.route_table_id
  destination_cidr_block     = var.destination_cidr_block
  destination_prefix_list_id = var.destination_prefix_list_id
  vpc_endpoint_id            = var.vpc_endpoint_id
  nat_gateway_id             = var.nat_gateway_id
  gateway_id                 = var.gateway_id
  network_interface_id       = var.network_interface_id
}