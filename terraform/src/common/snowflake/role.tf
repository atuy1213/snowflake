locals {
  snowflake_role = {
    accountadmin  = "ACCOUNTADMIN"
    sysadmin      = "SYSADMIN"
    securityadmin = "SECURITYADMIN"
    terraform     = "TERRAFORM" // WebUIから作成
  }
}

// beginnerのロール
resource "snowflake_role" "beginner" {
  provider = snowflake.security_admin
  name     = upper("beginner")
  comment  = "A role for beginner."
}

// adminのロール
resource "snowflake_role" "admin" {
  provider = snowflake.security_admin
  name     = upper("admin")
  comment  = "A role for admin."
}

// developerのロール
resource "snowflake_role" "developer" {
  provider = snowflake.security_admin
  name     = upper("developer")
  comment  = "A role for developer."
}

// analystのロール
resource "snowflake_role" "analyst" {
  provider = snowflake.security_admin
  name     = upper("analyst")
  comment  = "A role for analyst."
}

// businessのロール
resource "snowflake_role" "business" {
  provider = snowflake.security_admin
  name     = upper("business")
  comment  = "A role for business."
}

// beginnerロールにユーザを指定
resource "snowflake_role_grants" "beginner" {
  provider               = snowflake.security_admin
  role_name              = snowflake_role.beginner.name
  enable_multiple_grants = true
  users = [
    snowflake_user.beginner.name,
  ]
}

// adminロールにユーザを指定
resource "snowflake_role_grants" "admin" {
  provider               = snowflake.security_admin
  role_name              = snowflake_role.admin.name
  enable_multiple_grants = true
  users = [
    snowflake_user.admin.name,
  ]
}

// developerロールにユーザを指定
resource "snowflake_role_grants" "developer" {
  provider               = snowflake.security_admin
  role_name              = snowflake_role.developer.name
  enable_multiple_grants = true
  users = [
    snowflake_user.developer.name,
  ]
}

// analystロールにユーザを指定
resource "snowflake_role_grants" "analyst" {
  provider               = snowflake.security_admin
  role_name              = snowflake_role.analyst.name
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

// devの管理者のロール
resource "snowflake_role" "dev_admin" {
  provider = snowflake.security_admin
  name     = upper("dev_admin")
  comment  = "A role for dev admin."
}

// devの管理者のロールを付与するロールを指定
resource "snowflake_role_grants" "dev_admin" {
  provider               = snowflake.security_admin
  role_name              = snowflake_role.dev_admin.name
  enable_multiple_grants = true
  roles = [
    snowflake_role.admin.name,
  ]
}

// devの開発者のロール
resource "snowflake_role" "dev_developer" {
  provider = snowflake.security_admin
  name     = upper("dev_developer")
  comment  = "A role for dev developer."
}

// devの開発者のロールを付与するロールを指定
resource "snowflake_role_grants" "dev_developer" {
  provider               = snowflake.security_admin
  role_name              = snowflake_role.dev_developer.name
  enable_multiple_grants = true
  roles = [
    snowflake_role.developer.name,
    snowflake_role.beginner, name,
  ]
}

// devのML/DSのロール
resource "snowflake_role" "dev_analyst" {
  provider = snowflake.security_admin
  name     = upper("dev_analyst")
  comment  = "A role for dev analyst."
}

// devのML/DSのロールを付与するロールを指定
resource "snowflake_role_grants" "dev_analyst" {
  provider               = snowflake.security_admin
  role_name              = snowflake_role.dev_analyst.name
  enable_multiple_grants = true
  roles = [
    snowflake_role.analyst.name,
  ]
}

// stgの管理者のロール
resource "snowflake_role" "stg_admin" {
  provider = snowflake.security_admin
  name     = upper("stg_admin")
  comment  = "A role for dev admin."
}

// stgの管理者のロールを付与するロールを指定
resource "snowflake_role_grants" "stg_admin" {
  provider               = snowflake.security_admin
  role_name              = snowflake_role.stg_admin.name
  enable_multiple_grants = true
  roles = [
    snowflake_role.admin.name,
  ]
}

// stgの開発者のロール
resource "snowflake_role" "stg_developer" {
  provider = snowflake.security_admin
  name     = upper("stg_developer")
  comment  = "A role for stg developer."
}

// stgの開発者のロールを付与するロールを指定
resource "snowflake_role_grants" "stg_developer" {
  provider               = snowflake.security_admin
  role_name              = snowflake_role.stg_developer.name
  enable_multiple_grants = true
  roles = [
    snowflake_role.developer.name,
  ]
}

// stgのML/DSのロール
resource "snowflake_role" "stg_analyst" {
  provider = snowflake.security_admin
  name     = upper("stg_analyst")
  comment  = "A role for dev analyst."
}

// stgのML/DSのロールを付与するロールを指定
resource "snowflake_role_grants" "stg_analyst" {
  provider               = snowflake.security_admin
  role_name              = snowflake_role.stg_analyst.name
  enable_multiple_grants = true
  roles = [
    snowflake_role.analyst.name,
  ]
}
