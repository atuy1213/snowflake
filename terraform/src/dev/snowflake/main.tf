module "snowflake" {
  source = "../../../module/snowflake"

  aws_account_id = var.aws_account_id
  aws_region     = var.aws_region
  environment    = var.environment
  project        = var.project

  s3_adlog_bucket_arn                                = data.terraform_remote_state.aws.outputs.s3_adlog_bucket_arn
  snowflake_account_arn                              = "dummy"
  snowflake_storage_integration_s3_adlog_external_id = "dummy"
}
