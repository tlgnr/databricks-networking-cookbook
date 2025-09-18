//-----------------------------------
// VPC Endpoint Data
//-----------------------------------
data "aws_vpc_endpoint_service" "this" {
  count = var.service != null ? 1 : 0

  service         = var.service
  service_regions = var.service_regions

  filter {
    name   = "service-type"
    values = [var.service_type]
  }
}

//-----------------------------------
// VPC Endpoint
//-----------------------------------
resource "aws_vpc_endpoint" "this" {
  vpc_id              = var.vpc_id
  service_name        = var.service_name != null ? var.service_name : data.aws_vpc_endpoint_service.this[0].service_name
  vpc_endpoint_type   = var.service_type
  security_group_ids  = var.service_type == "Interface" ? var.security_group_ids : null
  subnet_ids          = var.service_type == "Interface" ? var.subnet_ids : null
  route_table_ids     = var.service_type == "Gateway" ? var.route_table_ids : null
  private_dns_enabled = var.service_type == "Interface" ? var.private_dns_enabled : null

  tags = {
    Name = var.name
  }
}