<div class="modal fade in" id="fundAccountModal" tabindex="-1" role="dialog" aria-labelledby="remoteModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
					×
				</button>
				<h4 class="modal-title" id="myModalLabel">Fund Your Naira Account</h4>
			</div>

			<form method="post" id="form-fund-account">
				<div class="modal-body">
					<div class="row">
						<div class="col-md-12">
							<div class="form-group">
								<div class="row">
									<div class="col-md-6">
										<label for="payment-opt">Payment Option</label>
										<select name="payment_opt" id="payment-opt" class="form-control" required>
											<option value="">-- Select Payment Option --</option>
											<option value="Deposit">Bank Deposit</option>
											<option value="Transfer">Transfer</option>
										</select>
									</div>

									<div class="col-md-6">
										<label for="amount">Amount</label>
										<input type="number" name="amount" id="amount" class="form-control" placeholder="Enter Amount" required />
									</div>
								</div>
							</div>

							<div id="transfer-div" class="hidden">
								<div class="alert alert-info">Enter the details of the bank account you will transfer from.</div>
								<div class="form-group">
									<label for="bank">Bank</label>
									<select id="bank" name="bank" class="form-control">
										<option value="">-- Select your bank</option>
										<option value="Access Bank Nigeria Plc">Access Bank Nigeria Plc</option>
										<option value="ACCION Microfinance bank">ACCION Microfinance bank</option>
										<option value="Aso Savings">Aso Savings</option>
										<option value="Diamond Bank Plc">Diamond Bank Plc</option>
										<option value="Ecobank Nigeria">Ecobank Nigeria</option>
										<option value="Ekondo MFB">Ekondo MFB</option>
										<option value="Enterprise Bank Plc">Enterprise Bank Plc</option>
										<option value="Fidelity Bank Plc">Fidelity Bank Plc</option>
										<option value="First Bank of Nigeria Plc">First Bank of Nigeria Plc</option>
										<option value="First City Monument Bank">First City Monument Bank</option>
										<option value="Guaranty Trust Bank Plc">Guaranty Trust Bank Plc</option>
										<option value="Heritage Bank">Heritage Bank</option>
										<option value="Jaiz Bank PLC">Jaiz Bank PLC</option>
										<option value="Keystone Bank Ltd">Keystone Bank Ltd</option>
										<option value="Mainstreet Bank Plc">Mainstreet Bank Plc</option>
										<option value="Skye Bank Plc">Skye Bank Plc</option>
										<option value="Stanbic IBTC Plc">Stanbic IBTC Plc</option>
										<option value="Sterling Bank Plc">Sterling Bank Plc</option>
										<option value="Union Bank Nigeria Plc">Union Bank Nigeria Plc</option>
										<option value="United Bank for Africa Plc">United Bank for Africa Plc</option>
										<option value="Unity Bank Plc">Unity Bank Plc</option>
										<option value="WEMA Bank Plc">WEMA Bank Plc</option>
										<option value="Zenith Bank International">Zenith Bank International</option>
									</select>
								</div>

								<div class="form-group">
									<label for="subject">Account Name</label>
									<input type="text" name="account_name" id="account-name" class="form-control" />
								</div>

								<div class="form-group">
									<label for="account-number">Account Number</label>
									<input type="text" name="account_number" id="account-number" class="form-control" />
								</div>
							</div>
              <div class="alert alert-danger hidden"></div>
						</div>
						<input type="hidden" name="tnx_type" value="Credit" />
						<input type="hidden" name="desc" value="Fund Account" />
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default close-modal" data-dismiss="modal">
						Cancel
					</button>
					<button type="submit" class="btn btn-primary" id="submit-btn">
						Continue
					</button>
				</div>
			</form>
		</div>
	</div>
</div>