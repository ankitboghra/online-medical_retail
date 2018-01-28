<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
<%--    <script src="Scripts/bootstrap.js"></script>
    <script src="Scripts/jquery-1.9.1.js"></script>
    <link href="Content/bootstrap.css" rel="stylesheet" />--%>
    <link href="Content/background.css" rel="stylesheet" />
    <link href="Required/bootstrap-3.3.7-dist/css/bootstrap.css" rel="stylesheet" />
    <script src="Required/bootstrap-3.3.7-dist/js/jquery.js"></script>
    <script src="Required/bootstrap-3.3.7-dist/js/bootstrap.js"></script>
</head>
<body style="margin-top: 75px;">
    <div class="container">
        <div class="row">
            <div class="col-lg-offset-4 col-md-4">
                <form id="login" runat="server">
                    <div class="p">
                        <div class="row">
                            <div class="col-md-offset-1 col-md-10" style="text-align: center; box-shadow: inset;">
                                <img src="Image/user.png" style="width: 200px; height: 200px; border-radius: 200px;" />
                            </div>
                        </div>
                        <br />
                        <br />
                        <div class="row">
                            <div class="col-md-offset-1 col-md-10">
                                <asp:TextBox ID="txtusername" runat="server" CssClass="form-control" Placeholder="Username" OnTextChanged="txtusername_TextChanged"></asp:TextBox>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-offset-1 col-md-10">
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="* Username is required" Font-Bold="True" Font-Italic="True" Font-Names="Calibri" ForeColor="Red" ControlToValidate="txtusername"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        <br />
                        <div class="row">
                            <div class="col-md-offset-1 col-md-10">
                                <asp:TextBox ID="txtpassword" runat="server" CssClass="form-control" Placeholder="Password" TextMode="Password"></asp:TextBox>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-offset-1 col-md-10">
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="* Password is required" Font-Bold="True" Font-Italic="True" Font-Names="Calibri" ForeColor="Red" ControlToValidate="txtpassword"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        <br />
                        <div class="row">
                            <div class="col-md-offset-1 col-md-10">
                                <asp:Label ID="Show" runat="server" Font-Bold="True" Font-Italic="True" Font-Names="Calibri" ForeColor="Red" Font-Size="Medium"></asp:Label>
                            </div>
                        </div>
                        <br />
                        <div class="row">
                            <div class="col-md-offset-1 col-md-10">
                                <asp:Button ID="btnlogin" runat="server" Text="Login" CssClass="btn btn-success form-control" OnClick="btnlogin_Click" />
                            </div>
                        </div>
                        <br />
                        <div class="row">
                            <div class="col-md-offset-1 col-md-10 text-center">
                                <a href="Pass.aspx" style="font-style: italic oblique; Font-Size: Medium; font-family: Calibri; color: red;"><b>Forgot Password??</b></a>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</body>
</html>
