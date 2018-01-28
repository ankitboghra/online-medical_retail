<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Extra.aspx.cs" Inherits="Extra" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="Required/bootstrap-3.3.7-dist/css/bootstrap.css" rel="stylesheet" />
    <style>
        body {
            padding-top: 55px;
        }

        .paddi {
            padding: 0;
            margin: 0;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>      
            <div class="container-fluid" style="background-color: #99FFFF">
                <div class="row">
                    <div class="col-md-3">
                        <div class="row">
                            <div class="col-md-8" style="background-color: none; padding-right: 1;">
                                <span class="label" style="font-size: small">Product Name</span><br />
                                <asp:DropDownList ID="DropDownList1" runat="server" CssClass="form-control input-md" onchange="fillBatch()"></asp:DropDownList>
                                <span class="label" style="font-size: smaller">Available</span>
                            </div>
                           
                        <div class="col-md-4 paddi" style="background-color: none;">
                            <span class="label" style="font-size: small">Batch</span><br />
                            <asp:DropDownList onchange="fillDatePrice()" CssClass="form-control input-md" ID="DropDownList2" runat="server"></asp:DropDownList>
                            <span class="label" style="font-size: smaller">Available</span>
                        </div>
                        </div>
                        <div class="row">
                            <div class="col-md-3"></div>
                            <div class="col-md-6 paddi" style="background-color: none; text-align: center">
                                <input type="text" id="Text1" style="font-size: x-small" class="form-control input-sm" readonly="true" />
                                <span class="label" style="font-size: small">Expiry</span>
                            </div>
                            <div class="col-md-3"></div>
                        </div>
                    </div>
                    <div class="col-md-2">
                        <div class="row">
                            <div class="col-md-1 paddi"></div>
                            <div class="col-md-5 paddi" style="background-color: none;">
                                <span class="label" style="font-size: small">Size</span><br />
                                <input type="number" class="form-control input-md" /><br />
                            </div>
                            <div class="col-md-5 paddi" style="background-color: none">
                                <span class="label" style="font-size: small">Strip</span><br />
                                <input type="number" class="form-control input-md" /><br />
                            </div>
                            <div class="col-md-1 paddi"></div>
                        </div>
                        <div class="row">
                            <div class="col-md-2 paddi"></div>
                            <div class="col-md-8 paddi" style="background-color: none; text-align: center">

                                <input type="text" class="form-control input-sm" readonly="true" />
                                <span class="label" style="font-size: small">Quantity</span>
                            </div>
                            <div class="col-md-2 paddi"></div>
                        </div>
                    </div>
                    <div class="col-md-2">               
                        <div class="row">         
                            <div class="col-md-6 paddi" style="background-color: none">
                                <span class="label" style="font-size: small">Purchase/Unit</span><br />
                                <input type="text" id="Text2" class="form-control input-md" readonly="true" />
                                
                            </div>
                            <div class="col-md-6 paddi" style="background-color: none">
                                <span class="label" style="font-size: small">MRP</span><br />
                                <input type="text" id="Text3" class="form-control input-md" readonly="true"/>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-3 paddi"></div>
                            <div class="col-md-6 paddi" style="background-color: none; text-align:center;">
                                <br />
                                <input type="text" class="form-control input-sm" readonly="true" />
                                <span class="label" style="font-size: small">Base</span>
                            </div>
                            <div class="col-md-3 paddi"></div>
                        </div>
                    </div>
                    <div class="col-md-2">
                        <%--<div class="panel-body">--%>
                        <div class="row">
                            <div class="col-md-1 paddi"></div>
                            <div class="col-md-10 paddi" style="background-color: none">
                                <span class="label" style="font-size: small">Discount</span><br />
                                <input type="text" class="form-control input-md" placeholder="%" />
                                <%--  <span class="label" style="font-size: small">Adj +/- 0</span>--%>
                            </div>
                            <div class="col-md-1 paddi"></div>                            
                        </div>
                        <div class="row">
                            <div class="col-md-1 paddi"></div>                            
                            <div class="col-md-5 paddi" style="background-color: none">
                                <br />
                                <input type="text" class="form-control input-sm" placeholder="Value" readonly="true" />
                                <span class="label" style="font-size: small">Value</span>
                            </div>
                            <div class="col-md-5 paddi" style="background-color: none">
                                <br />
                                <input type="text" class="form-control input-sm" readonly="true" />
                                <span class="label" style="font-size: small">Net Rate</span>
                            </div>
                            <div class="col-md-1 paddi"></div>                            
                        </div>
                        <%--</div>--%>
                    </div>
                     <%--<div class="col-md-2">
                        <div class="panel-body">
                        <div class="row">
                            <div class="col-md-12 paddi" style="background-color: none">
                                <span class="label" style="font-size: small">Discount</span><br />
                                <input type="text" class="form-control input-sm" placeholder="%" />
                                <span class="label" style="font-size: small">Adj +/- 0</span>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6 paddi" style="background-color: none">
                                <br />
                                <input type="text" class="form-control input-sm" placeholder="Value" readonly="true" />
                                <span class="label" style="font-size: small">Value</span>
                            </div>
                            <div class="col-md-6 paddi" style="background-color: none">
                                <br />
                                <input type="text" class="form-control input-sm" readonly="true" />
                                <span class="label" style="font-size: small">Net Rate</span>
                            </div>
                        </div>
                        </div>
                    </div>--%>
                    <div class="col-md-1">
                        <div class="row">
                            <%--<div class="col-md-1 paddi"></div>--%>
                            <div class="col-md-12 paddi" style="background-color: none">
                                <span class="label" style="font-size: small">TAX</span><br />
                                <input type="text" class="form-control input-md" placeholder="%" /><br />
                            </div>
                        </div>
                        <div class="row">
                            <%--<div class="col-md-1 paddi"></div>--%>
                            <div class="col-md-12 paddi" style="background-color: none">
                                <input type="text" class="form-control input-sm" readonly="true" placeholder="Value" />
                                <span class="label" style="font-size: small">Value</span>
                            </div>                            
                        </div>
                    </div>
                    <div class="col-md-2">
                        <div class="col-md-12 paddi" style="background-color: none">
                            <span class="label" style="font-size: small">Margin Total</span><br />
                            <div class="input-group">
                                <input type="text" class="form-control" aria-describedby="basic-addon2" placeholder="Margin Total" />
                                <span class="input-group-addon input-sm" id="Span1">&#8377;</span>
                            </div>
                        </div>
                    </div>
                </div>               
            </div>
        </div>
    </form>
</body>
</html>
