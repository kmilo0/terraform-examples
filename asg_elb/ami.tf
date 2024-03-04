data "aws_ami" "latest-amazon-linux-image" {
  most_recent = true
  owners           = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-kernel*-x86_64-gp2"]
  }
}
