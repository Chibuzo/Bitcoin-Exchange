<div class="modal inmodal fade in" id="addBeneficiaryModal" tabindex="-1" role="dialog" aria-labelledby="remoteModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    ×
                </button>
                <h4 class="modal-title" id="myModalLabel">Add New Beneficiary</h4>
            </div>

            <form method="post" id="form-account">
                <div class="modal-body">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="form-group">
                                <label for="bank">Bank</label>
                                <select id="bank" name="bank" class="form-control" required>
                                    <option value=""></option>
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
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <div class="form-group">
                                <label for="subject">Account Name</label>
                                <input type="text" name="account_name" id="account-name" class="form-control" required />
                            </div>
                            <div class="form-group">
                                <label for="account-number">Account Number</label>
                                <input type="text" name="account_number" id="account-number" class="form-control" required />
                            </div>
                        </div>
                    </div>
                    <input type="hidden" name="beneficiary_id" id="" />
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default close-modal" data-dismiss="modal">
                        Cancel
                    </button>
                    <button type="submit" class="btn btn-primary">
                        Save
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>