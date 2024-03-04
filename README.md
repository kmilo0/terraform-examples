# AWS Credentials

To run the AWS examples you will need your AWS credentials, they could be setup in the file

- Linux: $HOME/.aws/credentials
- Windows: "%USERPROFILE%\.aws\credentials"

And the content of the file is

```
[terraform]
aws_access_key_id=my-access-key
aws_secret_access_key=my-secret-key
```

More info about the AWS Provider Authentication and Configuration could be fount at https://registry.terraform.io/providers/hashicorp/aws/latest/docs#authentication-and-configuration

# Deploy

- Move to the folder of the example you want to deploy.
- Execute the commands

```
terraform init
terraform plan
terraform apply
```

## Clean Up

```
terraform destroy
```

# Terraform version

This was tested with Terraform v1.7.4

# Examples overview

| Example Directory         | Description                        |
| ------------------------- | ---------------------------------- |
| vpc_simple                | Basic vpc                          |
| vpc_complete              | Fully fledged vpc                  |
| vpc_complete_ec2_instance | Fully fledged vpc and ec2 instance |
| asg                       | Auto Scaling Group                 |
| asg_elb                   | Auto Scaling Group and ELB         |
