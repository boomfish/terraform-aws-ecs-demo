############################################################
# VPC Security Groups
############################################################

############################################################
# Data Sources
############################################################

#########################
# Base security group
#########################

data "aws_security_group" "base" {
  name       = "${var.aws_resource_prefix}base"
  vpc_id      = local.vpc_main_id
}

#########################
# Public-facing web server
#########################

data "aws_security_group" "public_webserver" {
  name       = "${var.aws_resource_prefix}pub-webserver"
  vpc_id      = local.vpc_main_id
}

#########################
# ECS service client
#########################

data "aws_security_group" "ecs_client" {
  name       = "${var.aws_resource_prefix}ecs-client"
  vpc_id      = local.vpc_main_id
}
