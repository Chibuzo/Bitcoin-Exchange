{% extends '../layout.swig' %}
{% set title = 'Settings' %}
{% block body %}

<style>
	#payment-details .row .col-md-6 {
		padding: 7px 15px;
	}
	
	.text-row {
		padding: 17px 14px;
		border-bottom: #ccc solid thin
	}
	
	.s-row {
		cursor: pointer;
	}
	
.artwork {
  cursor: pointer;
  height: 150px;
  margin-top: 6px;
  background: #e0e0e0; 
}

.preview {
  padding: 3px;
  width: auto;
}

.preview-image {
   height: 150px;
}

.upload-div {
  background: #fff;
  padding: 15px 20px;
  border-radius: 4px;
}

.upload-div .details {
  padding-top: 35px;
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
							<div class="col-md-7 col-md-offset-3">
								<div class="inner">
									<h3>Personal Details</h3><br>
									<div class="s-row">
										<div class="col-md-4 text-row"><i class="fa fa-user fa-lg fa-fw"></i> Name</div>
										<div class="col-md-8 text-row text-right">{{ user.fullname }}</div>
									</div>
									<div class="s-row">
										<div class="col-md-4 text-row"><i class="fa fa-envelope fa-lg fa-fw"></i> Email</div>
										<div class="col-md-8 text-row text-right">{{ user.email }}</div>
									</div>
									<div class="s-row" data-toggle="modal" data-target="#phoneVerificationModal">
										<div class="col-md-5 text-row"><i class="fa fa-phone fa-lg fa-fw"></i> Phone Number</div>
										<div class="col-md-7 text-row text-right">&nbsp;{{ user.phone }}</div>
									</div>
									<div class="hidden">
										<div class="col-md-4 text-row"><i class="fa fa-map-marker fa-lg fa-fw"></i> Country</div>
										<div class="col-md-8 text-row text-right">{{ user.fullname }}</div>
									</div>
									<div class="s-row">
										<div class="col-md-4 text-row" style="border-bottom: none"><i class="fa fa-user fa-lg fa-fw"></i> Verification</div>
										<div class="col-md-8 text-row text-right" style="border-bottom: none">Level <span id="u-level">{{ user.level.level }}</span> . <a href='' id="upgrade-level">Upgrade</a></div>
									</div>
									<br><hr style="margin-bottom: 8px;">
								</div>
							</div>

							<div class="hidden col-md-6">
								<div class="inner">
									<h3>Security</h3><br>
									<div>
										Two-factor Authentication
									</div>
									<div>
										Password
									</div>
									<br>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	
<div class="modal inmodal fade in" id="phoneVerificationModal" tabindex="-1" role="dialog" aria-labelledby="remoteModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
					×
				</button>
				<h4 class="modal-title" id="myModalLabel">Phone Number Verification</h4>
			</div>

			<form method="post" id="form-phone-verification">
				<div class="modal-body">
					<div class="row">
						<div class="col-md-12" id="div-phone">
							<div class="form-group">
								<label for="bank">Phone Number</label>
								<input type="text" name="phone" class="form-control" placeholder="Enter a valid phone number" />
							</div>
						</div>
            
            <div class="col-md-12 hidden" id="div-phone-code">
                <div class="alert alert-info">Your verification code has been sent to your phone number. It's valid for about 15 minutes from now</div>
                <div class="form-group">
                  <label for="">Verification Code</label>
                  <input type="text" name="verification_code" class="form-control" placeholder="Enter your verification code" />
                </div>
            </div>
					</div>
          <div class="alert hidden" id="alert"></div>
          <input type="hidden" name="opt" id="opt" value="add-phone" />
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default close-modal" data-dismiss="modal">
						Cancel
					</button>
					<button type="submit" class="btn btn-primary">
						Submit
					</button>
				</div>
			</form>
		</div>
	</div>
</div>

<div class="modal inmodal fade in" id="idModal" tabindex="-1" role="dialog" aria-labelledby="remoteModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
					×
				</button>
				<h4 class="modal-title" id="myModalLabel">Upload ID Card</h4>
			</div>

			<div class="modal-body">
				<div class="row">
					<div class="col-md-12">
						<p>Scan and upload a colour photo of the <strong>front</strong> and <strong>back</strong> of your National Identity Card,
						or Driver's License, or Permanent Voter's Card.</p>
						<p>The scan MUST show clearly; your names, date of birth and photo.</p>
					</div>
					
					<div class="form-group upload-div">
						<div class="row">
							<div class="col-md-6">
							  <div class="preview">
								  <strong>Front of ID</strong>  
								  <div class="artwork" id="id-front-holder">
								  </div><br>
								  <button type="button" class="btn btn-fill btn-info btn-block pull-right" id="id-front-btn">Select Photo</button>
							  </div>        
							</div>
							<div class="col-md-6">
							  <div class="preview">
								  <strong>Back of ID</strong>  
								  <div class="artwork" id="id-back-holder">
								  </div><br>
								  <button type="button" class="btn btn-fill btn-info btn-block pull-right" id="id-back-btn">Select Photo</button>
								  <form action="/userlevel/add-idcard" method="post" id="id-form" enctype="multipart/form-data">
									<input type="file" name="id_card" id="back-id" class="hidden" />
									<input type="file" name="id_card" id="front-id" class="hidden" />
								  </form>
							  </div>        
							</div>  
						</div>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default close-modal" data-dismiss="modal">
					Cancel
				</button>
				<button type="button" class="btn btn-primary" id="submit-id-btn">
					Submit
				</button>
			</div>
			
		</div>
	</div>
</div>

<div class="modal inmodal fade in" id="residenceModal" tabindex="-1" role="dialog" aria-labelledby="remoteModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
					×
				</button>
				<h4 class="modal-title" id="myModalLabel">Phone Number Verification</h4>
			</div>

			<form method="post" action="/userlevel/add-residence-proof" enctype="multipart/form-data">
				<div class="modal-body">
					<div class="row">
						<div class="col-md-12">Scan and upload your proof of residential address</div>
					</div>
					<div class="row">
						<div class="col-md-12">
							<div class="form-group">
								<label for="">Proof of Residential Address</label>
								<input type="file" name="residential_proof" class="form-control" placeholder="" />
							</div>
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default close-modal" data-dismiss="modal">
						Cancel
					</button>
					<button type="submit" class="btn btn-primary">
						Submit
					</button>
				</div>
			</form>
		</div>
	</div>
</div>

{% endblock %}

{% block scriptTag %}
<script type="text/javascript">
$(document).ready(function() {  
	
	$("#upgrade-level").click(function(e) {
		e.preventDefault();
		var level = $("#u-level").text();
		if (level == 0) {
			$("#phoneVerificationModal").modal();		
		} else if (level == 1) {
			$("#idModal").modal();
		} else if (level == 2) {
			$("#residenceModal").modal();
		}
	});
	
  
	$("#id-front-btn").click(function() {
		$("#front-id").click();
	});
	
  
	$("#front-id").on('change', function () {
		if (typeof (FileReader) != "undefined") {
			var image_holder = $("#id-front-holder");
			image_holder.empty();
	
			var reader = new FileReader();
			reader.onload = function (e) {
				$("<img />", {
					"src": e.target.result,
					"class": "preview-image"
				}).appendTo(image_holder);
			}
			image_holder.show();
			reader.readAsDataURL($(this)[0].files[0]);
		} else {
			alert("This browser does not support FileReader.");
		}
	});
	
  
	$("#id-back-btn").click(function() {
		$("#back-id").click();
	});
	
  
	$("#back-id").on('change', function () {
		if (typeof (FileReader) != "undefined") {
			var image_holder = $("#id-back-holder");
			image_holder.empty();
	
			var reader = new FileReader();
			reader.onload = function (e) {
				$("<img />", {
					"src": e.target.result,
					"class": "preview-image"
				}).appendTo(image_holder);
			}
			image_holder.show();
			reader.readAsDataURL($(this)[0].files[0]);
		} else {
			alert("This browser does not support FileReader.");
		}
	});
	
  
	$("#submit-id-btn").click(function() {
		$("#id-form").submit();
	});
  
  
  // submit phone number
  $("#form-phone-verification").submit(function(e) {
      e.preventDefault();
      if ($("#opt").val() == "add-phone") {
          $.post('/userlevel/addphone', $(this).serialize(), function(d) {
              if (d.status.trim()  == 'success') {
                  $("#div-phone").addClass('hidden');
                  $("#div-phone-code").removeClass('hidden');
                  $("#opt").val('verify-code');
              }
          }, 'JSON');
      } else if ($("#opt").val() == "verify-code") {
          $.post('/userlevel/verify-code', $(this).serialize(), function(d) {
              if (d.status.trim() == 'success') {
                  location.reload();
              } else {
                  $("#alert").addClass("alert-danger").text("We couldn't verify your phone number. Make sure your entered the code correctly");                
              }
          }, 'JSON');
      }
  });
  
});
</script>
{% endblock %}