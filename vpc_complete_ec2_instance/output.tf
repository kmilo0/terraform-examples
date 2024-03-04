output "aws_ami" {
  value       = data.aws_ami.latest-amazon-linux-image.description  
}

output "aws_instance_ssh_public_ip" {
    value = "ssh ec2-user@${aws_instance.web.public_ip}"
}

output "aws_instance_http_public_ip" {
    value = "http://${aws_instance.web.public_ip}"
}