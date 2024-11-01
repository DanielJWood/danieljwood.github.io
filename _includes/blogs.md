## Blogs and conference presentations

{% for row in site.data.work %}
  {% if row.type != 'story' %}   
<div class='date'><span class="post-meta">{{row.date}}</span></div>
### {{row['title']}} _[[{{row.type}}]({{row.link}})]_
   
  {% endif %}

{% endfor %}


