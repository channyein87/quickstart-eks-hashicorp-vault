variable "cluster_name" {
  description = "Cluster name."
  type        = string
  default     = "eks-quickstart"
}

variable "vpc_id" {
  description = "VPC id."
  type        = string
}

variable "public_subnet_ids" {
  description = "Public subnet ids."
  type        = list(string)
}

variable "private_subnet_ids" {
  description = "Private subnet ids."
  type        = list(string)
}

variable "region" {
  description = "AWS region."
  type        = string
}

variable "profile" {
  description = "AWS profile."
  type        = string
  default     = "default"
}

variable "dynamodb_name" {
  description = "Name of the DynamoDB table."
  type        = string
  default     = "eks-quickstart-vault"
}

variable "entrypoint_cfn_stack_name" {
  description = "Name of the CloudFormation stack using quickstart entrypoint with existing cluster."
  type        = string
  default     = null
}
