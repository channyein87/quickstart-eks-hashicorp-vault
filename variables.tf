variable "cluster_name" {
  description = "Cluster name."
  type        = string
  default     = "lab"
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
  default     = ""
}
