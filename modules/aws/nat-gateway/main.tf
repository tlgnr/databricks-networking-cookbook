//-----------------------------------
// Elastic IP
//-----------------------------------
resource "aws_eip" "this" {
  domain = "vpc"
}

//-----------------------------------
// NAT Gateway
//-----------------------------------
resource "aws_nat_gateway" "this" {
  allocation_id = aws_eip.this.allocation_id
  subnet_id     = var.subnet_id

  tags = {
    Name = var.name
  }
}