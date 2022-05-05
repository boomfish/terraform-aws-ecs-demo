###########################################################
# Providers
###########################################################

##########################
# AWS
##########################

provider "aws" {
  region  = var.aws_region

  default_tags {
    tags = {
      "${var.aws_resource_tag_name}" = var.aws_resource_tag_value
    }
  }
}
