{% extends '../theme.swig' %}
{% set title = 'New User Sign up' %}
{% block body %}
 <style>
  .s-header__navbar {
      background: #fff;
  }
</style>
 
<div class="g-bg-color--sky-light">
      <div class="container g-padding-y-80--xs g-padding-y-125--sm">
          <div class="g-text-center--xs g-margin-b-80--xs">
              <p class="text-uppercase g-font-size-14--xs g-font-weight--700 g-color--red g-letter-spacing--2 g-margin-b-25--xs" style="margin-top: 10px">Not Yet A Member?</p>
              <h2 class="g-font-size-32--xs g-font-size-36--md">Sign Up</h2>
          </div>
          <form action="" method="post" class="form-vertical" id="signup">
              <div class="row g-margin-b-40--xs">
                  <div class="col-sm-6 col-sm-offset-3 g-margin-b-20--xs g-margin-b-0--md">
                      <div class="g-margin-b-20--xs">
                          <input type="text" name="fullname" class="form-control s-form-v2__input g-radius--50" placeholder="* Fullname" required>
                      </div>
                      <div class="g-margin-b-20--xs">
                          <input type="email" name="email" class="form-control s-form-v2__input g-radius--50" placeholder="* Email" required>
                      </div>
                      <div class="g-margin-b-20--xs">
                          <input type="password" name="password" id="password" class="form-control s-form-v2__input g-radius--50" placeholder="* Password" required>
                      </div>
                      <div class="g-margin-b-20--xs">
                          <input type="password" name="verify_password" id="verify_password" class="form-control s-form-v2__input g-radius--50" placeholder="* Retype Password" required>
                      </div>
																						
																						<div class="alert alert-danger hidden"></div>
                  </div>
              </div>
              <div class="g-text-center--xs">
                  <button type="submit" class="text-uppercase s-btn s-btn--md s-btn--red-bg g-radius--50 g-padding-x-80--xs">Sign Up</button>
              </div>
          </form>
										<div class="col-md-8 col-md-offset-2 g-margin-b-10--xs g-margin-b-0--lg" style="display:none" id="signup-confirm">
														<div class="">
																		<div class="s-plan-v1 g-text-center--xs g-bg-color--white g-padding-y-100--xs">
																						<i class="g-display-block--xs g-font-size-40--xs g-color--primary g-margin-b-30--xs ti-check"></i>
																						<h3 class="g-font-size-18--xs g-color--primary g-margin-b-30--xs">Thank you</h3>
																						Thank you for signing up with CapitalX.<br>
																						An email has been sent to you containing the link to confirm your account.
																		</div>
														</div>
										</div>
      </div>
  </div>  

{% endblock %}

{% block script %}
{#<script>#}
$("#signup").submit(function(e) {
	e.preventDefault();
	var $this = $(this);
	if ($("#password").val() != $("#verify_password").val()) {
		$(".alert-danger").html("<strong>Error:</strong> Password doesn't match.").removeClass('hidden');
		return false;
	}
	$(this).find('button').html("<i class='fa fa-cog fa-spin'></i> Processing").prop('disabled', true);

	$.post('/user/signup', $(this).serialize(), function(d) {
		if(d.status.trim() == '01') {
			//location.href = '/user/confirmation/';
			$("#signup").fadeOut('fast');
			$('#signup-confirm').fadeIn();
		} else {
			$(".alert-danger").html("<strong>Error:</strong> " + d.msg).removeClass('hidden');
		}
		$this.find('button').text("SIGN UP").prop('disabled', false);
	}, 'JSON');
});
{#</script>#}
{% endblock %}
