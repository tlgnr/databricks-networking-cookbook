//-----------------------------------
// Dependencies
//-----------------------------------
variable "aws_security_group_ids" {
  type = list(string)
}

variable "aws_subnet_ids" {
  type = list(string)
}

variable "aws_vpc_endpoint_relay_id" {
  type = string
}

variable "aws_vpc_endpoint_rest_api_id" {
  type = string
}

variable "aws_vpc_id" {
  type = string
}

//-----------------------------------
// Databricks Network Configuration
//-----------------------------------
variable "account_id" {
  type = string
}

variable "environment" {
  type = string
}

variable "network_name" {
  type = string
}

variable "region" {
  type = string
}
