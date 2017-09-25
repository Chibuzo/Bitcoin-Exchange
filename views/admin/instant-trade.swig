{% extends 'admin-layout.swig' %}
{% set title = 'Instant Buy & Sell' %}
{% block body %}

	<div class="row wrapper border-bottom white-bg page-heading">
		<div class="col-sm-4">
			<h2>Instant Buy & Sell</h2>
			<ol class="breadcrumb">
				<li>
					Admin
				</li>
				<li class="active">
					<strong>Instant Trade</strong>
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
							<h5>Intant Trade</h5>
						</div>
						<div class="ibox-content">
							<table class="table table-striped">
								<thead>
								<tr>
									<th>Date</th>
									<th>User Name</th>
									<th>Trade Type</th>
									<th>BTC</th>
									<th>Market Price (&#8358;)</th>
									<th class="text-right">Total Amount (&#8358;)</th>
									<th>Status</th>
								</tr>
								</thead>
								<tbody id="tb-transactions">
								{% for tnx in trades %}
									<tr id="{{ tnx.id }}">
										<td>{{ tnx.createdAt | date('d-m-Y H:i') }}</td>
										<td>{{ tnx.user.fullname }}</td>
										<td>{{ tnx.trade_type }}</td>
										<td class="text-right">{{ tnx.btc | toFixed }}</td>
										<td class="text-right">{{ tnx.used_market_price | formatCurrency }}</td>
										<td class="text-right">{{ tnx.used_market_price * tnx.btc | formatCurrency }}</td>
										<td class="text-right">{{ tnx.amount | formatCurrency }}</td>
										<td>{{ tnx.status }}</td>
										<td class="text-center opt-icons hidden">
											<a href="" class="approve" data-toggle="tooltip" title="Confirm payment"><i class="fa fa-check fa-lg"></i> </a>
											<a href="" class="remove" data-toggle="tooltip" title="Remove transaction"><i class="fa fa-trash-o fa-lg"></i> </a>
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

{% block script %}
$(function() {
$('[data-toggle="tooltip"]').tooltip();
});