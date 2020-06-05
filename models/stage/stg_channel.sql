SELECT DISTINCT Channel
  FROM {{ ref('stg_ad_cost') }}
 UNION DISTINCT
SELECT DISTINCT Channel
  FROM {{ ref('stg_big_table') }}
