###########################################################
# IAM Roles
###########################################################

############################
# EC2 roles
############################

resource "aws_iam_role" "ec2_worker" {
  name                = "${var.aws_resource_prefix}${var.aws_region_prefix}ec2-worker"
  assume_role_policy   = data.aws_iam_policy_document.assume_role_ec2.json
  description          = "AWS EC2 service role for worker instances"
}

resource "aws_iam_role_policy_attachment" "ec2_worker_ecs_container_instance" {
  role        = aws_iam_role.ec2_worker.id
  policy_arn  = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}

resource "aws_iam_role_policy_attachment" "ec2_worker_ssm_managed_instance" {
  role        = aws_iam_role.ec2_worker.id
  policy_arn  = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_role_policy_attachment" "ec2_worker_cloudwatch_logs" {
  role        = aws_iam_role.ec2_worker.id
  policy_arn  = aws_iam_policy.cloudwatch_logs.arn
}

############################
# ECS roles
############################

resource "aws_iam_role" "ecs_task_execution" {
  name                = "${var.aws_resource_prefix}${var.aws_region_prefix}ecs-task-exec"
  assume_role_policy   = data.aws_iam_policy_document.assume_role_ecs_tasks.json
  description          = "AWS role for worker instances to execute ECS tasks"
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_standard_policy" {
  role        = aws_iam_role.ecs_task_execution.id
  policy_arn  = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

############################
# EC2 instance profiles
############################

resource "aws_iam_instance_profile" "worker" {
  name = "${var.aws_resource_prefix}${var.aws_region_prefix}ec2-worker"
  role = aws_iam_role.ec2_worker.name
}
