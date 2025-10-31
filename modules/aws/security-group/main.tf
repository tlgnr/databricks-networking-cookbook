//-----------------------------------
// Security Group
//-----------------------------------
resource "aws_security_group" "this" {
  description = var.description
  vpc_id      = var.vpc_id
  name        = var.name

  tags = {
    Name = var.name
  }
}