data "aws_eks_cluster_auth" "this" {
  name = module.eks.eks_cluster_id
}
