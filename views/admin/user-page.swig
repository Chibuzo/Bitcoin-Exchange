{% extends 'admin-layout.swig' %}
{% set title = 'User Page' %}
{% block body %}
<style>
.card {
    box-shadow: rgba(0, 0, 0, 0.05) 0px 1px 2px, rgba(63, 63, 68, 0.1) 0px 0px 0px 1px;
    background-color: rgb(255, 255, 255);
    margin-bottom: 30px;
    border-radius: 4px;
}

.card-user .image {
    height: 110px;
}

.card .image {
    width: 100%;
    position: relative;
    transform-style: preserve-3d;
    overflow: hidden;
    border-radius: 4px 4px 0px 0px;
}

.card-user .avatar.border-gray {
    border-color: rgb(238, 238, 238);
}

.card-user .avatar {
    width: 124px;
    height: 124px;
    position: relative;
    margin-bottom: 15px;
    border-width: 5px;
    border-style: solid;
    border-color: rgb(255, 255, 255);
    border-image: initial;
    border-radius: 50%;
}

img {
    vertical-align: middle;
}

img {
    border-width: 0px;
    border-style: initial;
    border-color: initial;
    border-image: initial;
}

.card-user .author {
    text-align: center;
    text-transform: none;
    margin-top: -70px;
}

.card .author {
    font-size: 12px;
    font-weight: 600;
    text-transform: uppercase;
}

.card-user .content {
    min-height: 240px;
}

.card .content {
    padding: 15px 15px 10px;
}

