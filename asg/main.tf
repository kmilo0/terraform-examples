# Configure the AWS Provider
provider "aws" {
  profile = "terraform"
  region = local.region  
}

locals {
  region = "us-east-1"
  avail_zone = "${local.region}a"  
}

variable public_key_location {}

# terraform-aws-modules/vpc/aws creates
# 1 VPC with
# 1 default Route table
# 1 default Network ACL
# 1 default Security Group WITHOUT RULES

# public_subnets creates
# 1 internet gateway
#   1 association with the vpc
# 1 subnet
# 1 non-default route table
#   1 association with the subnet
#   1 route with destination 0.0.0.0/0 and the target is the Internet gateway
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "my-vpc"
  cidr = "10.16.0.0/16"
  
  public_subnets  = ["10.16.101.0/24"]
  azs = [local.avail_zone]    
}

resource "aws_security_group" "myapp-sg" {
    vpc_id = module.vpc.vpc_id
    name = "myapp-sg"

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    # egress rule ALLOW ALL. By default terraform doesn't have this rule, but AWS does.
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
        prefix_list_ids = []
    }

    tags = {
        Name = "my-sg"
    }
}

resource "aws_key_pair" "ssh-key" {
    key_name = "server-key"
    public_key = file(var.public_key_location)
}

data "aws_ami" "latest-amazon-linux-image" {
  most_recent = true
  owners           = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-kernel*-x86_64-gp2"]
  }
}

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

output "aws_ami" {
  value       = data.aws_ami.latest-amazon-linux-image.description  
}

output "asg_name" {
  value = aws_autoscaling_group.example-autoscaling.name
}

output "public_ip" {
    value = "Go to the ec2 console to get the public ip of the instance"
}

output "ssh_public_ip" {
    value = "ssh ec2-user@<public_ip>"
}

output "http_public_ip" {
    value = "http://<public_ip>"
}

