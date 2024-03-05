output "aws_ami" {
  value       = data.aws_ami.latest-amazon-linux-image.description  
}

output "asg_name" {
  value = module.asg.autoscaling_group_name
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
