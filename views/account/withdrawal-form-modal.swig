<div class="modal fade in" id="withdrawalModal" tabindex="-1" role="dialog" aria-labelledby="remoteModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
					×
				</button>
				<h4 class="modal-title" id="myModalLabel">Withdraw from your Naira Account</h4>
			</div>
      
      {% if request === undefined %}
			<form method="post" id="form-withdrawal">
				<div class="modal-body">
					<div class="row">
						<div class="col-md-12">
							<div class="form-group">
								<div class="row">
									<div class="col-md-12">
										<label for="amount">Amount</label>
										<input type="number" name="amount" id="amount" class="form-control" placeholder="Enter amount to withdraw" required />
									</div>
								</div>
							</div>

              <div class="alert alert-info">We only pay into a beneficiary's account</div>
              <div class="form-group">
                <label for="beneficiary">Bank</label>
                <select id="beneficiary" name="beneficiary" class="form-control" required>
                  <option value="">Fetching your beneficiary's list...</option>
                </select>
              </div>
            </div>
          </div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default close-modal" data-dismiss="modal">
						Close
					</button>
					<button type="submit" class="btn btn-primary" id="submit-btn">
						Send Request
					</button>
				</div>
			</form>
    {% else %}
      <div class="modal-body">
        <div class="row">
          <div class="col-md-12">
<!--            <h3>Pending Withdrawal Request</h3>-->
            <table class="table table-bordered">
              <thead>
                <tr>
                  <th>Date</th>
                  <th>Amount (&#8358;)</th>
                  <th>Beneficiary</th>
                  <th></th>
                </tr>
              </thead>
              <tbody>
                <tr id="{{ request.id }}">
                  <td>{{ request.createdAt | date('d-m-Y') }}</td>
                  <td class="text-right">{{ request.amount | formatCurrency }}</td>
                  <td>{{ request.beneficiary.account_name }} ({{ request.beneficiary.bank }})</td>
                  <td class="text-center"><a href='' class="cancel-request btn btn-danger btn-xs"><i class="fa fa-times fa-lg"></i></a></td>
                </tr>
              </tbody>
            </table>
          </div>
      </div>
    {% endif %}
		</div>
	</div>
</div>