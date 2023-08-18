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

// beginnerロールに権限を付与
resource "snowflake_role_grants" "beginner" {
  provider               = snowflake.security_admin
  role_name              = snowflake_role.beginner.name
  enable_multiple_grants = true
  roles = [
    snowflake_role.dev_developer.name,
  ]
  users = [
    snowflake_user.beginner.name,
  ]
}

// adminロールに権限を付与し、ユーザを指定
resource "snowflake_role_grants" "admin" {
  provider               = snowflake.security_admin
  role_name              = snowflake_role.admin.name
  enable_multiple_grants = true
  roles = [
    snowflake_role.dev_admin.name,
    snowflake_role.stg_admin.name,
  ]
  users = [
    snowflake_user.admin.name,
  ]
}

// developerロールに権限を付与、ユーザを指定
resource "snowflake_role_grants" "developer" {
  provider               = snowflake.security_admin
  role_name              = snowflake_role.developer.name
  enable_multiple_grants = true
  roles = [
    snowflake_role.dev_developer.name,
    snowflake_role.stg_developer.name,
  ]
  users = [
    snowflake_user.developer.name,
  ]
}

// analystロールに権限を付与、ユーザを指定
resource "snowflake_role_grants" "analyst" {
  provider               = snowflake.security_admin
  role_name              = snowflake_role.analyst.name
  enable_multiple_grants = true
  roles = [
    snowflake_role.dev_analyst.name,
    snowflake_role.stg_analyst.name,
  ]
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
