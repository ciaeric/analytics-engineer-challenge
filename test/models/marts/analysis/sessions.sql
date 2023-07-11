{{
  config(
    materialized = 'view')
}}
with fct_sessions_no_partition as (
    select 
    *
    from {{ref('fct_sessions_no_partition')}}
),
final as (
    select 
    session_date,
    device_category,
    concat(geo_country,"-",geo_region,"-",geo_city) as location,
    concat(session_campaign,"-",session_medium,"-",session_source) as traffic_source,
    --a channel group would be better, not gonna do in the test
    count(session_id) as total_sessions,
    count(distinct user_id) as total_users,
    --could be duplicate if sum up by users
    count(distinct case when new_user_indicator = 1 then user_id else null end ) as total_new_users,
    sum(page_views) as total_page_views,
    count(case when search_indicator = 1 then session_id else null end) as sessions_with_search,
    sum(session_length_in_seconds)/count(session_id) as avg_session_duration
    from fct_sessions_no_partition
    group by session_date,
    device_category,
    concat(geo_country,"-",geo_region,"-",geo_city) ,
    concat(session_campaign,"-",session_medium,"-",session_source) 
)
select * from final
-- not overthinking, just put everything into an aggregate view, materilized view would be better, needs separate macro, so not doing it in test