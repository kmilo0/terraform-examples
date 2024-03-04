resource "aws_security_group" "myapp-sg" {
  vpc_id = module.vpc.vpc_id
  name        = "myapp-sg"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.elb-securitygroup.id]
  }

    # egress rule ALLOW ALL. By default terraform doesn't have this rule, but AWS does.
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }


  tags = {
    Name = "myapp-sg"
  }
}

resource "aws_security_group" "elb-securitygroup" {
  vpc_id = module.vpc.vpc_id
  name        = "elb"
  description = "security group for load balancer"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

    # egress rule ALLOW ALL. By default terraform doesn't have this rule, but AWS does.
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }


  tags = {
    Name = "elb"
  }
}

