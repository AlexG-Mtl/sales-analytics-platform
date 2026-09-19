{% macro publish_production() %}

    {% set database = target.database %}

    {% set publish_sql %}

        CREATE OR REPLACE SCHEMA {{ database }}.STAGING
        CLONE {{ database }}.BUILD_STAGING;

        CREATE OR REPLACE SCHEMA {{ database }}.CORE
        CLONE {{ database }}.BUILD_CORE;

        CREATE OR REPLACE SCHEMA {{ database }}.MARTS
        CLONE {{ database }}.BUILD_MARTS;

    {% endset %}

    {% do run_query(publish_sql) %}

{% endmacro %}