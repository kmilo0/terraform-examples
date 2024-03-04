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
