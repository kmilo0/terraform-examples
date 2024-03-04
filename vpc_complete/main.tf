# Configure the AWS Provider
provider "aws" {
  profile = "terraform"
  region = local.region  
}

locals {
  region = "us-east-1"
  avail_zone = "${local.region}a"  
}
