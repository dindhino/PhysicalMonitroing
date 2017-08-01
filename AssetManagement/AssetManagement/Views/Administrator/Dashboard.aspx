<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="AssetManagement.Views.Administrator.Dashboard" %>

<%@ Import Namespace="Biofarma.Framework.Security" %>
<%@ Import Namespace="Biofarma.Business.Activity" %>
<%@ Import Namespace="Biofarma.Presentation.Component" %>
<%@ Import Namespace="Biofarma.AssetManagement.Presentation" %>
<%@ Import Namespace="System.Web.Configuration" %>

<!DOCTYPE html>
<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        //SessionCreator();
        if (Session["username"] == null && Session["password"] == null) Response.Redirect(WebConfigurationManager.AppSettings["LoginTo"]);
        
        if (!IsPostBack)
        {
            
        }
    }

    protected void SessionCreator()
    {
        Session["username"] = "1906";
        Session["name"] = "Allan Prakosa";
        Session["password"] = "BIOFARMA";
        Session["email"] = "allanprakosa@biofarma.co.id";
    }
    
</script>

<html lang="en">
<head>
    <% Response.Write(Basic.GetMetaScript()); %>
    <title>Dashboard</title>
    <% Response.Write(CSS.GetCoreStyle()); %>
    <% Response.Write(CSS.GetCustomStyle()); %>
    <% Response.Write(CSS.GetTableStyle()); %>
</head>

<body>

    <section id="container">

        <!--header start-->
        <%Response.Write(Navigation.SetApplicationHeader((string)Session["name"])); %>
        <!--header end-->

        <!--left side bar start-->
        <%Response.Write(Navigation.SetMenuAuthority((string)Session["menu"])); %>
        <!--left side bar end-->

        <!--main content start-->
        <section id="main-content">
            <section class="wrapper">
                <!-- page start-->
                <div class="row">
                    <div class="col-sm-12">
                            <section class="panel" style="background-image:url(../../Images/background.jpg);background-size:cover;height:680px;">
                            <header class="panel-heading">
                                Dashboard
                          <span class="tools pull-right">
                              <%--<a class="fa fa-chevron-down" href="javascript:;"></a>
                              <a class="fa fa-times" href="javascript:;"></a>--%>
                          </span>
                            </header>
                            <form runat="server">
                                <div class="panel-body" align="center">
                                    <% Response.Write(Notification.GetInfoNotification("Welcome! you are login to Bio Farma Asset Management Application")); %>
                                    <% Response.Write(Notification.GetInfoNotification("Please contact our technical support at ext. 37424 for support")); %>
                                </div>
                            </form>
                        </section>
                    </div>
                </div>
                <!-- page end-->
            </section>
        </section>
        <!--main content end-->
        <!--right sidebar start-->
        <!--right sidebar end-->
    </section>

    <!-- Placed js at the end of the document so the pages load faster -->
    <% Response.Write(Javascript.GetCoreScript()); %>
    <% Response.Write(Javascript.GetCustomFormScript()); %>
    <% Response.Write(Javascript.GetDynamicTableScript()); %>
    <% Response.Write(Javascript.GetInitialisationScript()); %>
</body>
</html>
