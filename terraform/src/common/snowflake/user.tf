resource "snowflake_user" "admin" {
  provider     = snowflake.user_admin
  name         = "admin"
  default_role = snowflake_role.dev_admin.name
  comment      = "Created by Terraform."
}

resource "snowflake_user" "developer" {
  provider     = snowflake.user_admin
  name         = "developer"
  default_role = snowflake_role.dev_developer.name
  comment      = "Created by Terraform."
}

resource "snowflake_user" "analyst" {
  provider     = snowflake.user_admin
  name         = "analyst"
  default_role = snowflake_role.dev_analyst.name
  comment      = "Created by Terraform."

}
resource "snowflake_user" "business" {
  provider     = snowflake.user_admin
  name         = "business"
  default_role = snowflake_role.business.name
  comment      = "Created by Terraform."
}
