<div class="modal inmodal fade in" id="sendBitcoinModal" tabindex="-1" role="dialog" aria-labelledby="remoteModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
					×
				</button>
				<h4 class="modal-title" id="myModalLabel">Send Bitcoin</h4>
			</div>

			<form method="post" id="form-send-coin">
				<div class="modal-body">
					<div class="row">
						<div class="col-md-12">
							<div class="form-group">
								<label for="bank">From</label>
								<select class="form-control">
									<option value="1">My Wallet ({{ req.session.coinAvailableBalance }})</option>
								</select>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-md-12">
							<div class="form-group">
								<label for="btc_address">To</label>
								<input type="text" name="btc_address" id="btc_address" class="form-control" placeholder="Bitcoin address" required />
							</div>
							<div class="form-group">
								<label for="btc-amount">Amount</label>
								<input type="text" name="btc_amount" id="btc-amount" class="form-control" placeholder="BTC" required />
							</div>
							<div class="form-group">
								<label for="description">Description</label>
								<textarea name="description" class="form-control" placeholder="Purpose for sending"></textarea>
							</div>
						</div>
					</div>
					<div class="alert alert-error hidden"></div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default close-modal" data-dismiss="modal">
						Cancel
					</button>
					<button type="submit" class="btn btn-primary" id="btc-send-btn">
						<i class='fa fa-bitcoin'></i>&nbsp;
						Send BTC
					</button>
				</div>
			</form>
		</div>
	</div>
</div>