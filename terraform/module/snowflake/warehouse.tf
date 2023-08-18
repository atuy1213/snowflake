// dbt 用の Warehouse を作成
resource "snowflake_warehouse" "dbt" {
  for_each = toset(["xsmall", "small", "medium", "large"])

  provider                     = snowflake.sys_admin
  name                         = upper("${var.environment}_wh_dbt_${each.key}")
  comment                      = "Warehouse for ${var.environment} dbt on ${each.key} size"
  warehouse_size               = each.key
  auto_resume                  = true
  auto_suspend                 = 60
  statement_timeout_in_seconds = 3600 // 1 hour
  initially_suspended          = true
  enable_query_acceleration    = false
}

// dbt ロールに dbt Warehouse の USAGE 権限を付与
resource "snowflake_warehouse_grant" "dbt" {
  provider       = snowflake.security_admin
  for_each       = snowflake_warehouse.dbt
  warehouse_name = each.value.name
  privilege      = "USAGE"
  roles = [
    snowflake_role.dbt.name,
  ]
}
