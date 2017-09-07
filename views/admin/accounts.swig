{% extends 'admin-layout.swig' %}
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
		<ol class="breadcrumb">
			<li>
				<a href="#">Home</a>
			</li>
			<li class="active">
				<strong>Accounts</strong>
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
									BTC {{ req.session.coinTotalAmount | toFixed }}
									<br><br>
								</div>
								<div>
									Available<br>
									BTC {{ req.session.coinAvailableBalance | toFixed }}
								</div>
								<br><hr style="margin-bottom: 8px;">
								<a href="/admin/btc-transactions" class="btn btn-primary pull-right">View Account</a>
							</div>
						</div>

						<div class="col-md-6">
							<div class="inner">
								<h3>NGN Account</h3><br>
								<div>
									Balance<br>
									NGN {{ balance.total | formatCurrency }}
									<br><br>
								</div>
								<div>
									Available<br>
									NGN {{ balance.available | formatCurrency }}
								</div>
								<br><hr style="margin-bottom: 8px;">
								<a href="/admin/naira-transactions" data-toggle="modal" class="btn btn-primary pull-right">View Transactions</a>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

{% endblock %}
{% block scriptTag %}<script src="/js/plugins/numeral.min.js"></script>  {% endblock %}