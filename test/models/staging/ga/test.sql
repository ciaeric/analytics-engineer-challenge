select * from 
{{source('ga4','events')}}
where (_table_suffix between format_date('%Y%m%d', '2021-01-31')
            and format_date('%Y%m%d', '2021-01-31'))