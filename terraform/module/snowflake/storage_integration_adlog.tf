# IAM Role for integration S3 dsp tracking logs raw-data with snowflake
resource "aws_iam_role" "snowflake_storage_integration_s3_adlog" {
  name        = "${var.environment}-${var.project}-snowflake_storage_integration_s3_adlog"
  description = "for snowflake storage integration with s3"
  assume_role_policy = templatefile("${path.module}/policy/snowflake_trust_policy.json", {
    snowflake_account_arn = var.snowflake_account_arn
    snowflake_external_id = var.snowflake_s3_dsp_tracking_logs_integration_external_id
  })
}

resource "aws_iam_policy" "snowflake_storage_integration_s3_adlog" {
  name = "${var.environment}-${var.project}-snowflake_storage_integration_s3_adlog"
  policy = templatefile("${path.module}/policy/storage_integration_policy.json", {
    bucket_arn = var.s3_adlog_bucket_arn
    s3_prefix  = "[\"*\"]"
  })
}

resource "aws_iam_role_policy_attachment" "snowflake_storage_integration_s3_adlog" {
  role       = aws_iam_role.snowflake_storage_integration_s3_adlog.name
  policy_arn = aws_iam_policy.snowflake_storage_integration_s3_adlog.arn
}

# Storage Integration Config for dsp tracking logs raw-data
# resource "snowflake_storage_integration" "s3_adlog" {
#   provider             = snowflake.sys_admin
#   name                 = upper("${var.environment}_${var.project}_s3_adlog")
#   comment              = "storage integration with S3 bucket"
#   type                 = "EXTERNAL_STAGE"
#   enabled              = true
#   storage_provider     = "S3"
#   storage_aws_role_arn = aws_iam_role.snowflake_storage_integration_s3_adlog.arn
#   storage_allowed_locations = [
#     "s3://${var.s3_bucket_name.dsp_tracking_logs}/",
#   ]
# }

# resource "snowflake_integration_grant" "integration-tracking-logs" {
#   provider               = snowflake.sys_admin
#   integration_name       = snowflake_storage_integration.s3_adlog.name
#   enable_multiple_grants = true
#   privilege              = "USAGE"
#   roles                  = [var.roles.developer, snowflake_role.app-db-ro.name]
#   with_grant_option      = false
# }
