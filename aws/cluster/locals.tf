###########################################################
# Local values
###########################################################

locals {

  #########################
  # SSM Parameter data
  #########################
  route53_domain_zoneid = data.aws_ssm_parameter.route53_domain_zoneid.value
  vpc_main_id           = data.aws_ssm_parameter.vpc_main_id.value
  # AWS-provider parameters
  ecs_bottlerocket_ami  = data.aws_ssm_parameter.ecs_bottlerocket_ami.value

  #########################
  # VPC data
  #########################
  vpc_private_subnet_id_list = tolist(data.aws_subnet_ids.private.ids) # NB. This does not preserve the original order!

}
