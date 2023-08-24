// sysadminロールのユーザを指定
resource "snowflake_role_grants" "admin" {
  provider               = snowflake.security_admin
  role_name              = local.snowflake_role.sysadmin
  enable_multiple_grants = true
  users = [
    snowflake_user.admin.name,
  ]
}

// admin 用の Warehouse を作成
resource "snowflake_warehouse" "admin" {
  for_each = toset(["xsmall", "small", "medium", "large"])

  provider                     = snowflake.sys_admin
  name                         = upper("wh_admin_${each.key}")
  comment                      = "Warehouse for sysadmin on ${each.key} size"
  warehouse_size               = each.key
  auto_resume                  = true
  auto_suspend                 = 60
  statement_timeout_in_seconds = 3600 // 1 hour
  initially_suspended          = true
  enable_query_acceleration    = false
}

// adminロールに権限を付与
resource "snowflake_grant_privileges_to_role" "admin_warehouse" {
  for_each   = snowflake_warehouse.admin
  role_name  = local.snowflake_role.sysadmin
  privileges = ["USAGE"]
  on_account_object {
    object_type = "WAREHOUSE"
    object_name = each.value.name
  }
}

resource "snowflake_grant_privileges_to_role" "admin_stg_database_raw" {
  role_name      = local.snowflake_role.sysadmin
  all_privileges = true
  on_account_object {
    object_type = "DATABASE"
    object_name = data.terraform_remote_state.dev_snowflake.outputs.snowflake_database_raw_name
  }
}


resource "snowflake_grant_privileges_to_role" "admin_stg_all_schema_in_raw" {
  role_name      = local.snowflake_role.sysadmin
  all_privileges = true
  on_schema {
    all_schemas_in_database = data.terraform_remote_state.dev_snowflake.outputs.snowflake_database_raw_name
  }
}

resource "snowflake_grant_privileges_to_role" "admin_stg_future_schema_in_raw" {
  role_name      = local.snowflake_role.sysadmin
  all_privileges = true
  on_schema {
    future_schemas_in_database = data.terraform_remote_state.dev_snowflake.outputs.snowflake_database_raw_name
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

resource "snowflake_grant_privileges_to_role" "admin_dev_all_schema_in_raw" {
  role_name      = local.snowflake_role.sysadmin
  all_privileges = true
  on_schema {
    all_schemas_in_database = data.terraform_remote_state.stg_snowflake.outputs.snowflake_database_raw_name
  }
}

resource "snowflake_grant_privileges_to_role" "admin_dev_future_schema_in_raw" {
  role_name      = local.snowflake_role.sysadmin
  all_privileges = true
  on_schema {
    future_schemas_in_database = data.terraform_remote_state.stg_snowflake.outputs.snowflake_database_raw_name
  }
}
