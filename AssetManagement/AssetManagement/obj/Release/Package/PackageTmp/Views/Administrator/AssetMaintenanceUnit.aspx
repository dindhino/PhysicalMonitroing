<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AssetMaintenanceUnit.aspx.cs" Inherits="AssetManagement.Views.Administrator.AssetMaintenanceUnit" %>

<%@ Import Namespace="Biofarma.AssetManagement.Data.DataAccess" %>
<%@ Import Namespace="Biofarma.AssetManagement.Presentation" %>
<%@ Import Namespace="Biofarma.AssetManagement.Business.Activity" %>
<%@ Import Namespace="Biofarma.Framework.Security" %>
<%@ Import Namespace="Biofarma.Framework.Entity" %>
<%@ Import Namespace="Biofarma.Presentation.Component" %>
<%@ Import Namespace="Biofarma.Framework.Converter" %>
<%@ Import Namespace="Biofarma.Data.DataAccess" %>
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
            CreateDefaultFormControl();
            SetOrganisasi();
        }
    }

    protected void SessionCreator()
    {
        Session["username"] = "1906";
        Session["name"] = "Allan Prakosa";
        Session["password"] = "BIOFARMA";
        Session["email"] = "allanprakosa@biofarma.co.id";
    }

    protected void CreateDefaultFormControl()
    {
        txtDate.Text = DateTimeFormat.GetDateFormat(DateTime.Now.ToString("MM/dd/yyyy"));
        txtDate.Enabled = false;
        txtDate.CssClass = "form-control form-control-inline input-medium update";
        txtOperator.Text = (string)Session["name"];
        txtOperator.Enabled = false;
        txtOperator.CssClass = "form-control form-control-inline input-medium update";
    }
    
    //Update Soon
    protected void SetOrganisasi()
    {
        DataTable data = AssetCatalog.GetExistingAssetOrganization();

        ddlOrganization.Items.Clear();
        for (int i = 0; i < data.Rows.Count; i++)
        {
            ddlOrganization.Items.Add(new ListItem(data.Rows[i]["ORGNM"].ToString(), data.Rows[i]["ORGCD"].ToString()));
        }
    }
    
    //View
    protected string GetAction(string OBJID)
    {
        StringBuilder element = new StringBuilder();

        //Preview Detail
        element.Append("<a class='btn btn-warning popovers' style='color:white;margin-bottom:5px;' href='Task.aspx?actio=1&objid=" + Cryptography.Encrypt(OBJID, true) + "' data-content='Silakan klik untuk melakukan preview dan update data' data-placement='left' data-trigger='hover'><i class='fa fa-edit'></i></a> ");
        element.Append("<a class='btn btn-default popovers' style='color:white;margin-bottom:5px;' href='Task.aspx?actio=2&objid=" + Cryptography.Encrypt(OBJID, true) + "' data-content='Silakan klik untuk melakukan delimit data. Apakah Anda Yakin?' data-placement='left' data-trigger='hover'><i class='fa fa-recycle'></i></a> ");
        element.Append("<a class='btn btn-danger popovers' style='color:white;margin-bottom:5px;' href='Task.aspx?actio=3&objid=" + Cryptography.Encrypt(OBJID, true) + "' data-content='Silakan klik untuk menghapus data. Apakah Anda yakin?' data-placement='left' data-trigger='hover'><i class='fa fa-trash-o'></i></a> ");
        
        return element.ToString();
    }
    
    protected DataSet CreateDataReport(DataTable dataTable, DateTime begda, DateTime endda, string ORGNM, bool isNeedPeriode)
    {
        DataSet dataSet = new DataSet();
        dataSet.Tables.Add(dataTable);
        dataSet.Tables.Add("Header");
        dataSet.Tables.Add("Footer");


        dataSet.Tables["Header"].Columns.Add("ORGNM", typeof(string));
        dataSet.Tables["Header"].Columns.Add("PERIO", typeof(string));
        dataSet.Tables["Header"].Rows.Add(new object[] { ORGNM, DateTimeFormat.GetDateFormat(begda.ToString()) + " - " + DateTimeFormat.GetDateFormat(endda.ToString()) });

        dataSet.Tables["Footer"].Columns.Add("PRTDT", typeof(string));
        dataSet.Tables["Footer"].Columns.Add("PDTTM", typeof(string));
        dataSet.Tables["Footer"].Columns.Add("RVPOS", typeof(string));
        dataSet.Tables["Footer"].Columns.Add("RVWNM", typeof(string));
        dataSet.Tables["Footer"].Columns.Add("RVWPN", typeof(string));
        dataSet.Tables["Footer"].Rows.Add(new object[] { DateTimeFormat.GetDateFormat(DateTime.Today.ToString()), DateTimeFormat.GetDateTimeFormat(DateTime.Now.ToString()), Session["prorg"].ToString(), Session["name"].ToString(), Session["username"].ToString() });
        
        return dataSet;
    }

    protected String GenerateData()
    {
        StringBuilder _table = new StringBuilder();

        if (rbtHistory.Checked)
        {
            if (Session["viewState"] != null)
            {
                DateTime _initDate = Convert.ToDateTime(DateTimeFormat.ReverseDateVersionSQL(txtPlanBegda.Text));
                DateTime _endDate = Convert.ToDateTime(DateTimeFormat.ReverseDateVersionSQL(txtPlanEndda.Text));

                DataTable _data = PreventiveMaintenance.GetAssetMaintenanceHistoryUnit(ddlOrganization.SelectedValue, _initDate, _endDate, true);
                Session["CurrentDataSet"] = CreateDataReport(_data, _initDate, _endDate, ddlOrganization.SelectedItem.Text, true);

                for (int i = 0; i < _data.Rows.Count; i++)
                {
                    _table.Append("<tr class=''>");
                    _table.Append("<td>" + _data.Rows[i]["PLNCD"].ToString() + "</td>");
                    _table.Append("<td>" + _data.Rows[i]["PLNNM"].ToString() + "</td>");
                    _table.Append("<td>" + _data.Rows[i]["TASK"].ToString() + "</td>");
                    _table.Append("<td>" + _data.Rows[i]["STASK"].ToString() + "</td>");
                    _table.Append("<td>" + _data.Rows[i]["PRIOD"].ToString() + "</td>");
                    _table.Append("<td>" + _data.Rows[i]["REAL"].ToString() + "</td>");
                    _table.Append("<td>" + _data.Rows[i]["PLAN"].ToString() + "</td>");
                    _table.Append("</tr>");
                }
            }
        }
        else if (rbtPlan.Checked)
        {
            if (Session["viewState"] != null)
            {
                DateTime _initDate = Convert.ToDateTime(DateTimeFormat.ReverseDateVersionSQL(txtPlanBegda.Text));
                DateTime _endDate = Convert.ToDateTime(DateTimeFormat.ReverseDateVersionSQL(txtPlanEndda.Text));

                DataTable _data = PreventiveMaintenance.GetAssetMaintenancePlanUnit(ddlOrganization.SelectedValue, _initDate, _endDate);
                Session["CurrentDataSet"] = CreateDataReport(_data, _initDate, _endDate, ddlOrganization.SelectedItem.Text, true);

                for (int i = 0; i < _data.Rows.Count; i++)
                {
                    _table.Append("<tr class=''>");
                    _table.Append("<td>" + _data.Rows[i]["PLNCD"].ToString() + "</td>");
                    _table.Append("<td>" + _data.Rows[i]["PLNNM"].ToString() + "</td>");
                    _table.Append("<td>" + _data.Rows[i]["TASK"].ToString() + "</td>");
                    _table.Append("<td>" + _data.Rows[i]["STASK"].ToString() + "</td>");
                    _table.Append("<td>" + _data.Rows[i]["PRIOD"].ToString() + "</td>");
                    _table.Append("<td>" + string.Empty + "</td>");
                    _table.Append("<td>" + _data.Rows[i]["PLAN"].ToString() + "</td>");
                    _table.Append("</tr>");
                }
            }
        }

        return _table.ToString();
    }


    protected void btnOkay_Click(object sender, EventArgs e)
    {
        Session["viewState"] = true;
    }

    protected void lnkPrintDocument_Click(object sender, EventArgs e)
    {
        if (rbtPlan.Checked)
        {
            Response.Redirect("../Reporting/AssetMaintenancePlanReporting.aspx");
        }
        else
        {
            Response.Redirect("../Reporting/AssetMaintenanceHistoryReporting.aspx");
        }
    }

    protected void rbtMaintenanceType_CheckedChanged(object sender, EventArgs e)
    {
        Session["viewState"] = null;
    }

    protected void ddlOrganization_SelectedIndexChanged(object sender, EventArgs e)
    {
        Session["viewState"] = null;
    }
    
