// dbt用のユーザ
resource "snowflake_user" "dbt" {
  provider     = snowflake.user_admin
  name         = "${var.environment}_dbt"
  default_role = snowflake_role.dbt.name
  comment      = "Created by Terraform."
}

// dbt用のロール
resource "snowflake_role" "dbt" {
  provider = snowflake.security_admin
  name     = upper("${var.environment}_dbt")
  comment  = "A role for ${var.environment} dbt."
}

// dbtロールをdbtユーザに付与
resource "snowflake_role_grants" "dbt" {
  provider               = snowflake.security_admin
  role_name              = snowflake_role.dbt.name
  enable_multiple_grants = true
  users = [
    snowflake_user.dbt.name,
  ]
}

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


// dbtロールに権限を付与
resource "snowflake_grant_privileges_to_role" "dbt_database_raw" {
  role_name  = snowflake_role.dbt.name
  privileges = ["USAGE"]
  on_account_object {
    object_type = "DATABASE"
    object_name = snowflake_database.raw.name
  }
}

resource "snowflake_grant_privileges_to_role" "dbt_schema_report" {
  role_name  = snowflake_role.dbt.name
  privileges = ["USAGE"]
  on_schema {
    future_schemas_in_database = snowflake_database.raw.name
  }
}

resource "snowflake_grant_privileges_to_role" "dbt_warehouse" {
  for_each   = snowflake_warehouse.dbt
  role_name  = snowflake_role.dbt.name
  privileges = ["USAGE"]
  on_account_object {
    object_type = "WAREHOUSE"
    object_name = each.value.name
  }
}
