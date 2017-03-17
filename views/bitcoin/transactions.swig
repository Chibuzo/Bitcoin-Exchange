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
								<a class="dropdown-toggle btn btn-white" data-toggle="dropdown" href="#">
									<i class="fa fa-filter"></i>
								</a>
								<ul class="dropdown-menu dropdown-user">
									<li><a href="#">Send</a>
									</li>
									<li><a href="#">Received</a>
									</li>
								</ul>
							</div>
						</div>
						<div class="ibox-content">
							<table class="table table-striped">
								<thead>
									<tr>
										<th>Date</th>
										<th>BTC</th>
										<th>Receiver</th>
										<th>Address</th>
										<th>Description</th>
										<th>Message</th>
										<th>Fee</th>
										<th>Notice</th>
									</tr>
								</thead>
								<tbody id="tb-transactions">
								{% for tnx in trnx %}
									<tr id="{{ tnx.id }}">
										<td>{{ tnx.createdAt | date('D, d M Y') }}</td>
										<td>{{ tnx.btc }}</td>
										<td>{{ tnx.receiver.fullname }}</td>
										<td>{{ tnx.address }}</td>
										<td>{{ tnx.description }}</td>
										<td>{{ tnx.notice }}</td>
										<td>{{ tnx.fee / 100000000 }}</td>
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
