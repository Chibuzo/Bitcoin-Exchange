{% extends '../theme.swig' %}
{% set title = 'Exchange' %}
{% block body %}
<style>
	#chart-canvass {
		min-height: 300px;
	}
</style>

<div class="container-fluid" style="margin-top: 70px; background: #333">
	<div class="row">
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
						<div class="pull-right">Sell</div>
					</div>
					<div class="inner-div">
						Order
					</div>
				</div>
				<div class="col-md-8">
					<div class="trade-header">
						<div class="pull-left">Open Orders</div>
						<div class="pull-right">Open</div>
					</div>
					<div class="inner-div">
						You have no order
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

{% endblock %}