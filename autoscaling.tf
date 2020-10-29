resource "aws_launch_configuration" "sush-launchconfig" {
  name_prefix     = "sush-launchconfig"
  image_id        = var.AMIS[var.AWS_REGION]
  instance_type   = "t2.micro"
  key_name        = aws_key_pair.mykeypair.key_name
  security_groups = [aws_security_group.sush-SG.id]
  user_data       = "${file("sush.sh")}"
}

resource "aws_autoscaling_group" "sush-autoscaling" {
  name                      = "sush-autoscaling"
  vpc_zone_identifier       = [aws_subnet.sush-public-1.id, aws_subnet.sush-public-2.id]
  launch_configuration      = aws_launch_configuration.sush-launchconfig.name
  min_size                  = 2
  max_size                  = 4
  health_check_grace_period = 300
  health_check_type         = "ELB"
# load_balancers            = [aws_alb.sush-alb.name]

  force_delete              = true

  tag {
    key                 = "Name"
    value               = "ec2 instance"
    propagate_at_launch = true
  }
}
