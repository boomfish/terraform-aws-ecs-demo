###########################################################
# Elastic Container Services
###########################################################

##########################
# ECS Cluster
##########################
resource "aws_ecs_cluster" "cluster" {
  name = "${var.aws_resource_prefix}cluster"
}
