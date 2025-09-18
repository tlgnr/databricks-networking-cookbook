//-----------------------------------
// General
//-----------------------------------
variable "environment" {
  type = string
}

variable "tags" {
  type = map(string)
}

//-----------------------------------
// AWS
//-----------------------------------
variable "region" {
  type = string
}

//-----------------------------------
// Azure
//-----------------------------------
variable "location" {
  type = string
}

variable "subscription_id" {
  type = string
}