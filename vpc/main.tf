
resource "aws_vpc" "Tera-vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "Tera-vpc"
  }
}

resource "aws_security_group" "My-sg" {
  name        = "My-sg"
  description = "Allow all in/outbound traffic"
  vpc_id      = aws_vpc.Tera-vpc.id

  ingress {
    from_port = var.rules["from"]
    to_port   = var.rules["to"]
    protocol  = var.rules["protocol"]
    cidr_blocks = [var.rules["v4"]]
    ipv6_cidr_blocks = [var.rules["v6"]]
  }

  egress {
    from_port = var.rules["from"]
    to_port = var.rules["to"]
    protocol = var.rules["protocol"]
    cidr_blocks = [var.rules["v4"]]
    ipv6_cidr_blocks = [var.rules["v6"]]
  }
}