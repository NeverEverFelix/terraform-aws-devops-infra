variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "cluster_version" {
  description = "EKS Kubernetes version"
  type        = string
  default     = "1.29"
}

variable "subnet_ids" {
  description = "List of subnet IDs for the EKS cluster"
  type        = list(string)
}

variable "vpc_id" {
  description = "VPC ID for the EKS cluster"
  type        = string
}

variable "node_group_name" {
  description = "Name for the EKS managed node group"
  type        = string
}

variable "node_group_desired_size" {
  description = "Desired number of worker nodes"
  type        = number
  default     = 2
}

variable "node_group_max_size" {
  description = "Maximum number of worker nodes"
  type        = number
  default     = 4
}

variable "node_group_min_size" {
  description = "Minimum number of worker nodes"
  type        = number
  default     = 1
}

variable "instance_types" {
  description = "EC2 instance types for the EKS node group"
  type        = list(string)
  default     = ["t3.medium"]
}

variable "eks_cluster_role_arn" {
  description = "IAM role ARN for EKS cluster"
  type        = string
}

variable "eks_node_role_arn" {
  description = "IAM role ARN for EKS node group"
  type        = string
}
variable "repository_name" {
  description = "Name of the ECR repository"
  type        = string
}
variable "oidc_url" {
  description = "OIDC provider URL from the EKS cluster"
  type        = string
}

variable "thumbprint" {
  description = "OIDC TLS certificate thumbprint"
  type        = string
}

variable "namespace" {
  description = "Kubernetes namespace of the service account"
  type        = string
}

variable "service_account_name" {
  description = "Name of the Kubernetes service account"
  type        = string
}

variable "role_name" {
  description = "Name of the IAM role to create for IRSA"
  type        = string
}
output "irsa_role_arn" {
  description = "ARN of the IAM role created for IRSA"
  value       = aws_iam_role.irsa_role.arn
}

output "oidc_provider_arn" {
  description = "ARN of the IAM OIDC provider"
  value       = aws_iam_openid_connect_provider.oidc.arn
}
variable "service_account_name" {
  description = "Name of the IRSA-enabled service account to use for EBS CSI driver"
  type        = string
}
variable "vpc_name" {
  description = "Name tag for the VPC and its components"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "azs" {
  description = "List of availability zones to use"
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "CIDR blocks for private subnets"
  type        = list(string)
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets"
  type        = list(string)
}
variable "admin_user" {
  description = "Admin username for Jenkins UI"
  type        = string
}

variable "admin_password" {
  description = "Admin password for Jenkins UI"
  type        = string
  sensitive   = true
}

variable "service_account_name" {
  description = "IRSA-enabled service account for Jenkins controller"
  type        = string
}

variable "jenkins_image_tag" {
  description = "Jenkins controller image tag to deploy"
  type        = string
  default     = "lts"
}
