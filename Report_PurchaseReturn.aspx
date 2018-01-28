﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Report_PurchaseReturn.aspx.cs" Inherits="Report_Sales" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Purchase Return Report</title>
    <link href="Required/bootstrap-3.3.7-dist/css/bootstrap.css" rel="stylesheet" />
    <script src="Required/bootstrap-3.3.7-dist/js/jquery.js"></script>
    <script src="Required/bootstrap-3.3.7-dist/js/bootstrap.js"></script>
    <style>
        body {
            padding-top: 55px;
        }
        .paddi {
            padding: 0;
            margin: 0;
        }
        .sml {
            font-size:small;
        }

        .navTotal {
            background:#000000;
            color:#f8f8f8;
            font-weight:500;
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
<body>
    <form id="form1" runat="server">
        <div class="container-fluid">
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
                        <li><a href="Reports.aspx">Back To Reports</a></li>
                        </ul>
                        <ul class="nav navbar-nav navbar-right">
                            <li><a class="navbar-brand" href="Logout.aspx">Log Out</a></li>
                        </ul>
                    </div>
                    <!-- /.navbar-collapse -->
                </div>
                <!-- /.container-fluid -->
            </nav>
            <div class="row">
                <div class="panel">
                    <div class="panel-heading text-center">
                        <h2>Purchase Return Report</h2>
                    </div>
                    <div class="panel-body">
                        <div class="col-md-4 paddi">
                            <span class="label" style="font-size: larger">Start Date</span><br />
                            <asp:TextBox ID="startDate" CssClass="form-control input-md" TextMode="Date" runat="server"></asp:TextBox>
                        </div>
                        <div class="col-md-4 paddi">
                            <span class="label" style="font-size: larger">End Date</span><br />
                            <asp:TextBox ID="endDate" CssClass="form-control input-md" TextMode="Date" runat="server"></asp:TextBox>
                        </div>
                        <span class="label" style="font-size: larger"></span>
                        <br />
                        <asp:Button ID="Button1" runat="server" CssClass="btn btn-primary" Text="Generate Report" OnClick="Button1_Click" />
                        <div class="row">&nbsp;</div>
                        <asp:Panel ID="panel1" runat="server">
                                <div class="row">
                                    <div class="col-md-6">
                                        <asp:Label CssClass="label" ID="label1" runat="server" Style="font-size: larger">Total Margin Purchased : </asp:Label>
                                        <asp:Label CssClass="label text-danger" ID="lblTotal" runat="server" Style="font-size: larger">Rs. </asp:Label>
                                    </div>
                                    <div class="col-md-6 form-inline">
                                        <asp:Label CssClass="label" ID="label2" runat="server" Style="font-size: larger">Export To : </asp:Label>
                                        <asp:DropDownList ID="DDExportTo" CssClass="form-control" runat="server">
                                            <asp:ListItem>PDF</asp:ListItem>
                                            <asp:ListItem>Excel File</asp:ListItem>
                                            <asp:ListItem>Word File</asp:ListItem>
                                        </asp:DropDownList>
                                        <asp:Button ID="btnExport" runat="server" CssClass="btn btn-primary" Text="Export" OnClick="btnExport_Click" />
                                    </div>
                                </div>
                            </asp:Panel>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="table-responsive">
                    <asp:GridView ID="GridView1" runat="server" CssClass="table table-responsive table-hover table-striped">
                    </asp:GridView>
                </div>
            </div>
            <asp:Label ID="lbl1" runat="server"></asp:Label>
        </div>
    </form>
</body>
</html>
