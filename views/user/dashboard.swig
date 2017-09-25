{% extends '../layout.swig' %}
{% set title = 'Dashboard' %}
{% block body %}
<style>
#qrcode {
	width: 170px;
	height: 170px;
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

#progress-bar {
    width: 100%;
    height: 20px;
}
</style>
<div class="row wrapper border-bottom white-bg page-heading">
	<div class="col-sm-6">
		<h2>Dashboard</h2>
		<ol class="breadcrumb">
			<li>
				<a href="index.html">Home</a>
			</li>
			<li class="active">
				<strong>Dashboard</strong>
			</li>
		</ol>
	</div>
  <div class="col-md-6">
    <div class="btn-group pull-right" style="margin-top: 40px">
      <button class="btn btn-white" data-toggle="modal" data-target="#sendBitcoinModal" type="button"><i class="fa fa-send"></i>&nbsp; Send</button>
      <button class="btn btn-white" data-toggle="modal" data-target="#receiveBitcoinModal" id="getBTC-address" type="button"><i class="fa fa-reply-all"></i>&nbsp; Receive</button>
      <button class="btn btn-white" data-toggle="modal" data-target="#instantBuyModal" type="button"><i class="fa fa-btc"></i>&nbsp; Buy</button>
    </div>
  </div>
</div>

<div class="wrapper wrapper-content">
	<div class="animated fadeInRight">
		<div class="row">
			<div class="col-md-6">
				<div class="ibox float-e-margins">
					<div class="ibox-title">
						<h5><i class="fa fa-clock-o"></i> &nbsp;Recent BTC Transactions</h5>
						<div class="ibox-tools">

						</div>
					</div>
					<div class="ibox-content">
              <table class="table table-striped">
                  <thead>
                      <tr>
                          <th>Date</th>
                          <th>Address</th>
                          <th>BTC</th>
                          <th>Status</th>
                      </tr>
                  </thead>
                  <tbody>
                      {% for tnx in trnx %}
                          <tr>
                              <td>{{ tnx.createdAt | date('d-m-Y') }}</td>
                              <td>{{ tnx.address }}</td>
                              <td>{{ tnx.btc }}</td>
                              <td>{{ tnx.notice }}</td>
                          </tr>
                      {% endfor %}
                  </tbody>
              </table>
          </div>
        </div>
      </div>
      
      <div class="col-md-6">
				<div class="ibox float-e-margins">
					<div class="ibox-title">
						<h5><i class="fa fa-bar-chart"></i> &nbsp;Recent BTC Market Prices</h5>
						<div class="ibox-tools">

						</div>
					</div>
					<div class="ibox-content">
            <div id="chart-canvass"></div>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>


{% include '../bitcoin/send-modal.swig' %}
{% include '../bitcoin/receive-modal.swig' %}
{% include '../trade/instant-buy-modal.swig' %}

{% endblock %}

{% block scriptTag %}
<script src="/js/plugins/qrcode.min.js"></script>
<script type="text/javascript" src="/js/plugins/numeral.min.js"></script>
<script src="https://code.highcharts.com/highcharts.js"></script>
<script src="/js/plugins/progressbar.min.js"></script>
<script>
var bar;
$(document).ready(function() {
    // progress bar for instant buy
    bar = new ProgressBar.Line('#progress-bar', {
        strokeWidth: 4,
        easing: 'linear',
        duration: 60000,
        color: '#FFEA82',
        trailColor: '#eee',
        trailWidth: 4,
        svgStyle: {width: '100%', height: '100%'}
    });


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
      $("#btc-send-btn").html("<i class='fa fa-cog fa-spin'></i> &nbsp;Processing").prop("disabled", true);
      $.post('/wallet/send', $(this).serialize(), function(d) {
        if (d.status.trim() == 'success') {
          location.replace('/transaction/btc');
        } else if (d.status.trim() == 'error') {
            $("#form-send-coin .alert-error").html(d.msg).removeClass('hidden');
            $("#btc-send-btn").html("<i class='fa fa-btc'></i> &nbsp;Send BTC").prop("disabled", false);
        }
      }, 'JSON');
    });
    
    
    var market_price = {{ market_price | json | safe }};
    var xrate = {{ xrate | json | safe }};
    var chart_data = [];
    market_price.values.forEach(function(data) {
      var ngn = (data.y * xrate);
      chart_data.push([(data.x * 1000), ngn]);
    });
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
    
    
    var qrcode = new QRCode(document.getElementById("qrcode"), {
      width : 170,
      height : 170
    });

    function makeCode () {
        var address = $("#btc-address").text();
        qrcode.makeCode(address);
    }
    
    
    // instant buy
    $("#amount, #cur").change(function() {
        calculateCost();
    });
    
    $("#amount").keyup(function() {
        calculateCost();
    });

    $("#form-instant-buy").submit(function(e) {
        e.preventDefault();

        $("#instant-btn").html("<i class='fa fa-cog fa-spin'></i> &nbsp;Processing").prop("disabled", true);
        $.post('/order/buy', $(this).serialize(), function(d) {
            if (d.status.trim() == 'success') {
                if (d.action.trim() == 'Broadcast') {
                    $("#instant-error").text("There is not enough BTC to meet your order at the moment. Please try again later.").removeClass('hidden');
                } else {
                    location.reload();
                }
            } else {
                $("#instant-error").text(d.msg).removeClass('hidden');
                $("#instant-btn").html("&nbsp;Send Request").prop("disabled", false);
            }
        }, 'JSON');
    });
});

var balance = {{ req.session.naira_available | json | safe }};
function calculateCost() {
    bar.set(0); // reset progress bar
    var cur = $("#cur option:selected").val();
    var amt = $("#amount").val();
    var btc_price = $("#prefered-amt").val();
    var btc_qty, req_ngn = 0;
    if (cur == 'naira') {
        btc_qty = amt / btc_price;
        req_ngn = amt;
    } else if (cur == 'btc') {
        req_ngn = btc_price * amt;
        btc_qty = amt;
    }
    if (req_ngn > balance) {
        alert("Insufficient balance. Fund your account to continue.");
        $("#amount").val('');
        return false;
    }
    $("#btc-to-buy").val(Number(btc_qty).toFixed(9));
    $("#required_amt").val(numeral(req_ngn).format('0,00'));

    // start the bar
    bar.animate(1.0, function() {
        $.get('/get-btc-price', function(d) {
            if (d.status.trim() == 'success') {
                $("#btc-price").text(numeral(d.btc_price).format("0,00"));
                $("#prefered-amt").val(d.btc_price);
                calculateCost();
            }
        }, 'JSON');
    }); // start the progress bar
}
</script>
{%  endblock %}
