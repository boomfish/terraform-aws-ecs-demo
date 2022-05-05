###########################################################
# EC2
###########################################################

#########################
# EC2 instances
#########################

resource "aws_instance" "worker" {
  count = var.ec2_worker_instance_count

  ami           = local.ecs_bottlerocket_ami
  instance_type = var.ec2_worker_instance_type

  vpc_security_group_ids = [
    data.aws_security_group.base.id,
    aws_security_group.ecs_worker.id,
  ]

  subnet_id                   = element(local.vpc_private_subnet_id_list, count.index)
  associate_public_ip_address = false
  iam_instance_profile        = aws_iam_instance_profile.worker.name
  user_data                   = <<END_OF_CONFIG
[settings.ecs]
cluster = "${aws_ecs_cluster.cluster.name}"
END_OF_CONFIG

  credit_specification {
    cpu_credits = "standard"
  }

## No need to tweak root volume for container instances
#
#  root_block_device {
#    volume_type = "gp3"
#    volume_size = 8
#    tags = {
#      Name = "${var.aws_resource_prefix}worker${count.index+1}-root",
#      Host = "${var.aws_resource_prefix}worker",
#    }
#  }

  tags = {
    Name   = "${var.aws_resource_prefix}worker${count.index+1}",
    Host   = "${var.aws_resource_prefix}worker",
  }

  lifecycle {
    create_before_destroy = true
  }
}
