// RAW データベースを作成
resource "snowflake_database" "raw" {
  name                        = upper("${var.environment}_raw")
  comment                     = "This is RAW DATABASE."
  data_retention_time_in_days = 1
}

// RAW データベースに REPORT スキーマを作成
resource "snowflake_schema" "report" {
  database            = snowflake_database.raw.name
  name                = upper("report")
  comment             = "This is an REPORT schema."
  is_transient        = false
  is_managed          = false
  data_retention_days = 1
}

output "snowflake_database_raw_name" {
  value = snowflake_database.raw.name
}

output "snowflake_schema_report_name" {
  value = snowflake_schema.report.name
}
