// RAW データベースを作成
resource "snowflake_database" "raw" {
  provider                    = snowflake.sys_admin
  name                        = upper("${var.environment}_raw")
  comment                     = "This is RAW DATABASE."
  data_retention_time_in_days = 1
}

// RAW データベースに ADLOG スキーマを作成
resource "snowflake_schema" "raw_adlog" {
  provider            = snowflake.sys_admin
  database            = snowflake_database.raw.name
  name                = upper("adlog")
  comment             = "This is an ADLOG schema."
  is_transient        = false
  is_managed          = false
  data_retention_days = 1

  depends_on = [
    snowflake_grant_privileges_to_role.dbt_future_schema_in_raw
  ]
}

// RAW データベースに SCHEMACHANGE スキーマを作成
resource "snowflake_schema" "raw_schemachange" {
  provider            = snowflake.sys_admin
  database            = snowflake_database.raw.name
  name                = upper("schemachange")
  comment             = "This is an SCHEMACHANGE schema."
  is_transient        = false
  is_managed          = false
  data_retention_days = 1
}

// RAW データベースの SCHEMACHANGE スキーマに CHANGE_HISTORY テーブルを作成
resource "snowflake_table" "schemachange_change_history" {
  provider = snowflake.sys_admin
  database = snowflake_database.raw.name
  schema   = snowflake_schema.raw_schemachange.name
  name     = upper("change_history")
  comment  = "This is a CHANGE_HISTORY table."
  column {
    name = "VERSION"
    type = "VARCHAR"
  }
  column {
    name = "DESCRIPTION"
    type = "VARCHAR"
  }
  column {
    name = "SCRIPT"
    type = "VARCHAR"
  }
  column {
    name = "SCRIPT_TYPE"
    type = "VARCHAR"
  }
  column {
    name = "CHECKSUM"
    type = "VARCHAR"
  }
  column {
    name = "EXECUTION_TIME"
    type = "NUMBER"
  }
  column {
    name = "STATUS"
    type = "VARCHAR"
  }
  column {
    name = "INSTALLED_BY"
    type = "VARCHAR"
  }
  column {
    name = "INSTALLED_ON"
    type = "TIMESTAMP_LTZ"
  }

  depends_on = [
    snowflake_grant_privileges_to_role.migration_future_table_in_raw
  ]
}

// STAGING データベースを作成
resource "snowflake_database" "staging" {
  provider                    = snowflake.sys_admin
  name                        = upper("${var.environment}_staging")
  comment                     = "This is STAGING DATABASE."
  data_retention_time_in_days = 1
}

// STAGING データベースに ADLOG スキーマを作成
resource "snowflake_schema" "staging_adlog" {
  provider            = snowflake.sys_admin
  database            = snowflake_database.staging.name
  name                = upper("adlog")
  comment             = "This is an ADLOG schema."
  is_transient        = false
  is_managed          = false
  data_retention_days = 1

  depends_on = [
    snowflake_grant_privileges_to_role.dbt_future_schema_in_staging
  ]
}

// MART データベースを作成
resource "snowflake_database" "mart" {
  provider                    = snowflake.sys_admin
  name                        = upper("${var.environment}_mart")
  comment                     = "This is MART DATABASE."
  data_retention_time_in_days = 1
}

// MART データベースに REPORT スキーマを作成
resource "snowflake_schema" "mart_report" {
  provider            = snowflake.sys_admin
  database            = snowflake_database.mart.name
  name                = upper("report")
  comment             = "This is an REPORT schema."
  is_transient        = false
  is_managed          = false
  data_retention_days = 1

  depends_on = [
    snowflake_grant_privileges_to_role.dbt_future_schema_in_mart
  ]
}
