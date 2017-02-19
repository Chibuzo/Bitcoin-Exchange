<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>CPBit - {{ title }}</title>

    <link href="/styles/bootstrap.min.css" rel="stylesheet">
    <link href="/styles/font-awesome.min.css" rel="stylesheet">

    <link href="/styles/animate.css" rel="stylesheet">
    <link href="/styles/style.css" rel="stylesheet">
    
    <style>
      .auth-panel {
        border: #ccc solid thin;
        margin: auto;
        width: 400px;
        padding: 20px 20px 50px 20px;
        margin-top: 80px;
        border-radius: 3px;
      }
    </style>
</head>
<body id="page-top" class="landing-page">
<div class="navbar-wrapper">
        <nav class="navbar navbar-default navbar-fixed-top" role="navigation">
            <div class="container">
                <div class="navbar-header page-scroll">
                    <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <a class="navbar-brand" href="index.html">CPBit</a>
                </div>
                <div id="navbar" class="navbar-collapse collapse">
                    <ul class="nav navbar-nav navbar-right">
                        <li><a class="page-scroll" href="#">BTC/NGN 499.694</a></li>
                        <li><a class="page-scroll" href="#">Help</a></li>
                        <li><a class="page-scroll" href="/user/signin">Sign In</a></li>
                        <li><a class="page-scroll" href="/user/signup">Sign Up</a></li>
                    </ul>
                </div>
            </div>
        </nav>
</div>

<div style="clear: both">
{% block body %}{% endblock %}

</div>

<section id="contact" class="gray-section contact">
    <div class="container">
        <div class="row">
            <div class="col-lg-12 text-center">
              <br><br><br>
                <p class="m-t-sm">
                    Follow us on social platform
                </p>
                <ul class="list-inline social-icon">
                    <li><a href="#"><i class="fa fa-twitter"></i></a>
                    </li>
                    <li><a href="#"><i class="fa fa-facebook"></i></a>
                    </li>
                    <li><a href="#"><i class="fa fa-linkedin"></i></a>
                    </li>
                </ul>
            </div>
        </div>
        <div class="row">
            <div class="col-lg-8 col-lg-offset-2 text-center m-t-lg m-b-lg">
                <p><strong>&copy; 2015 Company Name</strong>
            </div>
        </div>
    </div>
</section>

<!-- Mainly scripts -->
<script src="/js/jquery-2.1.1.js"></script>
<script src="/js/bootstrap-datepicker.js"></script>
<script src="/js/bootstrap.min.js"></script>
<script src="/js/plugins/metisMenu/jquery.metisMenu.js"></script>
<script src="/js/plugins/slimscroll/jquery.slimscroll.min.js"></script>

<!-- Custom and plugin javascript -->
<script src="/js/inspinia.js"></script>
<script src="/js/plugins/pace/pace.min.js/"></script>
<script src="/js/plugins/wow/wow.min.js"></script>


<script>

    $(document).ready(function () {

        $('body').scrollspy({
            target: '.navbar-fixed-top',
            offset: 80
        });

        // Page scrolling feature
        $('a.page-scroll').bind('click', function(event) {
            var link = $(this);
            $('html, body').stop().animate({
                scrollTop: $(link.attr('href')).offset().top - 50
            }, 500);
            event.preventDefault();
            $("#navbar").collapse('hide');
        });
    });

    var cbpAnimatedHeader = (function() {
        var docElem = document.documentElement,
                header = document.querySelector( '.navbar-default' ),
                didScroll = false,
                changeHeaderOn = 200;
        function init() {
            window.addEventListener( 'scroll', function( event ) {
                if( !didScroll ) {
                    didScroll = true;
                    setTimeout( scrollPage, 250 );
                }
            }, false );
        }
        function scrollPage() {
            var sy = scrollY();
            if ( sy >= changeHeaderOn ) {
                $(header).addClass('navbar-scroll')
            }
            else {
                $(header).removeClass('navbar-scroll')
            }
            didScroll = false;
        }
        function scrollY() {
            return window.pageYOffset || docElem.scrollTop;
        }
        init();

    })();

    // Activate WOW.js plugin for animation on scrol
    new WOW().init();

    {% block script %} {% endblock %}
</script>

</body>
</html>