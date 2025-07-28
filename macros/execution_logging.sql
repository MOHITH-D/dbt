{% macro log_model_start(model_name) %}
    {% set sql %}
        INSERT INTO {{ source('control', 'model_execution_log') }} (
            model_name, status, started_at, created_at
        )
        VALUES (
            '{{ model_name }}', 'RUNNING', current_timestamp, current_timestamp
        )
    {% endset %}
    {% if execute %}
        {% do run_query(sql) %}
    {% endif %}
{% endmacro %}

{% macro log_model_success(model_name) %}
    {% set sql %}
        UPDATE {{ source('control', 'model_execution_log') }}
        SET status = 'SUCCESS',
            ended_at = current_timestamp,
            run_duration = TIMESTAMPDIFF(second, started_at, current_timestamp)
        WHERE model_name = '{{ model_name }}'
          AND status = 'RUNNING'
          AND started_at = (
              SELECT MAX(started_at)
              FROM {{ source('control', 'model_execution_log') }}
              WHERE model_name = '{{ model_name }}' AND status = 'RUNNING'
          )
    {% endset %}
    {% if execute %}
        {% do run_query(sql) %}
    {% endif %}
{% endmacro %}

{% macro log_model_failure(model_name) %}
    {% set sql %}
        UPDATE {{ source('control', 'model_execution_log') }}
        SET status = 'FAILED',
            ended_at = current_timestamp,
            run_duration = TIMESTAMPDIFF(second, started_at, current_timestamp)
        WHERE model_name = '{{ model_name }}'
          AND status = 'RUNNING'
          AND started_at = (
              SELECT MAX(started_at)
              FROM {{ source('control', 'model_execution_log') }}
              WHERE model_name = '{{ model_name }}' AND status = 'RUNNING'
          )
    {% endset %}
    {% if execute %}
        {% do run_query(sql) %}
    {% endif %}
{% endmacro %}


{% macro auto_log_start() %}
    {{ log_model_start(this.name) }}
{% endmacro %}

{% macro auto_log_completion() %}
    {{ log_model_success(this.name) }}
{% endmacro %}


{% macro log_failed_models() %}
    {% if execute %}
        {% for result in results if result.status == 'error' %}
            {% do log_model_failure(result.node.name) %}
        {% endfor %}
    {% endif %}
{% endmacro %}
