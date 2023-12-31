terraform {
  required_version = "~> 1.5.0"

  backend "s3" {
    bucket         = "gjc-yoshimura-tfstate-bucket"
    dynamodb_table = "gjc-yoshimura-tfstate-lock-table"
    region         = "ap-northeast-1"
    key            = "github.com/atuy1213/snowflake/common/github.tfstate"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.47.0"
    }
  }
}

provider "aws" {
  region = "ap-northeast-1"
  default_tags {
    tags = {
      env     = var.environment
      project = var.project
      owner   = "terraform"
      tfstate = "common"
    }
  }
}
