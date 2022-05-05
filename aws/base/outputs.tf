###########################################################
# Output values
###########################################################

#########################
# AWS provider
#########################

output "aws_account_id" {
  value = data.aws_caller_identity.current.account_id
}


#########################
# Route53 (DNS)
#########################

output "route53_domain_name_servers" {
  value = aws_route53_zone.domain.name_servers
}

output "route53_domain_zone_id" {
  value = aws_route53_zone.domain.zone_id
}
