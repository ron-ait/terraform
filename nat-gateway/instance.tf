resource "aws_instance" "HelloWorld" {
  ami = "ami-08c40ec9ead489470"

  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.private2.id
  key_name               = "devops-rohit2"
  vpc_security_group_ids = [aws_security_group.allow_tl1.id]
  tags = {
    Name = "HelloWorld"
  }
}

resource "aws_instance" "HelloWorld2" {
  ami = "ami-08c40ec9ead489470"

  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.public1.id
  key_name               = "devops-rohit2"
  vpc_security_group_ids = [aws_security_group.allow_tl1.id]
  tags = {
    Name = "HelloWorld2"
  }
}

resource "aws_security_group" "allow_tl1" {
  name        = "allow_tl1"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.vpctf.id

  dynamic "ingress" {
    for_each = [22, 80, 443]
    iterator = port
    content {
      description = "TLS from VPC"
      from_port   = port.value
      to_port     = port.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_tl1"
  }
}