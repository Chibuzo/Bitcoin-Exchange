{% extends 'admin-layout.swig' %}
{% set title = 'Naira Transactions' %}
{% block body %}

	<div class="row wrapper border-bottom white-bg page-heading">
		<div class="col-sm-4">
			<h2>Transactions</h2>
			<ol class="breadcrumb">
				<li>
					Admin
				</li>
				<li class="active">
					<strong>Naira Transactions</strong>
				</li>
			</ol>
		</div>
    <div class="col-md-6">

    </div>
	</div>

	<div class="wrapper wrapper-content">
		<div class="animated fadeInRight">
			<div class="row">
				<div class="col-md-12">
					<div class="ibox float-e-margins">
						<div class="ibox-title">
							<h5>Naira Transactions</h5>
						</div>
						<div class="ibox-content">
							<table class="table table-striped">
								<thead>
								<tr>
									<th>Date</th>
									<th>User Name</th>
									<th>Description</th>
									<th>Type</th>
									<th>Payment Method</th>
									<th>Bank</th>
									<th class="text-right">Amount (&#8358;)</th>
									<th>Status</th>
									<th class="text-center">Action</th>
								</tr>
								</thead>
								<tbody id="tb-transactions">
								{% for tnx in trnx %}
									<tr id="{{ tnx.id }}">
										<td>{{ tnx.createdAt | date('d-m-Y H:i') }}</td>
										<td>{{ tnx.user.fullname }}</td>
										<td>{{ tnx.description }}</td>
										<td>{{ tnx.tnx_type }}</td>
										<td>{{ tnx.payment_opt }}</td>
										<td>{{ tnx.bank }}</td>
										<td class="text-right">{{ tnx.amount | formatCurrency }}</td>
										<td>{{ tnx.status }}</td>
										<td class="text-center opt-icons">
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
$(".approve").click(function(e) {
	e.preventDefault();
	if (!confirm("Are you sure you want to confirm this payment?")) {
		return false;
	}
	var $parentTr = $(this).parents('tr');
	var id = $parentTr.attr('id');
	$.post('/naira-transaction/approve-funding', { 'id': id }, function(d) {
		if (d.status.trim() == 'success') {
			$parentTr.find('td:nth-child(8)').text('Confirmed');
		}
	});
});


$(function() {
	$('[data-toggle="tooltip"]').tooltip();
});