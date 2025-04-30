resource "aws_autoscaling_group" "app_asg" {
    desired_capacity = 2
    max_size = 4
    min_size = 2
    vpc_zone_identifier = module.vpc.public_subnets
    launch_template {
      id = aws_launch_template.app_lt.id
      version = "$Latest"
    }

    target_group_arns = [ aws_lb_target_group.app_tg.arn ]
    health_check_type = "EC2"
}