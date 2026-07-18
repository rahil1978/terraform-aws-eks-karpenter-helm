# ------------------------------------------------------------------------------
# IAM role for the EKS control plane
# This role is assumed by the EKS service to manage cluster resources
# ------------------------------------------------------------------------------
resource "aws_iam_role" "eks_cluster" {
  # IAM role name built from team and environment metadata
  name = "${local.name}-eks-cluster-role"

  # Trust policy allowing EKS to assume this role
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action    = "sts:AssumeRole",
      Effect    = "Allow",
      Principal = {
        Service = "eks.amazonaws.com"
      }
    }]
  })

  # Apply shared tags to the control plane IAM role
  tags = var.tags
}

# ------------------------------------------------------------------------------
# Attach the EKS cluster policy
# Provides the control plane with permissions to manage the cluster
# ------------------------------------------------------------------------------
resource "aws_iam_role_policy_attachment" "eks_cluster_policy" {
  role       = aws_iam_role.eks_cluster.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

# ------------------------------------------------------------------------------
# Attach VPC Resource Controller policy
# Required for advanced networking, Fargate, and Karpenter support
# Recommended to include by default for production-grade EKS
# ------------------------------------------------------------------------------
resource "aws_iam_role_policy_attachment" "eks_vpc_resource_controller" {
  role       = aws_iam_role.eks_cluster.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
}