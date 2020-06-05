SELECT DISTINCT
       Campaign
  FROM {{ ref('stg_ad_cost') }}
 UNION DISTINCT
SELECT DISTINCT
       Campaign
  FROM {{ ref('stg_big_table') }}