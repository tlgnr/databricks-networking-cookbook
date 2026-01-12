//-----------------------------------
// Dependencies
//-----------------------------------
variable "aws_security_groups" {
  type = map(map(string))
}

variable "aws_subnets" {
  type = map(map(string))
}

//-----------------------------------
// AWS General
//-----------------------------------
variable "region" {
  type = string
}

variable "tags" {
  type = map(string)
}

//-----------------------------------
// AWS RDS Subnet Groups
//-----------------------------------
variable "aws_subnet_groups" {
  type = map(object({
    name         = string
    subnet_names = list(string)
  }))
}

//-----------------------------------
// AWS RDS Instances
//-----------------------------------
variable "aws_rds_instances" {
  type = map(object({
    allocated_storage                   = number
    apply_immediately                   = bool
    copy_tags_to_snapshot               = bool
    engine                              = string
    engine_version                      = string
    iam_database_authentication_enabled = bool
    identifier                          = string
    instance_class                      = string
    max_allocated_storage               = number
    parameter_group_name                = string
    skip_final_snapshot                 = bool
    storage_encrypted                   = bool
    subnet_group_name                   = string
    username                            = string
    vpc_security_group_names            = list(string)
  }))
}