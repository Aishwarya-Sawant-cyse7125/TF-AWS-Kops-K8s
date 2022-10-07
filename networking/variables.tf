variable "vpc_cidr" {
  type      = string
}
variable "vpc_name" {
  type      = string
}
variable "region" {
  type      = string
  default   = "us-east-1"
}
variable "private_subnet_1" {
  type      = string
  default   = "10.0.0.1/24"
}
variable "private_subnet_2" {
  type      = string
  default   = "10.0.0.2/24"
}
variable "private_subnet_3" {
  type      = string
  default   = "10.0.0.3/24"
}
variable "clustername" {
  type = string
}