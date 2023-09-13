resource "aws_s3_bucket" "my_bucket" {
  bucket = "anji5413"  # Replace with your desired bucket name
  acl    = "private"  # Access control settings (private, public-read, etc.)
}

