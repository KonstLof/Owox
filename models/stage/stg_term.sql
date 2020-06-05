SELECT DISTINCT Term
  FROM {{ ref('stg_ad_cost') }}
 UNION DISTINCT
SELECT DISTINCT Term
  FROM {{ ref('stg_big_table') }}
