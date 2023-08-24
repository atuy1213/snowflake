// businessロールのユーザーを指定
resource "snowflake_role_grants" "business" {
  provider               = snowflake.security_admin
  role_name              = snowflake_role.business.name
  enable_multiple_grants = true
  roles = [
    local.snowflake_role.sysadmin,
  ]
  users = [
    snowflake_user.business.name,
  ]
}

// businessのロール
resource "snowflake_role" "business" {
  provider = snowflake.security_admin
  name     = upper("business")
  comment  = "A role for business."
}

// business 用の Warehouse を作成
resource "snowflake_warehouse" "business" {
  for_each = toset(["xsmall", "small", "medium", "large"])

  provider                     = snowflake.sys_admin
  name                         = upper("wh_business_${each.key}")
  comment                      = "Warehouse for business on ${each.key} size"
  warehouse_size               = each.key
  auto_resume                  = true
  auto_suspend                 = 60
  statement_timeout_in_seconds = 3600 // 1 hour
  initially_suspended          = true
  enable_query_acceleration    = false
}

resource "snowflake_grant_privileges_to_role" "business_warehouse" {
  for_each   = snowflake_warehouse.business
  role_name  = snowflake_role.business.name
  privileges = ["USAGE"]
  on_account_object {
    object_type = "WAREHOUSE"
    object_name = each.value.name
  }
}