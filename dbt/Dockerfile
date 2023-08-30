FROM python:3.9

ENV DBT_CORE_VERSION=1.6.1
ENV DBT_SNOWFLAKE_VERSION=1.6.1
RUN pip install -U pip
RUN pip install dbt-core==${DBT_CORE_VERSION} dbt-snowflake==${DBT_SNOWFLAKE_VERSION}

COPY . /dbt
WORKDIR /dbt

# # install dbt dependency to use dbt packages
# RUN dbt deps
