//-----------------------------------
// Virtual Private Gateway
//-----------------------------------
variable "amazon_side_asn" {
  type    = string
  default = 64512
}

variable "name" {
  type = string
}

variable "route_table_ids" {
  type    = list(string)
  default = null
}

variable "vpc_id" {
  type = string
}
    