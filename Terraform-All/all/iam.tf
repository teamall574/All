resource "aws_iam_user" "iam" {
    count = "${length(var.iamusers)}"
    name = "${element(var.iamusers, count.index)}
}
resource "aws_iam_user_policy" "newemp_policy" {
  count = length(var.iamusers)
  name = "policyss"
  user = element(var.iamusers,count.index)
policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "ec2:Describe*"
      ],
      "Resource": "*"
    }
  ]
}
EOF
}
