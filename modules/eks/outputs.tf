output "cluster_name" {
  description = "Name of the EKS cluster"
  value       = aws_eks_cluster.this.name
}

output "cluster_endpoint" {
  description = "Endpoint for the EKS cluster"
  value       = aws_eks_cluster.this.endpoint
}

output "cluster_certificate_authority" {
  description = "Base64 encoded certificate data required to communicate with the cluster"
  value       = aws_eks_cluster.this.certificate_authority[0].data
}

output "node_group_name" {
  description = "Name of the managed node group"
  value       = aws_eks_node_group.default.node_group_name
}

output "oidc_issuer_url" {
  description = "OIDC provider URL for IRSA"
  value       = aws_eks_cluster.this.identity[0].oidc[0].issuer
}
output "repository_url" {
  description = "URL of the created ECR repository"
  value       = aws_ecr_repository.this.repository_url
}

output "repository_arn" {
  description = "ARN of the created ECR repository"
  value       = aws_ecr_repository.this.arn
}

output "repository_name" {
  description = "Name of the created ECR repository"
  value       = aws_ecr_repository.this.name
}
output "vpc_id" {
  description = "The ID of the created VPC"
  value       = aws_vpc.this.id
}

output "private_subnet_ids" {
  description = "List of private subnet IDs"
  value       = aws_subnet.private[*].id
}

output "public_subnet_ids" {
  description = "List of public subnet IDs"
  value       = aws_subnet.public[*].id
}

output "eks_node_sg_id" {
  description = "Security group ID for EKS nodes"
  value       = aws_security_group.eks_nodes.id
}
output "jenkins_name" {
  description = "Helm release name for Jenkins"
  value       = helm_release.jenkins.name
}

output "jenkins_namespace" {
  description = "Kubernetes namespace Jenkins is deployed into"
  value       = helm_release.jenkins.namespace
}
