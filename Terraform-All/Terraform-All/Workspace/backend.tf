terraform {
  backend "s3" {
    bucket = "anji48485"
    key = "terraform.tfstate"
    region ="us-east-1"
  }  
}