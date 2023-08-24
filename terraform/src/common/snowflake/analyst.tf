// analystロールのユーザを指定
resource "snowflake_role_grants" "analyst" {
  provider               = snowflake.security_admin
  role_name              = snowflake_role.analyst.name
  enable_multiple_grants = true
  roles = [
    local.snowflake_role.sysadmin,
  ]
  users = [
    snowflake_user.analyst.name,
  ]
}

// analystのロール
resource "snowflake_role" "analyst" {
  provider = snowflake.security_admin
  name     = upper("analyst")
  comment  = "A role for analyst."
}

// admin 用の Warehouse を作成
resource "snowflake_warehouse" "analyst" {
  for_each = toset(["xsmall", "small", "medium", "large"])

  provider                     = snowflake.sys_admin
  name                         = upper("wh_analyst_${each.key}")
  comment                      = "Warehouse for analyst on ${each.key} size"
  warehouse_size               = each.key
  auto_resume                  = true
  auto_suspend                 = 60
  statement_timeout_in_seconds = 3600 // 1 hour
  initially_suspended          = true
  enable_query_acceleration    = false
}


// dev_analystのロール
resource "snowflake_role" "dev_analyst" {
  provider = snowflake.security_admin
  name     = upper("dev_analyst")
  comment  = "A role for dev analyst."
}

// dev_analystロールを付与するロールを指定
resource "snowflake_role_grants" "dev_analyst" {
  provider               = snowflake.security_admin
  role_name              = snowflake_role.dev_analyst.name
  enable_multiple_grants = true
  roles = [
    snowflake_role.analyst.name,
  ]
}

resource "snowflake_grant_privileges_to_role" "dev_analyst_warehouse" {
  for_each   = snowflake_warehouse.analyst
  role_name  = snowflake_role.dev_analyst.name
  privileges = ["USAGE"]
  on_account_object {
    object_type = "WAREHOUSE"
    object_name = each.value.name
  }
}

// stg_analystのロール
resource "snowflake_role" "stg_analyst" {
  provider = snowflake.security_admin
  name     = upper("stg_analyst")
  comment  = "A role for dev analyst."
}

// stg_analystロールを付与するロールを指定
resource "snowflake_role_grants" "stg_analyst" {
  provider               = snowflake.security_admin
  role_name              = snowflake_role.stg_analyst.name
  enable_multiple_grants = true
  roles = [
    snowflake_role.analyst.name,
  ]
}

resource "snowflake_grant_privileges_to_role" "stg_analyst_warehouse" {
  for_each   = snowflake_warehouse.analyst
  role_name  = snowflake_role.stg_analyst.name
  privileges = ["USAGE"]
  on_account_object {
    object_type = "WAREHOUSE"
    object_name = each.value.name
  }
}