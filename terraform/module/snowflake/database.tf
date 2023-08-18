// EXAMPLE データベースを作成
resource "snowflake_database" "example" {
  name                        = upper("${var.environment}-example")
  comment                     = "This is example db."
  data_retention_time_in_days = 1
}

// dbt ロールに EXAMPLE データベースのUSAGE権限を付与
resource "snowflake_database_grant" "grant" {
  database_name = snowflake_database.example.name
  privilege     = "USAGE"
  roles = [
    snowflake_role.dbt.name,
  ]
}

// EXAMPLE データベースに report スキーマを作成
resource "snowflake_schema" "report" {
  database            = snowflake_database.example.name
  name                = "report"
  comment             = "This is an example schema."
  is_transient        = false
  is_managed          = false
  data_retention_days = 1
}

// dbt ロールに report スキーマのUSAGE権限を付与
resource "snowflake_schema_grant" "grant" {
  database_name = snowflake_database.example.name
  schema_name   = snowflake_schema.report.name
  privilege     = "USAGE"
  roles = [
    snowflake_role.dbt.name,
  ]
}

// dbt ロールに EXAMPLE データベースのSELECT権限を付与
resource "snowflake_table_grant" "select_example_db" {
  database_name = snowflake_database.example.name
  privilege     = "SELECT"
  roles = [
    snowflake_role.dbt.name,
  ]
  on_future = true
}
