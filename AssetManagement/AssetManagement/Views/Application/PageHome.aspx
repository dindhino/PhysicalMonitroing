<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PageHome.aspx.cs" Inherits="AssetManagement.Views.Application.PageHome" %>

<%@ Import Namespace="System.Web.Configuration" %>

<!DOCTYPE html>
<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        Request.Cookies.Clear();

        if (!IsPostBack)
        {
            if (Request.QueryString["logout"] != null)
            {
                WebConfigurationManager.AppSettings["UserMenu"] = "";
                Session.Clear();
            }
        }
    }
</script>
<html lang="en">
<head>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
    <meta content="width=device-width, initial-scale=1" name="viewport" />
    <title>Asset Management</title>
    <!-- Bootstrap -->
    <link href="Scripts/assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <link href="Scripts/assets/css/jasny-bootstrap.min.css" rel="stylesheet" type="text/css" />
    <!-- Main Style -->
    <link href="Scripts/assets/css/main.css" rel="stylesheet" type="text/css" />
    <!-- Responsive Style -->
    <link href="Scripts/assets/css/responsive.css" rel="stylesheet" type="text/css" />
    <!--Fonts-->
    <link href="Scripts/assets/fonts/font-awesome/font-awesome.min.css" media="screen" rel="stylesheet" />
    <!-- Extras -->
    <link href="Scripts/assets/extras/animate.css" rel="stylesheet" type="text/css" />
    <link href="Scripts/assets/extras/lightbox.css" rel="stylesheet" type="text/css" />
    <link href="Scripts/assets/extras/owl/owl.carousel.css" rel="stylesheet" type="text/css" />
    <link href="Scripts/assets/extras/owl/owl.theme.css" rel="stylesheet" type="text/css" />
    <link href="Scripts/assets/extras/owl/owl.transitions.css" rel="stylesheet" type="text/css" />
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
                <script src="Scripts/https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
                <script src="Scripts/https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
              <![endif]-->
</head>
<body>
    <!-- Header Section Start -->
    <div id="header">
        <div class="container">
            <div class="col-md-12 top-header"></div>

            <div class="row">
                <div class="col-md-12">
                    <form runat="server" class="banner text-center">
                        <h1 class="wow fadeInDown animated" data-wow-delay=".8s">Bio Farma Asset Management</h1>

                        <h2 class="wow fadeInDown animated" data-wow-delay=".6s">To help you manage the company asset. Please see our FAQ for further information.</h2>
                        <asp:LinkButton runat="server" ID="btnMultimedia" class="btn btn-border lg wow fadeInLeft animated" data-wow-delay="1.0s" OnClick="" Text="Login"></asp:LinkButton>
                        <asp:LinkButton runat="server" ID="btnApplication" class="btn btn-common lg wow fadeInRight animated" data-wow-delay="1.0s" OnClick=""  Text="Application Center"></asp:LinkButton>

                        <div align="center" class="scroll">
                            <div style="width: 130px; height: 130px;">
                                <img alt="logo" class="wow fadeInUp animated" data-wow-delay="1.2s" src="Scripts/assets/img/logo.png" style="width: 100%; height: 100%;" /></div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <!-- Header Section End -->
    <!-- Footer section Start -->

    <footer id="footer">
        <div class="container">
            <div class="row" style="margin-top: 5px;">
                <div class="col-lg-5 col-md-5 col-sm-5 col-xs-12">
                    <div class="copyright wow fadeInUp animated" data-wow-delay=".8s">
                        <p align="center">Copyright &copy; 2015 AIVOW | All rights reserved</p>
                    </div>
                </div>

                <div class="col-lg-2 col-md-2 col-sm-2 col-xs-12"></div>

                <div class="col-lg-5 col-md-5 col-sm-5 col-xs-12">
                    <p class="text-center wow fadeInUp animated" data-wow-delay=".8s">Developed by AIVOW</p>
                </div>
            </div>
        </div>
    </footer>
    <!-- Footer section End -->
    <!-- jQuery Load -->
    <script src="Scripts/assets/js/jquery-min.js"></script>
    <!-- Bootstrap JS -->
    <script src="Scripts/assets/js/bootstrap.min.js"></script>
    <!-- WOW JS plugin for animation -->
    <script src="Scripts/assets/js/wow.js"></script>
    <!-- All JS plugin Triggers -->
    <script src="Scripts/assets/js/main.js"></script>
    <!-- Smooth scroll -->
    <script src="Scripts/assets/js/smooth-scroll.js"></script>
    <!--  -->
    <script src="Scripts/assets/js/jasny-bootstrap.min.js"></script>
    <!-- Counterup -->
    <script src="Scripts/assets/js/jquery.counterup.min.js"></script>
    <!-- waypoints -->
    <script src="Scripts/assets/js/waypoints.min.js"></script>
    <!-- circle progress -->
    <script src="Scripts/assets/js/circle-progress.js"></script>
    <!-- owl carousel -->
    <script src="Scripts/assets/js/owl.carousel.js"></script>
    <!-- lightbox -->
    <script src="Scripts/assets/js/lightbox.min.js"></script>
</body>
</html>
