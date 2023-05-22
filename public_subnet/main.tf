
resource "aws_subnet" "pub-subs" {
  count = length(var.subnet_cidr)
  vpc_id = var.vpc-id
  cidr_block = var.subnet_cidr[count.index]
  map_public_ip_on_launch = var.sub_type
  availability_zone = var.az[count.index]
  tags = {
    Name = var.sub_names[count.index]
  }
}

resource "aws_internet_gateway" "My-gw" {
  vpc_id = var.vpc-id
  }

resource "aws_route_table" "public-rt" {
  vpc_id = var.vpc-id

  route {
    cidr_block = var.all_route
    gateway_id = aws_internet_gateway.My-gw.id
  }
}

resource "aws_route_table_association" "pub-sub-rt" {
  count = length(var.subnet_cidr)
  subnet_id = aws_subnet.pub-subs[count.index].id
  route_table_id = aws_route_table.public-rt.id
}