</script>

<html lang="en">
<head>
    <% Response.Write(Basic.GetMetaScript()); %>

    <title><% Response.Write(ConfigurationManager.AppSettings["App_Name"]); %></title>

    <% Response.Write(CSS.GetCoreStyle()); %>
    <% Response.Write(CSS.GetFormStyle()); %>
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
                                Preventive Maintenance | Reporting Form
                              <span class="tools pull-right">
                                  <a class="fa fa-times" href="javascript:;"></a>
                              </span>
                            </header>
                                <div class="panel-body">
                                   <div class="form-horizontal " runat="server">
                                        
                                        <div class="form-group">
                                            <label class="col-sm-2 control-label">Tanggal</label>
                                            <div class="col-lg-4 col-md-4 col-sm-4">
                                                <asp:TextBox ID="txtDate" runat="server" class="form-control  m-bot15" Enabled="false" CssClass ="form-control form-control-inline input-medium update"></asp:TextBox>
                                            </div>
                                            <label class="col-sm-1 control-label">Operator</label>
                                            <div class="col-lg-4 col-md-4 col-sm-4">
                                                <asp:TextBox ID="txtOperator" runat="server" class="form-control  m-bot15" Enabled="false" CssClass ="form-control form-control-inline input-medium update"></asp:TextBox>
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <div class="col-sm-12">
                                                <p style="font-size: 15px; margin-bottom: 30px;margin-top: 30px;" align="center">
                                                <asp:Label runat="server" ID="Label1" ><strong>SPESIFIKASI LAPORAN PEMELIHARAAN</strong></asp:Label></p>
                                            </div>
                                        </div>

                                       <div class="form-group">
                                            <label class="col-sm-2 control-label">Jenis Laporan</label>
                                            <div class="col-lg-10 col-md-10">
                                                <div class="col-lg-3 col-md-3">
                                                    <div class="radio">
                                                        <asp:RadioButton runat="server" GroupName="MaintenanceType" ID="rbtPlan" value="0" Text="Rencana Pemeliharaan" OnCheckedChanged="rbtMaintenanceType_CheckedChanged" AutoPostBack="true"/>
                                                    </div>
                                                </div>
                                                <div class="col-lg-3 col-md-3">
                                                    <div class="radio">
                                                        <div class="form-group">
                                                            <asp:RadioButton runat="server" GroupName="MaintenanceType" ID="rbtHistory" value="1" Text="Sejarah Pemeliharaan" OnCheckedChanged="rbtMaintenanceType_CheckedChanged" AutoPostBack="true"/>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                       <div class="form-group">
                                            <label class="col-sm-2 control-label">Unit Kerja</label>
                                            <div class="col-lg-4 col-md-4 col-sm-4">
                                                <asp:DropDownList ID="ddlOrganization" runat="server" class="chosen" OnSelectedIndexChanged="ddlOrganization_SelectedIndexChanged" AutoPostBack="true"></asp:DropDownList>
                                            </div>
                                        </div>

                                       <div class="form-group">
                                            <label class="col-sm-2 control-label"></label>
                                            <div class="col-lg-4 col-md-4">
                                                <div class="row">
                                                    <div class="col-lg-12 col-md-12">
                                                        <span class="help-block">Tanggal Inisial Rencana</span>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-lg-12 col-md-12">
                                                        <asp:TextBox ID="txtPlanBegda" runat="server" class="form-control form-control-inline input-medium default-date-picker"></asp:TextBox>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-lg-1 col-md-1"></div>
                                            <div class="col-lg-4 col-md-4">
                                                <div class="row">
                                                    <div class="col-lg-12 col-md-12">
                                                        <span class="help-block">Tanggal Akhir Rencana</span>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-lg-12 col-md-12">
                                                        <asp:TextBox ID="txtPlanEndda" runat="server" class="form-control form-control-inline input-medium default-date-picker"></asp:TextBox>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="form-group">
                                        <label class="col-sm-2 control-label"></label>
                                            <div class="col-sm-6">
		                                        <asp:LinkButton ID="btnBack" runat="server" class="btn btn-round btn-green" href="AssetMaintenance.aspx" Text="<i class='fa fa-reply'></i> Back"> </asp:LinkButton>
                                                <asp:LinkButton class="btn btn-round btn-green" Visible="true" ID="btnOkay" runat="server" Text="<i class='fa fa-check'></i> View " OnClick="btnOkay_Click"></asp:LinkButton>
                                            </div>
                                        </div>
                                </div>
                                </div>
                        </section>
                    </div>
                </div>
                <div class="row">
                    <div class="col-sm-12">
                        <section class="panel">
                            <header class="panel-heading">
                                Preventive Maintenance | Plan of Preventive Maintenance
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
                                                <button class="btn btn-green dropdown-toggle" data-toggle="dropdown">
                                                    Tools <i class="fa fa-angle-down"></i>
                                                </button>
                                                <ul class="dropdown-menu pull-right">
                                                    <li><asp:LinkButton runat="server" ID="lnkPrintDocument" OnClick="lnkPrintDocument_Click"><i class="fa fa-print"></i> Print Document</asp:LinkButton></li>
                                                </ul>
                                            </div>
                                        </div>
                                        <table class="table table-striped table-hover table-bordered" id="dynamic-table">
                                            <thead>
                                                <tr>
                                                    <th>Kode</th> 
                                                    <th>Nama Aset</th>       
                                                    <th>Grup Maintenance</th>       
                                                    <th>Jenis Maintenance</th>
                                                    <th>Periode</th>
                                                    <th>Realisasi</th>
                                                    <th>Rencana Selanjutnya</th>
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
