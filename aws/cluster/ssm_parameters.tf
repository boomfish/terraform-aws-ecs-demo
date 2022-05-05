###########################################################
# SSM Parameter Store
###########################################################

###########################################################
# Data Sources
###########################################################

#########################
# ECS Parameters
#########################

data "aws_ssm_parameter" "ecs_bottlerocket_ami" {
  name        = "/aws/service/bottlerocket/aws-ecs-1/x86_64/${var.ecs_bottlerocket_version}/image_id"
}

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
