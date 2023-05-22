
resource "aws_subnet" "priv-subs" {
  count = length(var.subnet_cidr)
  vpc_id = var.vpc-id
  cidr_block = var.subnet_cidr[count.index]
  availability_zone = var.az[count.index]
  tags = {
    Name = var.sub_names[count.index]
  }
}
resource "aws_route_table" "private-rt" {
  vpc_id = var.vpc-id

  route {
    cidr_block = var.all_route
    gateway_id = aws_nat_gateway.my-ngw.id
  }
}


resource "aws_route_table_association" "private-rt" {
  count = length(var.subnet_cidr)
  subnet_id = aws_subnet.priv-subs[count.index].id
  route_table_id = aws_route_table.private-rt.id
}

resource "aws_eip" "nat_eip" {
  vpc = true
}

resource "aws_nat_gateway" "my-ngw" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id = var.pub-sub-id
}