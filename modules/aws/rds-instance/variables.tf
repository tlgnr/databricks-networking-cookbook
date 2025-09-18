//-----------------------------------
// DB Subnet Group
//-----------------------------------
variable "subnet_group_name" {
  type = string
}

variable "subnet_ids" {
  type = list(string)
}

//-----------------------------------
// RDS Instance
//-----------------------------------
variable "allocated_storage" {
  type = number
}

variable "apply_immediately" {
  type = bool
}

variable "copy_tags_to_snapshot" {
  type = bool
}

variable "engine" {
  type = string
}

variable "engine_version" {
  type = string
}

variable "iam_database_authentication_enabled" {
  type = bool
}

variable "identifier" {
  type = string
}

variable "instance_class" {
  type = string
}


variable "max_allocated_storage" {
  type = number
}

variable "parameter_group_name" {
  type = string
}

variable "skip_final_snapshot" {
  type = bool
}

variable "storage_encrypted" {
  type = bool
}

variable "username" {
  type = string
}

variable "vpc_security_group_ids" {
  type = list(string)
}