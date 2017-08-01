<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WarehouseTransaction.aspx.cs" Inherits="AssetManagement.Views.Administrator.WarehouseTransaction" %>

<%@ Import Namespace="Biofarma.AssetManagement.Data.DataAccess" %>
<%@ Import Namespace="Biofarma.AssetManagement.Presentation" %>
<%@ Import Namespace="Biofarma.Framework.Security" %>
<%@ Import Namespace="Biofarma.Framework.Entity" %>
<%@ Import Namespace="Biofarma.Presentation.Component" %>
<%@ Import Namespace="Biofarma.Framework.Converter" %>
<%@ Import Namespace="Biofarma.Service.ERP" %>
<%@ Import Namespace="AssetManagement.Entity" %>
<%@ Import Namespace="System.Web.Configuration" %>
<%@ Import Namespace="System.Data" %>

<!DOCTYPE html>
<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        SessionCreator();
        if (Session["username"] == null && Session["password"] == null) Response.Redirect(WebConfigurationManager.AppSettings["LoginTo"]);

        if (!IsPostBack)
        {
            //SetDataToGroupList();
            SetDataGroup(ddlGroup.SelectedValue);
            
            if (Request.QueryString["sync"] != null)
            {
                if (Request.QueryString["sync"] == "1")
                {
                    AssetERPCatalog.GetERPAssets(Convert.ToDateTime("01/01/2000"), DateTime.Now, (string)Session["username"]);

                    Response.Redirect("Asset.aspx");
                }    
            }
            
            if (Request.QueryString["actio"] != null)
            {
                string _objid = Cryptography.Decrypt(Request.QueryString["objid"], true);
                
                if (Request.QueryString["actio"] == "2")
                {
                    //DelimitData(_objid);
                    Response.Redirect("Asset.aspx");
                }
                else if (Request.QueryString["actio"] == "3")
                {
                    //DeleteData(_objid);
                    Response.Redirect("Asset.aspx");
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
    
    //Delimit
    protected void DelimitData(string OBJID)
    {
        AssetCatalog.DelimitAssetHeader(OBJID, (string)Session["username"]);
    }
    
    //Delete
    protected void DeleteData(string OBJID)
    {
        AssetCatalog.DeleteAssetHeader(OBJID);
    }
    
    //View
    protected string GetAction(string OBJID)
    {
        StringBuilder element = new StringBuilder();

        //Preview Detail
        element.Append("<a class='btn btn-yellow popovers' style='color:white;margin-bottom:5px;' href='AssetForm.aspx?actio=1&objid=" + Cryptography.Encrypt(OBJID, true) + "' data-content='Silakan klik untuk melakukan preview dan update data Aset' data-placement='left' data-trigger='hover'><i class='fa fa-edit'></i></a> ");
        element.Append("<a class='btn btn-blue popovers' style='color:white;margin-bottom:5px;' href='AssetMaintenanceForm.aspx?actio=1&objid=" + Cryptography.Encrypt(OBJID, true) + "' data-content='Silakan klik untuk melakukan preview dan register data pemeliharaan aset' data-placement='left' data-trigger='hover'><i class='fa fa-gear'></i></a> ");
        element.Append("<a class='btn btn-green popovers' style='color:white;margin-bottom:5px;' href='AssetDocumentForm.aspx?actio=1&objid=" + Cryptography.Encrypt(OBJID, true) + "' data-content='Silakan klik untuk melakukan preview dan register dokumen aset' data-placement='left' data-trigger='hover'><i class='fa fa-book'></i></a> ");
        element.Append("<a class='btn btn-danger popovers' style='color:white;margin-bottom:5px;' href='Asset.aspx?actio=2&objid=" + Cryptography.Encrypt(OBJID, true) + "' data-content='Silakan klik untuk menghapus data. Apakah Anda yakin?' data-placement='left' data-trigger='hover'><i class='fa fa-trash-o'></i></a> ");
        
        //element.Append("<a class='btn btn-default popovers' style='color:white;margin-bottom:5px;' href='Asset.aspx?actio=2&objid=" + Cryptography.Encrypt(OBJID, true) + "' data-content='Silakan klik untuk melakukan delimit data. Apakah Anda Yakin?' data-placement='left' data-trigger='hover'><i class='fa fa-recycle'></i></a> ");
        //element.Append("<a class='btn btn-danger popovers' style='color:white;margin-bottom:5px;' href='Asset.aspx?actio=3&objid=" + Cryptography.Encrypt(OBJID, true) + "' data-content='Silakan klik untuk menghapus data. Apakah Anda yakin?' data-placement='left' data-trigger='hover'><i class='fa fa-trash-o'></i></a> ");
        return element.ToString();
    }

    protected string GetStatus(string STACD)
    {
        StringBuilder element = new StringBuilder();

        //Preview Detail
        if (STACD == ((int)AssetStatus.NewArrival).ToString())
            element.Append("<span class='label label-warning popovers' style='color:white' data-content='Data baru dari ERP' data-placement='left' data-trigger='hover'><i class='fa fa-asterisk'></i></span> ");
        else if (STACD == ((int)AssetStatus.Good).ToString())
            element.Append("<span class='label label-warning popovers' style='color:white' data-content='Registered : Aset dalam kondisi baik' data-placement='left' data-trigger='hover'><i class='fa fa-bookmark'></i></span> ");
        else if (STACD == ((int)AssetStatus.NotGood).ToString())
            element.Append("<span class='label label-warning popovers' style='color:white' data-content='Registered : Aset dalam kondisi rusak' data-placement='left' data-trigger='hover'><i class='fa fa-bookmark'></i></span> ");
        else if (STACD == ((int)AssetStatus.NoPhysic).ToString())
            element.Append("<span class='label label-warning popovers' style='color:white' data-content='Registered : Fisik aset tidak ada' data-placement='left' data-trigger='hover'><i class='fa fa-bookmark'></i></span> ");
        else 
            element.Append("<span class='label label-green popovers' style='color:white' data-content='Registered : Aset tidak produktif' data-placement='left' data-trigger='hover'><i class='fa fa-bookmark'></i></span> ");

        return element.ToString();
    }

    protected void ddlGroup_SelectedIndexChanged(object sender, EventArgs e)
    {
        SetDataGroup(ddlGroup.SelectedValue);
    }

    protected void SetDataToGroupList()
    {
        DataTable table = AssetCatalog.GetAssetMayorTypes();
        
        ddlGroup.Items.Clear();
        ddlGroup.DataSource = table;
        ddlGroup.DataValueField = "MAJCD";
        ddlGroup.DataTextField = "MAJOR";
        ddlGroup.DataBind();
    }

    protected void SetDataGroup(string GROUP)
    {
        //Session["group"] = GROUP;
    }

    protected String GenerateData()
    {
        StringBuilder _table = new StringBuilder();

        //DataTable table = AssetCatalog.GetAssetHeadersByMajor((string)Session["group"]);
        
        //for (int i = 0; i < table.Rows.Count; i++)
        //{
        //    string _action = GetAction(table.Rows[i]["OBJID"].ToString());
        //    string _status = GetStatus(table.Rows[i]["STACD"].ToString());
        //    int _yearRange = Convert.ToInt32((Convert.ToDateTime(table.Rows[i]["EXPDT"]) - Convert.ToDateTime(table.Rows[i]["EFFDT"])).TotalDays / 365);

        //    _table.Append("<tr class=''>");
        //    _table.Append("<td>" + _status + "</td>");
        //    _table.Append("<td>" + table.Rows[i]["PLNNM"].ToString() + "</td>");
        //    _table.Append("<td>" + table.Rows[i]["ASTNO"].ToString() + "</td>");
        //    _table.Append("<td>" + table.Rows[i]["INVNO"].ToString() + "</td>");
        //    _table.Append("<td>" + table.Rows[i]["PLNCD"].ToString() + "</td>");
        //    _table.Append("<td>" + _yearRange.ToString() + "</td>");
        //    _table.Append("<td>" + table.Rows[i]["HOWGT"].ToString() + "</td>");
        //    _table.Append("<td>" + table.Rows[i]["ASTTO"].ToString() + "</td>");
        //    _table.Append("<td>" + table.Rows[i]["LOCNM"].ToString() + "</td>");
        //    _table.Append("<td>" + table.Rows[i]["ORGNM"].ToString() + "</td>");
        //    _table.Append("<td align='center' width='15%'>" + _action + "</td>");
        //    _table.Append("</tr>");
        //}

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
                                Aset Perusahaan | Profil Aset
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
                                                    <%--<li><asp:HyperLink runat="server" ID="hypSync" NavigateUrl="Asset.aspx?sync=1"><i class="fa fa-refresh fa-spin"></i> Sync ERP</asp:HyperLink></li>--%>
                                                    <li><a href="AssetForm.aspx"><i class="fa fa-plus"></i> Add Transaction</a></li>
                                                    <li><a href="#"><i class="fa fa-print"></i> Print Document</a></li>
                                                </ul>
                                            </div>
                                        </div>
                                        <table class="table table-striped table-hover table-bordered" id="dynamic-table">
                                            <thead>
                                                <tr>
                                                    <th></th>
                                                    <th>Tanggal Transaksi</th>     
                                                    <th>Jenis Transaksi</th>
                                                    <th>Material</th>
                                                    <th>Batch</th>
                                                    <th>Gin</th>
                                                    <th>Rack</th>
                                                    <th>Quantity</th>
                                                    <th>Price</th>
                                                    <th>Status</th>
                                                    <th>Keterangan</th>
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