###########################################################
# Local values
###########################################################

locals {

  #########################
  # SSM Parameter data
  #########################
  route53_domain_zoneid = data.aws_ssm_parameter.route53_domain_zoneid.value
  vpc_main_id           = data.aws_ssm_parameter.vpc_main_id.value

  #########################
  # Route53 data
  #########################
  nginx_website_fqdn    = "${var.nginx_website_dns_name}.${data.aws_route53_zone.domain.name}"

}
