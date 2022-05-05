############################################################
# Elastic Container Registry
############################################################

#########################
# Repository
#########################

resource "aws_ecr_repository" "nginx" {
  name                 = "${var.aws_resource_prefix}${var.nginx_repository_suffix}"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}
