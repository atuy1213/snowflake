// adminロールに権限を付与
resource "snowflake_grant_privileges_to_role" "g3" {
  role_name      = local.snowflake_role.sysadmin
  all_privileges = true

  // dev
  on_account_object {
    object_type = "DATABASE"
    object_name = data.terraform_remote_state.dev_snowflake.outputs.snowflake_database_raw_name
  }
  on_account_object {
    object_type = "SCHEMA"
    object_name = data.terraform_remote_state.dev_snowflake.outputs.snowflake_schema_report_name
  }

  // stg
  on_account_object {
    object_type = "DATABASE"
    object_name = data.terraform_remote_state.stg_snowflake.outputs.snowflake_database_raw_name
  }
  on_account_object {
    object_type = "SCHEMA"
    object_name = data.terraform_remote_state.stg_snowflake.outputs.snowflake_schema_report_name
  }
}

// dev_developerロールに権限を付与
resource "snowflake_grant_privileges_to_role" "g4" {
  role_name      = snowflake_role.dev_developer.name
  all_privileges = true

  on_account_object {
    object_type = "DATABASE"
    object_name = data.terraform_remote_state.dev_snowflake.outputs.snowflake_database_raw_name
  }
  on_account_object {
    object_type = "SCHEMA"
    object_name = data.terraform_remote_state.dev_snowflake.outputs.snowflake_schema_report_name
  }
}

// stg_developerロールに権限を付与
resource "snowflake_grant_privileges_to_role" "g5" {
  role_name      = snowflake_role.stg_developer.name
  all_privileges = true

  on_account_object {
    object_type = "DATABASE"
    object_name = data.terraform_remote_state.stg_snowflake.outputs.snowflake_database_raw_name
  }
  on_account_object {
    object_type = "SCHEMA"
    object_name = data.terraform_remote_state.stg_snowflake.outputs.snowflake_schema_report_name
  }
}

// beginnerロールに権限を付与
resource "snowflake_grant_privileges_to_role" "g6" {
  role_name      = snowflake_role.beginner.name
  all_privileges = true

  on_account_object {
    object_type = "DATABASE"
    object_name = data.terraform_remote_state.dev_snowflake.outputs.snowflake_database_raw_name
  }
  on_account_object {
    object_type = "SCHEMA"
    object_name = data.terraform_remote_state.dev_snowflake.outputs.snowflake_schema_report_name
  }
}