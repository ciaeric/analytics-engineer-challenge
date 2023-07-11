with source_events as 
(   select 
    concat(user_pseudo_id, '.', (select cast(value.int_value as string) from unnest(event_params) where key = 'ga_session_id')) as session_id,
    *
    from {{source('ga4','events')}}
    where  (_table_suffix between format_date('%Y%m%d', date('{{ var("start_date") }}'))and format_date('%Y%m%d', current_date()))
),
final as (
    select 
    session_id, 
    user_pseudo_id as user_id,
    min(timestamp_micros(event_timestamp)) as session_start_at,
    format_date('%Y%m%d',min(timestamp_micros(event_timestamp)) ) as session_date,
    count(distinct case when event_name = 'first_visit' or event_name ='first_open' then user_pseudo_id else null end) as new_user_indicator,
    countif(event_name = 'page_view') as page_views,
    (max(event_timestamp)-min(event_timestamp))/1000000 as session_length_in_seconds,
    count(distinct case when event_name = 'view_search_results'then session_id else null end) as search_indicator,
    coalesce(max((select value.string_value from unnest(event_params) where key = 'source')),'(direct)') as session_source,
    coalesce(max((select value.string_value from unnest(event_params) where key = 'medium')),'(none)') as session_medium,
    coalesce(max((select value.string_value from unnest(event_params) where key = 'campaign')),'(direct)') as session_campaign,
    --channel grouping could be added for analysis
    max(geo.country) as geo_country,
    max(geo.region) as geo_region,
    max(geo.city) as geo_city,
    max(device.category) as device_category
    from source_events
    group by 1,2
)
select * from final