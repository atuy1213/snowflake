locals {
  snowflake_role = {
    accountadmin  = "ACCOUNTADMIN"
    sysadmin      = "SYSADMIN"
    securityadmin = "SECURITYADMIN"
    terraform     = "TERRAFORM" // WebUIから作成
  }
}

// devの管理者のロール
resource "snowflake_role" "dev_admin" {
  provider = snowflake.security_admin
  name     = upper("dev_admin")
  comment  = "A role for dev admin."
}

// devの開発者のロール
resource "snowflake_role" "dev_developer" {
  provider = snowflake.security_admin
  name     = upper("dev_developer")
  comment  = "A role for dev developer."
}

// devのML/DSのロール
resource "snowflake_role" "dev_analyst" {
  provider = snowflake.security_admin
  name     = upper("dev_analyst")
  comment  = "A role for dev analyst."
}

// stgの管理者のロール
resource "snowflake_role" "stg_admin" {
  provider = snowflake.security_admin
  name     = upper("stg_admin")
  comment  = "A role for dev admin."
}

// stgの開発者のロール
resource "snowflake_role" "stg_developer" {
  provider = snowflake.security_admin
  name     = upper("stg_developer")
  comment  = "A role for stg developer."
}

// stgのML/DSのロール
resource "snowflake_role" "stg_analyst" {
  provider = snowflake.security_admin
  name     = upper("stg_analyst")
  comment  = "A role for dev analyst."
}

// businessのロール
resource "snowflake_role" "business" {
  provider = snowflake.security_admin
  name     = upper("business")
  comment  = "A role for business."
}

// devの管理者ロールを利用できるユーザーを指定
resource "snowflake_role_grants" "dev_admin" {
  provider               = snowflake.security_admin
  role_name              = snowflake_role.dev_admin.name
  enable_multiple_grants = true
  users = [
    snowflake_user.admin.name,
  ]
}

// devの開発者ロールを利用できるユーザーを指定
resource "snowflake_role_grants" "dev_developer" {
  provider               = snowflake.security_admin
  role_name              = snowflake_role.dev_developer.name
  enable_multiple_grants = true
  users = [
    snowflake_user.developer.name,
  ]
}

// devのML/DSロールを利用できるユーザーを指定
resource "snowflake_role_grants" "dev_analyst" {
  provider               = snowflake.security_admin
  role_name              = snowflake_role.dev_analyst.name
  enable_multiple_grants = true
  users = [
    snowflake_user.analyst.name,
  ]
}

// stgの管理者ロールを利用できるユーザーを指定
resource "snowflake_role_grants" "stg_admin" {
  provider               = snowflake.security_admin
  role_name              = snowflake_role.stg_admin.name
  enable_multiple_grants = true
  users = [
    snowflake_user.admin.name,
  ]
}

// stgの開発者ロールを利用できるユーザーを指定
resource "snowflake_role_grants" "stg_developer" {
  provider               = snowflake.security_admin
  role_name              = snowflake_role.stg_developer.name
  enable_multiple_grants = true
  users = [
    snowflake_user.developer.name,
  ]
}

// stgのML/DSロールを利用できるユーザーを指定
resource "snowflake_role_grants" "stg_analyst" {
  provider               = snowflake.security_admin
  role_name              = snowflake_role.stg_analyst.name
  enable_multiple_grants = true
  users = [
    snowflake_user.analyst.name,
  ]
}

// businessのロールを利用できるユーザーを指定
resource "snowflake_role_grants" "business" {
  provider               = snowflake.security_admin
  role_name              = snowflake_role.business.name
  enable_multiple_grants = true
  users = [
    snowflake_user.business.name,
  ]
}