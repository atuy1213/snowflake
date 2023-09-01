# resource "snowflake_stage" "raw_adlog" {
#   provider            = snowflake.sys_admin
#   name                = upper("adlog")
#   url                 = "s3://${var.s3_adlog_bucket_name}/"
#   database            = snowflake_database.raw.name
#   schema              = snowflake_schema.raw_adlog.name
#   storage_integration = snowflake_storage_integration.s3_adlog.name
# }
