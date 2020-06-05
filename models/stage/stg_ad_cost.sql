SELECT cast(date AS date) AS Date
      ,'Unknown' AS Channel
      ,coalesce(sourceMedium, 'Unknown') AS sourceMedium
      ,coalesce(campaign, 'Unknown') AS Campaign
      ,coalesce(adContent, 'Unknown') AS Content
      ,coalesce(keyword, 'Unknown') AS Term
      ,'Unknown' AS Country
      ,impressions AS Impressions
      ,adClicks
      ,adCost
      ,CPC
      ,CTR
  FROM {{ get_ad_cost_table_name() }}
 WHERE date between {{ var('start_date') }} and {{ var('end_date') }}
