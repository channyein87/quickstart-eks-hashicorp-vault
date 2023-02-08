module "eks" {
  source = "github.com/aws-ia/terraform-aws-eks-blueprints?ref=v4.22.0"

  cluster_name       = var.cluster_name
  vpc_id             = var.vpc_id
  public_subnet_ids  = var.public_subnet_ids
  private_subnet_ids = var.private_subnet_ids
  map_roles          = local.eks_quickstart_roles

  managed_node_groups = {
    ondemand = {
      node_group_name = "ondemand"
      desired_size    = "1"
      max_size        = "2"
      min_size        = "1"
      instance_types  = ["t3a.large"]
      subnet_ids      = var.private_subnet_ids
    }
  }
}

module "eks_addons" {
  source = "github.com/aws-ia/terraform-aws-eks-blueprints//modules/kubernetes-addons?ref=v4.22.0"

  # EKS Addons
  enable_amazon_eks_vpc_cni            = true
  enable_amazon_eks_coredns            = true
  enable_amazon_eks_kube_proxy         = true
  enable_amazon_eks_aws_ebs_csi_driver = true

  #K8s Add-ons
  eks_cluster_id                      = module.eks.eks_cluster_id
  enable_aws_load_balancer_controller = true
  enable_metrics_server               = true
}

resource "aws_ec2_tag" "shared" {
  for_each = toset(concat(var.public_subnet_ids, var.private_subnet_ids))

  key         = "kubernetes.io/cluster/${var.cluster_name}"
  resource_id = each.value
  value       = "shared"
}

resource "aws_ec2_tag" "external_lb" {
  for_each = {
    for k, v in data.aws_subnet.public_subnets : k => v
    if !contains(keys(v.tags), "kubernetes.io/role/elb")
  }

  key         = "kubernetes.io/role/elb"
  resource_id = each.key
  value       = "1"
}

resource "aws_ec2_tag" "internal_lb" {
  for_each = {
    for k, v in data.aws_subnet.private_subnets : k => v
    if !contains(keys(v.tags), "kubernetes.io/role/internal-elb")
  }

  key         = "kubernetes.io/role/internal-elb"
  resource_id = each.key
  value       = "1"
}
