# https://docs.snowflake.com/user-guide/data-load-s3-config-storage-integration

resource "aws_iam_role" "snowflake_storage_integration_s3_adlog" {
  name        = "${var.environment}-${var.project}-snowflake-storage-integration-s3-adlog"
  description = "for snowflake storage integration with s3"
  assume_role_policy = templatefile("${path.module}/policy/snowflake_trust_policy.json", {
    snowflake_account_arn = snowflake_storage_integration.s3_adlog.storage_aws_iam_user_arn
    snowflake_external_id = snowflake_storage_integration.s3_adlog.storage_aws_external_id
  })
}

resource "aws_iam_policy" "snowflake_storage_integration_s3_adlog" {
  name = "${var.environment}-${var.project}-snowflake-storage-integration-s3-adlog"
  policy = templatefile("${path.module}/policy/storage_integration_policy.json", {
    bucket_arn = var.s3_adlog_bucket_arn
    s3_prefix  = ["*"]
  })
}

resource "aws_iam_role_policy_attachment" "snowflake_storage_integration_s3_adlog" {
  role       = aws_iam_role.snowflake_storage_integration_s3_adlog.name
  policy_arn = aws_iam_policy.snowflake_storage_integration_s3_adlog.arn
}

resource "snowflake_storage_integration" "s3_adlog" {
  provider             = snowflake.terraform
  name                 = upper("${var.environment}_${var.project}_s3_adlog")
  comment              = "storage integration with S3 bucket"
  type                 = "EXTERNAL_STAGE"
  enabled              = true
  storage_provider     = "S3"
  storage_aws_role_arn = aws_iam_role.snowflake_storage_integration_s3_adlog.arn
  storage_allowed_locations = [
    "s3://${var.s3_adlog_bucket_name}/",
  ]
}
