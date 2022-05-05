###########################################################
# SSM Parameter Store
###########################################################

#########################
# Workspace Parameters
#########################

resource "aws_ssm_parameter" "resource_prefix" {
  name        = "${var.aws_ssm_parameter_prefix}/resourcePrefix"
  description = "Resource prefix"
  type        = "String"
  value       = var.aws_resource_prefix
}

resource "aws_ssm_parameter" "region_prefix" {
  name        = "${var.aws_ssm_parameter_prefix}/regionPrefix"
  description = "Region prefix"
  type        = "String"
  value       = var.aws_region_prefix
}

#########################
# Route53 Parameters
#########################

resource "aws_ssm_parameter" "route53_domain_zoneid" {
  name        = "${var.aws_ssm_parameter_prefix}/route53/domain/zoneId"
  description = "Domain Zone ID"
  type        = "String"
  value       = aws_route53_zone.domain.zone_id
}

#########################
# VPC Parameters
#########################

resource "aws_ssm_parameter" "vpc_main_id" {
  name        = "${var.aws_ssm_parameter_prefix}/vpc/main/id"
  description = "Main VPC ID"
  type        = "String"
  value       = aws_vpc.main.id
}
