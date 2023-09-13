resource "aws_eks_cluster" "example" {

    name = var.eks_cluster_name
    role_arn =  ""
    
    vpc_config {
      subnet_ids = var.subnet_ids

    }


    tags = var.tags
}

resource "aws_iam_role" "eks_cluster" {
    name = "eks_cluster_example"
  
    assume_role_policy =  <<policy
{
    "version": "2012-10-17"
    "statement": [
       {
        "Effect": "Allow"
        "Pricipal": {
            "Service": "eks.amazonaws.com"
        },
        "Action": "sts:AssumeRole"
       }
    ]
}
Policy
}

resource "aws_iam_role_policy_attachment" "example-AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.example.name
}

variable "aws_iam_role_policy_attachment" {
    
}