{% macro generate_schema_name(custom_schema_name, node) -%}

    {%- if target.name == 'prod_build' -%}

        {%- if custom_schema_name is none -%}
            BUILD
        {%- else -%}
            BUILD_{{ custom_schema_name | trim }}
        {%- endif -%}

    {%- elif custom_schema_name is none -%}

        {{ target.schema }}

    {%- else -%}

        {{ custom_schema_name | trim }}

    {%- endif -%}

{%- endmacro %}