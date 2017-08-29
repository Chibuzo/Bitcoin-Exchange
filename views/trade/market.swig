{% extends '../theme.swig' %}
{% set title = 'Exchange' %}
{% block body %}
<script type="text/javascript" src="/js/plugins/numeral.min.js"></script>	
<style>
	#chart-canvass {
		min-height: 350px;
		width: 100%;
	}

	.trade-header {
		padding: 5px 8px;
		background-color: #e0e0e0;
		color: #666;
		overflow: auto;
		font-weight: bold;
		font-size: 14px;
		border-radius: 3px;
	}
	
	#offers {
		min-height: 270px;
	}

	.inner-div {
		padding: 15px 8px;
		font-size: 13px;
	}
	
	strong {
		font-size: 13px;
	}
	
	.buy tr td, .sell tr td, .tbl-order tr td {
		color: #f0f0f0;
	}
	
	.offer-ng-amt, .offer-btc-qty, .order-ng-amt, .order-btc-qty {
		cursor: pointer;
	}

	table tr td {
		padding: 3px;
	}
	
	table tr th {
		font-size: 13px;
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
			<div class="trade-header">Available Offer</div>
			<div class="inner-div" id="offers">
				<div class="row">
						<div class="col-md-6"><strong>NGN Price</strong></div>
						<div class="col-md-6 text-right"><strong>BTC Qty</strong></div>
					</div>
				{% for offer in offer_spread %}
					<div class="row offer-row">
						<div class="col-md-6 offer-ng-amt">{{ offer.amount_per_btc }}</div>
						<div class="col-md-6 text-right offer-btc-qty">{{ offer.btc_qty }}</div>
					</div>
				{% endfor %}	
			</div>
			
			<div class="trade-header">Current Orders</div>
			<div class="inner-div" id="offers">
				<div class="row">
					<div class="col-md-6"><strong>NGN Price</strong></div>
					<div class="col-md-6 text-right"><strong>BTC Qty</strong></div>
				</div>
				{% for order in order_spread %}
					<div class="row order-row">
						<div class="col-md-6 order-ng-amt">{{ order.amount_per_btc }}</div>
						<div class="col-md-6 text-right order-btc-qty">{{ order.btc_amount }}</div>
					</div>
				{% endfor %}	
			</div>
		</div>

		<div class="col-md-7">
			<div class="row">
				<div class="trade-header">Chart</div>
				<div class="col-md-12">
					<div id="chart-canvass">
						
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
									<span class="input-group-addon"><i class="fa fa-btc"></i> </span>
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
							<input type="hidden" id="ngn-balance" value="{{ req.session.naira_available }}" />
							<input type="hidden" id="btc-balance" value="{{ req.session.coinAvailableBalance }}" />
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
								<td id="ng_balance" class="text-right">{{ req.session.naira_available }}</td>
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
								<td id="btc-balance" class="text-right">{{ req.session.coinAvailableBalance }}</td>
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
						{% if req.session.userId %}
							<button type="button" class="btn btn-info btn-block btn-sm" style="margin-top: 7px" id="order-btn" disabled>Place Order</button>
						{% else %}
							<a href="/user/signin" class="btn btn-info btn-block btn-sm" style="margin-top: 7px">Sign in to trade</a>
						{% endif %}	
					</div>
				</div>
				<div class="col-md-8">
					<div class="trade-header">
						<div class="pull-left">Open Orders</div>
						<div class="pull-right">Open</div>
					</div>
					<div class="inner-div">
						<table class="tbl-order">
							<thead>
								<tr>
									<th>Description</th>
									<th class="text-right">Required BTC</th>
									<th class="text-right">Asking Price</th>
									<th class="text-right">Total Amount</th>
									<th class="text-right">Fees</th>
									<th class="text-center">Created</th>
									<th class="text-center">Cancel</th>
								</tr>
							</thead>
							<tbody>
								{% for order in orders %}
									{% if order.owner == req.session.userId %}
										{% set amount = order.amount_per_btc * order.btc_amount %}
										<tr id="{{ order.id }}">
											<td>BTC Order</td>
											<td class="text-right">{{ order.btc_amount }}</td>
											<td class="text-right">{{ order.amount_per_btc }}</td>
											<td class="text-right">{{ amount }}</td>
											<td class="text-right">{{ order.fees }}</td>
											<td class="text-center">{{ order.createdAt | date('d-m-Y') }}</td>
											<td class="text-center"><a href="" class="cancel-order"><i class="fa fa-times fa-lg"></i></a></td>
										</tr>
									{% endif %}	
								{% endfor %}
								{% for offer in offers %}
									{% set amount = offer.amount_per_btc * offer.btc_qty %}
									<tr id="{{ offer.id }}">
										<td>BTC Offer</td>
										<td class="text-right">{{ offer.btc_qty }}</td>
										<td class="text-right">{{ offer.amount_per_btc }}</td>
										<td class="text-right">{{ amount }}</td>
										<td class="text-right">{{ offer.fees }}</td>
										<td class="text-center">{{ offer.createdAt | date('d-m-Y') }}</td>
										<td class="text-center"><a href="" class="cancel-offer"><i class="fa fa-times fa-lg"></i></a></td>
									</tr>	
								{% endfor %}
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>

		<div class="col-md-3">
			<div class="trade-header">Recent Trades</div>
			<div class="inner-div">
				24 Hour Volume: BTC
				<div class="row">
					<div class="col-md-2"><strong>Time</strong></div>
					<div class="col-md-5 text-right"><strong>NGN Price</strong></div>
					<div class="col-md-5 text-right"><strong>BTC Qty</strong></div>
				</div>
				{% for trade in trades %}
					<div class="row">
						<div class="col-md-2">{{ trade.updatedAt | date('H:i') }}</div>
						<div class="col-md-5 order-ng-amt text-right">{{ trade.amount_per_btc }}</div>
						<div class="col-md-5 text-right order-btc-qty">{{ trade.btc_amount }}</div>
					</div>
				{% endfor %}	
			</div>
		</div>
	</div>
</div>

<script type="text/javascript" src="/js/plugins/numeral.min.js"></script>
<script src="https://code.highcharts.com/highcharts.js"></script>
{% endblock %}

{% block script %}

$(function () {
	$('[data-toggle="tooltip"]').tooltip();
});


// update estimated cost and fees
var btc, ngn;
$("#btc_qty, #prefered_amount").keyup(function() {
	calculateTrade();
});



$(".btn-sell").click(function(e) {
	e.preventDefault();
	$("#trade-opt").val('Sell');
	$(this).addClass('trade-btn-active');
	$(".buy").addClass('hidden');
	$(".sell").removeClass('hidden');
	$(".btn-buy").removeClass('trade-btn-active');
	$("#order-btn").text("Post Offer");
	calculateTrade();
});


$(".btn-buy").click(function(e) {
	e.preventDefault();
	//calculateTrade();
	$("#trade-opt").val('Buy');
	$(this).addClass('trade-btn-active');
	$(".sell").addClass('hidden');
	$(".buy").removeClass('hidden');
	$(".btn-sell").removeClass('trade-btn-active');
	$("#order-btn").text("Place Order");
	calculateTrade();
});


// submit form
$("#form-trade").submit(function(e) {
	e.preventDefault();

	var opt = $("#trade-opt").val();
	var path;
	if (opt == 'Sell') {
		path = '/offer/sell'
	} else if (opt == 'Buy') {
		path = '/order/buy';
	}
	$.post(path, $(this).serialize(), function(d) {
		if (d.status.trim() == 'success') {
			location.reload(true);
		} else {
			alert("Error");
		}
	}, 'JSON');
});

$("#order-btn").click(function() {
	$("#form-trade").submit();
});

$(".order-row, .offer-row").click(function() {
	if ($(this).attr("class") == 'order-row') {
		$("#btc_qty").val($(this).find('order-btc-qty').text());
		$("#prefered_amount").val($(this).find('order-ng-amt').text());
		$('.btn-buy').click();
	} else {
		$("#btc_qty").val($(this).find('offer-btc-qty').text());
		$("#prefered_amount").val($(this).find('offer-ng-amt').text());
		$('.btn-sell').click();
	}
});

$('.cancel-order').click(function(e) {
	e.preventDefault();
	if (confirm("Are you sure you want to cancel this Order?")) {
		var $parentTr = $(this).parents('tr');
		var id = $parentTr.attr('id');
		$.post('/order/cancel/' + id, function(d) {
			if (d.status.trim() == 'success') {
				$parentTr.fadeOut();
			}
		}, 'JSON');
	}
});

$('.cancel-offer').click(function(e) {
	e.preventDefault();
	if (confirm("Are you sure you want to cancel this Offer?")) {
		var $parentTr = $(this).parents('tr');
		var id = $parentTr.attr('id');
		$.post('/offer/cancel/' + id, function(d) {
			if (d.status.trim() == 'success') {
				$parentTr.fadeOut();
			}
		}, 'JSON');
	}
});

var market_price = {{ market_price | json | safe }};
var xrate = {{ xrate | json | safe }};
var chart_data = [];
market_price.values.forEach(function(data) {
	var ngn = (data.y * xrate);
	chart_data.push([(data.x * 1000), ngn]);
});
console.log(chart_data);
Highcharts.chart('chart-canvass', {
	title: {
        text: null
    },
	
	subtitle: {
        text: 'Average NGN market price across major bitcoin exchanges.'
    },
	
    xAxis: {
		type: 'datetime',
		labels: {
		  format: '{value:%e %b %Y}'
		}
	},
	
	yAxis: {
		title: {
			text: 'Market price'
		},
		labels: {
			formatter: function () {
				return 'N' + numeral(this.value).format('0,0');
			}            
		}
	},

    series: [{
        name: 'Price',
        data: chart_data 
    }]

});


function calculateTrade() {
	btc = $("#btc_qty").val();
	ngn = $("#prefered_amount").val();

	var selling_fees = $("#sell-fees").val() / 100;
	var buying_fees = $("#buy-fees").val() / 100;
	var naira_balance = numeral($("#ngn-balance").val()) || 0.00;
	var btc_balance = $("#btc-balance").val();
	var trade_opt = $("#trade-opt").val();
//console.log(naira_balance);
	if (trade_opt == 'Buy') {
		buying_fees = (buying_fees * btc).toFixed(8);
		$(".buy").find("#est-btc").text(buying_fees);
		$(".buy").find("#ng-required").text(numeral(ngn * btc).format('0,0.00'));
		$(".buy").find("#ng-balance").text(naira_balance);
		// manipulate submit button
		if (ngn < naira_balance) {
			$("#order-btn").prop("disabled", false);
		} else {
			$("#order-btn").prop("disabled", true);
		}
	} else if (trade_opt == 'Sell') {
		selling_fees = (selling_fees * btc).toFixed(8);
		$(".sell").find("#est-btc").text(selling_fees);
		$(".sell").find("#btc-required").text(btc);
		$(".sell").find("#btc-balance").text(btc_balance);
		$(".sell").find("#sales-total").text(numeral(ngn * btc).format('0,0.00'));
		// manipulate submit button
		if (btc < btc_balance) {
			$("#order-btn").prop("disabled", false);
		} else {
			$("#order-btn").prop("disabled", true);
		}
	}
}
{% endblock %}