<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AssetMaintenance.aspx.cs" Inherits="AssetManagement.Views.Administrator.AssetMaintenance" %>

<%@ Import Namespace="Biofarma.AssetManagement.Data.DataAccess" %>
<%@ Import Namespace="Biofarma.AssetManagement.Presentation" %>
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
            setFilter(ddlUnit.SelectedValue, ddlLokasi.SelectedValue, ddlGroup.SelectedValue);
            ddlPageRows.SelectedValue = "50";
            
            if (Request.QueryString["actio"] != null)
            {
                string _objid = Cryptography.Decrypt(Request.QueryString["objid"], true);
                
                if (Request.QueryString["actio"] == "2")
                {
                    DelimitData(_objid);
                    Response.Redirect("Asset.aspx");
                }
                else if (Request.QueryString["actio"] == "3")
                {
                    DeleteData(_objid);
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

    protected void ddl_filter(object sender, EventArgs e)
    {
        grvAset.PageSize = Convert.ToInt16(ddlPageRows.SelectedValue);
        setFilter(ddlUnit.SelectedValue, ddlLokasi.SelectedValue, ddlGroup.SelectedValue);
    }

    protected void setFilter(string UNIT, string LOKASI, string GROUP)
    {
        Session["group"] = GROUP;
        Session["location"] = LOKASI;
        Session["unit"] = UNIT;
    }

    protected void SetDataToGroupList()
    {
        DataTable table = AssetCatalog.GetAssetMayorTypes();

        ddlGroup.Items.Clear();
        ddlGroup.DataSource = table;
        ddlGroup.DataValueField = "MAJCD";
        ddlGroup.DataTextField = "MAJOR";
        ddlGroup.DataBind();

        DataTable unit = Biofarma.Data.DataAccess.OrganizationCatalog.GetUnitOrganization();
        ddlUnit.Items.Clear();
        ddlUnit.DataSource = unit;
        ddlUnit.DataValueField = "ORGCD";
        ddlUnit.DataTextField = "ORGNM";
        ddlUnit.DataBind();

        DataTable lokasi = AssetCatalog.GetClusterArea();
        ddlLokasi.Items.Clear();
        ddlLokasi.DataSource = lokasi;
        ddlLokasi.DataValueField = "OBJID";
        ddlLokasi.DataTextField = "CLUST";
        ddlLokasi.DataBind();
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
        element.Append("<a class='btn btn-blue popovers' style='color:white;margin-bottom:5px;' href='AssetMaintenanceUpdate.aspx?actio=1&objid=" + Cryptography.Encrypt(OBJID, true) + "' data-content='Silakan klik untuk melakukan register data pemeliharaan aset' data-placement='left' data-trigger='hover'><i class='fa fa-gear'></i></a> ");
        element.Append("<a class='btn btn-orange popovers' style='color:white;margin-bottom:5px;' href='AssetMaintenancePlan.aspx?actio=1&objid=" + Cryptography.Encrypt(OBJID, true) + "' data-content='Silakan klik untuk melihat rencana pemeliharaan aset' data-placement='left' data-trigger='hover'><i class='fa fa-calendar'></i></a> ");
        element.Append("<a class='btn btn-purple popovers' style='color:white;margin-bottom:5px;' href='AssetMaintenanceHistory.aspx?actio=1&objid=" + Cryptography.Encrypt(OBJID, true) + "' data-content='Silakan klik untuk melihat history pemeliharaan aset' data-placement='left' data-trigger='hover'><i class='fa fa-history'></i></a> ");
        
        //element.Append("<a class='btn btn-default popovers' style='color:white;margin-bottom:5px;' href='Asset.aspx?actio=2&objid=" + Cryptography.Encrypt(OBJID, true) + "' data-content='Silakan klik untuk melakukan delimit data. Apakah Anda Yakin?' data-placement='left' data-trigger='hover'><i class='fa fa-recycle'></i></a> ");
        //element.Append("<a class='btn btn-danger popovers' style='color:white;margin-bottom:5px;' href='Asset.aspx?actio=3&objid=" + Cryptography.Encrypt(OBJID, true) + "' data-content='Silakan klik untuk menghapus data. Apakah Anda yakin?' data-placement='left' data-trigger='hover'><i class='fa fa-trash-o'></i></a> ");
        return element.ToString();
    }

    protected string GetStatus(string STACD)
    {
        StringBuilder element = new StringBuilder();

        //Preview Detail
        if (STACD == ((int)AssetStatus.NewArrival).ToString())
            element.Append("<span class='label label-warning popovers' style='color:white' data-content='Data baru dari ERP' data-placement='left' data-trigger='hover'><i class='fa fa-gear'></i></span> ");
        else if (STACD == ((int)AssetStatus.Good).ToString())
            element.Append("<span class='label label-warning popovers' style='color:white' data-content='Registered : Aset dalam kondisi baik' data-placement='left' data-trigger='hover'><i class='fa fa-gear'></i></span> ");
        else if (STACD == ((int)AssetStatus.NotGood).ToString())
            element.Append("<span class='label label-warning popovers' style='color:white' data-content='Registered : Aset dalam kondisi rusak' data-placement='left' data-trigger='hover'><i class='fa fa-gear'></i></span> ");
        else if (STACD == ((int)AssetStatus.NoPhysic).ToString())
            element.Append("<span class='label label-warning popovers' style='color:white' data-content='Registered : Fisik aset tidak ada' data-placement='left' data-trigger='hover'><i class='fa fa-gear'></i></span> ");
        else
            element.Append("<span class='label label-green popovers' style='color:white' data-content='Registered : Aset tidak produktif' data-placement='left' data-trigger='hover'><i class='fa fa-bookmark'></i></span> ");

        return element.ToString();
    }

    protected String GenerateData()
    {
        StringBuilder _table = new StringBuilder();

        DataTable table = AssetCatalog.GetAssetHeaders();
        
        for (int i = 0; i < table.Rows.Count; i++)
        {
            string _action = GetAction(table.Rows[i]["OBJID"].ToString());
            string _status = GetStatus(table.Rows[i]["STACD"].ToString());
            int _yearRange = Convert.ToInt32((Convert.ToDateTime(table.Rows[i]["EXPDT"]) - Convert.ToDateTime(table.Rows[i]["EFFDT"])).TotalDays / 365);
                
            _table.Append("<tr class=''>");
            _table.Append("<td>" + _status + "</td>");
            _table.Append("<td>" + table.Rows[i]["PLNNM"].ToString() + "</td>");
            _table.Append("<td>" + (table.Rows[i]["ASTNO"].ToString() == string.Empty ? table.Rows[i]["PLNCD"].ToString() : table.Rows[i]["ASTNO"].ToString()) + "</td>");
            _table.Append("<td>" + _yearRange.ToString() + "</td>");
            _table.Append("<td>" + table.Rows[i]["HOWGT"].ToString() + "</td>");
            _table.Append("<td>" + table.Rows[i]["ASTTO"].ToString() + "</td>");
            _table.Append("<td>" + table.Rows[i]["LOCNM"].ToString() + "</td>");
            _table.Append("<td>" + table.Rows[i]["ORGNM"].ToString() + "</td>");
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
    <style type="text/css">
        body {
            font-family: Arial;
            font-size: 10pt;
        }

        .GridPager a, .GridPager span {
            display: inline-block;
            padding: 4px 10px;
            margin-bottom: 0;
            font-size: 14px;
            font-weight: normal;
            line-height: 1.428571429;
            text-align: center;
            white-space: nowrap;
            vertical-align: middle;
            cursor: pointer;
            background-image: none;
            border: 1px solid transparent;
            border-radius: 4px;
            -webkit-user-select: none;
            -moz-user-select: none;
            -ms-user-select: none;
            -o-user-select: none;
            user-select: none;
        }

        .GridPager a {
            background-color: #f5f5f5;
            color: #969696;
            /*border: 1px solid #969696;*/
        }

        .GridPager span {
            background-color: #50b6fe;
            color: #6b6161;
            /*border: 1px solid #c5c5c5;*/
            color: white;
        }

        .adv-table table .GridPager td {
            padding: 2px;
        }

        .GridPager a:hover {
            background-color: #50b6fe;
            color: white;
            /* border: 1px solid #969696; */
        }

        .dropdown-menu-right {
            right: 0;
            left: auto;
        }
    </style>
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
                                                <div class="form-group">
                                                    <div class="col-sm-1" style="padding-right: 5px;padding-left: 5px;">
                                                        <asp:DropDownList runat="server" ID="ddlPageRows" OnSelectedIndexChanged="ddl_filter" AutoPostBack="true" class="form-control input m-bot15" style="padding: 5px 5px;">
                                                            <asp:ListItem>10</asp:ListItem>
                                                            <asp:ListItem>25</asp:ListItem>
                                                            <asp:ListItem>50</asp:ListItem>
                                                            <asp:ListItem>100</asp:ListItem>
                                                            <asp:ListItem>500</asp:ListItem>
                                                        </asp:DropDownList>
                                                    </div>
                                                    <div class="col-sm-2" style="padding-right: 5px;padding-left: 5px;">
                                                            <asp:DropDownList runat="server" ID="ddlUnit" OnSelectedIndexChanged="ddl_filter" AutoPostBack="true" class="form-control input-sm m-bot15 chosen"></asp:DropDownList>
                                                    </div>
                                                    <div class="col-sm-2" style="padding-right: 5px;padding-left: 5px;">
                                                            <asp:DropDownList runat="server" ID="ddlLokasi" OnSelectedIndexChanged="ddl_filter" AutoPostBack="true" class="form-control input-sm chosen"></asp:DropDownList>
                                                    </div>
                                                    <div class="col-sm-2" style="padding-right: 5px;padding-left: 5px;">
                                                            <asp:DropDownList runat="server" ID="ddlGroup" OnSelectedIndexChanged="ddl_filter" AutoPostBack="true" class="form-control input-sm m-bot15 chosen" ></asp:DropDownList>
                                                    </div>
                                                    <div class="col-sm-5">
                                                        <div class="input-group pull-right">
                                                            <input name="txtTerm" onkeyup="filter2(this, '<%=grvAset.ClientID %>')" class="input form-control" type="text">
                                                            <%--<asp:TextBox ID="txtSearchAset" runat="server" CssClass="input-sm form-control" placeholder="Search..."></asp:TextBox>--%>
                                                            <div class="input-group-btn">
                                                                <button type="button" class="btn input btn-green dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Action <span class="caret"></span></button>
                                                                <ul class="dropdown-menu dropdown-menu-right">
                                                                    <li><a href="AssetMaintenanceTask"><i class="fa fa-tasks"></i> Preview Task List</a></li>
                                                    <li><a href="AssetMaintenanceUnit"><i class="fa fa-file-o"></i> Print Document</a></li>
                                                                </ul>
                                                            </div>
                                                            <!-- /btn-group -->
                                                        </div>
                                                    </div>
                                                </div>
                                                <!-- /input-group -->
                                                <%--<div class="btn-group pull-right">
                                                <button class="btn btn-green dropdown-toggle" data-toggle="dropdown">
                                                    Tools <i class="fa fa-angle-down"></i>
                                                </button>
                                                <ul class="dropdown-menu pull-right">
                                                    <li>
                                                        <asp:HyperLink runat="server" ID="hypSync" NavigateUrl="Asset.aspx?sync=1"><i class="fa fa-refresh fa-spin"></i> Sync ERP</asp:HyperLink></li>
                                                    <li><a href="AssetForm.aspx"><i class="fa fa-plus"></i>Add Asset</a></li>
                                                    <li><a href="#"><i class="fa fa-print"></i>Print Document</a></li>
                                                </ul>
                                            </div>--%>
                                            </div>
                                            <br />
                                            <asp:GridView ID="grvAset" runat="server" DataSourceID="ObjectDataSourceAssetFilter" AllowPaging="True" CssClass="table table-striped table-bordered" AllowSorting="True" ClientIDMode="Static" AutoGenerateColumns="False" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="4" ForeColor="Black" GridLines="Horizontal" PageSize="50">
                                                <Columns>
                                                    <asp:BoundField DataField="#" HeaderText="#" HtmlEncode="False" SortExpression="#" />
                                                    <asp:BoundField DataField="Nama Aset" HeaderText="Nama Aset" SortExpression="Nama Aset" />
                                                    <asp:BoundField DataField="Kode Aset Akuntansi" HeaderText="Kode Aset Akuntansi" SortExpression="Kode Aset Akuntansi" />
                                                    <asp:BoundField DataField="No Inventaris" HeaderText="No Inventaris" SortExpression="No Inventaris" />
                                                    <asp:BoundField DataField="Id Alat" HeaderText="Id Alat" SortExpression="Id Alat" />
                                                    <asp:BoundField DataField="Masa Aset" HeaderText="Masa Aset" SortExpression="Masa Aset" />
                                                    <asp:BoundField DataField="Perolehan" HeaderText="Perolehan" SortExpression="Perolehan" />
                                                    <asp:BoundField DataField="Peruntukan" HeaderText="Peruntukan" SortExpression="Peruntukan" />
                                                    <asp:BoundField DataField="Lokasi" HeaderText="Lokasi" SortExpression="Lokasi" />
                                                    <asp:BoundField DataField="Unit" HeaderText="Unit" SortExpression="Unit" />
                                                    <asp:BoundField DataField="Action" HeaderText="Action" HtmlEncode="False" SortExpression="Action" />
                                                </Columns>
                                                <FooterStyle BackColor="#CCCC99" ForeColor="Black" />
                                                <PagerStyle HorizontalAlign="Right" CssClass="GridPager" />
                                                <SelectedRowStyle BackColor="#CC3333" Font-Bold="True" ForeColor="White" />

                                            </asp:GridView>
                                            <asp:ObjectDataSource ID="ObjectDataSourceAssetFilter" runat="server" SelectMethod="GetAssetMaintenanceFilter" TypeName="Biofarma.AssetManagement.Business.Component.Asset">
                                                <SelectParameters>
                                                    <asp:ControlParameter ControlID="ddlUnit" Name="unit" PropertyName="SelectedValue" Type="String" />
                                                    <asp:ControlParameter ControlID="ddlLokasi" Name="location" PropertyName="SelectedValue" Type="String" />
                                                    <asp:ControlParameter ControlID="ddlGroup" Name="group" PropertyName="SelectedValue" Type="String" />
                                                </SelectParameters>
                                            </asp:ObjectDataSource>
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
    <script>
        function filter2(phrase, _id) {
            var words = phrase.value.toLowerCase().split(" ");
            var table = document.getElementById(_id);
            var ele;
            for (var r = 1; r < table.rows.length; r++) {
                ele = table.rows[r].innerHTML.replace(/<[^>]+>/g, "");
                var displayStyle = 'none';
                for (var i = 0; i < words.length; i++) {
                    if (ele.toLowerCase().indexOf(words[i]) >= 0)
                        displayStyle = '';
                    else {
                        displayStyle = 'none';
                        break;
                    }
                }
                table.rows[r].style.display = displayStyle;
            }
        }

        $('#grvAset').dataTable();
    </script>
</body>
</html>
