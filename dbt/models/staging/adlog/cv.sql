{{ config(
    schema='ADLOG'
  )
}}

SELECT
    TRACKING_ID,
    ADGROUP_ID,
    AD_ID,
    REQUEST_AT,
    DATE_TIME
FROM
    {{ source('ADLOG', 'LOG') }}
WHERE
    LOG_TYPE = 'cv'
