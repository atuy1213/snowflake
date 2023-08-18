resource "snowflake_database" "example_db" {
  name                        = upper("${var.environment}-example")
  comment                     = "This is example db."
  data_retention_time_in_days = 1
}

// developerロールにデータベースexample_dbのUSAGE権限を付与
resource "snowflake_database_grant" "grant" {
  database_name = snowflake_database.example_db.name

  privilege = "USAGE"
  roles = [
    snowflake_role.developer.name,
  ]
}

// データベースexample_dbにスキーマexample_schemaを作成
resource "snowflake_schema" "example_schema" {
  database = snowflake_database.example_db.name
  name     = "example_schema"
  comment  = "This is an example schema."

  is_transient        = false
  is_managed          = false
  data_retention_days = 1
}


// developerロールにスキーマexample_schemaのUSAGE権限を付与
resource "snowflake_schema_grant" "grant" {
  database_name = snowflake_database.example_db.name
  schema_name   = snowflake_schema.example_schema.name

  privilege = "USAGE"
  roles = [
    snowflake_role.developer.name,
  ]
}

// developerロールにデータベースexample_dbのSELECT権限を付与
resource "snowflake_table_grant" "select_example_db" {
  database_name = snowflake_database.example_db.name

  privilege = "SELECT"
  roles = [
    snowflake_role.developer.name,
  ]
  on_future = true
}