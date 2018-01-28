<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Reports.aspx.cs" Inherits="Reports" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">

    <title>Sales - MedZilla</title>
    <link href="Required/bootstrap-3.3.7-dist/css/bootstrap.css" rel="stylesheet" />
    <script src="Required/bootstrap-3.3.7-dist/js/jquery.js"></script>
    <script src="Required/bootstrap-3.3.7-dist/js/bootstrap.js"></script>
    <link href="Required/assets/css/zabuto_calendar.css" rel="stylesheet" />
    <link href="Required/assets/js/gritter/css/jquery.gritter.css" rel="stylesheet" />
    <link href="Required/assets/lineicons/style.css" rel="stylesheet" />
    <link href="Required/assets/css/style-responsive.css" rel="stylesheet" />
    <link href="Required/assets/css/style.css" rel="stylesheet" />
    <script src="assets/js/chart-master/Chart.js"></script>
    <style>
        body {
            padding-top: 55px;
        }

        .paddi {
            padding: 0;
            margin: 0;
        }

        .sml {
            font-size: small;
        }

        .navTotal {
            background: #000000;
            color: #f8f8f8;
            font-weight: 500;
        }

        a {
            color: #3c763d;
        }

            a:hover {
                color: #3c763d;
                text-decoration: none;
            }
    </style>
