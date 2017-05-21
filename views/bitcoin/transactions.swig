{% extends '../layout.swig' %}
{% set title = 'Bitcoin Transactions' %}
{% block body %}

	<div class="row wrapper border-bottom white-bg page-heading">
		<div class="col-sm-4">
			<h2>Transactions</h2>
			<ol class="breadcrumb">
				<li>
					Transactions
				</li>
				<li class="active">
					<strong>BTC</strong>
				</li>
			</ol>
		</div>
		<div class="col-md-4 pull-right text-right">
			<h1>BTC {{ req.session.coinBalance }}</h1>
		</div>
	</div>

	<div class="wrapper wrapper-content">
		<div class="animated fadeInRight">
			<div class="row">
				<div class="col-md-12">
					<div class="ibox float-e-margins">
						<div class="ibox-title">
							<h5>Transactions</h5>
							<div class="ibox-tools">
								<a class="dropdown-toggle btn btn-white btn-sm" data-toggle="dropdown" href="#">
									<i class="fa fa-filter"></i>
								</a>
								<ul class="dropdown-menu dropdown-user">
									<li><a href="#">Sent</a>
									</li>
									<li><a href="#">Received</a>
									</li>
								</ul>
							</div>
						</div>
						<div class="ibox-content">
							<table class="table table-hover">
								<thead>
									<tr>
										<th>Date</th>
										<th>Receiver</th>
										<th>Address</th>
										<th>Description</th>
										<th class="text-right">BTC</th>
										<th class="text-right">Fee</th>
										<th>Status</th>
									</tr>
								</thead>
								<tbody id="tb-transactions">
								{% for tnx in trnx %}
									{% if tnx.receiver.fullname == req.session.fname %}
										{% set receiver = "Me" %}
										{% set tr = "warning" %}
									{% else %}
										{% set receiver = tnx.receiver.fullname %}
										{% set tr = "" %}
									{% endif %}
									
									<tr id="{{ tnx.id }}" class="{{ tr }}">
										<td>{{ tnx.createdAt | date('D, d-m-Y') }}</td>
										<td>{{ receiver }}</td>
										<td>{{ tnx.address }}</td>
										<td>{{ tnx.description }}</td>
										<td class="text-right">{{ tnx.btc }}</td>
										<td class="text-right">{{ tnx.fee / 100000000 }}</td>
										<td>{{ tnx.notice }}</td>
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
