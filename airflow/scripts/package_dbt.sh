#!/usr/bin/env bash
set -euo pipefail

rm -rf include/sales_analytics
mkdir -p include/sales_analytics

cp -a ../sales_analytics/. include/sales_analytics/

rm -rf \
  include/sales_analytics/target \
  include/sales_analytics/logs \
  include/sales_analytics/.git

echo "dbt project packaged into airflow/include/sales_analytics"