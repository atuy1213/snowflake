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
  on_account_object {
    object_type = "SCHEMA"
    object_name = data.terraform_remote_state.dev_snowflake.outputs.snowflake_schema_report_name
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
  on_account_object {
    object_type = "SCHEMA"
    object_name = data.terraform_remote_state.stg_snowflake.outputs.snowflake_schema_report_name
  }
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
  on_account_object {
    object_type = "SCHEMA"
    object_name = data.terraform_remote_state.dev_snowflake.outputs.snowflake_schema_report_name
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
  on_account_object {
    object_type = "SCHEMA"
    object_name = data.terraform_remote_state.stg_snowflake.outputs.snowflake_schema_report_name
  }
}


// beginnerロールに権限を付与
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
  on_account_object {
    object_type = "SCHEMA"
    object_name = data.terraform_remote_state.dev_snowflake.outputs.snowflake_schema_report_name
  }
}