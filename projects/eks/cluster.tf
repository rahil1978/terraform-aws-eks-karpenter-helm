# ------------------------------------------------------------------------------
# Create the AWS EKS cluster control plane
# ------------------------------------------------------------------------------
resource "aws_eks_cluster" "main" {
  # Cluster name from business division, environment, and cluster_name
  name     = local.eks_cluster_name

  # Kubernetes version for the EKS control plane
  version  = var.cluster_version

  # IAM role that EKS uses to manage the control plane
  role_arn = aws_iam_role.eks_cluster.arn

  # VPC networking settings for the control plane
  vpc_config {
    # Private subnets for EKS control plane ENIs
    subnet_ids = data.terraform_remote_state.vpc.outputs.private_subnet_ids

    # Enable private endpoint access within the VPC
    endpoint_private_access = var.cluster_endpoint_private_access

    # Enable public endpoint access for external API traffic
    endpoint_public_access  = var.cluster_endpoint_public_access

    # CIDR blocks that may reach the public endpoint
    public_access_cidrs     = var.cluster_endpoint_public_access_cidrs
  }

  # Optional Kubernetes service CIDR for ClusterIP services
  kubernetes_network_config {
    service_ipv4_cidr = var.cluster_service_ipv4_cidr
  }

  # Control plane log types enabled for visibility and troubleshooting
  enabled_cluster_log_types = [
    "api",               # API server logs
    "audit",             # audit logs
    "authenticator",     # IAM authenticator logs
    "controllerManager", # controller manager logs
    "scheduler"          # scheduler logs
  ]

  # Wait for IAM policy attachments before creating the cluster
  # Prevents race conditions during provisioning or destroy operations
  depends_on = [
    aws_iam_role_policy_attachment.eks_cluster_policy,
    aws_iam_role_policy_attachment.eks_vpc_resource_controller
  ]

  # Apply shared tags to the EKS cluster
  tags = var.tags

  # ----------------------------------------------------------------------------
  # Access configuration for EKS cluster authentication
  #
  # authentication_mode = "API_AND_CONFIG_MAP"
  #   Uses both the legacy aws-auth ConfigMap and the newer Access Entries API.
  #
  # bootstrap_cluster_creator_admin_permissions = true
  #   Grants cluster-admin access to the creator automatically.
  #   Without this, the initial creator may not have admin rights.
  #
  # In short:
  # - Retain the legacy aws-auth method for compatibility
  # - Use the Access Entries API for future compatibility
  # - Guarantee the creator has admin access by default
  # ----------------------------------------------------------------------------
  access_config {
    authentication_mode = "API_AND_CONFIG_MAP" # options: CONFIG_MAP, API, API_AND_CONFIG_MAP
    bootstrap_cluster_creator_admin_permissions = true
  }

}

