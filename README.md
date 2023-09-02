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
