provider "snowflake" {
  organization_name = "OZCCFCG"
  account_name      = "KEB07684"
  user              = "AI_DWH_SVC"
  role              = "AI_DWH_ROLE"
  authenticator     = "SNOWFLAKE_JWT"

  private_key = file("/home/alex/.snowflake/keys/ai_dwh_svc_key.p8")
}