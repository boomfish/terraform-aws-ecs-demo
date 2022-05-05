############################################################
# Elastic Container Service
############################################################

############################################################
# Data Sources
############################################################

#########################
# ECS Cluster
#########################

data "aws_ecs_cluster" "cluster" {
  cluster_name = "${var.aws_resource_prefix}cluster"
}

############################################################
# Resources
############################################################

#########################
# Task definitions
#########################

resource "aws_ecs_task_definition" "nginx" {
  family                   = var.nginx_task_family_name
  requires_compatibilities = ["EC2"]
  network_mode             = "bridge"

  container_definitions = jsonencode([
    {
      name         = var.nginx_web_container_name
      image        = "${aws_ecr_repository.nginx.repository_url}:${var.nginx_repository_deploy_tag}"
      memory       = var.nginx_web_container_memory
      portMappings = [
        {
          containerPort = var.nginx_web_container_public_port
        }
      ]
    }
  ])
}

#########################
# Services
#########################

resource "aws_ecs_service" "nginx" {
  name            = var.nginx_service_name
  cluster         = data.aws_ecs_cluster.cluster.id
  task_definition = aws_ecs_task_definition.nginx.arn
  desired_count   = var.nginx_service_desired_count

  load_balancer {
    target_group_arn = aws_lb_target_group.nginx_web.arn
    container_name   = var.nginx_web_container_name
    container_port   = var.nginx_web_container_public_port
  }
}
