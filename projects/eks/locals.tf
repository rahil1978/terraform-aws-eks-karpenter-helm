# --------------------------------------------------------------------
# Shared local values for naming and metadata
# These values keep EKS resource names consistent across the module
# --------------------------------------------------------------------
locals {
  # Business division or team name from input variables
  owners = var.business_division  # Example: "sales"

  # Environment name such as dev, staging, prod (from variable)
  environment = var.environment_name  # Example: "dev"

  # Standardized naming prefix: "<division>-<env>"
  name = "${local.owners}-${local.environment}"  # Example: "sales-dev"

  # Full EKS cluster name used for resource naming and tagging
  eks_cluster_name = "${local.name}-${var.cluster_name}"  # Example: "sales-dev-eks"
}