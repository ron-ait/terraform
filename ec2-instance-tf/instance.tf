# resource "aws_instance" "web" {
#   ami = "ami-08c40ec9ead489470"

#   instance_type = "t2.micro"
#   key_name = "${aws_key_pair.hello.key_name}"
#   tags = {
#     Name = "HelloWorld"
#   }
# }