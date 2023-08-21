// EXAMPLE データベースを作成
resource "snowflake_database" "example" {
  name                        = upper("${var.environment}_example")
  comment                     = "This is EXAMPLE DATABASE."
  data_retention_time_in_days = 1
}

// EXAMPLE データベースのUSAGE権限を付与
resource "snowflake_database_grant" "grant" {
  database_name = snowflake_database.example.name
  privilege     = "USAGE"
  roles = [
    local.snowflake_role.sysadmin,
    snowflake_role.dbt.name,
    local.snowflake_role.developer,
  ]
}

// EXAMPLE データベースに REPORT スキーマを作成
resource "snowflake_schema" "report" {
  database            = snowflake_database.example.name
  name                = upper("report")
  comment             = "This is an REPORT schema."
  is_transient        = false
  is_managed          = false
  data_retention_days = 1
}

// report スキーマのUSAGE権限を付与
resource "snowflake_schema_grant" "grant" {
  database_name = snowflake_database.example.name
  schema_name   = snowflake_schema.report.name
  privilege     = "USAGE"
  roles = [
    local.snowflake_role.sysadmin,
    local.snowflake_role.developer,
    snowflake_role.dbt.name,
  ]
}

// EXAMPLE データベースのSELECT権限を付与
resource "snowflake_table_grant" "select_example_db" {
  database_name = snowflake_database.example.name
  privilege     = "SELECT"
  roles = [
    local.snowflake_role.sysadmin,
    snowflake_role.dbt.name,
  ]
  on_future = true
}
