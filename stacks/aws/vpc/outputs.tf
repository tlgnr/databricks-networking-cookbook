//-----------------------------------
// AWS Security Groups
//-----------------------------------
output "aws_security_groups" {
  value = module.aws_security_group
}

//-----------------------------------
// AWS Subnets
//-----------------------------------
output "aws_subnets" {
  value = module.aws_subnet
}

//-----------------------------------
// AWS VPCs
//-----------------------------------
output "aws_vpcs" {
  value = module.aws_vpc
}

//-----------------------------------
// AWS VPC Endpoints
//-----------------------------------
output "aws_vpc_endpoints" {
  value = module.aws_vpc_endpoint
}
