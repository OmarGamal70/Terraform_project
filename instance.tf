#Create EC2 instances in public subnets
resource "aws_instance" "Pub2a_ec2" {
  ami                         = "ami-006dcf34c09e50022"
  instance_type               = "t2.micro"
  associate_public_ip_address = true
  subnet_id                   = aws_subnet.Public_sub2a.id
  security_groups             = [aws_security_group.my_vpc_sg.id]

  user_data = <<-EOF
    #!/bin/bash
    yum update -y
    yum install -y httpd
    systemctl start httpd
    systemctl enable httpd
    echo "<h1>Code finally Worked.EC2 instance launched in us-east-2a!!!</h1>" > var/www/html/index.html
    EOF
}

resource "aws_instance" "Pub2b_ec2" {
  ami                         = "ami-006dcf34c09e50022"
  instance_type               = "t2.micro"
  associate_public_ip_address = true
  subnet_id                   = aws_subnet.Public_sub2b.id
  security_groups             = [aws_security_group.my_vpc_sg.id]

  user_data = <<-EOF
    #!/bin/bash
    yum update -y
    yum install -y httpd
    systemctl start httpd
    systemctl enable httpd
    echo "<h1>Code finally Worked.EC2 instance launched in us-east-2b!!!</h1>" > var/www/html/index.html
    EOF
}

##########################################################################
#Db instances

#Create EC2 instances in public subnets
resource "aws_instance" "db_ec2" {
  ami                         = "ami-006dcf34c09e50022"
  instance_type               = "t2.micro"
  associate_public_ip_address = false
  subnet_id                   = aws_subnet.db_private_sub2a.id
  security_groups             = [aws_security_group.db_sg.id]

}

#Create EC2 instances in public subnets
resource "aws_instance" "db2_ec2" {
  ami                         = "ami-006dcf34c09e50022"
  instance_type               = "t2.micro"
  associate_public_ip_address = false
  subnet_id                   = aws_subnet.db_Private_sub2b.id
  security_groups             = [aws_security_group.db_sg.id]

}