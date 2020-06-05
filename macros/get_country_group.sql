{% macro get_country_group() %}

case Country
  when 'Estonia' then 'EE'
  when 'United Kingdom' then 'UK'
  when 'United States' then 'US'
  else 'ZZ'
end as countryISOCode

{% endmacro %}