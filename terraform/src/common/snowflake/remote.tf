data "terraform_remote_state" "dev_snowflake" {
  backend = "s3"
  config = {
    bucket = "gjc-yoshimura-tfstate-bucket"
    key    = "github.com/atuy1213/snowflake/dev/snowflake.tfstate"
    region = "ap-northeast-1"
  }
}

data "terraform_remote_state" "stg_snowflake" {
  backend = "s3"
  config = {
    bucket = "gjc-yoshimura-tfstate-bucket"
    key    = "github.com/atuy1213/snowflake/stg/snowflake.tfstate"
    region = "ap-northeast-1"
  }
}
