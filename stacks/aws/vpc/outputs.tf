//-----------------------------------
// AWS Subnets
//-----------------------------------
output "aws_subnet_ids" {
  value = module.aws_subnet
}

//-----------------------------------
// AWS Security Groups
//-----------------------------------
output "aws_security_group_ids" {
  value = module.aws_security_group
}