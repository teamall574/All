resource "aws_dynamodb_table" "dynamo-db-locking" {
  name           = "dynamo-db-locking"
  hash_key       = "LockID"
  read_capacity  = 5
  write_capacity = 5

  attribute {
    name = "LockID"
    type = "S"
  }
}