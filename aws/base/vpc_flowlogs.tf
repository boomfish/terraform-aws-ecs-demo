###########################################################
# VPC Flowlogs
###########################################################

#########################
#  Flow logs to S3
#########################

resource "aws_flow_log" "flowlog_s3" {
  count = var.vpc_flowlog_enabled ? 1 : 0

  log_destination      = "arn:aws:s3:::${var.vpc_flowlog_s3_bucket_name}"
  log_destination_type = "s3"
  traffic_type         = "ALL"
  vpc_id               = aws_vpc.main.id
}
