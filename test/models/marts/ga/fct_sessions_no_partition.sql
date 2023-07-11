{{
  config(
    materialized = 'incremental',
    unique_key='session_id'
  )
}}
with final as (
    select 
    * 
    from {{ ref('stg_ga_events') }}
    {% if is_incremental() %}
        where
            date(session_start_at) >= (select max(date(session_start_at)) from {{ this }})
    {% endif %}
)
select * from final