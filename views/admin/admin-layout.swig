<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Bitcoin Platform</title>

    <link href="/styles/bootstrap.min.css" rel="stylesheet">
    <link href="/styles/font-awesome.min.css" rel="stylesheet">
    <link href="/stylel/plugins/bootstrap-datepicker3.css" rel="stylesheet">

    <link href="/styles/animate.css" rel="stylesheet">
    <link href="/styles/style.css" rel="stylesheet">
    <style>
        .panel {
            width: 80%;
            margin: auto;
            background: inherit;
        }

        .panel .inner {
            border: #e0e0e0 solid thin;
            margin: 3px;
            padding: 20px;
            padding-bottom: 9px;
            background: #fff;
            border-radius: 2px;
            overflow: auto;
        }

        .opt-icons .fa {
            margin: 1px 5px;
        }
    </style>
</head>

<body class="">

<div id="wrapper">

    <nav class="navbar-default navbar-static-side" role="navigation">
        <div class="sidebar-collapse">
            <ul class="nav metismenu" id="side-menu">
                <li class="nav-header">
                    <div class="dropdown profile-element"> <span>
                            <i class="fa fa-user fa-3x" style="margin-left: 13px; color: #ccc"></i>
                            <img alt="image" class="img-circle hidden" src="/images/profile_small.jpg" />
                             </span>
                        <a data-toggle="dropdown" class="dropdown-toggle" href="#">
                            <span class="clear"> <span class="block m-t-xs"> <strong class="font-bold">Administrator</strong>
                             </span> <span class="text-muted text-xs block"></span> </a>
                        <ul class="dropdown-menu animated fadeInRight m-t-xs hidden">
                            <li><a href="profile">Profile</a></li>
                            <li><a href="contacts">Contacts</a></li>
                            <li><a href="mailbox">Mailbox</a></li>
                            <li class="divider"></li>
                            <li><a href="login.html">Logout</a></li>
                        </ul>
                    </div>
                    <div class="logo-element">
                        IN+
                    </div>
                </li>
                <li>
                    <a href="/admin/dashboard" class="page-link"><i class="fa fa-dashboard fa-lg fa-fw"></i> <span class="nav-label">Dashboards</span></a>
                </li>
                <li>
                    <a href="/accounts/"><i class="fa fa-money fa-lg fa-fw"></i> <span class="nav-label">Accounts</span></a>
                </li>
                <li>
                    <a href="#"><i class="fa fa-bitcoin fa-lg fa-fw"></i> <span class="nav-label">Trade Bitcoin</span><span class="fa arrow"></span></a>
                    <ul class="nav nav-second-level collapse">
                        <li><a href="#wallet/send" class="page-link">Send</a></li>
                        <li><a href="#wallet/receive" class="page-link">Receive</a></li>
                        <li><a href="#wallet/buy" class="page-link">Buy</a></li>
                    </ul>
                </li>
                <li class="">
                    <a href="#wallet/transactions"><i class="fa fa-list fa-lg fa-fw"></i> <span class="nav-label">Transactions</span></a>
                </li>
                <li class="">
                    <a href="/beneficiary/"><i class="fa fa-group fa-lg fa-fw"></i> <span class="nav-label">Beneficiaries</span></a>
                </li>
                <li class="">
                    <a href="#"><i class="fa fa-gift fa-lg fa-fw"></i> <span class="nav-label">Promotions</span></a>
                </li>
                <li class="">
                    <a href="/admin/users"><i class="fa fa-users fa-lg fa-fw"></i> <span class="nav-label">Users</span></a>
                </li>
                <li>
                    <a href="/admin/settings"><i class="fa fa-wrench fa-lg fa-fw"></i> <span class="nav-label">Settings</span></a>
                </li>
                <li class="">
                    <a href="/user/signout"><i class="fa fa-sign-out fa-lg fa-fw"></i> <span class="nav-label">Sign Out</span></a>
                </li>
            </ul>

        </div>
    </nav>

    <div id="page-wrapper" class="gray-bg">
        <div class="row border-bottom">
            <nav class="navbar navbar-static-top  " role="navigation" style="margin-bottom: 0">
                <div class="navbar-header">
                    <a class="navbar-minimalize minimalize-styl-2 btn btn-primary " href="#"><i class="fa fa-bars"></i> </a>
                </div>
                <ul class="nav navbar-top-links navbar-right">
                    <li>
                        <span class="m-r-sm text-muted welcome-message hidden">MicroCredit Admin</span>
                    </li>
                    <li class="dropdown">
                        <a class="dropdown-toggle count-info hidden" data-toggle="dropdown" href="#">
                            <i class="fa fa-envelope"></i>  <span class="label label-warning">0</span>
                        </a>
                        <ul class="dropdown-menu dropdown-messages">
                            <li>
                                <div class="dropdown-messages-box">
                                    <a href="profile.html" class="pull-left">
                                        <img alt="image" class="img-circle" src="img/a7.jpg">
                                    </a>
                                    <div class="media-body">
                                        <small class="pull-right">46h ago</small>
                                        <strong>Mike Loreipsum</strong> started following <strong>Monica Smith</strong>. <br>
                                        <small class="text-muted">3 days ago at 7:58 pm - 10.06.2014</small>
                                    </div>
                                </div>
                            </li>
                            <li class="divider"></li>
                            <li>
                                <div class="dropdown-messages-box">
                                    <a href="profile.html" class="pull-left">
                                        <img alt="image" class="img-circle" src="img/a4.jpg">
                                    </a>
                                    <div class="media-body ">
                                        <small class="pull-right text-navy">5h ago</small>
                                        <strong>Chris Johnatan Overtunk</strong> started following <strong>Monica Smith</strong>. <br>
                                        <small class="text-muted">Yesterday 1:21 pm - 11.06.2014</small>
                                    </div>
                                </div>
                            </li>
                            <li class="divider"></li>
                            <li>
                                <div class="dropdown-messages-box">
                                    <a href="profile.html" class="pull-left">
                                        <img alt="image" class="img-circle" src="img/profile.jpg">
                                    </a>
                                    <div class="media-body ">
                                        <small class="pull-right">23h ago</small>
                                        <strong>Monica Smith</strong> love <strong>Kim Smith</strong>. <br>
                                        <small class="text-muted">2 days ago at 2:30 am - 11.06.2014</small>
                                    </div>
                                </div>
                            </li>
                            <li class="divider"></li>
                            <li>
                                <div class="text-center link-block">
                                    <a href="mailbox.html">
                                        <i class="fa fa-envelope"></i> <strong>Read All Messages</strong>
                                    </a>
                                </div>
                            </li>
                        </ul>
                    </li>
                    <li class="dropdown">
                        <a class="dropdown-toggle count-info hidden" data-toggle="dropdown" href="#">
                            <i class="fa fa-bell"></i>  <span class="label label-primary">0</span>
                        </a>
                        <ul class="dropdown-menu dropdown-alerts">
                            <li>
                                <a href="mailbox.html">
                                    <div>
                                        <i class="fa fa-envelope fa-fw"></i> You have 16 messages
                                        <span class="pull-right text-muted small">4 minutes ago</span>
                                    </div>
                                </a>
                            </li>
                            <li class="divider"></li>
                            <li>
                                <a href="profile.html">
                                    <div>
                                        <i class="fa fa-twitter fa-fw"></i> 3 New Followers
                                        <span class="pull-right text-muted small">12 minutes ago</span>
                                    </div>
                                </a>
                            </li>
                            <li class="divider"></li>
                            <li>
                                <a href="grid_options.html">
                                    <div>
                                        <i class="fa fa-upload fa-fw"></i> Server Rebooted
                                        <span class="pull-right text-muted small">4 minutes ago</span>
                                    </div>
                                </a>
                            </li>
                            <li class="divider"></li>
                            <li>
                                <div class="text-center link-block">
                                    <a href="notifications.html">
                                        <strong>See All Alerts</strong>
                                        <i class="fa fa-angle-right"></i>
                                    </a>
                                </div>
                            </li>
                        </ul>
                    </li>


                    <li>
                        <a href="/user/signout">
                            <i class="fa fa-sign-out"></i> Log out
                        </a>
                    </li>
                </ul>

            </nav>
        </div>

        <div id="content">
          {% block body %} {% endblock %}
        </div>

        <div class="footer">
            <div class="pull-right">
                Haha!
            </div>
            <div>
                <strong>Copyright</strong> CPBits &copy;
            </div>
        </div>

    </div>
</div>

<!-- Mainly scripts -->
<script src="/js/jquery-2.1.1.js"></script>
<script src="/js/bootstrap-datepicker.js"></script>
<script src="/js/bootstrap.min.js"></script>
<script src="/js/plugins/metisMenu/jquery.metisMenu.js"></script>
<script src="/js/plugins/slimscroll/jquery.slimscroll.min.js"></script>

<!-- Custom and plugin javascript -->
<script src="/js/inspinia.js"></script>
<script src="/js/plugins/pace/pace.min.js/"></script>

<script type="text/javascript">
$(document).ready(function() {
    // load page using ajax

    {% block script %} {% endblock %}
});
</script>
</body>

</html>