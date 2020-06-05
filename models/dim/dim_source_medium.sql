{{
    config(
        unique_key = 'sourceMedium' 
    )
}}

WITH A AS (
SELECT 'Unknown' AS sourceMedium
 UNION DISTINCT
SELECT sourceMedium
  FROM {{ ref('stg_source_medium') }}
)
SELECT GENERATE_UUID() as uuidSourceMedium
      ,sourceMedium
  FROM A
