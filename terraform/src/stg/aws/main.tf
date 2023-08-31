module "s3" {
  source         = "../../../module/s3"
  aws_account_id = var.aws_account_id
  aws_region     = var.aws_region
  environment    = var.environment
  project        = var.project
}
