FROM python:3.9-slim

RUN apt-get update \
    && apt-get install -y git \
    && rm -rf /var/lib/apt/lists/*

RUN pip install -U pip \
    && pip install dbt-core==1.6.1 dbt-snowflake==1.6.1

COPY . /dbt
WORKDIR /dbt

# # install dbt dependency to use dbt packages
# RUN dbt deps
