//-----------------------------------
// EC2 Instance Connect Endpoint
//-----------------------------------
variable "security_group_ids" {
  type    = list(string)
  default = []
}

variable "subnet_id" {
  type = string
}

variable "tags" {
  type = map(string)
}