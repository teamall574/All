terraform {
    backend "s3" {
      bucket = "anji5413"
      key = "backend/terraform.tfstate"
      region = "us-east-1"
      dynmodb_table = "anji-locking"  
    }
}  