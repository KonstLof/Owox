{{
    config (
        materialized = 'table',
    )
}}

SELECT *
  FROM {{ ref('stg_utm') }}