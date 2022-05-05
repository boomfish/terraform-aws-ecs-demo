############################################################
# VPC Security Groups
############################################################

############################################################
# Data Sources
############################################################

#########################
# Base security group
#########################

data "aws_security_group" "base" {
  name       = "${var.aws_resource_prefix}base"
  vpc_id      = local.vpc_main_id
}

############################################################
# Resources
############################################################

#########################
# ECS worker
#########################

resource "aws_security_group" "ecs_worker" {
  name        = "${var.aws_resource_prefix}ecs-worker"
  vpc_id      = local.vpc_main_id

  ingress {
    description     = "Incoming requests for ECS services running on ephemeral ports"
    from_port       = 20000
    to_port         = 65535
    protocol        = "tcp"
    security_groups = [
      aws_security_group.ecs_client.id,
    ]
  }

  tags = {
    Name        = "${var.aws_resource_prefix}ecs-worker",
    Description = "Allow incoming requests from authorised ECS clients",
  }
}

#########################
# ECS client
#########################

resource "aws_security_group" "ecs_client" {
  name        = "${var.aws_resource_prefix}ecs-client"
  vpc_id      = local.vpc_main_id

  tags = {
    Name        = "${var.aws_resource_prefix}ecs-client",
    Description = "Authorised to send service requests to ECS workers",
  }
}
