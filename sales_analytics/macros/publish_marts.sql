{% macro publish_marts() %}

    {% set publish_sql %}
        CREATE OR REPLACE TABLE
            SALES_ANALYTICS_PROD.MARTS.MART_SALES_REP_PERFORMANCE
        CLONE
            SALES_ANALYTICS_PROD.BUILD_MARTS.MART_SALES_REP_PERFORMANCE

        COPY GRANTS
    {% endset %}

    {% do run_query(publish_sql) %}

{% endmacro %}