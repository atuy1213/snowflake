// RAW データベースを作成
resource "snowflake_database" "raw" {
  name                        = upper("${var.environment}_raw")
  comment                     = "This is RAW DATABASE."
  data_retention_time_in_days = 1
}

// RAW データベースに ADLOG スキーマを作成
resource "snowflake_schema" "raw_adlog" {
  database            = snowflake_database.raw.name
  name                = upper("adlog")
  comment             = "This is an ADLOG schema."
  is_transient        = false
  is_managed          = false
  data_retention_days = 1
}

// STAGING データベースを作成
resource "snowflake_database" "staging" {
  name                        = upper("${var.environment}_staging")
  comment                     = "This is STAGING DATABASE."
  data_retention_time_in_days = 1
}

// STAGING データベースに ADLOG スキーマを作成
resource "snowflake_schema" "staging_adlog" {
  database            = snowflake_database.staging.name
  name                = upper("adlog")
  comment             = "This is an ADLOG schema."
  is_transient        = false
  is_managed          = false
  data_retention_days = 1
}


// MART データベースを作成
resource "snowflake_database" "mart" {
  name                        = upper("${var.environment}_mart")
  comment                     = "This is MART DATABASE."
  data_retention_time_in_days = 1
}

// MART データベースに REPORT スキーマを作成
resource "snowflake_schema" "mart_report" {
  database            = snowflake_database.mart.name
  name                = upper("report")
  comment             = "This is an REPORT schema."
  is_transient        = false
  is_managed          = false
  data_retention_days = 1
}
