//-----------------------------------
// Public IP
//-----------------------------------
variable "allocation_method" {
  type = string
}

variable "location" {
  type = string
}

variable "name" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "sku" {
  type = string
}

variable "tags" {
  type = map(string)
}