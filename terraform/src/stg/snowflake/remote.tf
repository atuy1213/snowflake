data "terraform_remote_state" "aws" {
  backend = "s3"
  config = {
    bucket = "gjc-yoshimura-tfstate-bucket"
    key    = "github.com/atuy1213/snowflake/stg/aws.tfstate"
    region = "ap-northeast-1"
  }
}
