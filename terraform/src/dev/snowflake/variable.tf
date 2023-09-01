variable "aws_account_id" {}
variable "aws_region" {}
variable "environment" {
  default = "dev"
}
variable "project" {
  default = "snowflake"
}
variable "snowflake_storage_integration_adlog_iam_user_arn" {
  default = "arn:aws:iam::073967647674:user/ddwa0000-s"
}
variable "snowflake_storage_integration_adlog_external_id" {
  default = "UN25113_SFCRole=21_NmrZ2wDkJo4qXNkescbDr2UnvVI="
}
