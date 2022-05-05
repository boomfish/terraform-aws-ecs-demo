###########################################################
# ACM Certificates
###########################################################

#########################
# Server certificates
#########################

resource "aws_acm_certificate" "nginx_website" {
  domain_name       = local.nginx_website_fqdn
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}

#########################
# Certificate validation
#########################

resource "aws_acm_certificate_validation" "nginx_website" {
  certificate_arn         = aws_acm_certificate.nginx_website.arn

  validation_record_fqdns = [for record in aws_route53_record.nginx_website_cert_validation : record.fqdn]
}
