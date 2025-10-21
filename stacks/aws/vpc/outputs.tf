//-----------------------------------
// AWS Security Groups
//-----------------------------------
output "aws_security_group_ids" {
  value = module.aws_security_group
}

//-----------------------------------
// AWS Subnets
//-----------------------------------
output "aws_subnet_ids" {
  value = module.aws_subnet
}

//-----------------------------------
// AWS VPCs
//-----------------------------------
output "aws_vpc_ids" {
  value = module.aws_vpc
}

//-----------------------------------
// AWS VPC Endpoints
//-----------------------------------
output "aws_vpc_endpoint_ids" {
  value = module.aws_vpc_endpoint
}
