# Data Governance

## PII Handling

Customer email is treated as PII.

A Snowflake masking policy is defined centrally in:

SALES_ANALYTICS.GOVERNANCE.EMAIL_MASK

The raw customer email column is protected by the masking policy.

The dbt staging model `stg_crm__customers` also applies the same masking policy through a dbt `post_hook`.

This ensures the policy is reapplied whenever dbt recreates the staging view.

## Access Model

- `AI_DWH_ROLE` can see unmasked data for pipeline processing.
- Restricted analyst roles see masked values.
- Governance objects are managed separately from transformation logic.

## CI Validation

The same dbt model runs in the CI schema.

Because the masking policy is applied using `{{ this }}`, the post-hook automatically targets the correct environment-specific relation.