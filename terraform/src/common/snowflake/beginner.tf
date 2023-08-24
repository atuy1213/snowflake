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

// beginner 用の Warehouse を作成
resource "snowflake_warehouse" "beginner" {
  for_each = toset(["xsmall", "small", "medium", "large"])

  provider                     = snowflake.sys_admin
  name                         = upper("wh_beginner_${each.key}")
  comment                      = "Warehouse for beginner on ${each.key} size"
  warehouse_size               = each.key
  auto_resume                  = true
  auto_suspend                 = 60
  statement_timeout_in_seconds = 3600 // 1 hour
  initially_suspended          = true
  enable_query_acceleration    = false
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

resource "snowflake_grant_privileges_to_role" "beginner_warehouse" {
  for_each   = snowflake_warehouse.beginner
  role_name  = local.snowflake_role.sysadmin
  privileges = ["USAGE"]
  on_account_object {
    object_type = "WAREHOUSE"
    object_name = each.value.name
  }
}

resource "snowflake_grant_privileges_to_role" "beginner_dev_all_schema_in_raw" {
  role_name  = snowflake_role.beginner.name
  privileges = ["USAGE"]
  on_schema {
    all_schemas_in_database = data.terraform_remote_state.dev_snowflake.outputs.snowflake_database_raw_name
  }
}

resource "snowflake_grant_privileges_to_role" "beginner_dev_future_schema_in_raw" {
  role_name  = snowflake_role.beginner.name
  privileges = ["USAGE"]
  on_schema {
    future_schemas_in_database = data.terraform_remote_state.dev_snowflake.outputs.snowflake_database_raw_name
  }
}