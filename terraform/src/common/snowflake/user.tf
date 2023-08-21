resource "snowflake_user" "admin" {
  provider     = snowflake.user_admin
  name         = upper("admin")
  default_role = local.snowflake_role.sysadmin
  comment      = "Created by Terraform."
}

resource "snowflake_user" "developer" {
  provider     = snowflake.user_admin
  name         = upper("developer")
  default_role = snowflake_role.dev_developer.name
  comment      = "Created by Terraform."
}

resource "snowflake_user" "analyst" {
  provider     = snowflake.user_admin
  name         = upper("analyst")
  default_role = snowflake_role.dev_analyst.name
  comment      = "Created by Terraform."

}
resource "snowflake_user" "business" {
  provider     = snowflake.user_admin
  name         = upper("business")
  default_role = snowflake_role.business.name
  comment      = "Created by Terraform."
}

resource "snowflake_user" "beginner" {
  provider     = snowflake.user_admin
  name         = upper("beginner")
  default_role = snowflake_role.beginner.name
  comment      = "Created by Terraform."
}