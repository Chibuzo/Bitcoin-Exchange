<!DOCTYPE html>
<html lang="en" class="no-js">
    <!-- Begin Head -->
    <head>
        <!-- Basic -->
        <meta charset="utf-8"/>
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta http-equiv="x-ua-compatible" content="ie=edge">
        <title>CapitalX - {{ title }}</title>
        <meta name="keywords" content="HTML5 Theme" />
        <meta name="description" content="Megakit - HTML5 Theme">
        <meta name="author" content="keenthemes.com">

        <!-- Web Fonts -->
        <link href="https://fonts.googleapis.com/css?family=Lato:300,400,400i|Montserrat:400,700" rel="stylesheet">

        <!-- Vendor Styles -->
        <link href="/styles/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <link href="/styles/animate.css" rel="stylesheet" type="text/css"/>
        <link href="/vendor/themify/themify.css" rel="stylesheet" type="text/css"/>
        <link href="/vendor/scrollbar/scrollbar.min.css" rel="stylesheet" type="text/css"/>
        <link href="/vendor/magnific-popup/magnific-popup.css" rel="stylesheet" type="text/css"/>
        <link href="/vendor/swiper/swiper.min.css" rel="stylesheet" type="text/css"/>
        <link href="/vendor/cubeportfolio/css/cubeportfolio.min.css" rel="stylesheet" type="text/css"/>
        <link href="/styles/font-awesome.min.css" rel="stylesheet">
        <!-- Theme Styles -->
        <link href="/styles/front_style.css" rel="stylesheet" type="text/css"/>
        <link href="/styles/global.css" rel="stylesheet" type="text/css"/>

        <!-- Favicon -->
        <link rel="shortcut icon" href="/img/favicon.ico" type="image/x-icon">
        <link rel="apple-touch-icon" href="/img/apple-touch-icon.png">
    </head>
    <!-- End Head -->

    <!-- Body -->
    <body>

        <!--========== HEADER ==========-->
        <header class="navbar-fixed-top s-header js__header-sticky js__header-overlay">
            <!-- Navbar -->
            <div class="s-header__navbar navbar navbar-default">
                <div class="s-header__container">
                    <div class="s-header__navbar-row">
                        <!--<div class="s-header__navbar-row-col">-->
                          <div class="navbar-header">
                            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#capitalX-nav" aria-expanded="false">
                              <span class="sr-only">Toggle navigation</span>
                              <span class="icon-bar"></span>
                              <span class="icon-bar"></span>
                              <span class="icon-bar"></span>
                            </button>
                            <div class="s-header__logo">
                                <a href="/" class="s-header__logo-link">
                                    <img class="s-header__logo-img s-header__logo-img-default" src="/images/logo.png" alt="CapitalX Logo">
                                    <img class="s-header__logo-img s-header__logo-img-shrink" src="/images/logo.png" alt="CapitalX Logo">
                                </a>
                            </div>
                          </div>
                            <!-- Logo -->
                            
                            <!-- End Logo -->
                        <!--</div>-->
                        
                        <div class="collapse navbar-collapse navbar-right navbar-main-collapse" id="capitalX-nav">
                            <ul class="nav navbar-nav">
                                <!-- Hidden li included to remove active class from about link when scrolled up past about section -->
                                <li>
                                    <a class="text-uppercase g-font-weight--400 g-color--red g-letter-spacing--2" href="/trade/">Market</a>
                                </li>
                                {% if req.session.userId %}
                                    <li>
                                        <a class="text-uppercase g-font-weight--400 g-color--red g-letter-spacing--2" href="/user/dashboard">Dashboard</a>
                                    </li>
                                    <li>
                                        <a class="text-uppercase g-font-weight--400 g-color--red g-letter-spacing--2" href="/user/signout">Sign Out</a>
                                    </li>
                                {% else %}
                                    <li>
                                        <a class="text-uppercase g-font-weight--400 g-color--red g-letter-spacing--2" href="/user/signin">Sign In</a>
                                    </li>
                                    <li>
                                        <a class="text-uppercase g-font-weight--400 g-color--red g-letter-spacing--2" href="/user/signup">Sign Up</a>
                                    </li>
                                {% endif %}
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
            <!-- End Navbar -->
        </header>
        <!--========== END HEADER ==========-->


{% block body %}{% endblock %}



</div>



