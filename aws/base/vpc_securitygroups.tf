############################################################
# VPC Security Groups
############################################################

#########################
# Base security group
#########################

resource "aws_security_group" "base" {
  name       = "${var.aws_resource_prefix}base"
  vpc_id      = aws_vpc.main.id

  egress {
    description = "Allow all outgoing traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.aws_resource_prefix}base",
    Description = "Allow all outgoing traffic",
  }
}

#########################
# Public-facing Web servers
#########################

resource "aws_security_group" "public_webserver" {
  name        = "${var.aws_resource_prefix}pub-webserver"
  vpc_id      = aws_vpc.main.id
  ingress {
    description = "HTTP from anywhere"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS from anywhere"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.aws_resource_prefix}pub-webserver",
    Description = "Allow incoming HTTP/S from anywhere",
  }
}
