resource "aws_s3_bucket" "example" {
  bucket = "anji45345"
  acl = "private"

  tags = {
    Name = "anji45345"
    Environment = "dev"
  }
}