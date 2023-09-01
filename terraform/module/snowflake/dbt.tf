// dbt用のユーザ
resource "snowflake_user" "dbt" {
  provider     = snowflake.user_admin
  name         = upper("${var.environment}_dbt")
  password     = data.aws_ssm_parameter.dbt_password.value
  default_role = snowflake_role.dbt.name
  comment      = "Created by Terraform."
}

data "aws_ssm_parameter" "dbt_password" {
  name = "/github.com/atuy1213/snowflake/dbt/${var.environment}/user/password"
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
  roles = [
    local.snowflake_role.accountadmin,
  ]
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

// WARAHOUSE
resource "snowflake_grant_privileges_to_role" "dbt_warehouse" {
  for_each   = snowflake_warehouse.dbt
  role_name  = snowflake_role.dbt.name
  privileges = ["USAGE"]
  on_account_object {
    object_type = "WAREHOUSE"
    object_name = each.value.name
  }
}

// RAW DATABASE
resource "snowflake_grant_privileges_to_role" "dbt_database_raw" {
  role_name      = snowflake_role.dbt.name
  all_privileges = true
  on_account_object {
    object_type = "DATABASE"
    object_name = snowflake_database.raw.name
  }
}

resource "snowflake_grant_privileges_to_role" "dbt_future_schema_in_raw" {
  role_name      = snowflake_role.dbt.name
  all_privileges = true
  on_schema {
    future_schemas_in_database = snowflake_database.raw.name
  }
}

resource "snowflake_grant_privileges_to_role" "dbt_future_table_in_raw" {
  role_name      = snowflake_role.dbt.name
  all_privileges = true
  on_schema_object {
    future {
      object_type_plural = "TABLES"
      in_database        = snowflake_database.raw.name
    }
  }
}

// STAGING DATABASE
resource "snowflake_grant_privileges_to_role" "dbt_database_staging" {
  role_name      = snowflake_role.dbt.name
  all_privileges = true
  on_account_object {
    object_type = "DATABASE"
    object_name = snowflake_database.staging.name
  }
}

resource "snowflake_grant_privileges_to_role" "dbt_future_schema_in_staging" {
  role_name      = snowflake_role.dbt.name
  all_privileges = true
  on_schema {
    future_schemas_in_database = snowflake_database.staging.name
  }
}

resource "snowflake_grant_privileges_to_role" "dbt_future_table_in_staging" {
  role_name      = snowflake_role.dbt.name
  all_privileges = true
  on_schema_object {
    future {
      object_type_plural = "TABLES"
      in_database        = snowflake_database.staging.name
    }
  }
}

// MART DATABASE
resource "snowflake_grant_privileges_to_role" "dbt_database_mart" {
  role_name      = snowflake_role.dbt.name
  all_privileges = true
  on_account_object {
    object_type = "DATABASE"
    object_name = snowflake_database.mart.name
  }
}

resource "snowflake_grant_privileges_to_role" "dbt_future_schema_in_mart" {
  role_name      = snowflake_role.dbt.name
  all_privileges = true
  on_schema {
    future_schemas_in_database = snowflake_database.mart.name
  }
}

resource "snowflake_grant_privileges_to_role" "dbt_future_table_in_mart" {
  role_name      = snowflake_role.dbt.name
  all_privileges = true
  on_schema_object {
    future {
      object_type_plural = "TABLES"
      in_database        = snowflake_database.mart.name
    }
  }
}

resource "snowflake_grant_privileges_to_role" "dbt_storage_integration_s3_adlog" {
  role_name      = snowflake_role.dbt.name
  all_privileges = true
  on_account_object {
    object_type = "INTEGRATION"
    object_name = snowflake_storage_integration.s3_adlog.name
  }
}

# resource "snowflake_grant_privileges_to_role" "dbt_external_stage_adlog" {
#   role_name      = snowflake_role.dbt.name
#   all_privileges = true
#   on_schema_object {
#     object_type = "STAGE"
#     object_name = snowflake_stage.raw_adlog.name
#   }
# }
