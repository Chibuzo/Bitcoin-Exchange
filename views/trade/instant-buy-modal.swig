<div class="modal fade in" id="instantBuyModal" tabindex="-1" role="dialog" aria-labelledby="remoteModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
					×
				</button>
				<h4 class="modal-title" id="myModalLabel">Instant BTC Purchase</h4>
			</div>
      
			<form method="post" id="form-instant-buy">
				<div class="modal-body">
					<div class="row">
						<div class="col-md-12">
							<div class="form-group">
								<div class="row">
                  <div class="col-md-3">
                    <select name="cur" id="cur" class="form-control" required>
                        <option value="btc">Bitcoin</option>
                        <option value="naira">Naira</option>
                    </select>
                  </div>
									<div class="col-md-9">
										<input type="number" name="amount" id="amount" class="form-control" placeholder="Enter amount to buy" required />
									</div>
								</div>
							</div>
            </div>
          </div>
          <div class="row"><br>
              <div class="col-md-8 text-right">Required Amount</div>
              <div class="col-md-4 text-right">
                  <div class="input-group">
                    <span class="input-group-addon">&#8358;</span>
                    <input type="text" class="form-control text-right" id="required_amt" value="0.00" readonly />
                  </div>
              </div>
          </div>
           <div class="row">   
              <div class="col-md-8 text-right">BTC Quantity</div>
              <div class="col-md-4 text-right">
                  <div class="input-group">
                    <span class="input-group-addon"><i class="fa fa-btc"></i></span>
                    <input type="text" name="btc_qty" class="form-control text-right" id="btc-to-buy" value="0" readonly />
                  </div>
              </div>
          </div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default close-modal" data-dismiss="modal">
						Cancel
					</button>
					<button type="submit" class="btn btn-primary" id="submit-btn">
						Send Request
					</button>
				</div>
			</form>
		</div>
	</div>
</div>` 