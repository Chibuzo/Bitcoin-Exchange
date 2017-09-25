{% extends '../admin/admin-layout.swig' %}
{% set title = 'Nothing' %}

{% block body %}
	<div class="row wrapper border-bottom white-bg page-heading">
		<div class="col-md-4">
			<h2>Some</h2>
			<ol class="breadcrumb">
				<li>
					<a href="index.html">Users</a>
				</li>
				<li class="active">
					<strong>Another Page</strong>
				</li>
			</ol>
		</div>
	</div>

	<div class="wrapper wrapper-content">
		Echo
	</div>
{% endblock %}