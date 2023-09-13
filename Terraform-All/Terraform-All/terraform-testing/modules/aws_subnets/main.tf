resource "aws-subnet" "main" {
    vpc_id = "var.vpc_id"
    cidr_block = "var.cidr_block"
    availbility_zone = var.availbility_zone
  
}