# ------------------------------------------------------------------------------
# Expose the EKS cluster API server endpoint
# This value is used by kubectl and external tools to connect to the cluster
# ------------------------------------------------------------------------------
output "eks_cluster_endpoint" {
  value       = aws_eks_cluster.main.endpoint
  description = "EKS API server endpoint"
}

# ------------------------------------------------------------------------------
# Expose the EKS cluster resource ID
# Useful for automation and referencing the cluster in scripts
# ------------------------------------------------------------------------------
output "eks_cluster_id" {
  description = "The unique EKS cluster ID"
  value       = aws_eks_cluster.main.id
}

# ------------------------------------------------------------------------------
# Expose the Kubernetes version of the cluster
# Helps verify cluster version compatibility with add-ons or tooling
# ------------------------------------------------------------------------------
output "eks_cluster_version" {
  description = "Kubernetes version running on the EKS cluster"
  value       = aws_eks_cluster.main.version
}

# ------------------------------------------------------------------------------
# Expose the EKS cluster name
# Useful for CLI commands such as aws eks update-kubeconfig
# ------------------------------------------------------------------------------
output "eks_cluster_name" {
  value       = aws_eks_cluster.main.name
  description = "EKS cluster name"
}

# ------------------------------------------------------------------------------
# Expose the EKS cluster CA certificate data
# Required when generating kubeconfig or establishing trust with the API server
# ------------------------------------------------------------------------------
output "eks_cluster_certificate_authority_data" {
  value       = aws_eks_cluster.main.certificate_authority[0].data
  description = "Base64 encoded certificate authority data for the cluster"
}

# ------------------------------------------------------------------------------
# Expose the private node group name
# Useful when configuring autoscaling, dashboards, or external tooling
# ------------------------------------------------------------------------------
output "private_node_group_name" {
  value       = aws_eks_node_group.private_nodes.node_group_name
  description = "Name of the EKS private node group"
}

# ------------------------------------------------------------------------------
# Expose the IAM role ARN used by the EKS node group
# Useful for IRSA or attaching additional permissions later
# ------------------------------------------------------------------------------
output "eks_node_instance_role_arn" {
  value       = aws_iam_role.eks_nodegroup_role.arn
  description = "IAM role ARN for EKS worker node group"
}

# ------------------------------------------------------------------------------
# Provide a ready-to-use kubectl configuration command
# Users can copy and run this after Terraform apply
# ------------------------------------------------------------------------------
output "to_configure_kubectl" {
  description = "Command to update local kubeconfig to connect to the EKS cluster"
  value       = "aws eks --region ${var.aws_region} update-kubeconfig --name ${local.eks_cluster_name}"
}

