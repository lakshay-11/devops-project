resource "aws_launch_template" "app_lt" {
    name_prefix = "app-template"
    image_id = data.aws_ami.amzn2.id
    instance_type = var.instance_type
    key_name = var.key_name

    user_data = base64encode(file("user_data.sh"))
    vpc_security_group_ids = [ aws_security_group.alb_sg.id ]
}

data "aws_ami" "amzn2" {
    most_recent = true
    owners = [ "amazon" ]

    filter {
      name = "name"
      values = [ "amzn2-ami-hvm-*-x86_64-gp2"]
    }
}

