<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Purchase.aspx.cs" Inherits="Purchase" ViewStateEncryptionMode="Never" validateRequest="false" EnableEventValidation="false" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Purchase</title>
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
    <script>
        function fillBatch() {
            var proId = document.getElementById("productName").value.toString();
            //alert(proId);
            if (proId != "-Select-") {
                var x = new XMLHttpRequest();
                x.open("POST", "ClientSide.aspx?id=" + proId + "&c=" + 1, false);
                x.send(null);
                var str = x.responseText;
                document.getElementById("batch").innerHTML = str.slice(0, str.search("-End1-"));
                document.getElementById("txtSize").value = 10;
                document.getElementById("txtStrip").value = 1;
                document.getElementById("txtQty").value = 10;
                document.getElementById("txtPPU").value = 0;
                document.getElementById("txtMRPperUnit").value = 0;
                document.getElementById("txtMRP").value = 0;
                document.getElementById("txtDiscountValue").value = 0;
                document.getElementById("txtDiscountPer").value = 0;
                document.getElementById("txtBasePPU").value = 0;
                document.getElementById("txtNetRate").value = 0;
                document.getElementById("txtTaxValue").value = 0;
                document.getElementById("txtMargin").value = 0;
                fillDatePrice();
                getCount(proId);
                setprices();
                setdiscount();
            }
            if (proId == "-Select-") {
                document.getElementById("batch").innerHTML = "";
                document.getElementById("txtSize").value = 10;
                document.getElementById("txtStrip").value = 1;
                document.getElementById("txtQty").value = 10;
                document.getElementById("txtPPU").value = 0;
                document.getElementById("txtMRP").value = 0;
                document.getElementById("txtMRPperUnit").value = 0;
                document.getElementById("txtDiscountValue").value = 0;
                document.getElementById("txtDiscountPer").value = 0;
                document.getElementById("txtBasePPU").value = 0;
                document.getElementById("txtNetRate").value = 0;
                document.getElementById("txtTaxValue").value = 0;
                document.getElementById("txtMargin").value = 0;
                document.getElementById("txtExpiry").value = 0;
            }
        }

        function getCount(pro) {
            var x = new XMLHttpRequest();
            x.open("POST", "ClientSide.aspx?id=" + pro + "&c=" + 3, false);
            x.send(null);
            document.getElementById("total_qty").textContent = x.responseText;
        }
        function fillDatePrice() {
            var x = new XMLHttpRequest();
            var proId = document.getElementById("productName").value.toString();
            var batch = document.getElementById("batch").value.toString();
            document.getElementById("hiddenBatch").value = batch;
            x.open("POST", "ClientSide.aspx?id=" + proId + "&batch=" + batch + "&c=" + 2, false);
            x.send(null);
            var str = x.responseText;
            document.getElementById("txtExpiry").value = str.slice(0, str.search("-End1-"));
            document.getElementById("hiddenExpiry").value = document.getElementById("txtExpiry").value;
            document.getElementById("hiddenPPU").value = str.slice(str.search("-End1-") + 6, str.search("-End2-"));
            document.getElementById("hiddenMRPperUnit").value = str.slice(str.search("-End2-") + 6, str.search("-End3-"));
            var y = new XMLHttpRequest();
            y.open("POST", "ClientSide.aspx?id=" + proId + "&batch=" + batch + "&c=" + 4, false);
            y.send(null);
            document.getElementById("total_per_batch").textContent = y.responseText;
        }
        function getqty() {
            var si = parseInt(document.getElementById("txtSize").value);
            var st = parseInt(document.getElementById("txtStrip").value);
            document.getElementById("txtQty").value = parseInt(si * st);
            document.getElementById("hiddenQty").value = document.getElementById("txtQty").value;
            setprices();
            setdiscount();
        }
        function setprices() {
            var ppu = parseFloat(document.getElementById("hiddenPPU").value);
            var mrp = parseFloat(document.getElementById("hiddenMRPperUnit").value);
            var qty = document.getElementById("txtQty").value;
            document.getElementById("txtPPU").value = ppu;
            document.getElementById("txtMRPperUnit").value = mrp;
            document.getElementById("txtBasePPU").value = (parseFloat(ppu * qty)).toFixed(2);
            document.getElementById("txtMRP").value = (parseFloat(mrp * qty)).toFixed(2);
        }
        function setdiscount() {
            var mrp = parseFloat(document.getElementById("txtMRP").value);
            var discount = parseFloat(document.getElementById("txtDiscountPer").value);
            document.getElementById("hiddenDiscountPer").value = discount;
            document.getElementById("txtDiscountValue").value = (parseFloat((discount / 100) * mrp)).toFixed(2);
            document.getElementById("hiddenDiscountValue").value = document.getElementById("txtDiscountValue").value;
            document.getElementById("txtNetRate").value = (parseFloat(mrp - ((discount / 100) * mrp))).toFixed(2);
            setmargin();
        }
        function setmargin() {
            var net = parseFloat(document.getElementById("txtNetRate").value);
            var tax = parseFloat(document.getElementById("DDTax").value);
            getadditional();
            var taxA = parseFloat(document.getElementById("lbladditional").textContent);
            tax = tax + taxA;
            document.getElementById("hiddenTAX").value = tax;
            var taxval = document.getElementById("txtTaxValue").value = ((tax / 100) * net).toFixed(2);
            document.getElementById("txtMargin").value = (parseFloat(net) + parseFloat(taxval)).toFixed(2);
            document.getElementById("hiddenMargin").value = document.getElementById("txtMargin").value;
        }

        $(document).ready(function () {
            $('[data-toggle="popover"]').popover();
        });

        //$("#productName").trigger('fillBatch()');

        function getadditional() {
            var Taxvalue = document.getElementById("DDTax").value.toString();
            var y = new XMLHttpRequest();
            y.open("POST", "ClientSide.aspx?taxvalue=" + Taxvalue + "&c=" + 6, false);
            y.send(null);
            document.getElementById("lbladditional").textContent = y.responseText;
        }
        function addTempRecord() {
            //alert("start");
            //var proId = document.getElementById("productName").value.toString();
            var x = new XMLHttpRequest();
            x.open("POST", "ClientSide.aspx?id=" + proId + "&c=" + 6, false);
            x.send(null);
            //alert("done");
        }
        function fillsupplierinfo()
        {
            var sId = document.getElementById("DDSupplier").value.toString();
            var x = new XMLHttpRequest();
            x.open("POST", "ClientSide.aspx?id=" + sId + "&c=" + 7, false);
            x.send(null);
            var str = x.responseText;
            document.getElementById("txtsupplierMP").value = str.slice(0, str.search("-End1-"));
            document.getElementById("txtAddress").value = str.slice(str.search("-End1-") + 6, str.search("-End2-"));
            document.getElementById("HiddensupplierMP").value = str.slice(0, str.search("-End1-"));
            document.getElementById("HiddenSAdd").value = str.slice(str.search("-End1-") + 6, str.search("-End2-"));
        }
    </script>
