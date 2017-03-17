{% extends '../layout.swig' %}
{% set title = 'Dashboard' %}
{% block body %}
<style>
#qrcode {
	width: 150px;
	height: 150px;
	border: #ccc solid thin;
	margin: auto;
}

#btc-address {
	border: #e0e0e0 solid thin;
	background: #f0f0f0;
	font-size: 14px;
	padding: 5px;
	font-style: italic;
}
</style>
<div class="row wrapper border-bottom white-bg page-heading">
	<div class="col-sm-4">
		<h2>Dashboard</h2>
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
				<div class="ibox float-e-margins">
					<div class="ibox-title hidden">
						<h5></h5>
						<div class="ibox-tools">

						</div>
					</div>
					<div class="ibox-content">
						<div class="row">
							<div class="col-md-12">
								<div class="btn-group pull-right">
									<button class="btn btn-white" data-toggle="modal" data-target="#sendBitcoinModal" type="button"><i class="fa fa-send"></i>&nbsp; Send</button>
									<button class="btn btn-white" data-toggle="modal" data-target="#receiveBitcoinModal" id="getBTC-address" type="button"><i class="fa fa-reply-all"></i>&nbsp; Receive</button>
									<button class="btn btn-white" type="button"><i class="fa fa-btc"></i>&nbsp; Buy</button>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

{% include '../bitcoin/send-modal.swig' %}
{% include '../bitcoin/receive-modal.swig' %}

<script src="/js/plugins/qrcode.min.js"></script>
{% endblock %}

{% block script %}
$("#getBTC-address").click(function(e) {
	$.get('/wallet/new-address', function(d) {
		if (d.status.trim() == 'success') {
			$("#btc-address").text(d.address).css('font-style', 'normal');
			makeCode();
		}
	}, 'JSON');
});


// send bitcoin
$("#form-send-coin").submit(function(e) {
	e.preventDefault();

	$.post('/wallet/send', $(this).serialize(), function(d) {
		if (d.status.trim() == 'success') {
			location.replace('/transaction/btc');
		}
	}, 'JSON');
});


var qrcode = new QRCode(document.getElementById("qrcode"), {
	width : 150,
	height : 150
});

function makeCode () {
	var address = $("#btc-address").text();
	qrcode.makeCode(address);
}

{%  endblock %}
