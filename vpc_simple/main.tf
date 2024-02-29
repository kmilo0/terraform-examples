# Configure the AWS Provider
provider "aws" {
  profile = "terraform"
  region = "us-east-1"  
}

# Creates 1 VPC with 
# 1 default Route table 
# 1 default Network ACL 
# 1 default Security Group 
# 1 default inbound Security Group Rule
# 1 default outbound Security Group Rule
resource "aws_vpc" "example" {
  cidr_block = "10.16.0.0/16"
  
  tags = {
    Name = "main"
  }  
}
