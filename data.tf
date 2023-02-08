locals {
  eks_quickstart_roles = var.entrypoint_cfn_stack_name == null ? [] : [
    {
      rolearn  = data.aws_cloudformation_stack.eks_quickstart_entrypoint[0].outputs["EKSAdminRoleArn"]
      username = data.aws_cloudformation_stack.eks_quickstart_entrypoint[0].outputs["EKSAdminRoleArn"]
      groups   = ["system:masters"]
    },
    {
      rolearn  = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/awsqs-kubernetes-helm"
      username = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/awsqs-kubernetes-helm"
      groups   = ["system:masters"]
    },
    {
      rolearn  = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/awsqs-kubernetes-get"
      username = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/awsqs-kubernetes-get"
      groups   = ["system:masters"]
    },
    {
      rolearn  = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/awsqs-kubernetes-resource"
      username = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/awsqs-kubernetes-resource"
      groups   = ["system:masters"]
    }
  ]
}

data "aws_eks_cluster_auth" "this" {
  name = module.eks.eks_cluster_id
}

data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

data "aws_cloudformation_stack" "eks_quickstart_entrypoint" {
  count = var.entrypoint_cfn_stack_name != null ? 1 : 0
  name  = var.entrypoint_cfn_stack_name
}

data "aws_subnet" "public_subnets" {
  for_each = toset(var.public_subnet_ids)
  id       = each.value
}

data "aws_subnet" "private_subnets" {
  for_each = toset(var.private_subnet_ids)
  id       = each.value
}
