{{
  config(
    materialized = 'incremental',
    partition_by = {'field': 'session_start_at', 'data_type': 'timestamp'},
    incremental_strategy = 'insert_overwrite'
  )
}}
with final as (
    select 
    * 
    from {{ ref('stg_ga_events') }}
    {% if var('query_date') != 'none' %}          
        where
            date(session_start_at) = date('{{ var('query_date') }}')
    {% elif is_incremental() %}
        where
            date(session_start_at) >= date_sub(date(_dbt_max_partition), interval 1 day)
    {% endif %}
)
select * from final
