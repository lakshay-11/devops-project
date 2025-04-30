resource "aws_autoscaling_policy" "scale_out" {
    name = "scale-out-policy"
    scaling_adjustment = 1
    adjustment_type = "ChangeInCapacity"
    cooldown = 300
    autoscaling_group_name = aws_autoscaling_group.app_asg.name
}

resource "aws_autoscaling_policy" "scale_in" {
    name = "scale-in-policy"
    scaling_adjustment = -1
    adjustment_type = "ChangeInCapacity"
    cooldown = 300
    autoscaling_group_name = aws_autoscaling_group.app_asg.name
}

resource "aws_cloudwatch_metric_alarm" "high_cpu" {
    alarm_name = "HighCPUUtilization"
    comparison_operator = "GreaterThanThreshold"
    evaluation_periods = 2
    metric_name = "CPUUtilization"
    namespace = "AWS/EC2"
    period = 120
    statistic = "Average"
    threshold = 70
  
    dimensions = {
      AutoScalingGroupName = aws_autoscaling_group.app_asg.name
    }

    alarm_actions = [ aws_autoscaling_policy.scale_out.arn ]
}

resource "aws_cloudwatch_metric_alarm" "low_cpu" {
    alarm_name = "LowCPUUtilization"
    comparison_operator = "LessThanThreshold"
    evaluation_periods = 2
    metric_name = "CPUUtilization"
    namespace = "AWS/EC2"
    period = 120
    statistic = "Average"
    threshold = 30
  
    dimensions = {
      AutoScalingGroupName = aws_autoscaling_group.app_asg.name
    }

    alarm_actions = [ aws_autoscaling_policy.scale_in.arn ]
}