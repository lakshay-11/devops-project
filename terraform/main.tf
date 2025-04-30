module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  name = "full-devops-vpc"
  cidr = var.vpc_cidr
  azs = ["ap-south-1a" , "ap-south-1b"]
  public_subnets = var.public_subnets
  enable_nat_gateway = false
}

resource "aws_security_group" "alb_sg" {
    name = "alb-sg"
    description = "Allow web traffic"
    vpc_id = module.vpc.vpc_id

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = [ "0.0.0.0/0" ]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = [ "0.0.0.0/0" ]
    }
}

resource "aws_lb" "app_lb" {
    name = "app-lb"
    load_balancer_type = "application"
    security_groups = [ aws_security_group.alb_sg.id ]
    subnets = module.vpc.public_subnets
}

resource "aws_lb_target_group" "app_tg" {
    name = "app-tg"
    port = 80
    protocol = "HTTP"
    vpc_id = module.vpc.vpc_id
    target_type = "instance"
    health_check {
      path = "/"
      matcher = "200"
      interval = 30
      timeout = 5
      healthy_threshold = 5
      unhealthy_threshold = 2
    }
}

resource "aws_lb_listener" "front_end" {
    load_balancer_arn = aws_lb.app_lb.arn
    port = 80
    protocol = "HTTP"
  
    default_action {
        type = "forward"
        target_group_arn = aws_lb_target_group.app_tg.arn
    }
}