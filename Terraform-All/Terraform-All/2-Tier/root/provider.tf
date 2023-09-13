terraform{
    required_providers {
      aws = {
        source = "hashicorp/aws"
        version = "4.67.0"  ##it will use only 4.67.0 version any one can use latest version or old version will not work
      }
    }
}  

provider "aws" {
    region = var.region
}