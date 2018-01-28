<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Error.aspx.cs" Inherits="Error" %>

<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Error</title>
    <link href="Required/bootstrap-3.3.7-dist/css/bootstrap.css" rel="stylesheet" />
    <script src="Required/bootstrap-3.3.7-dist/js/jquery.js"></script>
    <script src="Required/bootstrap-3.3.7-dist/js/bootstrap.js"></script>
    
</head>
<body>
    <div class="container" style="margin-top:100px;">
        <div class="row">
            <div class="col-md-5 col-md-offset-2">
                <h1 style="color:#0094ff;font-size:100px;">Oops!</h1>
                <h2>Something went Wrong..</h2>
                <h5>Try Again..</h5>
                <ul class="list-unstyled">
                    <li>Here are some helpful links :</li>
                    <li>
                        <h4><u><b><a href="CustomerDashBoard.aspx">Back To DashBoard</a></b></u></h4>
                    </li>
                </ul>
            </div>

            <div class="col-md-4">
                <img src="Error.gif" width="313" height="428" alt="Something went wrong..">
            </div>
        </div>
    </div>
</body>
</html>
