# Configure the AWS Provider
provider "aws" {
  profile = "terraform"
  region = local.region  
}

locals {
  region = "us-east-1"
  avail_zone = "${local.region}a"  
}

# Creates 1 VPC with
# 1 default Route table
# 1 default Network ACL
# 1 default Security Group

# public_subnets creates
# 1 subnet
# 1 non-default route table
#   1 associated with the subnet
#   1 route with destination 0.0.0.0/0 and the target is the Internet gateway
# 1 internet gateway
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "my-vpc"

  azs = [local.avail_zone]
  public_subnets  = ["10.0.101.0/24"]  
}