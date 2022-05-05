###########################################################
# Route53 (DNS)
###########################################################

###########################################################
# Data Sources
###########################################################

#########################
# Zones
#########################

data "aws_route53_zone" "domain" {
  zone_id = local.route53_domain_zoneid
}

###########################################################
# Resources
###########################################################

#########################
# Records
#########################

#########################
# TLS certificate validation
#########################

resource "aws_route53_record" "nginx_website_cert_validation" {
  for_each = {
    for dvo in aws_acm_certificate.nginx_website.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  zone_id = local.route53_domain_zoneid
  name    = each.value.name
  type    = each.value.type
  ttl     = 60
  records = [ each.value.record ]
}

#########################
# NGINX website public DNS
#########################

resource "aws_route53_record" "nginx_website" {
  zone_id = local.route53_domain_zoneid
  name    = local.nginx_website_fqdn
  type    = "A"

  alias {
    name                   = aws_lb.nginx.dns_name
    zone_id                = aws_lb.nginx.zone_id
    evaluate_target_health = false
  }
}