.doc-preview {
	height: 150px;
	background-color: #f0f0f0;
	margin: 10px;
	padding: 15px;
	text-align: center;
}
</style>
	<div class="row wrapper border-bottom white-bg page-heading">
		<div class="col-md-4">
			<h2>User Page</h2>
			<ol class="breadcrumb">
				<li>
					<a href="index.html">Users</a>
				</li>
				<li class="active">
					<strong>User Page</strong>
				</li>
			</ol>
		</div>
	</div>

	<div class="wrapper wrapper-content">
		<div class="animated fadeInRightBig">
			<div class="row">
				<div class="col-md-8 col-sm-12 col-xs-12 col-lg-8">
					<div class="tabs-container">
						<div clss="tabs-right">
							<ul class="nav nav-tabs">
								<li class="active"><a data-toggle="tab" href="#tab-1"> Naira Transactions</a></li>
								<li class=""><a data-toggle="tab" href="#tab-2">BTC Transactions</a></li>
								<li class=""><a data-toggle="tab" href="#tab-3">Verification Docs</a></li>
							</ul>
							<div class="tab-content ">
								<div id="tab-1" class="tab-pane active">
									<div class="panel-body">
										<table class="table table-striped dataTable">
											<thead>
												<tr>
													<th>Date</th>
													<th>Description</th>
													<th>Type</th>
													<th>Amount (&#8358)</th>
													<th>Status</th>
												</tr>
											</thead>
											<tbody>
											{% for tnx in user.transactions %}
												<tr id="{{ tnx.id }}">
													<td>{{ tnx.createdAt | date('d-m-Y') }}</td>
													<td>{{ tnx.description }}</td>
													<td>{{ tnx.tnx_type }}</td>
													<td class="text-right">{{ tnx.amount | formatCurrency }}</td>
													<td>{{ tnx.status }}</td>
												</tr>
											{% endfor %}
											</tbody>
										</table>
									</div>
								</div>
								<div id="tab-2" class="tab-pane">
									<div class="panel-body">
										<table class="table table-striped">
											<thead>
												<tr>
													<th>Date</th>
													<th>Description</th>
													<th>BTC</th>
													<th>Fee</th>
													<th>Status</th>
												</tr>
											</thead>
											<tbody>
											{% for tnx in user.bitcointransactions %}
												<tr>
													<td>{{ tnx.tnx_date | date('d/m/Y H:i') }}</td>
													<td>{{ tnx.description }}</td>
													<td>{{ tnx.btc }}</td>
													<td>{{ tnx.fee }}</td>
													<td>{{ tnx.notice }}</td>
												</tr>
											{% endfor %}
											</tbody>
										</table>
									</div>
								</div>
								<div id="tab-3" class="tab-pane">
									<div class="panel-body">
										<div class="row">
											<div class="col-md-12">
												<h3>ID Cards</h3>
												<div>
													<div class="col-md-5"><a href="/images/"><div class="doc-preview">ID Front</div></a></div>
													<div class="col-md-5"><a href="/images/"><div class="doc-preview">ID Back</div></a></div>
													<div class="col-md-2" style="position: relative; height: 150px">
														{% if user.level.id_verified %}
															<button style="position: absolute; bottom: 0" class="btn btn-danger" id="revoke-ID">Revoke ID Card</button>
														{% else %}
															<button style="position: absolute; bottom: 0" class="btn btn-primary btn-block" id="verify-ID">Verify ID</button>
														{% endif %}
													</div>
												</div>
											</div>
										</div>
										<hr>
										<div class="row">
											<div class="col-md-12">
												<h3>Proof of Residence</h3>
												<div>
													<div class="col-md-5"><a href="/images/"><div class="doc-preview">Proof of Residence Doc</div></a></div>
													<div class="col-md-5" style="position: relative; height: 150px">
														{% if user.level.address_verified %}
															<button style="position: absolute; bottom: 0" class="btn btn-danger" id="revoke-residence-proof">Revoke Residence Proof</button>
														{% else %}
															<button style="position: absolute; bottom: 0" class="btn btn-primary" id="verify-residence-proof">Verify Residence Proof</button>
														{% endif %}
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="col-md-4 col-sm-12 col-xs-12 col-lg-4">
					<div class="card card-user">
                            <div class="image">
                            </div>
                            <div class="content">
                                <div class="author">
                                     <a href="#">
                                    <img class="avatar border-gray" src="/images/face-0.jpg" alt="..."/>

                                      <h4 class="title">{{ user.fullname }}<br />
                                         <small>{{ user.email }}</small><br>
                                         <small>{{ user.phone }}</small>
                                      </h4>
                                    </a>
                                </div><br>
                            </div>
                            <hr>
                            <div class="text-center">
                                <!--<button href="#" class="btn btn-simple"><i class="fa fa-facebook-square"></i></button>
                                <button href="#" class="btn btn-simple"><i class="fa fa-twitter"></i></button>
                                <button href="#" class="btn btn-simple"><i class="fa fa-google-plus-square"></i></button>-->
                            </div>
                        </div>
                    </div>
				</div>
			</div>
		</div>

{% endblock %}

{% block scriptTag %}
<script src="/js/plugins/datatables.min.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	var user_id = {{ user.id | json | safe }};

	$("#verify-ID").click(function() {
		if (confirm("Are you sure you want to perform this action?")) {
			$.post('/admin/verify-id', { user_id: user_id }, function() {
				location.reload();
			});
		}
	});

	$("#revoke-ID").click(function() {
		if (confirm("Are you sure you want to perform this action?")) {
			$.post('/admin/revoke-id', { user_id: user_id }, function() {
				location.reload();
			});
		}
	});


	$("#verify-residence-proof").click(function() {
		if (confirm("Are you sure you want to perform this action?")) {
			$.post('/admin/revoke-residence-proof', { user_id: user_id }, function() {
				location.reload();
			});
		}
	});

	$("#revoke-residence-proof").click(function() {
		if (confirm("Are you sure you want to perform this action?")) {
			$.post('/admin/verify-residence', { user_id: user_id }, function() {
				location.reload();
			});
		}
	});


	$('.dataTable').DataTable({
		pageLength: 25,
		responsive: true
//		"aoColumnDefs": [
//			{ 'bSortable': false, 'aTargets': [ 1, 2, 4 ] }
//		]
	});
});
</script>
{% endblock %}