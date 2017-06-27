{% extends '../layout.swig' %}
{% set title = 'SEttings' %}
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
									<h3>Personal Details</h3><br>
									<div class="col-md-4"><i class="fa fa-user fa-lg"></i> Name</div>
									<div class="col-md-8 pull-right">{{ user.fullname }}</div>
									<br><hr style="margin-bottom: 8px;">
								</div>
							</div>

							<div class="col-md-6">
								<div class="inner">
									<h3>Security</h3><br>
									<div>
										Two-factor Authentication
									</div>
									<div>
										Password
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

{% endblock %}

{% block script %}

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