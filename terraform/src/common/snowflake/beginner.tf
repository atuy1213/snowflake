// beginnerロールにユーザを指定
resource "snowflake_role_grants" "beginner" {
  provider               = snowflake.security_admin
  role_name              = snowflake_role.beginner.name
  enable_multiple_grants = true
  roles = [
    local.snowflake_role.sysadmin,
  ]
  users = [
    snowflake_user.beginner.name,
  ]
}

// beginnerのロール
resource "snowflake_role" "beginner" {
  provider = snowflake.security_admin
  name     = upper("beginner")
  comment  = "A role for beginner."
}

// dev_beginnerのロールに権限を付与
resource "snowflake_grant_privileges_to_role" "beginner_database_raw" {
  role_name  = snowflake_role.beginner.name
  privileges = ["USAGE"]
  on_account_object {
    object_type = "DATABASE"
    object_name = data.terraform_remote_state.dev_snowflake.outputs.snowflake_database_raw_name
  }
}

resource "snowflake_grant_privileges_to_role" "beginner_schema_report" {
  role_name  = snowflake_role.beginner.name
  privileges = ["USAGE"]
  on_schema {
    schema_name = data.terraform_remote_state.dev_snowflake.outputs.snowflake_schema_report_name
  }
}