# ASG
resource "aws_launch_template" "example-launchtemplate" {
  name_prefix     = "example-launchtemplate"
  image_id        = data.aws_ami.latest-amazon-linux-image.id
  instance_type = "t2.micro"

  network_interfaces {
    associate_public_ip_address = true
    security_groups = [aws_security_group.myapp-sg.id]
  }

  key_name        = aws_key_pair.ssh-key.key_name
  user_data = filebase64("entry-script.sh")
}

resource "aws_autoscaling_group" "example-autoscaling" {
  name                      = "example-autoscaling"
  vpc_zone_identifier       = module.vpc.public_subnets

  launch_template {
    id      = aws_launch_template.example-launchtemplate.id
    version = aws_launch_template.example-launchtemplate.latest_version
  }

  min_size                  = 1
  max_size                  = 2
  health_check_grace_period = 300
  health_check_type         = "EC2"
  force_delete              = true

  tag {
    key                 = "Name"
    value               = "ec2 instance"
    propagate_at_launch = true
  }
}
