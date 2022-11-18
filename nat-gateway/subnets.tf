resource "aws_subnet" "public1" {
  vpc_id                  = aws_vpc.vpctf.id
  cidr_block              = "10.0.0.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "public1"
  }
}

resource "aws_subnet" "private2" {
  vpc_id                  = aws_vpc.vpctf.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = false
  tags = {
    Name = "private2"
  }
}