</head>
<body style="background-color: #55FFFF">
    <form id="form3" runat="server" action="Purchase.aspx">
        <asp:ScriptManager ID="ScriptManager1" runat="server">
            
        </asp:ScriptManager>
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
                        <%--<li class="active"><a href="#">Link <span class="sr-only">(current)</span></a></li>--%>
                        <%--<li><a href="#">Add</a></li>
                        <li><a href="#">Edit</a></li>
                        <li><a href="#">Save</a></li>
                        <li><a href="#">Delete</a></li>
                        <li><a href="#">Cancel</a></li>--%>
                        <li><a href="CustomerDashBoard.aspx">Back To DashBoard</a></li>                        
                        <%--<li class="dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Display Sales<span class="caret"></span></a>
                            <ul class="dropdown-menu">                               
                                <li><a href="#">Action</a></li>
                                <li><a href="#">Another action</a></li>
                                <li><a href="#">Something else here</a></li>
                                <li role="separator" class="divider"></li>
                                <li><a href="#">Separated link</a></li>
                            </ul>
                        </li>--%>
                        <li><a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Add People<span class="caret"></span></a>
                            <ul class="dropdown-menu">
                                <li><a href="#" data-toggle="modal" data-target="#DoctorModal">Add Doctor</a></li>
                                <li><a href="#" data-toggle="modal" data-target="#PatientModel">Add Patient</a></li>
                                
                            </ul>
                        </li>
                    </ul>
                    <ul class="nav navbar-nav navbar-right">
                        <a class="navbar-brand" href="Logout.aspx">Log Out</a>
                        <li class="navTotal">
                            <%--<h4>Total : 0</h4> <h5> Sales : 0</h5>--%>
                            <h3>&nbsp;&nbsp;&nbsp;&nbsp;
                                Total : <asp:Label ID="lblTotal" runat="server" Text="0"></asp:Label> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
                                Sales : <asp:Label ID="lblSales" runat="server" Text="0"></asp:Label>  &nbsp;&nbsp;&nbsp;&nbsp;
                            </h3>
                        </li>
                    </ul>
                </div>
                <!-- /.navbar-collapse -->
            </div>
            <!-- /.container-fluid -->
        </nav>
        <div>   
            <%--<div class="text-center">Sales</div>--%>
            <div class="panel-body" style="background-color: #55FFFF">
                <div class="container-fluid" style="background-color: #55FFFF"><%--#55FFFF--%>
                <div class="row">
                    <%--<div class="col-md-offset-1"></div>--%>
                    <div class="col-md-9" style="background-color: none">
                        <div class="row">
                            <div class="col-md-2" style="background-color: none;">
                                <span class="label sml">Purchase</span>
                                <asp:TextBox ID="txtSalesID" class="form-control input-sm" ReadOnly="true" placeholder="Sales" runat="server"></asp:TextBox><br/>
                            </div>
                            <div class="col-md-3" style="background-color: none">
                                <span class="label sml">Purchase Date</span>
                                <asp:TextBox ID="txtDate" TextMode="Date" class="form-control input-sm" runat="server" ViewStateMode="Inherit" AutoPostBack="false"></asp:TextBox><br/>
                   
                            </div>
                            <div class="col-md-2" style="background-color: none">
                                <span class="label sml">Book Code</span>
                              <%--  <div class="dropdown">
                                    <select class="selectpicker form-control input-sm">
                                        <option data-icon="gl">Book 1</option>
                                        <option>Book 2</option>
                                        <option>Book 3</option>
                                    </select>
                                </div>--%>
                                <asp:DropDownList CssClass="form-control input-sm" ID="DDbook" runat="server">                                    
                                </asp:DropDownList>

                            </div>
                            <div class="col-md-2" style="background-color: none">
                                <span class="label sml">Type</span>
                                <asp:DropDownList CssClass="form-control input-sm" ID="DDPaymentType" runat="server">
                                </asp:DropDownList>
                            </div>
                            <%--<div class="col-md-3" style="background-color: none">
                                <span class="label sml">Doctor</span>
                                <asp:DropDownList CssClass="form-control input-sm" ID="DDDoctors" runat="server">
                                    
                                </asp:DropDownList>
                            </div>--%>
                        </div>
                        <div class="row">
                            <div class="col-md-5" style="background-color: none">
                                <span class="label sml">Firm Name (Supplier)</span>
                                <asp:DropDownList ID="DDSupplier" onchange="fillsupplierinfo();" CssClass="form-control input-sm" runat="server" >
                                </asp:DropDownList>                                
                                <%--<asp:TextBox class="form-control input-sm" placeholder="Patient Number" runat="server"></asp:TextBox>--%><br/>
                            </div>
                            <div class="col-md-4" style="background-color: none">
                                <span class="label sml">Supplier Main Person</span>
                                <asp:TextBox class="form-control input-sm" ID="txtsupplierMP" placeholder="Supplier Main Person" runat="server" ReadOnly="true"></asp:TextBox><br/>
                                <asp:HiddenField ID="HiddensupplierMP" runat="server" />
                            </div>
                            <div class="col-md-3" style="background-color: none">
                                <asp:TextBox ID="txtAddress" class="form-control" rows="3" placeholder="Address" runat="server" TextMode="MultiLine" ReadOnly="true"></asp:TextBox>                              
                                <asp:HiddenField ID="HiddenSAdd" runat="server" />
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3" style="background-color: none">                       
                        <div class="row">
                            <%--Empty Space--%>
                        &nbsp;
                        </div>
                        <%--<div class="row">
                            <div class="col-md-6 col-sm-6">
                                <label class="checkbox-inline">
                                    <asp:CheckBox ID="CheckBox3" runat="server" value="Sales"/>                                    
                                    <span class="label">Sales</span>
                                </label>
                            </div>
                            <div class="col-md-6  col-sm-6">
                                <label class="checkbox-inline">
                                    <asp:CheckBox ID="CheckBox6" runat="server" value="Loose"/>                                   
                                    <span class="label">Loose</span>
                                </label>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12  col-sm-6">
                                <label class="checkbox-inline">
                                    <asp:CheckBox ID="CheckBox1" value="TaxAfterScheme" runat="server" />
                                    <span class="label">Tax After Scheme</span>
                                </label>
                            </div>
                            <div class="col-md-12  col-sm-6">
                                <label class="checkbox-inline">
                                    <asp:CheckBox ID="CheckBox2" value="VatLumpsum" runat="server" />
                                    <span class="label">Vat/Lumpsum</span>
                                </label>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-10">
                                <div class="input-group">
                                    <span class="input-group-addon">Fix Discount</span>
                                    <asp:TextBox class="form-control input-sm" ID="txtfixDiscount" aria-label="Amount (to the nearest dollar)" runat="server"></asp:TextBox>
                                    <span class="input-group-addon">%</span>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12  col-sm-6">
                                <label class="checkbox-inline">
                                    <asp:CheckBox ID="CheckBox4" value="SalesReturn" runat="server" />                                    
                                    <span class="label">Sales Return</span>
                                </label>
                            </div>
                        </div>
                        <div class="row">
                            <span class="label">Return Number : </span>
                        </div>
                    </div>--%>
                </div>
            </div>
            </div>
            <div class="panel-body" style="background-color: #55FFFF">
                <div class="container-fluid" style="background-color: #55FFFF">
                <div class="row">
                    <div class="col-md-3">
                        <div class="row">
                           <%-- --%>
                                    <%--PRODUCT-NAME--%>
                                    <div class="col-md-8" style="background-color: none; padding-right: 1;">
                                        <div>
                                            <div>
                                                <span class="label" style="font-size: small">Product Name</span><br />
                                                <asp:DropDownList ID="productName" onchange="fillBatch();" runat="server" CssClass="form-control input-md" AutoPostBack="False">
                                                    <%--OnSelectedIndexChanged="productName_SelectedIndexChanged"--%>
                                                    <%--onchange="fillBatch();"--%>
                                                    <asp:ListItem>-Select-</asp:ListItem>
                                                </asp:DropDownList>                                         
                                                <span class="label" style="font-size: smaller" tabindex="-1"><a href="#" data-toggle="popover" title="Total Available Products in Stock!" data-placement="right" data-trigger="hover" tabindex="-1">Available:</a></span><asp:Label ID="total_qty" runat="server" Font-Size="Smaller"></asp:Label>
                                            </div>                                            
                                         </div>
                                    </div>
                                    <%--BATCH--%>
                            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                <Triggers>
                                    <asp:AsyncPostBackTrigger ControlID="productName" EventName="SelectedIndexChanged" />
                                </Triggers>
                                <ContentTemplate>
                                    <div class="col-md-4 paddi" style="background-color: none;">
                                        <span class="label" style="font-size: small">Batch</span><br />
                                        <asp:DropDownList ID="batch" onchange="fillDatePrice();" CssClass="form-control input-md" runat="server">
                                        </asp:DropDownList>
                                        <asp:HiddenField ID="hiddenBatch" Value=" " runat="server" />
                                        <span class="label" style="font-size: smaller" tabindex="-1"><a href="#" data-toggle="popover" title="Total Available Products in selected Batch!" data-placement="right" data-trigger="hover" tabindex="-1">Available:</a></span><asp:Label ID="total_per_batch" runat="server" Font-Size="Smaller"></asp:Label>
                                    </div>
                               </ContentTemplate>
                            </asp:UpdatePanel>
                        </div>
                        <div class="row">
                            <%--EXPIRY--%>
                            <div class="col-md-3"></div>
                            <div class="col-md-6 paddi" style="background-color: none; text-align: center">
                                <asp:TextBox ID="txtExpiry" runat="server" style="font-size: small; text-align:center " cssclass="form-control input-sm" readonly="true" tabindex="-1"></asp:TextBox>                                
                                <span class="label" style="font-size: small">Expiry</span>
                                <asp:HiddenField ID="hiddenExpiry" Value="0" runat="server" />
                            </div>
                            <div class="col-md-3"></div>
                        </div>
                    </div>
                    <div class="col-md-2">
                        <div class="row">
                            <div class="col-md-1 paddi"></div>
                            <%--SIZE--%>
                            <div class="col-md-5 paddi" style="background-color: none;">
                                <span class="label" style="font-size: small">Size</span><br/>                               
                                <asp:TextBox ID="txtSize" value="10" onkeyup="getqty()" cssclass="form-control input-md" runat="server" TextMode="Number"></asp:TextBox>
                            </div>
                            <%--STRIP--%>
                            <div class="col-md-5 paddi" style="background-color: none">
                                <span class="label" style="font-size: small">Strip</span><br/>
                                <asp:TextBox ID="txtStrip" runat="server" value="1" onkeyup="getqty()" cssclass="form-control input-md" TextMode="Number"></asp:TextBox><br/>
                            </div>
                            <div class="col-md-1 paddi"></div>
                        </div>
                        <%--QUANTITY--%>
                        <div class="row">                            
                            <div class="col-md-2 paddi"></div>
                            <div class="col-md-8 paddi" style="background-color: none; text-align: center">
                                <asp:TextBox ID="txtQty" runat="server" cssclass="form-control input-sm" onkeyup="setprices()" TabIndex="-1" ReadOnly="true"></asp:TextBox>                                
                                <span class="label" style="font-size: small">Quantity</span>
                                <asp:HiddenField ID="hiddenQty" Value="0" runat="server"/>
                            </div>
                            <div class="col-md-2 paddi"></div>
                        </div>
                    </div>
                    <div class="col-md-2">
                        <div class="row">         
                             <%--PURCHASE PER UNIT--%> 
                            <div class="col-md-6 paddi" style="background-color: none">
                                <span class="label" style="font-size: small">Purchase/Unit</span><br />
                                <asp:TextBox ID="txtPPU" runat="server" cssclass="form-control input-md" readonly="true" tabindex="-1"></asp:TextBox>                                
                                <%--Purchase Per Unit--%>
                                <asp:HiddenField ID="hiddenPPU" Value="0" runat="server"/>
                            </div>
                            <%--MRP--%>
                            <div class="col-md-6 paddi"  style="background-color: none;">
                                <span class="label" style="font-size: small">MRP/Unit</span><br/>                                
                                <asp:TextBox ID="txtMRPperUnit" CssClass="form-control" readonly="true" tabindex="-1" runat="server"></asp:TextBox>
                                <%--MRP per Unit in the hidden Field!--%>
                                <asp:HiddenField ID="hiddenMRPperUnit" Value="0" runat="server"/>
                            </div>
                        </div>
                        <%--BASE--%>
                        <div class="row">
                            <div class="col-md-6 paddi" style="background-color: none; text-align:center;">
                                <br />
                                <asp:TextBox ID="txtBasePPU" runat="server" cssclass="form-control input-sm" readonly="true" tabindex="-1"></asp:TextBox>
                                <span class="label" style="font-size: small">Base</span>
                            </div>
                            <%--MRP--%>
                            <div class="col-md-6 paddi" style="background-color: none; text-align: center">
                                <br/>                                
                                <asp:TextBox ID="txtMRP" CssClass="form-control input-sm" readonly="true" tabindex="-1" runat="server"></asp:TextBox>
                                <span class="label" style="font-size: small;">MRP</span>
                                <%--MRP per Unit in the hidden Field!--%>
                                <asp:HiddenField ID="HiddenField1" Value="0" runat="server"/>
                            </div>
                        </div>
                    </div>
                    <%--DISCOUNT--%>
                    <div class="col-md-2">                       
                        <div class="row">
                            <div class="col-md-1 paddi"></div>
                            <div class="col-md-10 paddi" style="background-color: none">
                                <span class="label" style="font-size: small">Discount</span><br />
                                <div class="input-group">
                                    <asp:TextBox ID="txtDiscountPer" onkeyup="setdiscount()" value="0" class="form-control input-md" runat="server" ViewStateMode="Inherit" TextMode="SingleLine"></asp:TextBox>
                                    <span class="input-group-addon">%</span>
                                    <asp:HiddenField ID="hiddenDiscountPer" Value="0" runat="server" />
                                </div>
                                
                                <%--  <span class="label" style="font-size: small">Adj +/- 0</span>--%>
                            </div>
                            <div class="col-md-1 paddi"></div>                            
                        </div>                        
                        <div class="row">
                            <%--DISCOUNT-VALUE--%>
                            <div class="col-md-1 paddi"></div>                            
                            <div class="col-md-5 paddi" style="background-color: none">
                                <br />
                                <asp:TextBox ID="txtDiscountValue" cssclass="form-control input-sm" placeholder="Value" readonly="true" tabindex="-1" runat="server"></asp:TextBox>
                                <span class="label" style="font-size: small">Value</span>
                                <asp:HiddenField ID="hiddenDiscountValue" Value="0" runat="server" />
                            </div>
                            <%--NET-RATE--%>
                            <div class="col-md-5 paddi" style="background-color: none">
                                <br/>
                                <asp:TextBox ID="txtNetRate" cssclass="form-control input-sm" readonly="true" tabindex="-1" runat="server"></asp:TextBox>
                                <span class="label" style="font-size: small">Net Rate</span>
                            </div>
                            <div class="col-md-1 paddi"></div>                            
                        </div>                        
                    </div>
                    <%--Tax--%>
                    <div class="col-md-1">
                        <div class="row">
                            <div class="col-md-12 paddi" style="background-color: none">
                                <span class="label" style="font-size: small">TAX</span>
                                <asp:DropDownList ID="DDTax" CssClass="form-control input-md" onchange="setmargin()" runat="server"></asp:DropDownList>
                                <span class="label" style="font-size: smaller" tabindex="-1"><a href="#" data-toggle="popover" title="Additional Tax" data-placement="right" data-trigger="hover" tabindex="-1">Add:</a><asp:Label ID="lbladditional" runat="server" Font-Size="Small" Text="0"></asp:Label>%</span>
                                <asp:HiddenField ID="hiddenTAX" Value="0" runat="server"/>                                
                            </div>
                            <%--<asp:TextBox ID="txtTaxPer" onkeypress="enterInDataGrid()" value="0" onkeyup="setmargin()" cssclass="form-control input-md" min="0" max="100" runat="server" TextMode="Number"></asp:TextBox>--%>
                        </div>
                        <div class="row">
                            <%--Tax-Value--%>
                            <div class="col-md-12 paddi" style="background-color: none">                                
                                <asp:TextBox ID="txtTaxValue" cssclass="form-control input-sm" readonly="true" placeholder="Value" tabindex="-1" runat="server"></asp:TextBox>
                                <span class="label" style="font-size: small">Value</span>
                            </div>                            
                        </div>
                    </div>
                    <%--Margin-Total--%>
                    <div class="col-md-2">
                        <div class="col-md-12 paddi" style="background-color: none">
                            <span class="label" style="font-size: small">Margin Total</span><br />
                            <div class="input-group">                                
                                <asp:TextBox ID="txtMargin" CssClass="form-control" aria-describedby="basic-addon2" placeholder="Margin Total" tabindex="-1" runat="server" OnTextChanged="txtMargin_TextChanged" ReadOnly="true"></asp:TextBox>
                                <span class="input-group-addon input-sm" id="Span1">&#8377;</span>
                                <asp:HiddenField ID="hiddenMargin" Value="0" runat="server"/>
                            </div>
                            <br />
                            <div class="row">
                                <div class="col-md-6" align="center">
                                    <%--<input type="button" class="form-control" value="ADD" onclick="addTempRecord()" />--%>
                                    <%--<asp:Button ID="Button1" CssClass="form-control" runat="server" Text="ADD" OnClick="Button1_Click1" />--%>
                                    <asp:Button ID ="txtBtn" CssClass="form-control" runat ="server" Text ="ADD" OnClick ="txtBtn_Click" CausesValidation ="false"  />
                                </div>
                                <div class="col-md-6" align="center">
                                    <asp:Button ID="btndelete" CssClass="form-control" runat="server" Text="Clear" OnClick="btndelete_Click" /></div>
                            </div>
                        </div>
                    </div>
                </div>               
            </div>
            </div>
            <div class="container-fluid" style="background-color: #55FFFF">
                <div class="row">
                       <%--Data Grid--%>
                    <div class="col-md-12 table-responsive">
                        <asp:GridView ID="GridView3" Width="100%" CssClass="table table-striped table-bordered table-hover" ShowHeaderWhenEmpty="True" runat="server" BackColor="White" BorderColor="#DEDFDE" BorderStyle="None" BorderWidth="1px" CellPadding="4" ForeColor="Black" GridLines="Vertical" OnSelectedIndexChanging="GridView3_SelectedIndexChanging" OnRowCancelingEdit="GridView3_RowCancelingEdit" OnRowEditing="GridView3_RowEditing" OnRowUpdating="GridView3_RowUpdating" OnRowDeleting="GridView3_RowDeleting">
                            <AlternatingRowStyle BackColor="White" />
                            <Columns>
                                <asp:CommandField ShowEditButton="True" />
                                <asp:CommandField ShowDeleteButton="True"/>
                            </Columns>
                            <FooterStyle BackColor="#CCCC99" />
                            <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
                            <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Right" />
                            <RowStyle BackColor="#F7F7DE" />
                            <SelectedRowStyle BackColor="#CE5D5A" Font-Bold="True" ForeColor="White" />
                            <SortedAscendingCellStyle BackColor="#FBFBF2" />
                            <SortedAscendingHeaderStyle BackColor="#848384" />
                            <SortedDescendingCellStyle BackColor="#EAEAD3" />
                            <SortedDescendingHeaderStyle BackColor="#575357" />                          
                        </asp:GridView>
                    </div>
                </div>
            </div>
            <div id="additions"></div>
            <div class="container-fluid" style="background-color: #55FFFF">
                <div class="row">
                    <div class="col-md-offset-4 col-md-4" align="center">                        
                        <asp:Button ID="btnGenerate" CssClass="btn btn-success" runat="server" Text="Generate Bill" OnClick="btnGenerate_Click" Font-Size="Medium"/>
                    </div>
                </div>
            </div>
        </div>  
        </div>
        <asp:Label ID="lblmsg" runat="server" Text=""></asp:Label>
       <%-- <!-- Modal Doctor -->
        <div class="modal fade" id="DoctorModal" role="dialog">
            <div class="modal-dialog modal-md">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Add Doctor</h4>
                    </div>
                    <div class="modal-body">
                        <div class="form-group">
                            <span class="label sml">Doctor Name</span>
                            <asp:TextBox ID="txtdocname" CssClass="form-control input-sm" runat="server"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <span class="label sml">Qualification</span>
                            <asp:TextBox ID="txtqualification" CssClass="form-control input-sm" runat="server"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <span class="label sml">Address</span>
                            <asp:TextBox ID="txtdocaddress" CssClass="form-control input-sm" runat="server" TextMode="MultiLine"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <span class="label sml">Contact No</span>
                            <asp:TextBox ID="txtdoccontact" CssClass="form-control input-sm" runat="server" TextMode="Number"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <span class="label sml">Hospital</span>
                            <asp:TextBox ID="txtdocHospital" CssClass="form-control input-sm" runat="server"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <span class="label sml">Hospital Address</span>
                            <asp:TextBox ID="txtdochospitaladd" CssClass="form-control input-sm" runat="server" TextMode="MultiLine"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <span class="label sml">Hospital Contact</span>
                            <asp:TextBox ID="txtdochostitalcontactno" CssClass="form-control input-sm" runat="server" TextMode="Number"></asp:TextBox>
                        </div>
                        <div align="center"><asp:Button ID="btndoc" CssClass="btn btn-success" runat="server" Text="Add Doctor" OnClick="btndoc_Click" /></div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>
        <!-- Modal Patient -->
        <div class="modal fade" id="PatientModel" role="dialog">
            <div class="modal-dialog modal-md">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Add Patient</h4>
                    </div>
                    <div class="modal-body">
                        <div class="form-group">
                            <span class="label sml">Patient Name</span>
                            <asp:TextBox ID="txtpaientname" CssClass="form-control input-sm" runat="server"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <span class="label sml">Patient Contact No</span>
                            <asp:TextBox ID="txtpatientcontact" CssClass="form-control input-sm" min="0" runat="server" TextMode="Number"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <span class="label sml">Pending Amount</span>
                            <asp:TextBox ID="txtpending" CssClass="form-control input-sm" min="0" runat="server" TextMode="Number"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <span class="label sml">Address</span>
                            <asp:TextBox ID="txtpatientaddress" CssClass="form-control input-sm" runat="server" TextMode="MultiLine"></asp:TextBox>
                        </div>                  
                        <div class="form-group">
                            <span class="label sml">Email Address</span>
                            <asp:TextBox ID="txtpatientEmail" CssClass="form-control input-sm" runat="server" TextMode="Email"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <span class="label sml">Date Of Birth</span>
                            <asp:TextBox ID="txtpatientDate" CssClass="form-control input-sm" runat="server" TextMode="Date"></asp:TextBox>
                        </div>      
                        <div align="center"><asp:Button ID="btnaddpatient" CssClass="btn btn-success" runat="server" Text="Add Patient" OnClick="btnaddpatient_Click"/></div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>--%>
        <asp:Label ID="Label1a" runat="server" Text="" Visible="false"></asp:Label>
        <asp:Button ID="Button1" runat="server" Text="Button" OnClick="Button1_Click" Visible="false"/>
    </form>
</body>
</html>
