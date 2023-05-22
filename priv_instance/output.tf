output "instance-1a-id" {
  value = aws_instance.priv-servers[0].id
}
output "instance-1b-id" {
  value = aws_instance.priv-servers[1].id
}