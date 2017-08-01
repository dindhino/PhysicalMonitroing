<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AssetMaintenanceTask.aspx.cs" Inherits="AssetManagement.Views.Administrator.AssetMaintenanceTask" %>

<%@ Import Namespace="Biofarma.AssetManagement.Data.DataAccess" %>
<%@ Import Namespace="Biofarma.AssetManagement.Business.Activity" %>
<%@ Import Namespace="Biofarma.AssetManagement.Presentation" %>
<%@ Import Namespace="Biofarma.Framework.Security" %>
<%@ Import Namespace="Biofarma.Framework.Entity" %>
<%@ Import Namespace="Biofarma.Presentation.Component" %>
<%@ Import Namespace="Biofarma.Framework.Converter" %>
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
            if (Request.QueryString["actio"] != null)
            {
                string _objid = Cryptography.Decrypt(Request.QueryString["objid"], true);
                
                if (Request.QueryString["actio"] == "2")
                {
                    DelimitData(_objid);
                    Response.Redirect("AssetMaintenance.aspx");
                }
                else if (Request.QueryString["actio"] == "3")
                {
                    DeleteData(_objid);
                    Response.Redirect("AssetMaintenance.aspx");
                }
                else if (Request.QueryString["actio"] == "4")
                {
                    UpdateSchedule(_objid);
                    Response.Redirect("AssetMaintenance.aspx");
                }
                
            }
        }
    }

    protected void SessionCreator()
    {
        Session["username"] = "1906";
        Session["name"] = "Allan Prakosa";
        Session["password"] = "BIOFARMA";
        Session["email"] = "allanprakosa@biofarma.co.id";
    }

    //Add
    protected void btnAdd_Click(object sender, EventArgs e)
    {
        if (Request.QueryString["actio"] != null)
        {
            if (Request.QueryString["actio"] == "1")
            {
                UpdateData(Cryptography.Decrypt(Request.QueryString["objid"], true));
            }
        }
        else
        {
            UpdateData("0");
        }
        Response.Redirect("AssetMaintenance.aspx");
    }
    
    //Update
    protected void UpdateData(string OBJID)
    {
        //Update Maintenance
    }
    
    protected void UpdateSchedule(string OBJID)
    {
        DataTable data = AssetCatalog.GetPlantMaintenanceByID(OBJID);
        DataTable asset = AssetCatalog.GetAssetHeaderByID(data.Rows[0]["PLNID"].ToString());
        
        AssetCatalog.UpdatePlantMaintenanceSchedule(Convert.ToInt32(OBJID), data.Rows[0]["PLNID"].ToString(), data.Rows[0]["TSKID"].ToString(), data.Rows[0]["TASK"].ToString(), data.Rows[0]["STKID"].ToString(), data.Rows[0]["STASK"].ToString(), data.Rows[0]["PERIO"].ToString(), data.Rows[0]["PUNIT"].ToString(), Session["username"].ToString());

        EmailNotification.SendEmailUpdatedMaintenanceNotification((string)Session["username"], (string)Session["name"], asset.Rows[0]["PLNCD"].ToString(), asset.Rows[0]["PLNNM"].ToString(), data.Rows[0]["STASK"].ToString(), string.Empty, DateTimeFormat.GetDateFormat(DateTime.Today.ToString()));
    }
    
    //Delimit
    protected void DelimitData(string OBJID)
    {
        AssetCatalog.DelimitPlantMaintenance(OBJID, (string)Session["username"]);
    }
    
    //Delete
    protected void DeleteData(string OBJID)
    {
        AssetCatalog.DeletePlantMaintenance(OBJID);
    }
    
    //View
    protected string GetAction(string OBJID, string PLNID)
    {
        StringBuilder element = new StringBuilder();

        //Preview Detail
        //element.Append("<a class='btn btn-orange popovers' style='color:white;margin-bottom:5px;' href='AssetMaintenanceForm.aspx?actio=1&objid=" + Cryptography.Encrypt(OBJID, true) + "' data-content='Silakan klik untuk melakukan preview dan update data' data-placement='left' data-trigger='hover'><i class='fa fa-file-o'></i></a> ");
        //element.Append("<a class='btn btn-yellow popovers' style='color:white;margin-bottom:5px;' href='AssetMaintenanceForm.aspx?actio=1&objid=" + Cryptography.Encrypt(OBJID, true) + "' data-content='Silakan klik untuk melakukan preview dan perubahan master pemeliharaan aset' data-placement='left' data-trigger='hover'><i class='fa fa-plus'></i></a> ");
        element.Append("<a class='btn btn-purple popovers' style='color:white;margin-bottom:5px;' href='AssetMaintenance.aspx?actio=4&objid=" + Cryptography.Encrypt(OBJID, true) + "' data-content='Silakan klik untuk melakukan update asset maintenance' data-placement='left' data-trigger='hover'><i class='fa fa-wrench'></i></a> ");
        element.Append("<a class='btn btn-blue popovers' style='color:white;margin-bottom:5px;' href='AssetMaintenanceUpdate.aspx?actio=1&objid=" + Cryptography.Encrypt(PLNID, true) + "' data-content='Silakan klik untuk melakukan preview dan update data pemeliharaan aset' data-placement='left' data-trigger='hover'><i class='fa fa-gear'></i></a> ");
        //element.Append("<a class='btn btn-default popovers' style='color:white;margin-bottom:5px;' href='AssetMaintenance.aspx?actio=2&objid=" + Cryptography.Encrypt(OBJID, true) + "' data-content='Silakan klik untuk melakukan delimit data. Apakah Anda Yakin?' data-placement='left' data-trigger='hover'><i class='fa fa-recycle'></i></a> ");
        //element.Append("<a class='btn btn-red popovers' style='color:white;margin-bottom:5px;' href='AssetMaintenance.aspx?actio=2&objid=" + Cryptography.Encrypt(OBJID, true) + "' data-content='Silakan klik untuk menghapus data. Apakah Anda yakin?' data-placement='left' data-trigger='hover'><i class='fa fa-trash-o'></i></a> ");
        
        return element.ToString();
    }

    protected string GetStatus(string PLANM)
    {
        StringBuilder element = new StringBuilder();
        int _dateDiff = Convert.ToInt32((Convert.ToDateTime(PLANM) - DateTime.Now).TotalDays);
        //Preview Detail
        if (_dateDiff > 0)
            element.Append("<span class='label label-green popovers' style='color:white' data-content='Status : masih dalam jangka aman untuk digunakan' data-placement='left' data-trigger='hover'><i class='fa fa-bookmark'></i></span> ");
        else if (_dateDiff == 0)
            element.Append("<span class='label label-orange popovers' style='color:white' data-content='Status : segera lakukan pemeliharaan' data-placement='left' data-trigger='hover'><i class='fa fa-bookmark'></i></span> ");
        else
            element.Append("<span class='label label-red popovers' style='color:white' data-content='Status : di luar jangka aman / expired' data-placement='left' data-trigger='hover'><i class='fa fa-bookmark'></i></span> ");

        return element.ToString();
    }

    protected String GenerateData()
    {
        StringBuilder _table = new StringBuilder();

        DataTable table = AssetCatalog.GetPlantMaintenances();

        for (int i = 0; i < table.Rows.Count; i++)
        {
            string _action = GetAction(table.Rows[i]["OBJID"].ToString(), table.Rows[i]["PLNID"].ToString());
            string _status = GetStatus(table.Rows[i]["PLANM"].ToString());
            
            _table.Append("<tr class=''>");
            _table.Append("<td>" + _status + "</td>");
            _table.Append("<td>" + table.Rows[i]["PLNCD"].ToString() + "</td>");
            _table.Append("<td>" + table.Rows[i]["PLNNM"].ToString() + "</td>");
            _table.Append("<td>" + table.Rows[i]["TASK"].ToString() + "</td>");
            _table.Append("<td>" + table.Rows[i]["STASK"].ToString() + "</td>");
            _table.Append("<td>" + DateTimeFormat.GetDateFormat(table.Rows[i]["LASTM"].ToString()) + "</td>");
            _table.Append("<td>" + DateTimeFormat.GetDateFormat(table.Rows[i]["PLANM"].ToString()) + "</td>");
            _table.Append("<td align='center' width='15%'>" + _action + "</td>");
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
                                Preventive Maintenance | Asset Maintenance
                          <span class="tools pull-right">
                              <a class="fa fa-chevron-down" href="javascript:;"></a>
                          </span>
                            </header>
                                <div class="panel-body">
                                    
                                    <div class="adv-table">
                                        <div class="clearfix">
                                            <div class="btn-group">
                                                <%--<asp:DropDownList runat="server" ID="ddlGroup" AutoPostBack="true" class="form-control input-sm m-bot15"></asp:DropDownList>--%>
                                            </div>
                                            <div class="btn-group pull-right">
                                                <%--<button class="btn btn-green dropdown-toggle" data-toggle="dropdown">
                                                    Tools <i class="fa fa-angle-down"></i>
                                                </button>
                                                <ul class="dropdown-menu pull-right">
                                                    <li><a href="AssetMaintenanceForm"><i class="fa fa-plus"></i> Add Maintenance</a></li>
                                                </ul>--%>
                                            </div>
                                        </div>
                                        <table class="table table-striped table-hover table-bordered" id="dynamic-table">
                                            <thead>
                                                <tr>
                                                    <th></th> 
                                                    <th>Kode</th> 
                                                    <th>Nama Aset</th>       
                                                    <th>Grup Maintenance</th>       
                                                    <th>Jenis Maintenance</th>
                                                    <th>Last Maintenance</th>
                                                    <th>Next Maintenance</th>
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