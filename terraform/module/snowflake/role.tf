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
