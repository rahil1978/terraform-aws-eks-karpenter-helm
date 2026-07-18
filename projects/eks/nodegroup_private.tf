# EKS managed node group provisioned in private subnets for secure worker placement
resource "aws_eks_node_group" "private_nodes" {

  # EKS cluster resource that hosts this node group
  cluster_name = aws_eks_cluster.main.name

  # Unique name assigned to this private node group within the cluster
  node_group_name = "${local.name}-private-ng"

  # IAM role assumed by worker nodes to access AWS and EKS resources
  node_role_arn = aws_iam_role.eks_nodegroup_role.arn

  # Private subnet IDs from the shared VPC remote state used for worker placement
  subnet_ids = data.terraform_remote_state.vpc.outputs.private_subnet_ids

  # EC2 instance types that define the compute capacity of each worker node
  instance_types = var.node_instance_types

  # Node group capacity type: ON_DEMAND or SPOT
  capacity_type = var.node_capacity_type

  # Use Amazon Linux 2023 AMI optimized for EKS workloads
  # Recommended for Kubernetes v1.25+ with updated packages, improved security,
  # and longer-term support compared with Amazon Linux 2.
  ami_type = "AL2023_x86_64_STANDARD"

  # Root disk size for each worker node in GiB
  disk_size = var.node_disk_size

  # Auto-scaling configuration for the managed node group
  scaling_config {
    # Desired number of worker nodes to launch initially
    desired_size = 3

    # Minimum number of workers allowed during scale-down
    min_size = 1

    # Maximum number of workers permitted during scale-up
    max_size = 6
  }

  # Maximum percentage of worker nodes allowed to be unavailable during rolling updates
  update_config {
    max_unavailable_percentage = 33
  }

  # Force a node group update when the EKS AMI version changes
  force_update_version = true

  # Labels applied to worker nodes for Kubernetes scheduling and resource grouping
  labels = {
    "env"  = var.environment_name
    "team" = var.business_division
  }

  # Tags applied to the node group and its EC2 instances for inventory and cost tracking
  tags = merge(var.tags, {
    # Standard EC2 name tag
    Name = "${local.name}-private-ng"

    # Environment label such as dev or prod
    Environment = var.environment_name
  })

  # Ensure required IAM policy attachments complete before creating the node group
  depends_on = [
    aws_iam_role_policy_attachment.eks_worker_node_policy,
    aws_iam_role_policy_attachment.eks_cni_policy,
    aws_iam_role_policy_attachment.eks_ecr_policy
  ]
}