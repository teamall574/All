resource "aws_iam_user" "anji" {
  name = "anji"
}

resource "aws_iam_role" "anji_role" {

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
          AWS  = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:user/anji"
        }
      }
    ]
  })
}

resource "aws_iam_policy_attachment" "s3_readonly_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
  roles      = [aws_iam_role.example_role.name]
}

resource "aws_iam_policy_attachment" "ssm_core_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMMaintenanceWindowRole"
  roles      = [aws_iam_role.example_role.name]
}

resource "aws_iam_user_policy_attachment" "anji_s3_policy_attachment" {
  user       = aws_iam_user.anji.name
  policy_arn = aws_iam_policy.s3_readonly.arn
}

resource "aws_iam_user_policy_attachment" "anji_ssm_policy_attachment" {
  user       = aws_iam_user.anji.name
  policy_arn = aws_iam_policy.ssm_core.arn
}





