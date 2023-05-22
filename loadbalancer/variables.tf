variable "lb-name" {
  type = string
}
variable "lb_type" {
  type = bool
}
variable "sg" {
  type = list(string)
}
variable "subs" {
  type = list(string)
}
variable "tg-name" {
  type = string
}
variable "vpc-id" {
  type = string
}
variable "instance-id" {
  type = list(string)
}