resource "aws_instance" "web" {
  ami = "ami-08c40ec9ead489470"

  instance_type = "t2.micro"

  key_name               = "devops-rohit2"
  vpc_security_group_ids = [aws_security_group.allow_tl1.id]
  tags = {
    Name = "HelloWorld"
  }
  user_data =<<EOF
#!/bin/bash
sudo apt-get update
sudo apt-get upgrade -y  
sudo apt-get install nginx -y 
EOF
}  