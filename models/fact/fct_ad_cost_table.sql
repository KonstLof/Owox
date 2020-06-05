{{ config (
    materialized = 'incremental',
    incremental_strategy = 'insert_overwrite',
    partition_by = {'field': 'Date', 'data_type': 'date'},
    )
}}

SELECT T.Date
      ,D1.uuidChannel
      ,D2.uuidSourceMedium
      ,D3.uuidCampaign
      ,D4.uuidContent
      ,D5.uuidTerm
      ,{{ get_country_group() }}
      ,T.Impressions
      ,T.adClicks
      ,T.adCost
      ,T.CPC
      ,T.CTR
  FROM {{ ref('stg_ad_cost') }} AS T
  JOIN {{ ref('dim_channel') }} AS D1
    ON D1.Channel = T.Channel
  JOIN {{ ref('dim_source_medium') }} AS D2
    ON D2.sourceMedium = T.sourceMedium
  JOIN {{ ref('dim_campaign') }} AS D3
    ON D3.Campaign = T.Campaign
  JOIN {{ ref('dim_content') }} AS D4
    ON D4.Content = T.Content
  JOIN {{ ref('dim_term') }} AS D5
    ON D5.Term = T.Term
