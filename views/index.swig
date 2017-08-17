{% extends 'theme.swig' %}
{% set title = 'Welcome to CapitalX Bitcoin Exchange' %}
{% block body %}
        <!--========== SWIPER SLIDER ==========-->
        <div class="s-swiper js__swiper-one-item">
            <!-- Swiper Wrapper -->
            <div class="swiper-wrapper">
                <div class="g-fullheight--xs g-bg-position--center swiper-slide" style="background: url('img/1920x1080/02.jpg');">
                    <div class="container g-text-center--xs g-ver-center--xs">
                        <div class="g-margin-b-30--xs">
                            <h1 class="g-font-size-35--xs g-font-size-45--sm g-font-size-55--md g-color--white">Cryptocurrency is<br>The future</h1>
                        </div>
                        
                    </div>
                </div>
                <div class="g-fullheight--xs g-bg-position--center swiper-slide" style="background: url('img/1920x1080/01.jpg');">
                    <div class="container g-text-center--xs g-ver-center--xs">
                        <div class="g-margin-b-30--xs">
                            <div class="g-margin-b-30--xs">
                                <h2 class="g-font-size-35--xs g-font-size-45--sm g-font-size-55--md g-color--white">The First and Leading<br>Bitcoin Exchange<br>In Nigeria</h2>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- End Swiper Wrapper -->

            <!-- Arrows -->
            <a href="javascript:void(0);" class="s-swiper__arrow-v1--right s-icon s-icon--md s-icon--white-brd g-radius--circle ti-angle-right js__swiper-btn--next"></a>
            <a href="javascript:void(0);" class="s-swiper__arrow-v1--left s-icon s-icon--md s-icon--white-brd g-radius--circle ti-angle-left js__swiper-btn--prev"></a>
            <!-- End Arrows -->
            
            <a href="#section-about" class="s-scroll-to-section-v1--bc g-margin-b-15--xs">
                <span class="g-font-size-18--xs g-color--white ti-angle-double-down"></span>
                <p class="text-uppercase g-color--white g-letter-spacing--3 g-margin-b-0--xs">Learn More</p>
            </a>
        </div>
        <!--========== END SWIPER SLIDER ==========-->

        <!--========== PAGE CONTENT ==========-->
        <!-- Features -->
        <div id="js__scroll-to-section" class="container g-padding-y-80--xs g-padding-y-125--sm">
            <div class="g-text-center--xs g-margin-b-100--xs">
                <p class="text-uppercase g-font-size-14--xs g-font-weight--700 g-color--red g-letter-spacing--2 g-margin-b-25--xs">Welcome to CapitalX</p>
                <h2 class="g-font-size-32--xs g-font-size-36--md">We Provide Basic Bitcoin Services</h2>
            </div>
            <div class="row g-margin-b-60--xs g-margin-b-70--md">
                <div class="col-sm-4 g-margin-b-60--xs g-margin-b-0--md">
                    <div class="clearfix">
                        <div class="g-media g-width-30--xs">
                            <div class="wow fadeInDown" data-wow-duration=".3" data-wow-delay=".1s">
                                <i class="g-font-size-28--xs g-color--red ti-wallet"></i>
                            </div>
                        </div>
                        <div class="g-media__body g-padding-x-20--xs">
                            <h3 class="g-font-size-18--xs">Bitcoin Wallet</h3>
                            <p class="g-margin-b-0--xs">On signup, a new Bitcoin Wallet will be created for you. It's free</p>
                        </div>
                    </div>
                </div>
                <div class="col-sm-4 g-margin-b-60--xs g-margin-b-0--md">
                    <div class="clearfix">
                        <div class="g-media g-width-30--xs">
                            <div class="wow fadeInDown" data-wow-duration=".3" data-wow-delay=".2s">
                                <i class="g-font-size-28--xs g-color--red ti-credit-card"></i>
                            </div>
                        </div>
                        <div class="g-media__body g-padding-x-20--xs">
                            <h3 class="g-font-size-18--xs">Naira Account</h3>
                            <p class="g-margin-b-0--xs">A Virtual Naira account not connected to your physical bank accounts</p>
                        </div>
                    </div>
                </div>
                <div class="col-sm-4">
                    <div class="clearfix">
                        <div class="g-media g-width-30--xs">
                            <div class="wow fadeInDown" data-wow-duration=".3" data-wow-delay=".3s">
                                <i class="g-font-size-28--xs g-color--red ti-direction-alt"></i>
                            </div>
                        </div>
                        <div class="g-media__body g-padding-x-20--xs">
                            <h3 class="g-font-size-18--xs">Market Place</h3>
                            <p class="g-margin-b-0--xs">Sell and buy bitcoin at your preferred price. It's easy and reliable.</p>
                        </div>
                    </div>
                </div>
            </div>
            <!-- // end row  -->
            <div class="row">
                <div class="col-sm-4 g-margin-b-60--xs g-margin-b-0--md">
                    <div class="clearfix">
                        <div class="g-media g-width-30--xs">
                            <div class="wow fadeInDown" data-wow-duration=".3" data-wow-delay=".4s">
                                <i class="g-font-size-28--xs g-color--red ti-shield"></i>
                            </div>
                        </div>
                        <div class="g-media__body g-padding-x-20--xs">
                            <h3 class="g-font-size-18--xs">Strong Security</h3>
                            <p class="g-margin-b-0--xs">Full data and end-to-end communication encryption. Protection against DDoS.</p>
                        </div>
                    </div>
                </div>
                <div class="col-sm-4 g-margin-b-60--xs g-margin-b-0--md">
                    <div class="clearfix">
                        <div class="g-media g-width-30--xs">
                            <div class="wow fadeInDown" data-wow-duration=".3" data-wow-delay=".5s">
                                <i class="g-font-size-28--xs g-color--red ti-info-alt"></i>
                            </div>
                        </div>
                        <div class="g-media__body g-padding-x-20--xs">
                            <h3 class="g-font-size-18--xs">No Hidden Charges</h3>
                            <p class="g-margin-b-0--xs">Low transaction fees based of volume. No Hidden charges</p>
                        </div>
                    </div>
                </div>
                <div class="col-sm-4">
                    <div class="clearfix">
                        <div class="g-media g-width-30--xs">
                            <div class="wow fadeInDown" data-wow-duration=".3" data-wow-delay=".6s">
                                <i class="g-font-size-28--xs g-color--red ti-thumb-up"></i>
                            </div>
                        </div>
                        <div class="g-media__body g-padding-x-20--xs">
                            <h3 class="g-font-size-18--xs">Standard Ensured</h3>
                            <p class="g-margin-b-0--xs">We offer a high level of financial service and banking compliance standards.</p>
                        </div>
                    </div>
                </div>
            </div>
            <!-- // end row  -->
        </div>
        <!-- End Features -->

        <!-- Parallax -->
        <div class="js__parallax-window" style="background: url(img/1920x1080/03.jpg) 50% 0 no-repeat fixed;">
            <div class="container g-text-center--xs g-padding-y-80--xs g-padding-y-125--sm">
                <div class="g-margin-b-80--xs">
                    <h2 class="g-font-size-40--xs g-font-size-50--sm g-font-size-60--md g-color--white">Why Use Bitcoins?</h2>
                </div>
                <div class="g-color--white g-font-size-20--xs">
                  Bitcoin is freedom because no single entity controls it. People all around the world already use to bitcoin to buy, receive payments
                  and send money to friends and love one. Bitcoin is also used as an alternative way to store wealth, hence it's like digital gold.
                </div>
                <a href="http://keenthemes.com/" class="hidden text-uppercase s-btn s-btn--md s-btn--white-brd g-radius--50">Learn More</a>
            </div>
        </div>
        <!-- End Parallax -->

        <!-- Culture -->
        <div class="g-promo-section" id="section-about">
            <div class="container g-padding-y-80--xs g-padding-y-125--sm">
                <div class="row">
                    <div class="col-md-4 g-margin-t-15--xs g-margin-b-60--xs g-margin-b-0--lg">
                        <p class="text-uppercase g-font-size-14--xs g-font-weight--700 g-color--red g-letter-spacing--2 g-margin-b-25--xs">Culture</p>
                        <div class="wow fadeInLeft" data-wow-duration=".3" data-wow-delay=".1s">
                            <h4 class="g-font-size-20--xs g-font-size-25--sm g-font-size-30--md">About</h4>
                        </div>
                        <div class="wow fadeInLeft" data-wow-duration=".3" data-wow-delay=".3s">
                            <h3 class="g-font-size-30--xs g-font-size-40--sm g-font-size-50--md">CapitalX</h3>
                        </div>
                    </div>
                    <div class="col-md-4 col-md-offset-1">
                        <p class="g-font-size-18--xs">We are the first and leading bitcoin exchange specifically serving the Nigerian market.</p>
                        <p class="g-font-size-18--xs">CapitalX is a subsidiary of Capital Plan LTD focusing majorly on cryptocurrency. Our goal is to provide
                        reliable and easy to use tools and services for individuals and organisations to exchange and carry out trading using bitcoins.</p>
                    </div>
                </div>
            </div>
            <div class="col-sm-3 g-promo-section__img-right--lg g-bg-position--center g-height-100-percent--md js__fullwidth-img">
                <img class="img-responsive" src="img/970x970/03.jpg" alt="Image">
            </div>
        </div>
        <!-- End Culture -->

        </div>
        
        <!-- Counter -->
        <div class="js__parallax-window" style="background: url(img/1920x1080/06.jpg) 50% 0 no-repeat fixed;">
            <div class="container g-padding-y-80--xs g-padding-y-125--sm">
                <div class="row">
                    <div class="col-md-3 col-xs-6 g-full-width--xs g-margin-b-70--xs g-margin-b-0--lg">
                        <div class="g-text-center--xs">
                            <div class="g-margin-b-10--xs">
                                <figure class="g-display-inline-block--xs g-font-size-70--xs g-color--white js__counter">300</figure>
                                <span class="g-font-size-40--xs g-color--white">+</span>
                            </div>
                            <div class="center-block g-hor-divider__solid--white g-width-40--xs g-margin-b-25--xs"></div>
                            <h4 class="g-font-size-18--xs g-color--white">Bitcoin Wallet</h4>
                        </div>
                    </div>
                    <div class="col-md-3 col-xs-6 g-full-width--xs g-margin-b-70--xs g-margin-b-0--lg">
                        <div class="g-text-center--xs">
                            <div class="g-margin-b-10--xs">
                                <figure class="g-display-inline-block--xs g-font-size-70--xs g-color--white js__counter">700</figure>
                                <span class="g-font-size-40--xs g-color--white">+</span>
                            </div>
                            <div class="center-block g-hor-divider__solid--white g-width-40--xs g-margin-b-25--xs"></div>
                            <h4 class="g-font-size-18--xs g-color--white">Transactions</h4>
                        </div>
                    </div>
                    <div class="col-md-3 col-xs-6 g-full-width--xs g-margin-b-70--xs g-margin-b-0--sm">
                        <div class="g-text-center--xs">
                            <figure class="g-display-block--xs g-font-size-70--xs g-color--white g-margin-b-10--xs js__counter">15</figure>
                            <div class="center-block g-hor-divider__solid--white g-width-40--xs g-margin-b-25--xs"></div>
                            <h4 class="g-font-size-18--xs g-color--white">Multiple Pages</h4>
                        </div>
                    </div>
                    <div class="col-md-3 col-xs-6 g-full-width--xs">
                        <div class="g-text-center--xs">
                            <div class="g-margin-b-10--xs">
                                <figure class="g-display-inline-block--xs g-font-size-70--xs g-color--white js__counter">2</figure>
                                <span class="g-font-size-40--xs g-color--white">x</span>
                            </div>
                            <div class="center-block g-hor-divider__solid--white g-width-40--xs g-margin-b-25--xs"></div>
                            <h4 class="g-font-size-18--xs g-color--white">Faster Support</h4>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- End Counter -->

        <!-- Feedback Form -->
        <div class="g-bg-color--sky-light">
            <div class="container g-padding-y-80--xs g-padding-y-125--sm">
                <div class="g-text-center--xs g-margin-b-80--xs">
                    <p class="text-uppercase g-font-size-14--xs g-font-weight--700 g-color--red g-letter-spacing--2 g-margin-b-25--xs">Contact</p>
                    <h2 class="g-font-size-32--xs g-font-size-36--md">Send us a note</h2>
                </div>
                <form>
                    <div class="row g-margin-b-40--xs">
                        <div class="col-sm-6 g-margin-b-20--xs g-margin-b-0--md">
                            <div class="g-margin-b-20--xs">
                                <input type="text" class="form-control s-form-v2__input g-radius--50" placeholder="* Name">
                            </div>
                            <div class="g-margin-b-20--xs">
                                <input type="email" class="form-control s-form-v2__input g-radius--50" placeholder="* Email">
                            </div>
                            <input type="text" class="form-control s-form-v2__input g-radius--50" placeholder="* Phone">
                        </div>
                        <div class="col-sm-6">
                            <textarea class="form-control s-form-v2__input g-radius--10 g-padding-y-20--xs" rows="8" placeholder="* Your message"></textarea>
                        </div>
                    </div>
                    <div class="g-text-center--xs">
                        <button type="submit" class="text-uppercase s-btn s-btn--md s-btn--red-bg g-radius--50 g-padding-x-80--xs">Submit</button>
                    </div>
                </form>
            </div>
        </div>
        <!-- End Feedback Form -->

        <!-- Google Map -->
        <section class="s-google-map">
            <div id="js__google-container" class="s-google-container g-height-400--xs"></div>
        </section>
        <!-- End Google Map -->
        <!--========== END PAGE CONTENT ==========-->

{% endblock %}

{% block scriptTag %}
    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBsXUGTFS09pLVdsYEE9YrO2y4IAncAO2U"></script>
    <script type="text/javascript" src="/js/components/google-map.min.js"></script>
{% endblock %}