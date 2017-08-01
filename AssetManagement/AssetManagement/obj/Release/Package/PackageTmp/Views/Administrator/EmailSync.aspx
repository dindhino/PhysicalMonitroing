<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EmailSync.aspx.cs" Inherits="AssetManagement.Views.Administrator.EmailSync" %>

<%@ Import Namespace="Biofarma.Service.ActiveDirectory" %>
<%@ Import Namespace="Biofarma.Data.DataAccess" %>

<!DOCTYPE html>
<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        UserCatalog.EmptyLocalUserEmail();
        ActiveDirectoryManager.SyncActiveUserEmailsToLocal("1906");
    }
    
</script>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    </div>
    </form>
</body>
</html>
