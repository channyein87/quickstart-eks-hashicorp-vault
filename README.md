# Quickstart EKS Hashicorp Vault

Fork of aws-quickstart/quickstart-eks-hashicorp-vault and building EKS with Terraform.

## Usage

1. Create `terraform.tfvars` file according to `variables.tf` with `entrypoint_cfn_stack_name = null` and build EKS with Terraform.
1. Deploy CloudFormation stack [amazon-eks-entrypoint-existing-cluster.template.yaml](quickstart-eks-hashicorp-vault/templates/amazon-eks-entrypoint-existing-cluster.template.yaml).
1. Rerun the Terraform with variable `entrypoint_cfn_stack_name` with the stack name from above step.
1. Deploy CloudFormation stack [quickstart-eks-hashicorp-vault.template.yml](quickstart-eks-hashicorp-vault/templates/quickstart-eks-hashicorp-vault.template.yml) and use the bucket from Terraform output.
