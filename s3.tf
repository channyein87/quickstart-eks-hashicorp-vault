resource "aws_s3_bucket" "eks_quickstart_vault" {
  bucket = "eks-quickstart-hashicorp-vault-${data.aws_region.current.name}-${data.aws_caller_identity.current.account_id}"
}

resource "aws_s3_bucket_object" "quickstart_eks_hashicorp_vault" {
  for_each = fileset(path.module, "quickstart-eks-hashicorp-vault/**")

  bucket = aws_s3_bucket.eks_quickstart_vault.id
  key    = each.value
  source = each.value
}
