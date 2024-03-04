# Creates 1 instance
# 1 ENI
# 1 EC2Volume
resource "aws_instance" "web" {
  ami = data.aws_ami.latest-amazon-linux-image.id
  instance_type = "t2.micro"

  subnet_id = module.vpc.public_subnets[0]
  vpc_security_group_ids = [aws_security_group.myapp-sg.id]
  availability_zone = local.avail_zone

  associate_public_ip_address = true
  key_name = aws_key_pair.ssh-key.key_name

  user_data = file("entry-script.sh")

  tags = {
      Name = "web"
  }

}
