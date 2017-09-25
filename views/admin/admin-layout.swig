<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>CapitalX Admin</title>

    <link href="/styles/bootstrap.min.css" rel="stylesheet">
    <link href="/styles/font-awesome.min.css" rel="stylesheet">
    <link href="/styles/plugins/dataTables/dataTables.min.css" rel="stylesheet">

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
                             </span>
                        <a data-toggle="dropdown" class="dropdown-toggle" href="#">
                            <span class="clear"> <span class="block m-t-xs"> <strong class="font-bold">Administrator</strong>
                             </span> <span class="text-muted text-xs block"></span></span> </a>

                    </div>
                    <div class="logo-element">
                        IN+
                    </div>
                </li>
                <li>
                    <a href="/admin/dashboard" class="page-link"><i class="fa fa-dashboard fa-lg fa-fw"></i> <span class="nav-label">Dashboards</span></a>
                </li>
                <li class="">
                    <a href="/admin/accounts"><i class="fa fa-credit-card fa-lg fa-fw"></i> <span class="nav-label">Accounts</span></a>
                </li>
                <li>
                    <a href="/withdrawals/pending"><i class="fa fa-money fa-lg fa-fw"></i> <span class="nav-label">Cashout Requests</span></a>
                </li>
                <li class="">
                    <a href="#"><i class="fa fa-list fa-lg fa-fw"></i> <span class="nav-label">Transactions</span><span class="fa arrow"></span></a>
                    <ul class="nav nav-second-level collapse">
                        <li><a href="/admin/naira-transactions">Naira Tranasactions</a></li>
                        <li><a href="/admin/btc-transactions">BTC Transactions</a></li>
                        <li><a href="/admin/instant-trade">Instant Buy & Sell</a></li>
                    </ul>
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
                Admin Dashboard
            </div>
            <div>
                <strong>Copyright</strong> CapitalX &copy;
            </div>
        </div>

    </div>
</div>

<!-- Mainly scripts -->
{#<script src="/js/jquery-2.1.1.js"></script>#}
<script
        src="https://code.jquery.com/jquery-2.2.4.min.js"
        integrity="sha256-BbhdlvQf/xTY9gja0Dq3HiwQF8LaCRTXxZKRutelT44="
        crossorigin="anonymous"></script>
<script src="/js/bootstrap.min.js"></script>
<script src="/js/plugins/metisMenu/jquery.metisMenu.js"></script>
<script src="/js/plugins/slimscroll/jquery.slimscroll.min.js"></script>

<!-- Custom and plugin javascript -->
<script src="/js/plugins/pace/pace.min.js"></script>
<script src="/js/inspinia.js"></script>
{% block scriptTag %} {% endblock %}
<script type="text/javascript">
$(document).ready(function() {
    // load page using ajax

    {% block script %} {% endblock %}
});
</script>
</body>

</html>