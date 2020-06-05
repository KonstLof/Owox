{{
    config(
        unique_key = 'Campaign' 
    )
}}

WITH A AS (
SELECT 'Unknown' AS Campaign
 UNION DISTINCT
SELECT Campaign
  FROM {{ ref('stg_campaign') }}
)
SELECT GENERATE_UUID() as uuidCampaign
      ,Campaign
  FROM A
