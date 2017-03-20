<div class="modal inmodal fade in" id="receiveBitcoinModal" tabindex="-1" role="dialog" aria-labelledby="remoteModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
					×
				</button>
				<h4 class="modal-title" id="myModalLabel">Receive Bitcoin</h4>
			</div>

			<form method="post" id="form-receive">
				<div class="modal-body">
					<div class="row">
						<div class="col-md-12">
							<div class="form-group">
								<label for="bank">Receive to</label>
								<select class="form-control">
									<option value="1">My Wallet ({{ req.session.coinBalance }})</option>
								</select>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-md-12">
							<div class="form-group">
								<label for="btc-address">Address</label>
								<div id="btc-address">Fetching BTC address...</div>
							</div>
						</div>
						<div class="col-md-12 text-center">
							<div id="qrcode" class="">

							</div>
						</div>
					</div>
					<input type="hidden" name="beneficiary_id" id="" />
				</div>
				<div class="modal-footer">
					<button type="subbuttonmit" class="btn btn-primary" data-dismiss="modal">
						Finish
					</button>
				</div>
			</form>
		</div>
	</div>
</div>