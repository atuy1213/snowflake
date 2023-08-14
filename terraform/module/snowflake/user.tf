resource "snowflake_user" "atuy1213" {
  provider     = snowflake.user_admin
  name         = "atuy1213"
  default_role = snowflake_role.developer.name
  comment      = "Created by Terraform."
}