//-----------------------------------
// Virtual Private Gateway
//-----------------------------------
output "id" {
  value = aws_vpn_gateway.this.id
}

output "asn" {
  value = aws_vpn_gateway.this.amazon_side_asn
}