# ECS Cluster

This Terraform project manages the server resources for an ECS environment

## Resources

This project manages the following resources:

- EC2 worker instances running Bottlerocket OS to use as ECS container instances
- ECS cluster
- IAM policies and roles for the workers and ECS
- VPC security groups for the workers to communicate

## Variables

Variables are defined in `variables.tf`.

Here are some key variables. Variables with no default value must be defined in the workspace.

| Variable name             | Description                                 | Default value          |
| ------------------------- | ------------------------------------------- | ---------------------- |
| aws_resource_prefix       | Prefix for AWS resource names               | "ecsdemo-"             |
| aws_region_prefix         | Extra prefix for cross-region AWS resources | ""                     |
| aws_ssm_parameter_prefix  | Value of BillingCode tag for resources      | "/ecsdemo"             |
| aws_resource_tag_name     | Name of tag to apply to all resources       | "Project"              |
| aws_resource_tag_value    | Value of tag to apply to all resources      | "ecsdemo"              |
| aws_region                | AWS region                                  | "ap-southeast-2"       |
| ec2_worker_instance_type  | Worker instance type                        | "t3a.small"            |
| ec2_worker_instance_count | Number of worker instances                  | 1                      |
| ecs_bottlerocket_version  | Bottlerocket OS version for workers         | "1.7.2"                |
