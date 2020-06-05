{{
    config(
        unique_key = 'Content' 
    )
}}

WITH A AS (
SELECT 'Unknown' AS Content
 UNION DISTINCT
SELECT Content
  FROM {{ ref('stg_content') }}
)
SELECT GENERATE_UUID() as uuidContent
      ,Content
  FROM A
