variable "subnet_cidr" {
  type = list(string)
}
variable "vpc-id" {
  type = string
}
variable "all_route" {
  type = string
}
variable "sub_names" {
  type = list(string)
}
variable "sub_type" {
  type = bool
}
variable "az" {
  type = list(string)
}