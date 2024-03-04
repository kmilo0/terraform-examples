output "aws_vpc" {
    value = aws_vpc.example.tags_all["Name"]
}
