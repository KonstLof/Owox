WITH A as (
SELECT DISTINCT
       '*****' as Channel -- No Channel at the moment in ad_cost table
      ,coalesce(sourceMedium, 'blank') as sourceMedium
      ,coalesce(campaign, 'blank') as Campaign
      ,coalesce(adContent, 'blank') as Content
      ,coalesce(keyword, 'blank') as term
  FROM  {{ get_ad_cost_table_name() }}
-- WHERE date between {{ var('start_date') }} and {{ var('end_date') }}
)
,B as (
SELECT DISTINCT
       coalesce(channelGrouping, 'blank') as Channel
      ,coalesce(utm_source_medium, 'blank') as sourceMedium
      ,coalesce(utm_campaign, 'blank') as Campaign
      ,coalesce(utm_content, 'blank') as Content
      ,coalesce(utm_term, 'blank') as Term
  FROM {{ get_big_table_name() }}
-- WHERE date between {{ var('start_date') }} and {{ var('end_date') }}
)
,C as (
SELECT *
  FROM A
 UNION DISTINCT
SELECT *
  FROM B
)
,D as (
SELECT row_number() over () as idUTM -- Primary key
      ,Channel
      ,sourceMedium
      ,Campaign
      ,Content
      ,Term
  FROM C
)
select idUTM
      ,case Channel -- Generate channel for ad_cost table
         when '*****' then
           case MOD(idUTM, 4)
             when 1 then 'Organic Google Search'
             when 2 then 'Paid Facebook'
             when 3 then '	Direct'
             else 'Paid Google Search'
            end
         else Channel
        end as Channel
      ,sourceMedium
      ,Campaign
      ,Content
      ,Term
  FROM D
