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
// Dependencies
//-----------------------------------
variable "subnet_ids" {
  type = map(map(string))
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