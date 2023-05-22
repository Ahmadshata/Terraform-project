
resource "aws_instance" "priv-servers" {
  count = 2
  ami = var.image
  key_name = "test"
  instance_type = var.type
  vpc_security_group_ids = var.sg
  user_data = var.ud-file
  subnet_id = var.sub-id[count.index]

  provisioner "local-exec" {
    command = "echo ${self.private_ip} >> ./private_ip.txt"
  }
}
