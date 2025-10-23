//-----------------------------------
// VPC Endpoint Service
//-----------------------------------
output "service_name" {
    value = aws_vpc_endpoint_service.this.service_name
}