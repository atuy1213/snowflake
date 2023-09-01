variable "aws_account_id" {}
variable "aws_region" {}
variable "environment" {
  default = "stg"
}
variable "project" {
  default = "github.com-atuy1213-snowflake"
}
variable "snowflake_storage_integration_adlog_iam_user_arn" {}
variable "snowflake_storage_integration_adlog_external_id" {}
