terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "
        }
    }
}

provider "aws" {
    access_key = "xxxxxxxxxxxxxxxxx"
    secret_key = "xxxxxxxxxxxxxxxxx"
    region = "xxxxxxxxxxx"
}