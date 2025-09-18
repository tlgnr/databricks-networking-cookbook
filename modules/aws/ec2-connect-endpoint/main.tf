//-----------------------------------
// EC2 Instance Connect Endpoint
//-----------------------------------
resource "aws_ec2_instance_connect_endpoint" "this" {
  subnet_id          = var.subnet_id
  security_group_ids = var.security_group_ids
  tags               = var.tags
}
