resource "snowflake_grant_privileges_to_role" "sysadmin_storage_integration_s3_adlog" {
  role_name      = local.snowflake_role.sysadmin
  all_privileges = true
  on_account_object {
    object_type = "INTEGRATION"
    object_name = snowflake_storage_integration.s3_adlog.name
  }
}
