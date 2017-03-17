{% extends 'admin-layout.swig' %}
{% set title = 'Dashboard' %}
{% block body %}

<div class="row wrapper border-bottom white-bg page-heading">
	<div class="col-sm-4">
		<h2>Dashboard</h2>
		<ol class="breadcrumb">
			<li>
				<a href="index.html">Admin</a>
			</li>
			<li class="active">
				<strong>Dashboard</strong>
			</li>
		</ol>
	</div>
</div>

<div class="wrapper wrapper-content">
	<div class="animated fadeInRightBig">
		<div class="row">
			<div class="col-md-12">
				<div class="ibox float-e-margins">
					<div class="ibox-title">
						<h5>Admin</h5>
						<div class="ibox-tools hidden">
							<a class="dropdown-toggle" data-toggle="dropdown" href="#">
								<i class="fa fa-filter"></i>
							</a>
							<ul class="dropdown-menu dropdown-user">
								<li><a href="#">Active</a>
								</li>
								<li><a href="#">Inactive</a>
								</li>
							</ul>
						</div>
					</div>
					<div class="ibox-content">
						Content here. Haha!
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
{% endblock %}
