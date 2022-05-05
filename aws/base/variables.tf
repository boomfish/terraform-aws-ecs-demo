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
  default     = "ecsdemo-base"
}

#########################
# AWS Provider
#########################

variable "aws_region" {
  type        = string
  description = "AWS region name"
  default     = "ap-southeast-2"
}

variable "aws_az_names" {
  type        = list(string)
  description = "List of availability zones in region to use"
  default     = [
    "ap-southeast-2a",
    "ap-southeast-2b",
    "ap-southeast-2c",
  ]
}

#########################
# Route53 (DNS)
#########################

variable "route53_domain_name" {
  type        = string
  description = "Domain name of Route53 zone"
  default     = "ecsdemo.boomfish.net"
}

#########################
# VPC
#########################

variable "vpc_net_address" {
  type        = string
  description = "VPC IPv4 addresses"
  default     = "10.51.0.0"
}

variable "vpc_netid_bits" {
  type        = number
  description = "Number of prefix bits in a VPC IPv4 address that identifies the network"
  default     = 20
}

variable "vpc_subnetid_bits" {
  type        = number
  description = "Number of bits in a VPC IPv4 address after the network number that identifies the subnet"
  default     = 4
}

variable "vpc_subnet_count" {
  type        = number
  description = "Number of public or private subnets (must not be greater than 2^(vpc_subnetid_bits-1))"
  default     = 3
}


#########################
# VPC Flowlogs
#########################

variable "vpc_flowlog_enabled" {
  type        = bool
  description = "Enabled flow log for VPC"
  default     = false
}

variable "vpc_flowlog_s3_bucket_name" {
  type        = string
  description = "Name of S3 bucket destination for VPC flow logs"
  default     = "audit-storage-flowlogs-myaccountid"
}
