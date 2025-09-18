//-----------------------------------
// Virtual Private Gateway
//-----------------------------------
resource "aws_vpn_gateway" "this" {
  vpc_id          = var.vpc_id
  amazon_side_asn = var.amazon_side_asn

  tags = {
    Name = var.name
  }
}