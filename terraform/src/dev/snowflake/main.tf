module "snowflake" {
  source = "../../../module/snowflake"

  aws_account_id = var.aws_account_id
  aws_region     = var.aws_region
  environment    = var.environment
  project        = var.project

  s3_adlog_bucket_arn  = data.terraform_remote_state.aws.outputs.s3_adlog_bucket_arn
  s3_adlog_bucket_name = data.terraform_remote_state.aws.outputs.s3_adlog_bucket_name
  // temporary
  snowflake_account_arn                              = var.aws_account_id
  snowflake_storage_integration_s3_adlog_external_id = "dummy"
}
