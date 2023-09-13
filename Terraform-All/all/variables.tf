variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "aws_region" {}
variable "amis" {}
variable "vpc_cidr" {}
variable "vpc_name" {}
variable "IGW_name" {}
variable "key_name" {}
variable "ami" {
  description = "AMIs by region"
  default = {
    ap-south-1 = "ami-024c319d5d14b463e"
    us-east-1 = "ami-0149b2da6ceec4bb0"
  }

}
variable public_Routing_Table {}
variable private_routing_table {}
variable "azs" {
  description = "Run the EC2 Instances in these Availability Zones"
  type = "list"
  default = ["ap-south-1a", "ap-south-1b"]
}

variable "public-cidrs" {
  description = "Run the Cidrs for subnets"
  type = "list"
  default = ["10.1.1.0/24", "10.1.2.0/24"]
}

variable "private-cidrs" {
  description = "Run the Cidrs for subnets"
  type = "list"
  default = ["10.1.10.0/24", "10.1.20.0/24"]
}

variable "environment" {}
variable "instance_type" {
  default = {
    dev = "t2.nano"
    test = "t2.micro"
    prod = "t2.micro"
    }
}
variable "env" {
   type = "string"
   default = "PROD"
}

variable "iamusers" {
  type = list(string)
  default =['anji23", "sampi12", "sampi11"]
}
