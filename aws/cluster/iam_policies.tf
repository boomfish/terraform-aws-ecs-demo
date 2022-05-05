###########################################################
# IAM Policies
###########################################################

resource "aws_iam_policy" "cloudwatch_logs" {
  name        = "${var.aws_resource_prefix}${var.aws_region_prefix}cloudwatch-logs"
  policy      = data.aws_iam_policy_document.cloudwatch_logs.json
}
