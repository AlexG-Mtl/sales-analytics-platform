from datetime import datetime, timedelta

from airflow import DAG
from airflow.operators.bash import BashOperator
from airflow.operators.empty import EmptyOperator


DBT_PROJECT_DIR = "/usr/local/airflow/include/sales_analytics"
DBT_PROFILES_DIR = "/usr/local/airflow/include"


default_args = {
    "owner": "data-engineering",
    "retries": 2,
    "retry_delay": timedelta(minutes=5),
}


with DAG(
    dag_id="sales_analytics_production",
    description="Production orchestration for the Sales Analytics platform",
    start_date=datetime(2026, 9, 1),
    schedule="0 6 * * *",
    catchup=False,
    default_args=default_args,
    tags=["sales-analytics", "production"],
) as dag:

    start = EmptyOperator(
        task_id="start",
    )

    source_freshness = BashOperator(
        task_id="source_freshness",
        bash_command=f"""
        dbt source freshness \
          --project-dir {DBT_PROJECT_DIR} \
          --profiles-dir {DBT_PROFILES_DIR} \
          --target prod
        """,
    )


    build_candidate = BashOperator(
        task_id="build_candidate",
        bash_command=f"""
        dbt build \
          --project-dir {DBT_PROJECT_DIR} \
          --profiles-dir {DBT_PROFILES_DIR} \
          --target prod_build
        """,
    )


    publish = BashOperator(
        task_id="publish",
        bash_command=f"""
        dbt run-operation publish_production \
          --project-dir {DBT_PROJECT_DIR} \
          --profiles-dir {DBT_PROFILES_DIR} \
          --target prod
        """,
    )

    end = EmptyOperator(
        task_id="end",
    )

start >> source_freshness >> build_candidate >> publish >> end