{% extends 'admin-layout.swig' %}
{% set title = 'Completed Withdrawals' %}
{% block body %}

	<div class="row wrapper border-bottom white-bg page-heading">
		<div class="col-sm-6">
			<h2>Completed Withdrawal</h2>
			<ol class="breadcrumb">
				<li>
					Admin
				</li>
				<li class="active">
					<strong>Cashouts</strong>
				</li>
			</ol>
		</div>
    <div class="col-md-6 text-right">
      <h2>Total Widthrawals: &#8358; {{ total | formatCurrency }}</h2>
    </div>
	</div>

	<div class="wrapper wrapper-content">
		<div class="animated fadeInRight">
			<div class="row">
				<div class="col-md-12">
					<div class="ibox float-e-margins">
						<div class="ibox-title">
              <div class="row">
                <div class="col-md-6"><h4 style="margin-top: 12px">Completed Withdrawals</h4></div>
                <div class="col-md-6 text-right"><a href="/withdrawals/pending" class="btn btn-danger">Pending Requests</a></div>
              </div>
						</div>
						<div class="ibox-content">
							<table class="table table-striped">
								<thead>
								<tr>
									<th>Date</th>
									<th>User Name</th>
									<th>Bank</th>
                  <th>Account Name</th>
                  <th>Account Number</th>
									<th class="text-right">Amount</th>
									<th>Status</th>
								</tr>
								</thead>
								<tbody id="tb-transactions">
								{% for req in requests %}
									<tr id="{{ req.id }}">
										<td>{{ req.createdAt | date('d-m-Y H:i') }}</td>
										<td>{{ req.user.fullname }}</td>
										<td>{{ req.beneficiary.bank }}</td>
                    <td>{{ req.beneficiary.account_name }}</td>
                    <td>{{ req.beneficiary.account_number }}</td>                   
										<td class="text-right">&#8358;{{ req.amount | formatCurrency }}</td>
										<td>{{ req.status }}</td>
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