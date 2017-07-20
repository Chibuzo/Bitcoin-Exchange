{% extends '../theme.swig' %}
{% set title = 'Member Sign In' %}
{% block body %}
<style>
  .s-header__navbar {
      background: #fff;
  }
</style>  
  
  <div class="g-bg-color--sky-light">
      <div class="container g-padding-y-80--xs g-padding-y-125--sm">
          <div class="g-text-center--xs g-margin-b-80--xs">
              <p class="text-uppercase g-font-size-14--xs g-font-weight--700 g-color--red g-letter-spacing--2 g-margin-b-25--xs" style="margin-top: 30px">Already A Member?</p>
              <h2 class="g-font-size-32--xs g-font-size-36--md">Welcome Back</h2>
          </div>
          <form action="/user/signin" method="post" class="form-vertical" id="signin">
              <div class="row g-margin-b-40--xs">
                  <div class="col-sm-6 col-sm-offset-3 g-margin-b-20--xs g-margin-b-0--md">
                      <div class="g-margin-b-20--xs">
                          <input type="email" name="email" class="form-control s-form-v2__input g-radius--50" placeholder="* Email" required>
                      </div>
                      <div class="g-margin-b-20--xs">
                          <input type="password" name="password" class="form-control s-form-v2__input g-radius--50" placeholder="* Password" required>
                      </div>
											
											<div class="alert alert-danger hidden"></div>
                  </div>
              </div>
              <div class="g-text-center--xs">
                  <button type="submit" class="text-uppercase s-btn s-btn--md s-btn--red-bg g-radius--50 g-padding-x-80--xs"><i class="fa fa-sign-in fa-lg"></i>&nbsp; Login</button>
              </div>
          </form>
      </div>
  </div>
{% endblock %}

{% block script %}
	{#<script>#}

	$("#signin").submit(function(e) {
		e.preventDefault();
		var $this = $(this);

		$(this).find('button').html("<i class='fa fa-cog fa-spin'></i> Processing").prop('disabled', true);

		$.post('/user/signin', $(this).serialize(), function(d) {
			if (d.status.trim() == 'Ok') {
				if (d.user_type == 'user') {
					location.replace('/user/dashboard');
				} else if (d.user_type == 'admin') {
					location.replace('/admin/dashboard');
				}
			} else {
				$(".alert-danger").html("<strong>Error:</strong> " + d.msg).removeClass('hidden');
			}
			$this.find('button').html("<i class='fa fa-sign-in fa-lg'></i>&nbsp; SIGN IN").prop('disabled', false);
		}, 'JSON');
	});
	{#</script>#}
{% endblock %}
