resource "aws_alb" "sush-alb" {
  name            = "sush-alb"
  security_groups = ["${aws_security_group.sush-alb-sg.id}"]
  subnets         = ["${aws_subnet.sush-public-1.id}","${aws_subnet.sush-public-2.id}"]
  tags = {
    Name = "sush-alb"
  }
}

resource "aws_lb_target_group" "sush-lb-tgroup" {
  name     = "sush-lb-tgroup"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "${aws_vpc.sush-vpc.id}"
  target_type = "instance"
  stickiness {
    type = "lb_cookie"
  }
  # Alter the destination of the health check to be the login page.
  health_check {
    path = "/"
    port = 80
  }
}

resource "aws_autoscaling_attachment" "sush-attachment" {
   alb_target_group_arn = "${aws_lb_target_group.sush-lb-tgroup.arn}"
   autoscaling_group_name = "${aws_autoscaling_group.sush-autoscaling.id}"
}


resource "aws_alb_listener" "sush-listener_http" {
  load_balancer_arn = "${aws_alb.sush-alb.arn}"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${aws_lb_target_group.sush-lb-tgroup.arn}"
    type             = "forward"
  }
}

resource "aws_alb_listener" "sush-listener_https" {
  load_balancer_arn = "${aws_alb.sush-alb.arn}"
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = "${var.certificate_arn}"
  default_action {
    target_group_arn = "${aws_lb_target_group.sush-lb-tgroup.arn}"
    type             = "forward"
  }
}
