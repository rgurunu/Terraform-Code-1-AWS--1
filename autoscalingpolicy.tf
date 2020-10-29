# scale up alarm

resource "aws_autoscaling_policy" "sush-cpu-policy" {
  name                   = "sush-cpu-policy"
  autoscaling_group_name = aws_autoscaling_group.sush-autoscaling.name
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = "1"
  cooldown               = "300"
  policy_type            = "SimpleScaling"
}

resource "aws_cloudwatch_metric_alarm" "sush-cpu-alarm" {
  alarm_name          = "sush-cpu-alarm"
  alarm_description   = "sush-cpu-alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "60"
  statistic           = "Average"
  threshold           = "10"

  dimensions = {
    "AutoScalingGroupName" = aws_autoscaling_group.sush-autoscaling.name
  }

  actions_enabled = true
  alarm_actions   = [aws_autoscaling_policy.sush-cpu-policy.arn]
}

# scale down alarm
resource "aws_autoscaling_policy" "sush-cpu-policy-scaledown" {
  name                   = "sush-cpu-policy-scaledown"
  autoscaling_group_name = aws_autoscaling_group.sush-autoscaling.name
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = "-1"
  cooldown               = "300"
  policy_type            = "SimpleScaling"
}

resource "aws_cloudwatch_metric_alarm" "sush-cpu-alarm-scaledown" {
  alarm_name          = "sush-cpu-alarm-scaledown"
  alarm_description   = "sush-cpu-alarm-scaledown"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "5"

  dimensions = {
    "AutoScalingGroupName" = aws_autoscaling_group.sush-autoscaling.name
  }

  actions_enabled = true
  alarm_actions   = [aws_autoscaling_policy.sush-cpu-policy-scaledown.arn]
}
