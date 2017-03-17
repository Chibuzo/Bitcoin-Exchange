{% extends '../layout.swig' %}
{% set title = 'Accounts' %}
{% block body %}

<div class="row wrapper border-bottom white-bg page-heading">
	<div class="col-sm-4">
		<h2>Beneficiaries</h2>
		<ol class="breadcrumb">
			<li>
				<a href="index.html">Home</a>
			</li>
			<li class="active">
				<strong>Beneficiaries</strong>
			</li>
		</ol>
	</div>
	<div class="col-md-3 pull-right">
		<h2></h2>
		<button class="btn btn-danger pull-right btn-lg" data-toggle="modal" data-target="#addBeneficiaryModal"><i class="fa fa-plus"></i> Add New</button>
	</div>
</div>

<div class="wrapper wrapper-content">
	<div class="animated fadeInRight">
		<div class="row">
			<div class="col-md-12">
				<div class="ibox float-e-margins">
					<div class="ibox-title">
						<h5>Beneficiaries</h5>
						<div class="ibox-tools">
							<a class="dropdown-toggle" data-toggle="dropdown" href="#">
								<i class="fa fa-filter"></i>
							</a>
							<ul class="dropdown-menu dropdown-user">
								<li><a href="#">Active</a>
								</li>
								<li><a href="#">Inactive</a>
								</li>
							</ul>
						</div>
					</div>
					<div class="ibox-content">
						<table class="table table-striped">
							<thead>
								<tr>
									<th>Date added</th>
									<th>Bank</th>
									<th>Account Name</th>
									<th>Account Number</th>
									<th class="text-center">Action</th>
								</tr>
							</thead>
							<tbody id="tb-beneficiaries">
								{% for acc in beneficiaries %}
									<tr id="{{ acc.id }}">
										<td>{{ acc.createdAt | date('Y-m-d') }}</td>
										<td>{{ acc.bank }}</td>
										<td>{{ acc.account_name }}</td>
										<td>{{ acc.account_number }}</td>
										<td class="opt-icons text-center">
											<a href="" class="edit-beneficiary" data-toggle="tooltip" title="Edit Beneficiary"><i class="fa fa-pencil fa-lg"></i> </a>
											<a href="" class="remove-beneficiary" data-toggle="tooltip" title="Remove Beneficiary"><i class="fa fa-trash fa-lg"></i> </a>
										</td>
									</tr>
								{% endfor %}
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

{% include 'add-new-modal.swig' %}

{% endblock %}

{% block script %}
$("#form-account").submit(function(e) {
	e.preventDefault();
	$this = $(this);

	$.post('/beneficiary/add', $this.serialize(), function(d) {
		if (d.status.trim() == '01') {
			var tr = '<tr id="' + d.id + '">'
						+'<td>' + d.createdAt + '</td>'
						+'<td>' + d.bank + '</td>'
						+'<td>' + d.account_name + '</td>'
						+'<td>' + d.account_number + '</td>'
						+'<td class="opt-icons text-center">'
							+'<a href="" class="edit-beneficiary" data-toggle="tooltip" title="Edit Beneficiary"><i class="fa fa-pencil fa-lg"></i> </a>'
							+'<a href="" class="remove-beneficiary" data-toggle="tooltip" title="Remove Beneficiary"><i class="fa fa-trash fa-lg"></i> </a>'
						+'</td>'
					+'</tr>';

			$("#tb-beneficiaries").prepend(tr);
		}
	}, 'JSON');
	$('.close-modal').click();
});
{% endblock %}