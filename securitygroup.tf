resource "aws_security_group" "sush-SG" {
  vpc_id      = aws_vpc.sush-vpc.id
  name        = "sush-SG"
  description = "security group that allows ssh, http and all egress traffic"
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.sush-alb-sg.id]
  }

  tags = {
    Name = "sush-SG"
  }
}

#resource "aws_security_group" "elb-securitygroup" {
#  vpc_id      = aws_vpc.sush-vpc.id
#  name        = "elb"
#  description = "security group for load balancer"
#  egress {
#    from_port   = 0
#    to_port     = 0
#    protocol    = "-1"
#    cidr_blocks = ["0.0.0.0/0"]
#  }

#  ingress {
#    from_port   = 80
#    to_port     = 80
#    protocol    = "tcp"
#    cidr_blocks = ["0.0.0.0/0"]
#  }
#  tags = {
#    Name = "elb"
#  }
#}


resource "aws_security_group" "sush-alb-sg" {
  name        = "sush-alb-sg"
  description = "Terraform load balancer security group"
  vpc_id      = "${aws_vpc.sush-vpc.id}"

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all outbound traffic.
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "sush-alb-sg"
  }
}
