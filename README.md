#terraform-aws-eks-karpenter-helm
This repository provides a modular Terraform for deploying AWS infrastructure, EKS clusters, Karpenter autoscaling, and Helm‑based addons. It is structured to support multiple environments and reusable modules while keeping each stack isolated and easy to manage.

The modules/ directory contains reusable components such as VPC. The projects/ directory contains deployable stacks for different parts of the infrastructure. Each stack includes its own backend configuration and lock file to ensure consistent provider versions and safe remote state usage.

Remote state is stored in S3 for state locking. Each environment uses its own state key path to ensure safe promotion and rollback. CI pipelines run formatting, validation, security checks, and plan generation before applying changes.

Modules are designed for clarity, reusability, and long‑term maintainability. The structure supports future growth and safe refactoring as new services or modules are added. This repository serves as a foundation for building reliable and repeatable cloud infrastructure across multiple environments.