</head>
<body style="background-color: #55FFFF">
    <form id="form1" runat="server">
        <div>
            <nav class="navbar navbar-default navbar-fixed-top">
                <div class="container-fluid">
                    <!-- Brand and toggle get grouped for better mobile display -->
                    <div class="navbar-header">
                        <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
                            <span class="sr-only">Toggle navigation</span>
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                        </button>
                        <a class="navbar-brand" href="#">MedZilla</a>                        
                    </div>
                    <!-- Collect the nav links, forms, and other content for toggling -->
                    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                        <ul class="nav navbar-nav">
                            <li><a href="CustomerDashBoard.aspx">Back To DashBoard</a></li>
                        </ul>
                        <ul class="nav navbar-nav navbar-right">                            
                            <li><a class="navbar-brand" href="Logout.aspx">Log Out</a></li>
                        </ul>
                    </div>
                    <!-- /.navbar-collapse -->
                </div>
                <!-- /.container-fluid -->
            </nav>
            <div class="container" style="margin-top:80px;">
            <div class="row">
                <div class="row mt">
                    <a href="Report_Sales.aspx">
                        <div class="col-md-3 col-sm-3 mb">
                            <div class="white-panel pn donut-chart">
                                <div class="white-header" style="background-color: #8558e2; color: black;">
                                    <h5>Sales</h5>
                                </div>
                                <div class="centered">
                                    <h1><i class="glyphicon glyphicon-circle-arrow-up" style="font-size: 170px; color: #8558e2;"></i></h1>
                                </div>
                            </div>
                        </div>
                    </a>
                    <a href="Report_SalesReturn.aspx">
                        <div class="col-md-3 col-sm-3 mb">
                            <div class="white-panel pn">
                                <div class="white-header" style="background-color: #dfe258; color: black;">
                                    <h5>Sales Returns</h5>
                                </div>
                                <div class="centered">
                                    <h1><i class="glyphicon glyphicon-circle-arrow-down" style="font-size: 170px; color: #dfe258;"></i></h1>
                                </div>
                            </div>
                        </div>
                    </a>
                    <!-- /col-md-4 -->
                    <a href="Report_PatientWiseSales.aspx">
                        <div class="col-md-3 col-sm-3 mb">
                            <div class="white-panel pn">
                                <div class="white-header" style="background-color: #8558e2; color: black;">
                                    <h5>Patientwise Sales</h5>
                                </div>
                                <div class="centered">
                                    <h1><i class="glyphicon glyphicon-circle-arrow-up" style="font-size: 170px; color: #8558e2;"></i></h1>
                                </div>
                            </div>
                        </div>
                    </a>
                    <a href="Report_PatientWiseSalesReturn.aspx">
                        <div class="col-md-3 col-sm-3 mb">
                            <!-- WHITE PANEL - TOP USER -->
                            <div class="white-panel pn">
                                <div class="white-header" style="background-color: #dfe258; color: black;">
                                    <h5>Patientwise Sales Return</h5>
                                </div>
                                <div class="centered">
                                    <h1><i class="glyphicon glyphicon-circle-arrow-down" style="font-size: 170px; color: #dfe258;"></i></h1>
                                </div>
                            </div>
                        </div>
                        <!-- /col-md-4 -->
                    </a>
                </div>
                <div class="row">
                    <a href="Report_DoctorWiseSale.aspx">
                        <div class="col-md-3 col-sm-3 mb">
                            <div class="white-panel pn">
                                <div class="white-header" style="background-color: #8558e2; color: black;">
                                    <h5>Doctorwise Sales</h5>
                                </div>
                                <div class="centered">
                                    <h1><i class="glyphicon glyphicon-circle-arrow-up" style="font-size: 170px; color: #8558e2;"></i></h1>
                                </div>
                            </div>
                        </div>
                    </a>
                    <a href="Report_Purchase.aspx">
                        <div class="col-md-3 col-sm-3 mb">
                            <div class="white-panel pn">
                                <div class="white-header" style="background-color: #58e2d2; color: black;">
                                    <h5>Purchase</h5>
                                </div>
                                <div class="centered">
                                    <h1><i class="glyphicon glyphicon-circle-arrow-down" style="font-size: 170px; color: #58e2d2;"></i></h1>
                                </div>
                            </div>
                        </div>
                    </a>
                    <a href="Report_PurchaseReturn.aspx">
                        <div class="col-md-3 col-sm-3 mb">
                            <div class="white-panel pn">
                                <div class="white-header" style="background-color: #58b1e2; color: black;">
                                    <h5>Purchase Return</h5>
                                </div>
                                <div class="centered">
                                    <h1><i class="glyphicon glyphicon-circle-arrow-up" style="font-size: 170px; color: #58b1e2;"></i></h1>
                                </div>
                            </div>
                        </div>
                    </a>
                    <a href="Report_SupplierWisePurchase.aspx">
                        <div class="col-md-3 col-sm-3 mb">
                            <div class="white-panel pn">
                                <div class="white-header" style="background-color: #58e2d2; color: black;">
                                    <h5>Supplierwise Purchase</h5>
                                </div>
                                <div class="centered">
                                    <h1><i class="glyphicon glyphicon-circle-arrow-down" style="font-size: 170px; color: #58e2d2;"></i></h1>
                                </div>
                            </div>
                        </div>
                    </a>
                </div>
                <div class="row">                    
                    <a href="Report_SupplierWisePurchaseReturn.aspx">
                        <div class="col-md-3 col-sm-3 mb">
                            <div class="white-panel pn">
                                <div class="white-header" style="background-color: #58b1e2; color: black;">
                                    <h5>Supplierwise Purchase Return</h5>
                                </div>
                                <div class="centered">
                                    <h1><i class="glyphicon glyphicon-circle-arrow-up" style="font-size: 170px; color: #58b1e2;"></i></h1>
                                </div>
                            </div>
                        </div>
                    </a>
                    <a href="Report_Expiry.aspx">
                        <div class="col-md-3 col-sm-3 mb">
                            <div class="white-panel pn">
                                <div class="white-header" style="background-color: #3c763d; color: black;">
                                    <h5>Expiry</h5>
                                </div>
                                <div class="centered">
                                    <h1><i class="glyphicon glyphicon-refresh" style="font-size: 170px; color: #3c763d;"></i></h1>
                                </div>
                            </div>
                        </div>
                    </a>
                    <a href="Report_MedicineWiseExpiry.aspx">
                        <div class="col-md-3 col-sm-3 mb">
                            <div class="white-panel pn">
                                <div class="white-header" style="background-color: #3c763d; color: black;">
                                    <h5>Medicinewise Expiry</h5>
                                </div>
                                <div class="centered">
                                    <h1><i class="glyphicon glyphicon-refresh" style="font-size: 170px; color: #3c763d;"></i></h1>
                                </div>
                            </div>
                        </div>
                    </a>
                </div>
                </div>

                <!-- js placed at the end of the document so the pages load faster -->
                <script src="assets/js/jquery.js"></script>
                <script src="assets/js/jquery-1.8.3.min.js"></script>
                <script src="assets/js/bootstrap.min.js"></script>
                <script class="include" type="text/javascript" src="assets/js/jquery.dcjqaccordion.2.7.js"></script>
                <script src="assets/js/jquery.scrollTo.min.js"></script>
                <script src="assets/js/jquery.nicescroll.js" type="text/javascript"></script>
                <script src="assets/js/jquery.sparkline.js"></script>



                <!--common script for all pages-->
                <script src="assets/js/common-scripts.js"></script>

                <script type="text/javascript" src="assets/js/gritter/js/jquery.gritter.js"></script>
                <script type="text/javascript" src="assets/js/gritter-conf.js"></script>

                <!--script for this page-->
                <script src="assets/js/sparkline-chart.js"></script>
                <script src="assets/js/zabuto_calendar.js"></script>



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


            </div>


        </div>
    </form>
</body>
</html>
