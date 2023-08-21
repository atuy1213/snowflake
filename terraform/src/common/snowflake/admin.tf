// sysadminロールのユーザを指定
resource "snowflake_role_grants" "admin" {
  provider               = snowflake.security_admin
  role_name              = local.snowflake_role.sysadmin
  enable_multiple_grants = true
  users = [
    snowflake_user.admin.name,
  ]
}

// adminロールに権限を付与
resource "snowflake_grant_privileges_to_role" "admin_stg_database_raw" {
  role_name      = local.snowflake_role.sysadmin
  all_privileges = true
  on_account_object {
    object_type = "DATABASE"
    object_name = data.terraform_remote_state.dev_snowflake.outputs.snowflake_database_raw_name
  }
}

resource "snowflake_grant_privileges_to_role" "admin_stg_schema_report" {
  role_name      = local.snowflake_role.sysadmin
  all_privileges = true
  on_schema {
    schema_name = data.terraform_remote_state.dev_snowflake.outputs.snowflake_schema_report_name
  }
}

resource "snowflake_grant_privileges_to_role" "admin_dev_database_raw" {
  role_name      = local.snowflake_role.sysadmin
  all_privileges = true
  on_account_object {
    object_type = "DATABASE"
    object_name = data.terraform_remote_state.stg_snowflake.outputs.snowflake_database_raw_name
  }
}

resource "snowflake_grant_privileges_to_role" "admin_dev_schema_report" {
  role_name      = local.snowflake_role.sysadmin
  all_privileges = true
  on_schema {
    schema_name = data.terraform_remote_state.stg_snowflake.outputs.snowflake_schema_report_name
  }
}
