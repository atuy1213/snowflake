// developerロールのユーザを指定
resource "snowflake_role_grants" "developer" {
  provider               = snowflake.security_admin
  role_name              = snowflake_role.developer.name
  enable_multiple_grants = true
  roles = [
    local.snowflake_role.sysadmin,
  ]
  users = [
    snowflake_user.developer.name,
  ]
}

// developerのロール
resource "snowflake_role" "developer" {
  provider = snowflake.security_admin
  name     = upper("developer")
  comment  = "A role for developer."
}

// dev_developerのロール
resource "snowflake_role" "dev_developer" {
  provider = snowflake.security_admin
  name     = upper("dev_developer")
  comment  = "A role for dev developer."
}

// dev_developerロールを付与するロールを指定
resource "snowflake_role_grants" "dev_developer" {
  provider               = snowflake.security_admin
  role_name              = snowflake_role.dev_developer.name
  enable_multiple_grants = true
  roles = [
    snowflake_role.developer.name,
    snowflake_role.beginner.name,
  ]
}

// stg_developerのロール
resource "snowflake_role" "stg_developer" {
  provider = snowflake.security_admin
  name     = upper("stg_developer")
  comment  = "A role for stg developer."
}

// stg_developerロールを付与するロールを指定
resource "snowflake_role_grants" "stg_developer" {
  provider               = snowflake.security_admin
  role_name              = snowflake_role.stg_developer.name
  enable_multiple_grants = true
  roles = [
    snowflake_role.developer.name,
  ]
}

// dev_developerロールに権限を付与
resource "snowflake_grant_privileges_to_role" "dev_developer_database_raw" {
  role_name  = snowflake_role.dev_developer.name
  privileges = ["USAGE"]
  on_account_object {
    object_type = "DATABASE"
    object_name = data.terraform_remote_state.dev_snowflake.outputs.snowflake_database_raw_name
  }
}

resource "snowflake_grant_privileges_to_role" "dev_developer_schema_report" {
  role_name  = snowflake_role.dev_developer.name
  privileges = ["USAGE"]
  on_schema {
    future_schemas_in_database = data.terraform_remote_state.dev_snowflake.outputs.snowflake_database_raw_name
  }
}

// stg_developerロールに権限を付与
resource "snowflake_grant_privileges_to_role" "stg_developer_database_raw" {
  role_name  = snowflake_role.stg_developer.name
  privileges = ["USAGE"]
  on_account_object {
    object_type = "DATABASE"
    object_name = data.terraform_remote_state.stg_snowflake.outputs.snowflake_database_raw_name
  }
}

resource "snowflake_grant_privileges_to_role" "stg_developer_schema_report" {
  role_name  = snowflake_role.stg_developer.name
  privileges = ["USAGE"]
  on_schema {
    future_schemas_in_database = data.terraform_remote_state.stg_snowflake.outputs.snowflake_database_raw_name
  }
}
