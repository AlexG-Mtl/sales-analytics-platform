resource "snowflake_schema" "terraform_test" {
  database = "SALES_ANALYTICS"
  name     = "TERRAFORM_TEST"
  comment = "Sales analytics schema managed by Terraform"
}