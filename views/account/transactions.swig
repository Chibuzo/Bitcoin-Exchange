{% extends '../layout.swig' %}
{% set title = 'Accounts' %}
{% block body %}

	<div class="row wrapper border-bottom white-bg page-heading">
		<div class="col-sm-4">
			<h2>Transactions</h2>
			<ol class="breadcrumb">
				<li>
					Home
				</li>
				<li class="active">
					<strong>Transactions</strong>
				</li>
			</ol>
		</div>
	</div>

	<div class="wrapper wrapper-content">
		<div class="animated fadeInRight">
			<div class="row">
				<div class="col-md-12">
					<div class="ibox float-e-margins">
						<div class="ibox-title">
							<h5>Naira Transactions</h5>
							<div class="ibox-tools">
								<a class="dropdown-toggle" data-toggle="dropdown" href="#">
									<i class="fa fa-filter"></i>
								</a>
								<ul class="dropdown-menu dropdown-user">
									<li><a href="#">Naira</a>
									</li>
									<li><a href="#">Bitcoin</a>
									</li>
								</ul>
							</div>
						</div>
						<div class="ibox-content">
							<table class="table table-striped">
								<thead>
								<tr>
									<th>Date</th>
									<th>Description</th>
									<th>Type</th>
									<th>Payment Method</th>
									<th>Bank</th>
									<th class="text-right">Amount</th>
									<th>Status</th>
								</tr>
								</thead>
								<tbody id="tb-beneficiaries">
								{% for tnx in tranx %}
									<tr id="{{ tnx.id }}">
										<td>{{ tnx.createdAt | date('D, d M Y - H:i') }}</td>
										<td>{{ tnx.description }}</td>
										<td>{{ tnx.tnx_type }}</td>
										<td>{{ tnx.payment_opt }}</td>
										<td>{{ tnx.bank }}</td>
										<td class="text-right">&#8358;{{ tnx.amount | formatCurrency }}</td>
										<td>{{ tnx.status }}</td>
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
