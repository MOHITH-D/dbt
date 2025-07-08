{% macro discount(amt_column)%}
(
    {{amt_column}}*0.90
)
{% endmacro%}