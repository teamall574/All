terraform {
  backend "s3" {
    bucket = "anji5413"
    key    = "myterraform.tfstate"
    region = "ap-south-1"
    encrypt        = true
    dynamodb_table = "dynamo-db-locking" ##need to create the dynamodb table then use this if any developer need to any actions it will get an error
  }
}