//application load balancer 

resource "aws_lb" "alb-tf" {
  name               = "alb-tf"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.allow_tl1.id]
  subnets            = [aws_subnet.public2.id, aws_subnet.public1.id]

  enable_deletion_protection = false

  tags = {
    Name = "alb-tf"
  }
}


//target group 

resource "aws_lb_target_group" "lb-tg-tf" {
  name     = "lb-tg-tf"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpctf.id
}


//aws load balancer listener 

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.alb-tf.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.lb-tg-tf.arn

  }
}



// aws target group attachment 

resource "aws_lb_target_group_attachment" "test" {
  target_group_arn = aws_lb_target_group.lb-tg-tf.arn
  target_id        = aws_instance.web.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "test2" {
  target_group_arn = aws_lb_target_group.lb-tg-tf.arn
  target_id        = aws_instance.web2.id
  port             = 80
}
