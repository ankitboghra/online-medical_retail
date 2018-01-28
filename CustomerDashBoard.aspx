<%@ Page Title="" Language="C#" MasterPageFile="MedicalAdminMain.master" AutoEventWireup="true" CodeFile="CustomerDashBoard.aspx.cs" Inherits="CustomerFiles_CustomerDashBoard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="Dashboard">
    <meta name="keyword" content="Dashboard, Bootstrap, Admin, Template, Theme, Responsive, Fluid, Retina">

    <title>Customer Dashboard</title>

    <!-- Bootstrap core CSS -->
    <link href="assets/css/bootstrap.css" rel="stylesheet">
    <!--external css-->
    <link href="assets/font-awesome/css/font-awesome.css" rel="stylesheet" />
    <link rel="stylesheet" type="text/css" href="assets/css/zabuto_calendar.css">
    <link rel="stylesheet" type="text/css" href="assets/js/gritter/css/jquery.gritter.css" />
    <link rel="stylesheet" type="text/css" href="assets/lineicons/style.css">


    <!-- Custom styles for this template -->
    <link href="assets/css/style.css" rel="stylesheet">
    <link href="assets/css/style-responsive.css" rel="stylesheet">

    <script src="assets/js/chart-master/Chart.js"></script>

</head>

<body>

    <section id="container">
        <!-- **********************************************************************************************************************************************************
      TOP BAR CONTENT & NOTIFICATIONS
      *********************************************************************************************************************************************************** -->
        <!--header start-->
        <header class="header black-bg">
            <div class="sidebar-toggle-box">
                <div class="fa fa-bars tooltips" data-placement="right" data-original-title="Toggle Navigation"></div>
            </div>
            <!--logo start-->
            <a href="index.html" class="logo"><b>Home</b></a>
            <!--logo end-->
            <div class="nav notify-row" id="top_menu">
            </div>
            <div class="top-menu" style="margin-top: 15px;">
                <ul class="nav pull-right top-menu">
                    <li><a class="Logout" href="Logout.aspx">Logout</a></li>
                </ul>
            </div>
        </header>
        <!--header end-->

        <!-- **********************************************************************************************************************************************************
      MAIN SIDEBAR MENU
      *********************************************************************************************************************************************************** -->
        <!--sidebar start-->
        <aside>
            <div id="sidebar" class="nav-collapse ">
                <!-- sidebar menu start-->
                <ul class="sidebar-menu" id="nav-accordion">

                    <p class="centered">
                        <a href="profile.html">
                            <img src="assets/img/ui-sam.jpg" class="img-circle" width="60"/>
                        </a>
                    </p>
                    <h5 class="centered">Online Medical Retail System</h5>

                    <li class="mt">
                        <a class="active" href="customer_dashboard.aspx">
                            <i class="fa fa-dashboard"></i>
                            <span>Home</span>
                        </a>
                    </li>

                    <li class="sub-menu">
                        <a href="User_pro.aspx">
                            <i class="fa fa-desktop"></i>
                            <span>Profile</span>
                        </a>

                    </li>

                </ul>
                <!-- sidebar menu end-->
            </div>
        </aside>
        <!--sidebar end-->

        <!-- **********************************************************************************************************************************************************
      MAIN CONTENT
      *********************************************************************************************************************************************************** -->
        <!--main content start-->
        <section id="main-content">
            <section class="wrapper">

                <div class="row">



                    <div class="row mt">
                        <!-- SERVER STATUS PANELS -->
                        <!-- /col-md-4 -->
                        <a href="SalesResponsive.aspx">
                            <div class="col-md-3 col-sm-3 mb">
                                <div class="white-panel pn">
                                    <div class="white-header" style="background-color: #8558e2; color: black;">
                                        <h5>Sales</h5>
                                    </div>
                                    <div class="centered">
                                        <h1><i class="glyphicon glyphicon-download" style="font-size: 170px; color: #8558e2;"></i></h1>
                                    </div>
                                </div>
                            </div>
                        </a>
                        <a href="SalesReturn.aspx">
                            <div class="col-md-3 col-sm-3 mb">
                                <!-- WHITE PANEL - TOP USER -->
                                <div class="white-panel pn">
                                    <div class="white-header" style="background-color: #dfe258; color: black;">
                                        <h5>Sales Return</h5>
                                    </div>
                                    <div class="centered">
                                        <h1><i class="glyphicon glyphicon-upload" style="font-size: 170px; color: #dfe258;"></i></h1>
                                    </div>
                                </div>
                            </div>
                            <!-- /col-md-4 -->
                            <a href="Purchase.aspx">
                            <div class="col-md-3 col-sm-3 mb">
                                <div class="white-panel pn donut-chart">
                                    <div class="white-header" style="background-color: #58e2d2; color: black;">
                                        <h5>Purchase</h5>
                                    </div>
                                    <div class="centered">
                                        <h1><i class="glyphicon glyphicon-circle-arrow-down" style="font-size: 170px; color: #58e2d2;"></i></h1>
                                    </div>
                                </div>
                            </div>
                        </a>
                        <a href="PurchaseReturn.aspx">
                            <div class="col-md-3 col-sm-3 mb">
                                <div class="white-panel pn">
                                    <div class="white-header" style="background-color: #58b1e2; color: black;">
                                        <h5>Purchase Returns</h5>
                                    </div>
                                    <div class="centered">
                                        <h1><i class="glyphicon glyphicon-circle-arrow-up" style="font-size: 170px; color: #58b1e2;"></i></h1>
                                    </div>
                                </div>
                            </div>
                        </a>
                    </div>
                    <!-- /row -->
                      <div class="row">
                          <a href="Drug_Content.aspx">
                              <div class="col-md-3 col-sm-3 mb">
                                  <div class="white-panel pn">
                                      <div class="white-header" style="background-color: #58b1e2; color: black;">
                                          <h5><strong>Drug Content</strong></h5>
                                      </div>
                                      <div class="centered">
                                          <h1><i class="glyphicon glyphicon-tree-deciduous" style="font-size: 170px; color: #58b1e2"></i></h1>
                                      </div>
                                  </div>
                              </div>
                          </a>
                    </div>

                    <!-- js placed at the end of the document so the pages load faster -->
                    <script src="../assets/js/jquery.js"></script>
                    <script src="../assets/js/jquery-1.8.3.min.js"></script>
                    <script src="../assets/js/bootstrap.min.js"></script>
                    <script class="include" type="text/javascript" src="../assets/js/jquery.dcjqaccordion.2.7.js"></script>
                    <script src="../assets/js/jquery.scrollTo.min.js"></script>
                    <script src="../assets/js/jquery.nicescroll.js" type="text/javascript"></script>
                    <script src="../assets/js/jquery.sparkline.js"></script>



                    <!--common script for all pages-->
                    <script src="../assets/js/common-scripts.js"></script>

                    <script type="text/javascript" src="../assets/js/gritter/js/jquery.gritter.js"></script>
                    <script type="text/javascript" src="../assets/js/gritter-conf.js"></script>

                    <!--script for this page-->
                    <script src="../assets/js/sparkline-chart.js"></script>
                    <script src="../assets/js/zabuto_calendar.js"></script>



                    <script type="application/javascript">
                        $(document).ready(function () {
                            $("#date-popover").popover({ html: true, trigger: "manual" });
                            $("#date-popover").hide();
                            $("#date-popover").click(function (e) {
                                $(this).hide();
                            });

                            $("#my-calendar").zabuto_calendar({
                                action: function () {
                                    return myDateFunction(this.id, false);
                                },
                                action_nav: function () {
                                    return myNavFunction(this.id);
                                },
                                ajax: {
                                    url: "show_data.php?action=1",
                                    modal: true
                                },
                                legend: [
                                    { type: "text", label: "Special event", badge: "00" },
                                    { type: "block", label: "Regular event", }
                                ]
                            });
                        });


                        function myNavFunction(id) {
                            $("#date-popover").hide();
                            var nav = $("#" + id).data("navigation");
                            var to = $("#" + id).data("to");
                            console.log('nav ' + nav + ' to: ' + to.month + '/' + to.year);
                        }
                    </script>
</body>
</html>

</asp:Content>