<!--========== FOOTER ==========-->
        <footer class="g-bg-color--dark">
            <!-- Links -->
            <div class="g-hor-divider__dashed--white-opacity-lightest">
                <div class="container g-padding-y-80--xs">
                    <div class="row">
                        <div class="col-sm-2 g-margin-b-20--xs g-margin-b-0--md">
                            <h5 class="g-color--white-opacity">Company</h5>
                            <ul class="list-unstyled g-ul-li-tb-5--xs g-margin-b-0--xs">
                                <li><a class="g-font-size-15--xs g-color--white-opacity" href="">Home</a></li>
                                <li><a class="g-font-size-15--xs g-color--white-opacity" href="">About</a></li>
                                <li><a class="g-font-size-15--xs g-color--white-opacity" href="http://themeforest.net/item/metronic-responsive-admin-dashboard-template/4021469?ref=keenthemes">Contact</a></li>
                            </ul>
                        </div>
                        
                        <div class="col-sm-2 g-margin-b-40--xs g-margin-b-0--md">
                            <h5 class="g-color--white-opacity">Policies</h5>
                            <ul class="list-unstyled g-ul-li-tb-5--xs g-margin-b-0--xs">
                                <li><a class="g-font-size-15--xs g-color--white-opacity" href="#">Fees</a></li>
                                <li><a class="g-font-size-15--xs g-color--white-opacity" href="/privacy-policy">Privacy Policy</a></li>
                                <li><a class="g-font-size-15--xs g-color--white-opacity" href="/termsofuse">Terms &amp; Conditions</a></li>
                            </ul>
                        </div>
                        
                        <div class="col-sm-2 g-margin-b-20--xs g-margin-b-0--md">
                            <h5 class="g-color--white-opacity">Support</h5>
                            <ul class="list-unstyled g-ul-li-tb-5--xs g-margin-b-0--xs">
                                <li><a class="g-font-size-15--xs g-color--white-opacity" href="">FAQ</a></li>
                                <li><a class="g-font-size-15--xs g-color--white-opacity" href="">Support</a></li>
                            </ul>
                        </div>
                        <div class="col-md-4 col-md-offset-2 col-sm-5 col-sm-offset-1 s-footer__logo g-padding-y-50--xs g-padding-y-0--md">
                            <h3 class="g-font-size-18--xs g-color--white">CapitalX</h3>
                            <p class="g-color--white-opacity">Our goal is to provide
                        reliable and easy to use tools and services for individuals and organisations to exchange and carry out trading using bitcoins.</p>
                        </div>
                    </div>
                </div>
            </div>
            <!-- End Links -->

            <!-- Copyright -->
            <div class="container g-padding-y-50--xs">
                <div class="row">
                    <div class="col-xs-6 g-color--white">
                        &copy; CapitalX {{ Date.now() | date('Y') }}
                    </div>
                    <div class="col-xs-6 g-text-right--xs">

                    </div>
                </div>
            </div>
            <!-- End Copyright -->
        </footer>
        <!--========== END FOOTER ==========-->

        <!-- Back To Top -->
        <a href="javascript:void(0);" class="s-back-to-top js__back-to-top"></a>

        <!--========== JAVASCRIPTS (Load javascripts at bottom, this will reduce page load time) ==========-->
        <!-- Vendor -->
        <script type="text/javascript" src="/vendor/jquery.min.js"></script>
        <script type="text/javascript" src="/vendor/jquery.migrate.min.js"></script>
        <script type="text/javascript" src="/vendor/bootstrap/js/bootstrap.min.js"></script>
        <script type="text/javascript" src="/vendor/jquery.smooth-scroll.min.js"></script>
        <script type="text/javascript" src="/vendor/jquery.back-to-top.min.js"></script>
        <script type="text/javascript" src="/vendor/scrollbar/jquery.scrollbar.min.js"></script>
        <script type="text/javascript" src="/vendor/magnific-popup/jquery.magnific-popup.min.js"></script>
        <script type="text/javascript" src="/vendor/swiper/swiper.jquery.min.js"></script>
        <script type="text/javascript" src="/vendor/waypoint.min.js"></script>
        <script type="text/javascript" src="/vendor/counterup.min.js"></script>
        <script type="text/javascript" src="/vendor/cubeportfolio/js/jquery.cubeportfolio.min.js"></script>
        <script type="text/javascript" src="/vendor/jquery.parallax.min.js"></script>
        <script type="text/javascript" src="/vendor/jquery.wow.min.js"></script>
        <script type="text/javascript">
            {% block script %}{% endblock %}
        </script>
        <!-- General Components and Settings -->
        <script type="text/javascript" src="/js/global.min.js"></script>
        <script type="text/javascript" src="/js/components/header-sticky.min.js"></script>
        <script type="text/javascript" src="/js/components/scrollbar.min.js"></script>
        <script type="text/javascript" src="/js/components/magnific-popup.min.js"></script>
        <script type="text/javascript" src="/js/components/swiper.min.js"></script>
        <script type="text/javascript" src="/js/components/counter.min.js"></script>
        <script type="text/javascript" src="/js/components/portfolio-3-col.min.js"></script>
        <script type="text/javascript" src="/js/components/parallax.min.js"></script>
        <script type="text/javascript" src="/js/components/wow.min.js"></script>
        <!--========== END JAVASCRIPTS ==========-->
        {% block scriptTag %}{% endblock %}
    </body>
    <!-- End Body -->
</html>