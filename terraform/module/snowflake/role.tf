locals {
  snowflake_role = {
    accountadmin  = "ACCOUNTADMIN"
    sysadmin      = "SYSADMIN"
    securityadmin = "SECURITYADMIN"
    terraform     = "TERRAFORM" // Created by console
  }
}

// dbt用のロール
resource "snowflake_role" "dbt" {
  provider = snowflake.security_admin
  name     = upper("${var.environment}-dbt")
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
    schema_name = "${snowflake_database.raw.name}.${snowflake_schema.report.name}"
  }
}