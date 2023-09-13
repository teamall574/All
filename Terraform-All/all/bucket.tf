variable "buckets" {
    type = list(string)
    default = ["anji2413", "anji2212", "anji2341"]
}

resource "aws_s3_bucket_acl" "bucket" {
  count = 3
  bucket = var.buckets[count.index]
  acl    = "private"
}

#secondway

variable "buckets" {
    type = list(string)
    default = ["anji2413", "anji2212", "anji2341"]
}

locals {
    mybucks = {
        for bucket in var.buckets:
         bucket => bucket
    }
}

resources "aws_s3_buckets" "bucks" {
    for_each = local.mybucks
    bucket = "${each.key}"
    acl = "private"
}
