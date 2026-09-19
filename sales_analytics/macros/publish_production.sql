{% macro publish_production() %}

    {% set database = target.database %}

    {% set publish_sql %}

        CREATE OR REPLACE SCHEMA {{ database }}.STAGING
        CLONE {{ database }}.BUILD_STAGING
        COPY GRANTS;

        CREATE OR REPLACE SCHEMA {{ database }}.CORE
        CLONE {{ database }}.BUILD_CORE
        COPY GRANTS;

        CREATE OR REPLACE SCHEMA {{ database }}.MARTS
        CLONE {{ database }}.BUILD_MARTS
        COPY GRANTS;

    {% endset %}

    {% do run_query(publish_sql) %}

{% endmacro %}