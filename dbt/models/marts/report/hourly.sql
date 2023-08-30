{{ config(
    schema='REPORT'
  )
}}

with
imp as (
    select * from {{ ref('imp') }}
),
click as (
    select * from {{ ref('click') }}
),
cv as (
    select * from {{ ref('cv') }}
),
final as (
    select
        imp.ADGROUP_ID as ADGROUP_ID,
        imp.AD_ID as AD_ID,
        count(imp.TRACKING_ID) as IMP_COUNT,
        count(click.TRACKING_ID) as CLICK_COUNT,
        count(cv.TRACKING_ID) as CV_COUNT
    from imp
    left join click
        on imp.TRACKING_ID = click.TRACKING_ID
    left join cv
        on imp.TRACKING_ID = cv.TRACKING_ID
    group by
        imp.ADGROUP_ID,
        imp.AD_ID
    )
select * from final
