###########################################################
# Input variables
###########################################################

#########################
# Terraform Workspace
#########################

variable "aws_resource_prefix" {
  type        = string
  description = "Prefix for AWS resource names"
  default     = "ecsdemo-"
}

variable "aws_region_prefix" {
  type        = string
  description = "Additional prefix for AWS resource names in cross-region namespaces"
  default     = "sydney-"
}

variable "aws_ssm_parameter_prefix" {
  type        = string
  description = "Prefix for AWS SSM parameters"
  default     = "/ecsdemo"
}

variable "aws_resource_tag_name" {
  type        = string
  description = "Name of tag to apply to all AWS resources"
  default     = "Project"
}

variable "aws_resource_tag_value" {
  type        = string
  description = "Value of tag to apply to all AWS resources"
  default     = "ecsdemo-cluster"
}

#########################
# AWS Provider
#########################

variable "aws_region" {
  type        = string
  description = "AWS region name"
  default     = "ap-southeast-2"
}

#########################
# EC2
#########################

variable "ec2_worker_instance_type" {
  type        = string
  description = "EC2 instance type for worker instances" 
  default     = "t3a.small"
}

variable "ec2_worker_instance_count" {
  type        = number
  description = "Number of worker instances" 
  default     = 1
}

#########################
# ECS
#########################

variable "ecs_bottlerocket_version" {
  type        = string
  description = "Bottlerocket OS version to use" 
  default     = "1.7.2"
}
