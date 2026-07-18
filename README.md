terraform-aws-eks-karpenter-helm/
│
├── projects/
│   ├── infrastructure/                # Project 1: Customer AWS infra (VPC, EC2, RDS, ECS, SNS, SSM, etc.)
│   │   ├── vpc/
│   │   ├── ec2/
│   │   ├── rds/
│   │   ├── ecs/
│   │   ├── sns/
│   │   ├── ssm/
│   │   └── main.tf
│   │
│   ├── eks-cluster/                   # Project 2: Dedicated EKS cluster creation
│   │   ├── cluster/
│   │   ├── karpenter/
│   │   ├── helm-addons/
│   │   └── main.tf
│   │
│   ├── observability/                 # Project 3: Monitoring & logging
│   │   ├── prometheus/
│   │   ├── grafana/
│   │   ├── cloudwatch/
│   │   ├── opensearch/
│   │   └── main.tf
│   │
│   └── security/                      # Optional future project (IAM, GuardDuty, WAF, KMS)
│       ├── iam/
│       ├── guardduty/
│       ├── kms/
│       └── main.tf
│
├── modules/                           # Shared reusable modules across all projects
│   ├── vpc/
│   ├── eks/
│   ├── karpenter/
│   ├── helm/
│   ├── rds/
│   ├── ecs/
│   ├── sns/
│   ├── ssm/
│   └── observability/
│
├── environments/                      # Dev/UAT/Prod configurations
│   ├── dev/
│   │   ├── backend.tf
│   │   ├── providers.tf
│   │   └── terraform.tfvars
│   ├── uat/
│   └── prod/
│
├── shared/                            # Shared infra primitives
│   ├── remote-state/                  # S3 + DynamoDB
│   ├── providers/                     # Common provider configs
│   ├── policies/                      # OPA, Sentinel, security policies
│   └── ci-cd/                         # GitHub Actions / pipelines
│
├── docs/                              # Architecture diagrams, READMEs
│   ├── architecture/
│   ├── networking/
│   ├── eks/
│   └── observability/
│
└── scripts/                           # Helper scripts (bash, python)
    ├── plan.sh
    ├── apply.sh
    └── destroy.sh
