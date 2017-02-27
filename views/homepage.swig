{% extends 'theme.swig' %}
{% set title = 'Welcome to CPBit Bitcoin Platform' %}
{% block body %}
  

<div id="nSlider" class="carousel carouselfade" data-ride="carousel">
    <div class="carousel-inner" role="listbox">
        <div class="item active">
            <div class="container">
                <div class="carousel-caption">
                    <h1>Bitcoins<br/>
                        </h1>
                    <p>Lorem Ipsum is simply dummy text of nothing. we will change it soon</p>
                    <p>
                        <a class="btn btn-lg btn-primary" href="#" role="button">READ MORE</a>
                    </p>
                </div>
                <div class="hidden carousel-image wow zoomIn">
                    <img src="img/landing/laptop.png" alt="laptop"/>
                </div>
            </div>
            <!-- Set background for slide in css -->
            <div class="header-back one"></div>

        </div>
    </div>
</div>


<section  class="container features">
    <div class="row">
        <div class="col-lg-12 text-center">
            <div class="navy-line"></div>
            <h1 class="navy"> Basic Features </h1>
            <p>CPBit platform has various features that makes it easy and safe to engage in bitcoin transactions</p>
        </div>
    </div>
    <div class="row">
        <div class="col-md-3 text-center wow fadeInLeft">
            <div>
                <i class="fa fa-archive features-icon"></i>
                <h2>Bitcoin Wallet</h2>
                <p>On signup, a new bitcoin wallet is created. The user computer encrypts the address and sends it back to us. That way, your wallet remains safe and secure.</p>
            </div>
            <div class="m-t-lg">
                <i class="fa fa-money features-icon"></i>
                <h2>Naira Account</h2>
                <p>A virtual naira (&#8358;) account is available for buying bitcoins from the platform and for receiving payment in naira prior to selling bitcoins. </p>
            </div>
        </div>
        <div class="col-md-6 text-center  wow zoomIn">
            <img src="/images/bitcoin-3.jpg" alt="bitcoins" class="img-responsive" style="margin: auto">
        </div>
        <div class="col-md-3 text-center wow fadeInRight">
            <div>
                <i class="fa fa-bar-chart features-icon"></i>
                <h2>Market Data</h2>
                <p>View the latest market data on selling and buying price of bitcoin in different currency. Stay updated on current orders to sell and buy bitcoins.</p>
            </div>
            <div class="m-t-lg">
                <i class="fa fa-exchange features-icon"></i>
                <h2>Send & Receive Bitcoin</h2>
                <p>Send and Receive bitcoin on this platform in a safe and secure manner. All that is required is the wallet address  and amount to effect the exchange.</p>
            </div>
        </div>
    </div>
</section>


<section class="features">
    <div class="container">
        <div class="row">
            <div class="col-lg-12 text-center">
                <div class="navy-line"></div>
                <h1>Current Market Trend & Prices</h1>
                <p>Lets us show you what is going on in the bitcoin market.</p>
            </div>
        </div>
        <div class="row features-block">
            <div class="col-lg-3 features-text wow fadeInLeft">
                <h2>Market Trend</h2>
                <p>Pending bitcoin offers and orders are always available for your proper decision making. Know when to buy and when to sell in order to make maximum profit trading on bitcoins.</p>
                <a href="" class="btn btn-primary">Learn more</a>
            </div>
            <div class="col-lg-6 text-right m-t-n-lg wow zoomIn">
                <img src="/images/iphone.jpg" class="img-responsive" alt="dashboard">
            </div>
            <div class="col-lg-3 features-text text-right wow fadeInRight">
                <h2>Market Prices</h2>
                <p>Have a visual display of bitcoin transactions and how it changes with time. See market prices and learn from a the large data accessible to us to trade wisely on this platform.</p>
                <a href="#" class="btn btn-primary">Learn more</a>
            </div>
        </div>
    </div>

</section>

<section class="timeline gray-section">
    <div class="container">
        <div class="row">
            <div class="col-lg-12 text-center">
                <div class="navy-line"></div>
                <h1>Our workflow</h1>
                <p>CPBit helps you buy and sell bitcoins in fews and simples steps </p>
            </div>
        </div>
        <div class="row features-block">

            <div class="col-lg-12">
                <div id="vertical-timeline" class="vertical-container light-timeline center-orientation">
                    <div class="vertical-timeline-block">
                        <div class="vertical-timeline-icon navy-bg">
                            <i class="fa fa-sign-in"></i>
                        </div>

                        <div class="vertical-timeline-content">
                            <h2>Sign Up</h2>
                            <p>Sign up for free account on CPBits and complete the verification processes based on your user level.
                            </p>
                            <span class="vertical-date"> Sign Up <br/> <small>Free account</small> </span>
                        </div>
                    </div>

                    <div class="vertical-timeline-block">
                        <div class="vertical-timeline-icon navy-bg">
                            <i class="fa fa-archive"></i>
                        </div>

                        <div class="vertical-timeline-content">
                            <h2>Fund Virtual Account</h2>
                            <p>You fund your naira (&#8358;) virtual account using a prefered funding method from our available options.</p>
                            <span class="vertical-date"> Fund Account <br/> <small>Naira account</small> </span>
                        </div>
                    </div>

                    <div class="vertical-timeline-block">
                        <div class="vertical-timeline-icon navy-bg">
                            <i class="fa fa-bitcoin"></i>
                        </div>

                        <div class="vertical-timeline-content">
                            <h2>Buy Bitcoin</h2>
                            <p>Buy bitcoin from your virtual account. You can then also send bitcoin to friends</p>
                            <span class="vertical-date"> Buy bitcoin <br/> <small>Carry out other bitcoin transactions</small> </span>
                        </div>
                    </div>

                </div>
            </div>

        </div>
    </div>

</section>

<section id="testimonials" class="navy-section testimonials" style="margin-top: 0">

    <div class="container">
        <div class="row">
            <div class="col-lg-12 text-center wow zoomIn">
                <i class="fa fa-comment big-icon"></i>
                <h1>
                    Why use bitcoin?
                </h1>
                <div class="testimonials-text">
                    Bitcoin is freedom because no single entity controls it. People all around the world already use to bitcoin to buy things, receive payments and send money to friends and love one. Bitcoin is also used as an alternative way to store wealth, hence it's like digital gold. 
            </div>
        </div>
    </div>

</section>


<section class="features hidden">
    <div class="container">
        <div class="row">
            <div class="col-lg-12 text-center">
                <div class="navy-line"></div>
                <h1>More and more extra great feautres</h1>
                <p>Donec sed odio dui. Etiam porta sem malesuada magna mollis euismod. </p>
            </div>
        </div>
        <div class="row">
            <div class="col-lg-5 col-lg-offset-1 features-text">
                <small>INSPINIA</small>
                <h2>Perfectly designed </h2>
                <i class="fa fa-bar-chart big-icon pull-right"></i>
                <p>INSPINIA Admin Theme is a premium admin dashboard template with flat design concept. It is fully responsive admin dashboard template built with Bootstrap 3+ Framework, HTML5 and CSS3, Media query. It has a huge collection of reusable UI components and integrated with.</p>
            </div>
            <div class="col-lg-5 features-text">
                <small>INSPINIA</small>
                <h2>Perfectly designed </h2>
                <i class="fa fa-bolt big-icon pull-right"></i>
                <p>INSPINIA Admin Theme is a premium admin dashboard template with flat design concept. It is fully responsive admin dashboard template built with Bootstrap 3+ Framework, HTML5 and CSS3, Media query. It has a huge collection of reusable UI components and integrated with.</p>
            </div>
        </div>
        <div class="row">
            <div class="col-lg-5 col-lg-offset-1 features-text">
                <small>INSPINIA</small>
                <h2>Perfectly designed </h2>
                <i class="fa fa-clock-o big-icon pull-right"></i>
                <p>INSPINIA Admin Theme is a premium admin dashboard template with flat design concept. It is fully responsive admin dashboard template built with Bootstrap 3+ Framework, HTML5 and CSS3, Media query. It has a huge collection of reusable UI components and integrated with.</p>
            </div>
            <div class="col-lg-5 features-text">
                <small>INSPINIA</small>
                <h2>Perfectly designed </h2>
                <i class="fa fa-users big-icon pull-right"></i>
                <p>INSPINIA Admin Theme is a premium admin dashboard template with flat design concept. It is fully responsive admin dashboard template built with Bootstrap 3+ Framework, HTML5 and CSS3, Media query. It has a huge collection of reusable UI components and integrated with.</p>
            </div>
        </div>
    </div>

</section>

{% endblock %}
