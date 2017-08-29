{% extends 'admin-layout.swig' %}
{% set title = 'App Settings' %}
{% block body %}

<style>
	#account-details .row .col-md-6 {
		padding: 7px 15px;
	}
</style>
	<div class="row wrapper border-bottom white-bg page-heading">
		<div class="col-sm-4">
			<h2>Dashboard</h2>
			<ol class="breadcrumb">
				<li>
					<a href="index.html">Admin</a>
				</li>
				<li class="active">
					<strong>Settings</strong>
				</li>
			</ol>
		</div>
	</div>

	<div class="wrapper wrapper-content">
		<div class="animated fadeInRight">
			<div class="row">
				<div class="col-md-6">
					<div class="ibox float-e-margins">
						<div class="ibox-title">
							<h5>Account Details</h5>
							<div class="ibox-tools">
							</div>
						</div>
						<div class="ibox-content">
							<div class="row">
								<div class="col-md-12" id="account-details">
								{% set found = 'No' %}
								{% for acc in account_details %}
									{% set found = 'Yes' %}
									<div class="row">
										<div class="col-md-6">Bank:</div>
										<div class="col-md-6" id="ph-bank">{{ acc.bank }}</div>
									</div>
									<div class="row">
										<div class="col-md-6">Account Name:</div>
										<div class="col-md-6" id="ph-account-name">{{ acc.account_name }}</div>
									</div>
									<div class="row">
										<div class="col-md-6">Account Number:</div>
										<div class="col-md-6" id="ph-account-number">{{ acc.account_number }}</div>
									</div><br>
									<button class="btn btn-default pull-right"><i class="fa fa-pencil"></i>&nbsp; Edit Account</button>
								{% endfor %}
								{% if found == 'No' %}
									<form method="post" class="" id="form-account" role="form">
										<div class="form-group">
											<label>Bank</label>
											<select id="bank" name="bank" class="form-control" required>
												<option value=""></option>
												<option value="Access Bank Nigeria Plc">Access Bank Nigeria Plc</option>
												<option value="ACCION Microfinance bank">ACCION Microfinance bank</option>
												<option value="Aso Savings">Aso Savings</option>
												<option value="Diamond Bank Plc">Diamond Bank Plc</option>
												<option value="Ecobank Nigeria">Ecobank Nigeria</option>
												<option value="Ekondo MFB">Ekondo MFB</option>
												<option value="Enterprise Bank Plc">Enterprise Bank Plc</option>
												<option value="Fidelity Bank Plc">Fidelity Bank Plc</option>
												<option value="First Bank of Nigeria Plc">First Bank of Nigeria Plc</option>
												<option value="First City Monument Bank">First City Monument Bank</option>
												<option value="Guaranty Trust Bank Plc">Guaranty Trust Bank Plc</option>
												<option value="Heritage Bank">Heritage Bank</option>
												<option value="Jaiz Bank PLC">Jaiz Bank PLC</option>
												<option value="Keystone Bank Ltd">Keystone Bank Ltd</option>
												<option value="Mainstreet Bank Plc">Mainstreet Bank Plc</option>
												<option value="Skye Bank Plc">Skye Bank Plc</option>
												<option value="Stanbic IBTC Plc">Stanbic IBTC Plc</option>
												<option value="Sterling Bank Plc">Sterling Bank Plc</option>
												<option value="Union Bank Nigeria Plc">Union Bank Nigeria Plc</option>
												<option value="United Bank for Africa Plc">United Bank for Africa Plc</option>
												<option value="Unity Bank Plc">Unity Bank Plc</option>
												<option value="WEMA Bank Plc">WEMA Bank Plc</option>
												<option value="Zenith Bank International">Zenith Bank International</option>
											</select>
										</div>

										<div class="form-group">
											<label for="subject">Account Name</label>
											<input type="text" name="account_name" id="account-name" class="form-control" required />
										</div>

										<div class="form-group">
											<label for="account-number">Account Number</label>
											<input type="text" name="account_number" id="account-number" class="form-control" required />
										</div>

										<input type="hidden" name="beneficiary_id" id="" />
										<div class="form-group">
											<input type="submit" class="btn btn-primary" value=" Save Account" />
										</div>
									</form>
								{% endif %}
								</div>
							</div>
						</div>
					</div>
				</div>

				<div class="col-md-6">
					<div class="ibox float-e-margins">
						<div class="ibox-title">
							<h5>User Levels</h5>
						</div>
						<div class="ibox-content">
							<form method="post" class="" id="form-account" role="form">
								<table class="table table-striped">
                  <thead>
                    <tr>
                      <th class="text-center">Level</th>
                      <th class="text-center">Phone</th>
                      <th class="text-center">ID Card</th>
                      <th class="text-center">Address</th>
                      <th class="text-center">Amount</th>
                    </tr>
                  </thead>
                  <tbody>
                    {% for level in levels %}
                      <tr id="1">
                        <td class="text-center">{{ level.level }}</td>
                        <td class="text-center">{% if level.phone_verified %} <i class="fa fa-check fa-lg"></i> {% else %} <i class="fa fa-times fa-lg"></i> {% endif %}</td>
                        <td class="text-center">{% if level.id_verified %} <i class="fa fa-check fa-lg"></i> {% else %} <i class="fa fa-times fa-lg"></i> {% endif %}</td>
                        <td class="text-center">{% if level.address_verified %} <i class="fa fa-check fa-lg"></i> {% else %} <i class="fa fa-times fa-lg"></i> {% endif %}</td>
                        <td class="text-center">{{ level.naira_access | formatCurrency }}</td>
                      </tr>
                    {% endfor %}
                  </tbody>
                </table>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
{% endblock %}

{% block script %}
$("#form-account").submit(function(e) {
	e.preventDefault();

	$.post('/admin/add-account', $(this).serialize(), function(d) {
		if (d.status.trim() == 'success') {
			location.replace('/admin/settings');
		}
	}, 'JSON');
});
{% endblock %}