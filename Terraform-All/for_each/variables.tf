variable "buckets" {
    type = list(string)
    default = ["devlopment245", "anji48546", "sampi5263"]
}

resource "aws_s3_bucket" "bucks" {
    count = 3
    bucket = var.buckets[count.index]
    acl = "private"
}