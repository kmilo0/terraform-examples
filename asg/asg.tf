module "asg" {
  source  = "terraform-aws-modules/autoscaling/aws"

  # Autoscaling group
  name = "example-autoscaling"
  vpc_zone_identifier = module.vpc.public_subnets

  min_size            = 1
  max_size            = 2
  desired_capacity    = 1
  health_check_grace_period = 300
  health_check_type         = "EC2"

  # Launch template
  launch_template_name = "example-launchtemplate"
  launch_template_use_name_prefix=true

  image_id      = data.aws_ami.latest-amazon-linux-image.id
  instance_type = "t2.micro"

  network_interfaces = [
    {
      associate_public_ip_address = true
      security_groups = [aws_security_group.myapp-sg.id]
    }
  ]

  key_name        = aws_key_pair.ssh-key.key_name
  user_data = filebase64("entry-script.sh")
}
