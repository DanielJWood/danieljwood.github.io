## Awards

{% assign previous_title = nil %}

{% for row in site.data.awards %}
  {% if row.select == 'TRUE' %}
    {% if row.award_ceremony != previous_title %}

### {{row['award_ceremony']}}, {{row['year']}}
    {% assign previous_title = row.award_ceremony %}
    {% endif %}
#### **{{ row.award_place | default: "" }}**{% if row.award_category and row.award_place %}, {% endif %} {{ row.award_category | default: "" }}
###### _{{ row.story_name | default: "" }}_

  {% endif %}
{% endfor %}
