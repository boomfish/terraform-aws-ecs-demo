###########################################################
# Route53 (DNS)
###########################################################

###########################################################
# DNS Zones
###########################################################

resource "aws_route53_zone" "domain" {
  name    = var.route53_domain_name
  comment = "Managed by Terraform for ${var.aws_ssm_parameter_prefix}"
}
