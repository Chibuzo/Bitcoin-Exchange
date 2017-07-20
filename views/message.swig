{% extends 'layout.swig' %}
{% set title = 'Notice' %}
{% block body %}
    
<div class="row wrapper border-bottom white-bg page-heading">
    <div class="col-sm-4">
        <h2>Notice</h2>
        
    </div>
</div>

<div class="row">
    <div class="col-md-12"><br><br>
        <div class="alert {{ alert_type }} text-center">
            {{ msg }}<br>
        </div>
    </div>
</div>

{% endblock %}