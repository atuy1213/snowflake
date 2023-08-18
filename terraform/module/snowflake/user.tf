// dbt用のユーザ
resource "snowflake_user" "dbt" {
  provider     = snowflake.user_admin
  name         = "${var.environment}-dbt"
  default_role = snowflake_role.dbt.name
  comment      = "Created by Terraform."
}