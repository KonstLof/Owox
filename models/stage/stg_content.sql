SELECT DISTINCT Content
  FROM {{ ref('stg_ad_cost') }}
 UNION DISTINCT
SELECT DISTINCT Content
  FROM {{ ref('stg_big_table') }}
