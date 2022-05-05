###########################################################
# IAM policy documents
###########################################################

###########################################################
# Assume role statements
###########################################################

#########################
# EC2
#########################

data "aws_iam_policy_document" "assume_role_ec2" {
  statement {
    effect    = "Allow"
    actions   = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

#########################
# ECS
#########################

data "aws_iam_policy_document" "assume_role_ecs_tasks" {
  statement {
    effect    = "Allow"
    actions   = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

###########################################################
# Identity-based policy statements
###########################################################

data "aws_iam_policy_document" "cloudwatch_logs" {

  statement {
    effect = "Allow"
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "logs:DescribeLogStreams",
    ]
    resources = [
      "arn:aws:logs:*:*:*",
    ]
  }

}

###########################################################
# Resource-based policy statements
###########################################################
