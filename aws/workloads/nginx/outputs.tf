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
# Elastic Container Registry
#########################

output "nginx_ecr_repository_url" {
  value = aws_ecr_repository.nginx.repository_url
}

#########################
# Route53
#########################

output "nginx_website_fqdn" {
  value = local.nginx_website_fqdn
}
