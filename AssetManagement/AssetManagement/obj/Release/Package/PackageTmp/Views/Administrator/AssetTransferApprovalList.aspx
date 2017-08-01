<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AssetTransferApprovalList.aspx.cs" Inherits="AssetManagement.Views.Administrator.AssetTransferApprovalList" %>

<%@ Import Namespace="Biofarma.AssetManagement.Data.DataAccess" %>
<%@ Import Namespace="Biofarma.AssetManagement.Presentation" %>
<%@ Import Namespace="Biofarma.AssetManagement.Business.Workflow" %>
<%@ Import Namespace="Biofarma.AssetManagement.Business.Entity" %>
<%@ Import Namespace="Biofarma.Framework.Security" %>
<%@ Import Namespace="Biofarma.Framework.Entity" %>
<%@ Import Namespace="Biofarma.Presentation.Component" %>
<%@ Import Namespace="Biofarma.Framework.Converter" %>
<%@ Import Namespace="AssetManagement.Entity" %>
<%@ Import Namespace="System.Web.Configuration" %>
<%@ Import Namespace="System.Data" %>

<!DOCTYPE html>
<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        //SessionCreator();
        if (Session["username"] == null && Session["password"] == null) Response.Redirect(WebConfigurationManager.AppSettings["LoginTo"]);

        if (!IsPostBack)
        {
            SetDataToGroupList();
            SetDataGroup(ddlGroup.SelectedValue);
        }
    }

    protected void SessionCreator()
    {
        Session["username"] = "1906";
        Session["name"] = "Allan Prakosa";
        Session["password"] = "BIOFARMA";
        Session["email"] = "allanprakosa@biofarma.co.id";
    }

    protected void ddlGroup_SelectedIndexChanged(object sender, EventArgs e)
    {
        SetDataGroup(ddlGroup.SelectedValue);
    }

    protected void SetDataToGroupList()
    {
        ddlGroup.Items.Clear();
        ddlGroup.Items.Add(new ListItem("In Process", ((int)WorkflowStatus.InProcess).ToString()));
        ddlGroup.Items.Add(new ListItem("Processed", ((int)WorkflowStatus.Approve).ToString()));
    }

    protected void SetDataGroup(string GROUP)
    {
        Session["group"] = GROUP;
    }

    protected String GenerateData()
    {
        StringBuilder _table = new StringBuilder();
        DataTable table = new DataTable();
        
        if (Session["group"].ToString() == ((int)WorkflowStatus.InProcess).ToString())
        {
            table = AssetWorkflow.GetWorkflowAssetTransferByStatus(Workflow.GetDataServiceGroup((int)WorkflowStatus.InProcess));
        }
        else if (Session["group"].ToString() == ((int)WorkflowStatus.Approve).ToString())
        {
            table = AssetWorkflow.GetWorkflowAssetTransferByStatus(Workflow.GetDataServiceGroup((int)WorkflowStatus.Approve));
        }
        
        for (int i = 0; i < table.Rows.Count; i++)
        {
            string _action = Workflow.GetWorkflowAction(table.Rows[i]["FLWTY"].ToString(), ((int)WorkflowUser.AssetManagementApprover).ToString(), table.Rows[i]["FLWST"].ToString(), table.Rows[i]["REFNO"].ToString(), table.Rows[i]["PLNID"].ToString());
            string _status = Workflow.GetWorkflowStatusSymbol(table.Rows[i]["FLWST"].ToString());
                
            _table.Append("<tr class=''>");
            _table.Append("<td>" + _status + "</td>");
            _table.Append("<td>" + table.Rows[i]["PLNNM"].ToString() + "</td>");
            _table.Append("<td>" + (table.Rows[i]["ASTNO"].ToString() + " / " + table.Rows[i]["INVNO"].ToString()) + "</td>");
            _table.Append("<td>" + DateTimeFormat.GetDateTimeFormat(table.Rows[i]["BEGDA"].ToString()) + "</td>");
            _table.Append("<td>" + table.Rows[i]["FRGNM"].ToString() + " <i class='fa fa-long-arrow-right'></i> " + table.Rows[i]["NRGNM"].ToString() + "</td>");
            _table.Append("<td>" + table.Rows[i]["FLCNM"].ToString() + " <i class='fa fa-long-arrow-right'></i> " + table.Rows[i]["NLCNM"].ToString() + "</td>");
            _table.Append("<td>" + table.Rows[i]["FNAME"].ToString() + " <i class='fa fa-long-arrow-right'></i> " + table.Rows[i]["CNAME"].ToString() + "</td>");
            _table.Append("<td align='center' width='10%'>" + _action + "</td>");
            _table.Append("</tr>");
        }

        return _table.ToString();
    }
    
</script>

<html lang="en">
<head>
    <% Response.Write(Basic.GetMetaScript()); %>

    <title><% Response.Write(ConfigurationManager.AppSettings["App_Name"]); %></title>

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
                <form runat="server">
                <div class="row">
                    <div class="col-sm-12">
                        <section class="panel">
                            <header class="panel-heading">
                                Aset Perusahaan | Persetujuan Mustasi Aset
                          <span class="tools pull-right">
                              <a class="fa fa-chevron-down" href="javascript:;"></a>
                          </span>
                            </header>
                                <div class="panel-body">
                                    <div class="adv-table">
                                        <div class="clearfix">
                                            <div class="btn-group">
                                                <asp:DropDownList runat="server" ID="ddlGroup" OnSelectedIndexChanged="ddlGroup_SelectedIndexChanged" AutoPostBack="true" class="form-control input-sm m-bot15"></asp:DropDownList>
                                            </div>
                                            <div class="btn-group pull-right">
                                                <button class="btn btn-green dropdown-toggle" data-toggle="dropdown">
                                                    Tools <i class="fa fa-angle-down"></i>
                                                </button>
                                                <ul class="dropdown-menu pull-right">
                                                    <li><a href="AssetDisposalHistory.aspx"><i class="fa fa-history"></i> Print History</a></li>
                                                    <li><a href="#"><i class="fa fa-print"></i> Print</a></li>
                                                </ul>
                                            </div>
                                        </div>
                                        <table class="table table-striped table-hover table-bordered" id="dynamic-table">
                                            <thead>
                                                <tr>
                                                    <th></th>
                                                    <th>Nama Aset</th>     
                                                    <th>Kode / Nomor</th>
                                                    <th>Tanggal Transaksi</th>
                                                    <th>Organisasi</th>
                                                    <th>Lokasi</th>
                                                    <th>Pemegang Aset</th>
                                                    <th></th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <%  Response.Write(GenerateData()); %>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                           
                        </section>
                    </div>
                </div>
                </form>
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
    <% Response.Write(Javascript.GetCharacterValidationInitScript()); %>
</body>
</html>