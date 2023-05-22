output "vpc-id" {
  value = aws_vpc.Tera-vpc.id
}
output "sg-id" {
  value = aws_security_group.My-sg.id
}

