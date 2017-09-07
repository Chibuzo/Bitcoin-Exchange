{% extends '../layout.swig' %}
{% set title = 'Accounts' %}
{% block body %}

<style>
	#payment-details .row .col-md-6 {
		padding: 7px 15px;
	}
  
  #beneficiary {
    border: #e0e0e0 solid thin;
    background: #f0f0f0;
    font-size: 14px;
    padding: 5px;
    font-style: italic;
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
									BTC {{ btc_balance.total_bal }}
									<br><br>
								</div>
								<div>
									Available<br>
									BTC {{ btc_balance.available_bal }}
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
									NGN {{ naira_balance.total | formatCurrency }}
									<br><br>
								</div>
								<div>
									Available<br>
									NGN {{ naira_balance.available | formatCurrency }}
								</div>
								<br><hr style="margin-bottom: 8px;">
								<a href="#withdrawalModal" data-toggle="modal" class="btn btn-info pull-right fetch-beneficiaries" style="margin-left: 8px">Withdraw</a>
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
			<div class="alert alert-success">For bank transfer, use an account that bear the same name with the name you use on this site.<p>Also for bank deposit, use your name as depositor.</p></div>
			{#<div class="alert alert-success"></div>#}
		</div>
	</div>
</div>

{% include 'fund-account-modal.swig' %}
{% include 'withdrawal-form-modal.swig' %}

{% endblock %}
{% block scriptTag %}<script src="/js/plugins/numeral.min.js"></script>  {% endblock %}
{% block script %}
var amt_limit = {{ req.session.amt_limit | json | safe }};

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
  
  if ($("#amount").val() > amt_limit) { 
      $(".alert-danger")
          .html("Deposit amount can not exceed the allowed amount for your current <strong>User Level\'s</strong> which is: <strong>&#8358;" + numeral(amt_limit).format('0,00') + "</strong><p>To increase your deposit amount, go to <a href='/user/settings'>settings</a></p>")
          .removeClass("hidden").show();
      return false;
  }
  
  if ($("#payment-opt option:selected").val() == "Transfer") {
      if ($("#bank").val().length < 1 || $("#account-name").val().length < 1 || $("#account-number").val().length < 1) {
          $(".alert-danger").text("Enter the full account details for the bank transfer").removeClass("hidden").show().fadeOut(9000, function() {
              $(this).addClass('hidden');
          });
          return false;
      }
  }
	var tnx_ref = generateUniqueRef(8);

	$("#ph-amount").html('&#8358;' + numeral($("#amount").val()).format('0,0'));
	$("#ph-tnx-ref").text(tnx_ref.toUpperCase());

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


// fetch beneficiaries
$(".fetch-beneficiaries").click(function() {
  $.get('/beneficiary/getall', function(d) {
      if (d.status.trim() == 'success') {
          var html = "<option value=''>-- Choose beneficiary --</option>\n";
          $.each(d.accounts, function(i, acc) {
              html += "<option value='" + acc.id + "'>" + acc.account_name + " - " + acc.bank + "</option>";
          });
          $("#beneficiary").html(html).css({'font-style': 'normal', 'background': 'none'});
      }
  }, 'JSON')
});


// submit withdrawal request
$("#form-withdrawal").submit(function(e) {
    e.preventDefault();
    
    $.post('/withdrawal/new-request', $(this).serialize(), function(d) {
        if (d.status.trim() == 'success') {
            $("#withdrawalModal #submit-btn").hide();
            var feedback = "We have received you withdrawal request, within 48 hours from now your money will be sent to the beneficiary account you provided";
            $('#withdrawalModal .modal-body').html("<div class='alert alert-success'>" + feedback + "</div>");
        }
    }, 'JSON');
});


// cancel withdrawal request
$(".cancel-request").click(function(e) {
    e.preventDefault();
    if (confirm("Are you sure want to cancel this withdrawal request?")) {
        var id = $(this).parents('tr').attr('id');
        $.get('/withdrawal/cancel/' + id);
        location.reload();
    }
});

{% endblock %}