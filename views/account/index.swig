{% extends '../layout.swig' %}
{% set title = 'Accounts' %}
{% block body %}

<style>
	#payment-details .row .col-md-6 {
		padding: 7px 15px;
	}
</style>

<div class="row wrapper border-bottom white-bg page-heading">
	<div class="col-sm-4">
		<h2>Accounts</h2>
		<ol class="breadcrumb hidden">
			<li>
				<a href="index.html">Settings</a>
			</li>
			<li class="active">
				<strong>Manage Staff</strong>
			</li>
		</ol>
	</div>
</div>

<div class="wrapper wrapper-content">
	<div class="animated fadeInRight">
		<div class="row">
			<div class="col-md-12">
				<div class="panel">
					<div class="row">
						<div class="col-md-6">
							<div class="inner">
								<h3>BTC Account</h3><br>
								<div>
									Balance<br>
									BTC {{ req.session.coinTotalAmount }}
									<br><br>
								</div>
								<div>
									Available<br>
									BTC {{ req.session.coinAvailableBalance }}
								</div>
								<br><hr style="margin-bottom: 8px;">
								<a href="/transaction/btc" class="btn btn-primary pull-right">View Account</a>
							</div>
						</div>

						<div class="col-md-6">
							<div class="inner">
								<h3>NGN Account</h3><br>
								<div>
									Balance<br>
									NGN {{ req.session.naira_balance }}
									<br><br>
								</div>
								<div>
									Available<br>
									NGN {{ req.session.naira_available }}
								</div>
								<br><hr style="margin-bottom: 8px;">
								<a href="#" class="btn btn-info pull-right" style="margin-left: 8px">Withdraw</a>
								<a href="#fundAccountModal" data-toggle="modal" class="btn btn-primary pull-right">Fund Account</a>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<div id="payment_details" class="hidden">
	<div id="payment-details">
		Pay into the following account:<br>
		{% for acc in account_details %}
			<div class="row">
				<div class="col-md-6"><strong>Bank:</strong></div>
				<div class="col-md-6" id="ph-bank">{{ acc.bank }}</div>
			</div>
			<div class="row">
				<div class="col-md-6"><strong>Account Name:</strong></div>
				<div class="col-md-6" id="ph-account-name">{{ acc.account_name }}</div>
			</div>
			<div class="row">
				<div class="col-md-6"><strong>Account Number:</strong></div>
				<div class="col-md-6" id="ph-account-number">{{ acc.account_number }}</div>
			</div>
			<div class="row">
				<div class="col-md-6"><strong>Payment ref:</strong></div>
				<div class="col-md-6" id="ph-tnx-ref"></div>
			</div>
			<div class="row">
				<div class="col-md-6"><strong>Total amount payable:</strong></div>
				<div class="col-md-6" id="ph-amount"></div>
			</div><br>
		{% endfor %}
		<div>
			<div class="alert alert-success">For bank transfer, use an account that bear the same name with the name you use on this site.</div>
			<div class="alert alert-success">Also for bank deposit, use your name as depositor.</div>
		</div>
	</div>
</div>

{% include 'fund-account-modal.swig' %}

{% endblock %}

{% block script %}
$("#payment-opt").change(function() {
	var opt = $("#payment-opt option:selected").val();
	if (opt == 'Transfer') {
		$("#transfer-div").removeClass('hidden');
	} else {
		$("#transfer-div").addClass('hidden');
	}
});


$("#form-fund-account").submit(function(e) {
	e.preventDefault();
	var tnx_ref = generateUniqueRef(8);

	$("#ph-amount").html('&#8358;' + $("#amount").val());
	$("#ph-tnx-ref").text(tnx_ref);

	$.post('/account/fundNairaAccount', $(this).serialize() + '&tnx_ref=' + tnx_ref, function(d) {
		if (d.status.trim() == 'success') {
			//location.replace('/account/transactions');
		}
	}, 'JSON');

	$(".modal-body").fadeOut(function() {
		$(this).html($("#payment_details").html()).fadeIn();
		$("#submit-btn").text("Complete").prop("type", "button");
	});
});


// complete funding action
$("#form-fund-account").on("click", "button[type='button']#submit-btn", function() {
	location.replace('/account/transactions');
});

{% endblock %}