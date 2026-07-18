# terraform-aws-eks-karpenter-helm

A modular Terraform repository for provisioning AWS infrastructure, EKS clusters, Karpenter autoscaling, and Helm-based add-ons. The repository is organized to support multiple environments, reusable components, and independent infrastructure stacks while maintaining clear separation between shared modules and deployable projects.

## Repository structure

- `modules/`
  - Reusable Terraform modules that encapsulate common infrastructure patterns.
  - Contains the `vpc` module used by multiple stacks to provision network resources.

- `projects/`
  - Deployable stacks that consume reusable modules and define environment-specific infrastructure.
  - Includes subdirectories such as `eks`, `infra`, `observability`, and `security` for separate infrastructure concerns.

- `environments/`
  - Environment configuration and variable definitions for multiple deployment targets.
  - Used to keep environment-specific settings isolated from shared module definitions.

- `pipelines/`
  - CI/CD pipeline definitions and automation scripts for validating, planning, and applying Terraform changes.
  - Supports workflow consistency across environments and helps enforce best practices.

- `docs/`
  - Documentation and guidance for repository usage, architecture, and operational procedures.

- `scripts/`
  - Utility scripts used during development, deployment, or repository maintenance.

- `shared/`
  - Shared configuration, variables, or helper files that can be referenced by multiple project stacks.

## Key concepts

- **Modular design**: Core infrastructure is isolated in reusable modules, allowing different stacks to consume the same network, compute, or security constructs without duplication.
- **Environment separation**: Each environment can define its own variable values and backend settings, reducing risk when promoting changes between dev, staging, and production.
- **Remote state**: Terraform state is expected to be stored in S3, enabling state locking and centralized management for collaborative workflows.
- **Consistent provider versions**: Each stack controls its provider dependencies and version constraints to ensure stable and predictable deployments.

## Getting started

1. Review the target project folder under `projects/` for the stack you want to deploy.
2. Verify environment variables and Terraform variable definitions under `environments/` or the respective project’s `*.tfvars` file.
3. Run `terraform init` and `terraform plan` from the selected project directory.
4. Apply changes only after validating the output and confirming the target environment.

## Recommended workflow

- Use the `pipelines/` definitions for CI validation, formatting, and security checks.
- Keep shared logic in `modules/` and instantiate it from `projects/` stacks.
- Avoid modifying state backend settings directly in the shared modules; keep backend configuration at the project level.

## Notes

This repository is intended as a foundation for building production-grade AWS infrastructure with a focus on repeatability, maintainability, and safe environment separation.