resource "aws_security_group" "allow_tls" {
  name        = "allow_tl1"
  description = "Allow TLS inbound traffic"


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

  #   ingress {
  #     description = "TLS from VPC"
  #     from_port   = 22
  #     to_port     = 22
  #     protocol    = "tcp"
  #     cidr_blocks = ["0.0.0.0/0"]
  #   }

  #   ingress {
  #     description = "TLS from VPC"
  #     from_port   = 443
  #     to_port     = 443
  #     protocol    = "tcp"
  #     cidr_blocks = ["0.0.0.0/0"]
  #   }
}