<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AssetManagementReporting.aspx.cs" Inherits="AssetManagement.Views.Reporting.AssetManagementReporting" %>

<%@ Register assembly="DevExpress.XtraReports.v13.2.Web, Version=13.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.XtraReports.Web" tagprefix="dx" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="AssetManagement.Views.Reporting" %>

<!DOCTYPE html>
<script runat="server">
    
    protected void Page_Load(object sender, EventArgs e)
    {
        //SessionCreator();
        if (Session["username"] == null && Session["password"] == null) Response.Redirect("../../Views/Application/PageSignIn.aspx");

        DataSet _datasource = new DataSet();

        if (Session["CurrentDataSet"] != null)
            _datasource = (DataSet)Session["CurrentDataSet"];

        dcvReporting.Report = new MaintenancePlan();
        dcvReporting.Report.DataSource = _datasource;
        dcvReporting.Report.DataMember = "MaintenancePlant";
    }
</script>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <dx:ASPxDocumentViewer ID="dcvReporting" runat="server">
        </dx:ASPxDocumentViewer>
    
    </div>
    </form>
</body>
</html>
