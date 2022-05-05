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
# Application Load Balancing
#########################

variable "nginx_alb_idle_timeout" {
  type        = number
  description = "Time in seconds that HTTP/S connections to NGINX load balancer are allowed to be idle"
  default     = 30
}

variable "nginx_web_target_group_port" {
  type        = string
  description = "Unique service port to route NGINX web traffic, best within range 20000-29999"
  default     = 20001
}

#########################
# NGINX service
#########################

variable "nginx_repository_suffix" {
  type        = string
  description = "Suffix for NGINX ECR repository name"
  default     = "nginx"
}

variable "nginx_repository_deploy_tag" {
  type        = string
  description = "NGINX ECR respository tag to deploy"
  default     = "latest"
}

variable "nginx_task_family_name" {
  type        = string
  description = "Name of NGINX ECS tasks"
  default     = "nginx"
}

variable "nginx_web_container_name" {
  type        = string
  description = "Name of NGINX ECS web container"
  default     = "nginx-web"
}

variable "nginx_web_container_public_port" {
  type        = number
  description = "Public service port for NGINX ECS web container"
  default     = 80
}

variable "nginx_web_container_memory" {
  type        = number
  description = "Amount of memory in MB to reserve for NGINX ECS web container"
  default     = 128
}

variable "nginx_service_name" {
  type        = string
  description = "Name of NGINX ECS service"
  default     = "nginx"
}

variable "nginx_service_desired_count" {
  type        = number
  description = "Desired number of running tasks for NGINX ECS service"
  default     = 1
}

#########################
# Route 53
#########################

variable "nginx_website_dns_name" {
  type        = string
  description = "DNS name of NGINX website (without domain)" 
  default     = "nginx"
}
