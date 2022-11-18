//vpc 
resource "aws_vpc" "vpctf" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "vpctf"
  }
}


// elastic ip 
resource "aws_eip" "lb" {
  vpc = true

  tags = {
    Name = "lb"
  }
}


//internet gateway 
resource "aws_internet_gateway" "ig-tf" {
  vpc_id = aws_vpc.vpctf.id

  tags = {
    Name = "ig-tf"
  }
}

//NAT gateway 
resource "aws_nat_gateway" "nat-tf" {
  allocation_id = aws_eip.lb.id
  subnet_id     = aws_subnet.public1.id

  tags = {
    Name = "nat-tf"
  }
}


resource "aws_route_table" "pvt-rt-tf" {
  vpc_id = aws_vpc.vpctf.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat-tf.id
  }

  tags = {
    Name = "pvt-rt-tf"
  }
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.private2.id
  route_table_id = aws_route_table.pvt-rt-tf.id
}

resource "aws_route_table" "pub-rt-tf" {
  vpc_id = aws_vpc.vpctf.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ig-tf.id
  }

  tags = {
    Name = "pub-rt-tf"
  }
}
resource "aws_route_table_association" "b" {
  subnet_id      = aws_subnet.public1.id
  route_table_id = aws_route_table.pub-rt-tf.id
}