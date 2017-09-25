{% extends 'admin-layout.swig' %}
{% set title = 'User Page' %}
{% block body %}
	<div class="row wrapper border-bottom white-bg page-heading">
		<div class="col-md-4">
			<h2>User Page</h2>
			<ol class="breadcrumb">
				<li>
					<a href="index.html">Users</a>
				</li>
				<li class="active">
					<strong>User Page</strong>
				</li>
			</ol>
		</div>
	</div>

	<div class="wrapper wrapper-content">
		<div class="animated fadeInRightBig">
			<div class="row">
				<div class="col-md-8 col-sm-12 col-xs-12 col-lg-8">
					<div class="tabs-container">
						<div clss="tabs-right">
							<ul class="nav nav-tabs">
								<li class="active"><a data-toggle="tab" href="#tab-1"> Naira Transactions</a></li>
								<li class=""><a data-toggle="tab" href="#tab-2">BTC Transactions</a></li>
								<li class=""><a data-toggle="tab" href="#tab-3">Verification Docs</a></li>
							</ul>
							<div class="tab-content ">
								<div id="tab-1" class="tab-pane active">
									<div class="panel-body">
										<table class="table table-striped dataTable">
											<thead>
												<tr>
													<th>Date</th>
													<th>Description</th>
													<th>Type</th>
													<th>Amount (&#8358)</th>
													<th>Status</th>
												</tr>
											</thead>
											<tbody>
											{% for tnx in user.transactions %}
												<tr id="{{ tnx.id }}">
													<td>{{ tnx.createdAt | date('d-m-Y') }}</td>
													<td>{{ tnx.description }}</td>
													<td>{{ tnx.tnx_type }}</td>
													<td class="text-right">{{ tnx.amount | formatCurrency }}</td>
													<td>{{ tnx.status }}</td>
												</tr>
											{% endfor %}
											</tbody>
										</table>
									</div>
								</div>
								<div id="tab-2" class="tab-pane">
									<div class="panel-body">
										<table class="table table-striped">
											<thead>
												<tr>
													<th>Date</th>
													<th>Description</th>
													<th>BTC</th>
													<th>Fee</th>
													<th>Status</th>
												</tr>
											</thead>
											<tbody>
											{% for tnx in user.bitcointransactions %}
												<tr>
													<td>{{ tnx.tnx_date | date('d/m/Y H:i') }}</td>
													<td>{{ tnx.description }}</td>
													<td>{{ tnx.btc }}</td>
													<td>{{ tnx.fee }}</td>
													<td>{{ tnx.notice }}</td>
												</tr>
											{% endfor %}
											</tbody>
										</table>
									</div>
								</div>
								<div id="tab-3" class="tab-pane">
									<div class="panel-body">
										<div class="row">
											<div class="col-md-12">
												<h3>ID Cards</h3>
												<div>
													<div class="col-md-5"><a href="/images/"><div class="doc-preview">ID Front</div></a></div>
													<div class="col-md-5"><a href="/images/"><div class="doc-preview">ID Back</div></a></div>
													<div class="col-md-2" style="position: relative; height: 150px">
														{% if user.level.id_verified %}
															<button style="position: absolute; bottom: 0" class="btn btn-danger" id="revoke-ID">Revoke ID Card</button>
														{% else %}
															<button style="position: absolute; bottom: 0" class="btn btn-primary btn-block" id="verify-ID">Verify ID</button>
														{% endif %}
													</div>
												</div>
											</div>
										</div>
										<hr>
										<div class="row">
											<div class="col-md-12">
												<h3>Proof of Residence</h3>
												<div>
													<div class="col-md-5"><a href="/images/"><div class="doc-preview">Proof of Residence Doc</div></a></div>
													<div class="col-md-5" style="position: relative; height: 150px">
														{% if user.level.address_verified %}
															<button style="position: absolute; bottom: 0" class="btn btn-danger" id="revoke-residence-proof">Revoke Residence Proof</button>
														{% else %}
															<button style="position: absolute; bottom: 0" class="btn btn-primary" id="verify-residence-proof">Verify Residence Proof</button>
														{% endif %}
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="col-md-4 col-sm-12 col-xs-12 col-lg-4">

				</div>
			</div>
		</div>

{% endblock %}

{#{% block scriptTag %}#}
{#<script src="/js/plugins/datatables.min.js"></script>#}
{#<script type="text/javascript">#}
{#$(document).ready(function() {#}
	{#var user_id = {{ user.id | json | safe }};#}

	{#$("#verify-ID").click(function() {#}
		{#if (confirm("Are you sure you want to perform this action?")) {#}
			{#$.post('/admin/verify-id', { user_id: user_id }, function() {#}
				{#location.reload();#}
			{#});#}
		{#}#}
	{#});#}

	{#$("#revoke-ID").click(function() {#}
		{#if (confirm("Are you sure you want to perform this action?")) {#}
			{#$.post('/admin/revoke-id', { user_id: user_id }, function() {#}
				{#location.reload();#}
			{#});#}
		{#}#}
	{#});#}


	{#$("#verify-residence-proof").click(function() {#}
		{#if (confirm("Are you sure you want to perform this action?")) {#}
			{#$.post('/admin/revoke-residence-proof', { user_id: user_id }, function() {#}
				{#location.reload();#}
			{#});#}
		{#}#}
	{#});#}

	{#$("#revoke-residence-proof").click(function() {#}
		{#if (confirm("Are you sure you want to perform this action?")) {#}
			{#$.post('/admin/verify-residence', { user_id: user_id }, function() {#}
				{#location.reload();#}
			{#});#}
		{#}#}
	{#});#}


	{#$('.dataTable').DataTable({#}
		{#pageLength: 25,#}
		{#responsive: true#}
{#//		"aoColumnDefs": [#}
{#//			{ 'bSortable': false, 'aTargets': [ 1, 2, 4 ] }#}
{#//		]#}
	{#});#}
{#});#}
{#</script>#}
{#{% endblock %}#}