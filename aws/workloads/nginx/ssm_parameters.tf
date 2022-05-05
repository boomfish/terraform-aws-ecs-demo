###########################################################
# SSM Parameter Store
###########################################################

###########################################################
# Data Sources
###########################################################

#########################
# Route53 Parameters
#########################

data "aws_ssm_parameter" "route53_domain_zoneid" {
  name        = "${var.aws_ssm_parameter_prefix}/route53/domain/zoneId"
}

#########################
# VPC Parameters
#########################

data "aws_ssm_parameter" "vpc_main_id" {
  name        = "${var.aws_ssm_parameter_prefix}/vpc/main/id"
}
