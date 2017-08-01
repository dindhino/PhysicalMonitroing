<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AppLock.aspx.cs" Inherits="AssetManagement.Views.Application.AppLock" %>

<script runat="server">


    protected void Page_Load(object sender, EventArgs e)
    {

    }
    
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        //if (Session["password"] == txtPassword.Value)
        {
            Response.Redirect("../../Views/Application/PageHome.aspx");
        }
    }
    
</script>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="Allan Prakosa">
    <link rel="shortcut icon" href="../../Scripts/UserPanel/img/favicon.html">

    <title>Lock Screen</title>

    <!-- Bootstrap core CSS -->
    <link href="../../Scripts/UserPanel/bs3/css/bootstrap.min.css" rel="stylesheet">
    <link href="../../Scripts/UserPanel/css/bootstrap-reset.css" rel="stylesheet">
    <!--external css-->
    
    <link href='../../Scripts/UserPanel/assets/font-awesome-4.1.0/css/font-awesome.min.css' rel='stylesheet' />
    <!-- Custom styles for this template -->
    <link href="../../Scripts/UserPanel/css/style.css" rel="stylesheet">
    <link href="../../Scripts/UserPanel/css/style-responsive.css" rel="stylesheet" />
</head>

<body class="lock-screen" onload="startTime()">

    <div class="lock-wrapper">

        <div id="time"></div>


        <div class="lock-box text-center">
            <div class="lock-name">Allan Prakosa</div>
            <img src="../../Scripts/UserPanel/images/al2.jpg" alt="lock avatar"/>
            <div class="lock-pwd">
                <form role="form" class="form-inline" runat="server">
                    <div class="form-group">
                        <input runat="server" type="password" placeholder="Password" id="txtPassword" class="form-control lock-input">
                        <asp:LinkButton runat="server" ID="btnSubmit" class="btn btn-lock" OnClick="btnSubmit_Click">
                            <i class="fa fa-arrow-right"></i>
                        </asp:LinkButton>
                    </div>
                </form>
            </div>

        </div>
    </div>
    <script>
        function startTime() {
            var today = new Date();
            var h = today.getHours();
            var m = today.getMinutes();
            var s = today.getSeconds();
            // add a zero in front of numbers<10
            m = checkTime(m);
            s = checkTime(s);
            document.getElementById('time').innerHTML = h + ":" + m + ":" + s;
            t = setTimeout(function () { startTime() }, 500);
        }

        function checkTime(i) {
            if (i < 10) {
                i = "0" + i;
            }
            return i;
        }
    </script>
</body>
</html>
