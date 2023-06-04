#Create an ALB target group
resource "aws_lb_target_group" "alb-TG" {
  name     = "alb-TG"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.my_vpc.id
}

#Create Load balancer
resource "aws_lb" "my-aws-alb" {
  name               = "my-aws-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.my_vpc_sg.id]
  subnets            = [aws_subnet.Public_sub2a.id, aws_subnet.Public_sub2b.id]
}

# Create Load balancer listner rule
resource "aws_lb_listener" "lb_lst" {
  load_balancer_arn = aws_lb.my-aws-alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb-TG.arn
  }
}

#Load balancer-Target group attachment
resource "aws_lb_target_group_attachment" "my-aws-alb" {
  target_group_arn = aws_lb_target_group.alb-TG.arn
  target_id        = aws_instance.Pub2a_ec2.id
  port             = 80
}

#Load balancer-Target group attachment
resource "aws_lb_target_group_attachment" "my-aws-alb2" {
  target_group_arn = aws_lb_target_group.alb-TG.arn
  target_id        = aws_instance.Pub2b_ec2.id
  port             = 80
}

#network_load_balancer
#Create an NLB target group
resource "aws_lb_target_group" "nlb-TG" {
  name     = "nlb-TG"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.my_vpc.id
}

#Create Load balancer
resource "aws_lb" "my-aws-nlb" {
  name               = "my-aws-nlb"
  internal           = true
  load_balancer_type = "application"
  security_groups    = [aws_security_group.db_sg.id]
  subnets            = [aws_subnet.db_private_sub2a.id, aws_subnet.db_Private_sub2b.id]
}

# Create Load balancer listner rule
resource "aws_lb_listener" "lb_2st" {
  load_balancer_arn = aws_lb.my-aws-nlb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.nlb-TG.arn
  }
}

#Network Load balancer-Target group attachment
resource "aws_lb_target_group_attachment" "my-aws-nlb" {
  target_group_arn = aws_lb_target_group.nlb-TG.arn
  target_id        = aws_instance.db_ec2.id
  port             = 80
}

#Load balancer-Target group attachment
resource "aws_lb_target_group_attachment" "my-aws-nlb2" {
  target_group_arn = aws_lb_target_group.nlb-TG.arn
  target_id        = aws_instance.db2_ec2.id
  port             = 80
}