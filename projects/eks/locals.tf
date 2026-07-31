# --------------------------------------------------------------------
# Shared local values for naming and metadata
# These values keep EKS resource names consistent across the module
# --------------------------------------------------------------------
locals {
  #customer_prefix
  customer_prefix = "${var.customer}${var.environment_name}"

  # Business division or team name from input variables
  business_division = var.business_division  # Example: "sales"
  
  # Environment name such as dev, staging, prod (from variable)
  environment = var.environment_name  # Example: "dev"

  # Standardized naming prefix: "<division>-<env>"
  customer_prefix_business_division = "${local.customer_prefix}-${local.business_division}"  # Example: "foliodev-sales"

  # Full EKS cluster name used for resource naming and tagging
  eks_cluster_name = "${local.customer_prefix}-${local.business_division}-eks"  # Example: "foliodev-sales-eks"
}