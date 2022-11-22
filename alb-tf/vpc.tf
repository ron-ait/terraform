resource "aws_vpc" "vpctf" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "vpctf"
  }
}

resource "aws_internet_gateway" "ig-tf" {
  vpc_id = aws_vpc.vpctf.id

  tags = {
    Name = "ig-tf"
  }
}

resource "aws_route_table" "rt-tf" {
  vpc_id = aws_vpc.vpctf.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ig-tf.id
  }

  tags = {
    Name = "rt-tf"
  }
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.public2.id
  route_table_id = aws_route_table.rt-tf.id
}

resource "aws_route_table_association" "b" {
  subnet_id      = aws_subnet.public1.id
  route_table_id = aws_route_table.rt-tf.id
}