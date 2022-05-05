############################################################
# Application Load Balancers
############################################################

#########################
# Load Balancer
#########################

resource "aws_lb" "nginx" {
  name               = "${var.aws_resource_prefix}nginx"
  load_balancer_type = "application"
  idle_timeout       = var.nginx_alb_idle_timeout
  security_groups    = [
    data.aws_security_group.base.id,
    data.aws_security_group.public_webserver.id,
    data.aws_security_group.ecs_client.id,
  ]
  subnets            = data.aws_subnet_ids.public.ids
}

#########################
# Listeners
#########################

resource "aws_lb_listener" "nginx_http" {
  load_balancer_arn = aws_lb.nginx.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = 443
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_lb_listener" "nginx_https" {
  load_balancer_arn = aws_lb.nginx.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-FS-1-2-2019-08" # Disallow TLS < 1.2 and weak ciphers
  certificate_arn   = aws_acm_certificate.nginx_website.arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.nginx_web.arn
  }

  depends_on = [
    aws_acm_certificate_validation.nginx_website,
  ]
}

#########################
# Target groups
#########################

resource "aws_lb_target_group" "nginx_web" {
  name     = "${var.aws_resource_prefix}nginx-web"
  port     = var.nginx_web_target_group_port
  protocol = "HTTP"
  vpc_id   = local.vpc_main_id
}
