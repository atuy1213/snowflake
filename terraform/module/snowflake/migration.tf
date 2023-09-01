// migration用のユーザ
resource "snowflake_user" "migration" {
  provider     = snowflake.user_admin
  name         = upper("${var.environment}_migration")
  password     = data.aws_ssm_parameter.migration_password.value
  default_role = snowflake_role.migration.name
  comment      = "Created by Terraform."
}

data "aws_ssm_parameter" "migration_password" {
  name = "/github.com/atuy1213/snowflake/migration/${var.environment}/user/password"
}

// migration用のロール
resource "snowflake_role" "migration" {
  provider = snowflake.security_admin
  name     = upper("${var.environment}_migration")
  comment  = "A role for ${var.environment} migration."
}

// migration 用の Warehouse を作成
resource "snowflake_warehouse" "migration" {
  provider                     = snowflake.sys_admin
  name                         = upper("${var.environment}_wh_migration_xsmall")
  comment                      = "Warehouse for ${var.environment} migration on xsmall size"
  warehouse_size               = "xsmall"
  auto_resume                  = true
  auto_suspend                 = 60
  statement_timeout_in_seconds = 3600 // 1 hour
  initially_suspended          = true
  enable_query_acceleration    = false
}

// migrationロールをmigrationユーザに付与
resource "snowflake_role_grants" "migration" {
  provider               = snowflake.security_admin
  role_name              = snowflake_role.migration.name
  enable_multiple_grants = true
  roles = [
    local.snowflake_role.accountadmin,
  ]
  users = [
    snowflake_user.migration.name,
  ]
}

// migrationロールに権限を付与

resource "snowflake_grant_privileges_to_role" "migration_warehouse" {
  role_name  = snowflake_role.migration.name
  privileges = ["USAGE"]
  on_account_object {
    object_type = "WAREHOUSE"
    object_name = snowflake_warehouse.migration.name
  }
}

resource "snowflake_grant_privileges_to_role" "migration_database_raw" {
  role_name  = snowflake_role.migration.name
  privileges = ["USAGE"]
  on_account_object {
    object_type = "DATABASE"
    object_name = snowflake_database.raw.name
  }
}

resource "snowflake_grant_privileges_to_role" "migration_raw_schemachange_schema" {
  role_name      = snowflake_role.migration.name
  all_privileges = true
  on_schema {
    schema_name = "${snowflake_database.raw.name}.${snowflake_schema.raw_schemachange.name}"
  }
}

resource "snowflake_grant_privileges_to_role" "migration_raw_adlog_schema" {
  role_name      = snowflake_role.migration.name
  all_privileges = true
  on_schema {
    schema_name = "${snowflake_database.raw.name}.${snowflake_schema.raw_adlog.name}"
  }
}

resource "snowflake_grant_privileges_to_role" "migration_future_table_in_raw" {
  role_name      = snowflake_role.migration.name
  all_privileges = true
  on_schema_object {
    future {
      object_type_plural = "TABLES"
      in_database        = snowflake_database.raw.name
    }
  }
}

resource "snowflake_grant_privileges_to_role" "migration_storage_integration_s3_adlog" {
  role_name      = snowflake_role.migration.name
  all_privileges = true
  on_account_object {
    object_type = "INTEGRATION"
    object_name = snowflake_storage_integration.s3_adlog.name
  }
}

# resource "snowflake_grant_privileges_to_role" "migration_external_stage_adlog" {
#   role_name      = snowflake_role.migration.name
#   all_privileges = true
#   on_schema_object {
#     object_type = "STAGE"
#     object_name = snowflake_stage.raw_adlog.name
#   }
# }
