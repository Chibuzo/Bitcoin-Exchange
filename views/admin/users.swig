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
					<strong>Users</strong>
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
							<h5>Users</h5>
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
						<div class="ibox-content table-responsive">
							<table class="table table-striped dataTable table-bordered">
								<thead>
									<tr>
										<th style="width: 30px">S/NO</th>
										<th>Name</th>
										<th>Email</th>
										<th>Level</th>
										<th>Status</th>
										<th>Balance ( &#8358; )</th>
										<th class="text-center">Action</th>
									</tr>
								</thead>
								<tbody>
									{% set n = 0 %}
									{% for user in users %}
										{% set n = n + 1 %}
										<tr>
											<td>{{ n }}</td>
											<td>{{ user.fullname }}</td>
											<td>{{ user.email }}</td>
											<td>Level {{ user.level }}</td>
											<td>{{ user.status }}</td>
											<td class="text-center">0.00</td>
											<td class="opt-icons text-center">
												<a href="/admin/userpage/{{ user.id }}" class="" data-toggle="tooltip" title="View activities"><i class="fa fa-exchange fa-lg"></i> </a>
												<a href="" class="ban-user" data-toggle="tooltip" title="Ban User"><i class="fa fa-ban fa-lg"></i> </a>
											</td>
										</tr>
									{% endfor %}
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
{% endblock %}

{% block scriptTag %}
<script src="/js/plugins/datatables.min.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	$('.dataTable').DataTable({
		pageLength: 25,
		responsive: true,
		"aoColumnDefs": [
			{ 'bSortable': false, 'aTargets': [ 0, 2, 3, 4, 6 ] }
		]
	});


	$(function () {
		$('[data-toggle="tooltip"]').tooltip();
	});
})
</script>
{% endblock %}