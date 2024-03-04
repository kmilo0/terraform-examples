output "aws_ami" {
  value       = data.aws_ami.latest-amazon-linux-image.description  
}

output "ELB" {
  value = aws_elb.my-elb.dns_name
}

