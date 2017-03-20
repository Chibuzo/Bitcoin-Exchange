{% extends '../theme.swig' %}
{% set title = 'Exchange' %}
{% block body %}
<style>
	#chart-canvass {
		min-height: 350px;
	}

	.trade-header {
		padding: 5px 8px;
		background-color: #e0e0e0;
		color: #666;
		overflow: auto;
		font-weight: bold;
		border-radius: 3px;
	}

	.inner-div {
		padding: 15px 8px;
		color: #f0f0f0;
	}

	table tr td {
		padding: 3px;
	}

	table {
		width: 100%;
		padding: 2px;
	}

	.trade-btn:link, .trade-btn:visited {
		color: #666;
	}

	.trade-btn-active:link, .trade-btn-active:visited {
		color: #fff;
	}

</style>

<div class="container-fluid">
	<div class="row" style="margin-top: 100px !important;">
		<div class="col-md-2">
			<div class="trade-header">Order Book</div>
		</div>

		<div class="col-md-8">
			<div class="row">
				<div class="trade-header">Chart</div>
				<div class="col-md-12">
					<div id="chart-canvass">
						Things here men
					</div>
				</div>
			</div>

			<div class="row">
				<div class="col-md-4">
					<div class="trade-header">
						<div class="pull-left">Place Order</div>
						<div class="pull-right">
							<a href="" class="btn-buy trade-btn trade-btn-active">BUY</a>&nbsp; &nbsp;<a href="" class="btn-sell trade-btn">SELL</a>
						</div>
					</div>
					<div class="inner-div">
						<form action="" method="post" id="form-trade">
							<div class="form-group">
								<div class="input-group">
									<span class="input-group-addon"><i class="fa fa-bitcoin"></i> </span>
									<input type="number" name="btc_qty" id="btc_qty" class="form-control" placeholder="BTC Amount to buy" data-toggle="tooltip" title="Enter the amount of bitcoin you want to buy" data-container="body" data-placement="right" required />
								</div>
							</div>

							<div class="form-group">
								<div class="input-group">
									<span class="input-group-addon">&#8358;</span>
									<input type="number" name="prefered_amount" id="prefered_amount" class="form-control" placeholder="Naira price per bitcoin" data-toggle="tooltip" title="Enter amount at which you want to buy bitcoin" data-container="body" data-placement="right" required />
								</div>
							</div>
							<input type="hidden" name="trade_opt" id="trade-opt" value="Buy" />
							<input type="hidden" id="sell-fees" value="{{ sails.fees.sell_btc }}" />
							<input type="hidden" id="buy-fees" value="{{ sails.fees.order_btc }}" />
							<input type="hidden" id="ngn-balance" value="{{ req.session.naira_avaliable }}" />
							<input type="hidden" id="btc-balance" value="{{ req.session.coinBalance }}" />
						</form>
						<table class="buy">
							<tr>
								<td style="width: 190px">Required funds:</td>
								<td>NGN</td>
								<td id="ng-required" class="text-right">0.00</td>
							</tr>
							<tr>
								<td>Available balance:</td>
								<td>NGN</td>
								<td id="ng-balance" class="text-right">0.00</td>
							</tr>
							<tr>
								<td>Estimated fees:</td>
								<td>BTC</td>
								<td id="est-btc" class="text-right">0.00</td>
							</tr>
						</table>
						<table class="sell hidden">
							<tr>
								<td>Required funds:</td>
								<td>BTC</td>
								<td id="btc-required" class="text-right">0.00</td>
							</tr>
							<tr>
								<td>Available balance:</td>
								<td>BTC</td>
								<td id="btc-balance" class="text-right">0.00</td>
							</tr>
							<tr>
								<td>Sales total:</td>
								<td>NGN</td>
								<td id="sales-total" class="text-right">0.00</td>
							</tr>
							<tr>
								<td>Estimated fees:</td>
								<td>BTC</td>
								<td id="est-btc" class="text-right">0.00</td>
							</tr>
						</table>
						<button type="button" class="btn btn-info btn-block btn-sm" style="margin-top: 7px">Sign in to trade</button>
					</div>
				</div>
				<div class="col-md-8">
					<div class="trade-header">
						<div class="pull-left">Open Orders</div>
						<div class="pull-right">Open</div>
					</div>
					<div class="inner-div">
						<table>
							<thead>
								<tr>
									<th></th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td></td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>

		<div class="col-md-2">
			<div class="trade-header">Recent Trades</div>
			<div class="inner-div">
				24 Hour Volume: BTC
			</div>
		</div>
	</div>
</div>

<script type="text/javascript" src="/js/plugins/numeral.min.js"></script>
{% endblock %}

{% block script %}
$('body').css('background-color', '#2f4050');

$(function () {
	$('[data-toggle="tooltip"]').tooltip();
});


// update estimated cost and fees
var btc, ngn;
$("#btc_qty, #prefered_amount").keyup(function() {
	btc = $("#btc_qty").val();
	ngn = $("#prefered_amount").val();

	var selling_fees = $("#sell-fees").val() / 100;
	var buying_fees = $("#buy-fees").val() / 100;
	var naira_balance = +$("#ngn-balance").val() || 0.00;
	var btc_balance = $("#btc-balance").val();
	var trade_opt = $("#trade-opt").val();

	if (trade_opt == 'Buy') {
		buying_fees = (buying_fees * btc).toFixed(8);
		$(".buy").find("#est-btc").text(buying_fees);
		$(".buy").find("#ng-required").text(numeral(ngn * btc).format('0,0.00'));
		$(".buy").find("#ng-balance").text(naira_balance);
	} else if (trade_opt == 'Sell') {
		selling_fees = (selling_fees * btc).toFixed(8);
		$(".sell").find("#est-btc").text(selling_fees);
		$(".sell").find("#btc-required").text(btc);
		$(".sell").find("#btc-balance").text(btc_balance);
		$(".sell").find("#sales-total").text(numeral(ngn * btc).format('0,0.00'))
	}
});



$(".btn-sell").click(function(e) {
	e.preventDefault();
	$("#trade-opt").val('Sell');
	$(this).addClass('trade-btn-active');
	$(".buy").addClass('hidden');
	$(".sell").removeClass('hidden');
	$(".btn-buy").removeClass('trade-btn-active');
});


$(".btn-buy").click(function(e) {
	e.preventDefault();
	$("#trade-opt").val('Buy');
	$(this).addClass('trade-btn-active');
	$(".sell").addClass('hidden');
	$(".buy").removeClass('hidden');
	$(".btn-sell").removeClass('trade-btn-active');
});


// submit form
$("#form-trade").submit(function(e) {
	e.preventDefault();

	var opt = $("#trade-opt").val();
	if (opt == 'Sell') {
		$.post('/offer/sell', $(this).serialize(), function(d) {
			if (d.status.trim() == 'success') {

			} else {

			}
		}, 'JSON');
	} else if (opt == 'Buy') {
		$.post('/order/buy', $(this).serialize(), function(d) {
			if (d.status.trim() == 'success') {

			} else {

			}
		}, 'JSON');
	}
});
{% endblock %}