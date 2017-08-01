<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AssetMaintenanceHistory.aspx.cs" Inherits="AssetManagement.Views.Administrator.AssetMaintenanceHistory" %>

<%@ Import Namespace="Biofarma.AssetManagement.Data.DataAccess" %>
<%@ Import Namespace="Biofarma.AssetManagement.Business.Activity" %>
<%@ Import Namespace="Biofarma.AssetManagement.Presentation" %>
<%@ Import Namespace="Biofarma.Framework.Security" %>
<%@ Import Namespace="Biofarma.Framework.Entity" %>
<%@ Import Namespace="Biofarma.Data.DataAccess" %>
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
            Session["viewState"] = null;
            CreateDefaultFormControl();
            SetImageFileDefault();

            SetMayorType();
            SetSubType(ddlGroup.SelectedValue);
            SetAssetBySubGroup(ddlSubGroup.SelectedValue);
            Session["_attrb"] = ddlGroup.SelectedValue;

            SetInitialRowAsset();
            SetOrganisasi();
            SetLokasi();
            SetCaraPerolehan();
            SetEmployee();

            if (Request.QueryString["objid"] != null)
            {
                string _objid = Cryptography.Decrypt(Request.QueryString["objid"], true);

                if (Request.QueryString["actio"] == "1")
                {
                    SetDataToController(_objid);
                    SetAssetDetailToDataTable(_objid);
                    SetImageFile(_objid);
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

    protected void CreateDefaultFormControl()
    {
        txtDate.Text = DateTimeFormat.GetDateFormat(DateTime.Now.ToString("MM/dd/yyyy"));
        txtDate.Enabled = false;
        txtDate.CssClass = "form-control form-control-inline input-medium update";
        txtOperator.Text = (string)Session["name"];
        txtOperator.Enabled = false;
        txtOperator.CssClass = "form-control form-control-inline input-medium update";
    }

    protected void SetInitialRowAsset()
    {
        DataTable dt = new DataTable();
        DataRow dr = null;
        dt.Columns.Add(new DataColumn("RowNumber", typeof(string)));
        dt.Columns.Add(new DataColumn("AttributeLabel", typeof(string)));
        dt.Columns.Add(new DataColumn("AttributeValue", typeof(string)));

        dr = dt.NewRow();
        dr["RowNumber"] = 1;
        dr["AttributeLabel"] = string.Empty;
        dr["AttributeValue"] = string.Empty;
        dt.Rows.Add(dr);

        //Store the DataTable in ViewState
        ViewState["CurrentTableAsset"] = dt;

        grvAttribute.DataSource = dt;
        grvAttribute.DataBind();

        //Extract and Fill the DropDownList with Data
        DropDownList ddlAssetAttribute = (DropDownList)grvAttribute.Rows[0].Cells[1].FindControl("ddlAssetAttribute");
        SetAssetAttribute(ddlAssetAttribute);
    }

    protected void SetAssetAttribute(DropDownList ddlAssetAttribute)
    {
        DataTable _table = AssetCatalog.GetAssetAttributesByGroup((string)Session["_attrb"]);

        ddlAssetAttribute.Items.Clear();
        for (int index = 0; index < _table.Rows.Count; index++)
        {
            ddlAssetAttribute.Items.Add(new ListItem(_table.Rows[index]["ATTNM"].ToString(), _table.Rows[index]["OBJID"].ToString()));
        }
    }

    protected void SetAssetDetailToDataTable(string OBJID)
    {
        DataTable _table = AssetCatalog.GetAssetDetailByAssetID(OBJID);
        DataRow _row = null;

        DataTable dt = new DataTable();
        dt.Columns.Add(new DataColumn("RowNumber", typeof(string)));
        dt.Columns.Add(new DataColumn("AttributeLabel", typeof(string)));
        dt.Columns.Add(new DataColumn("AttributeValue", typeof(string)));

        if (_table.Rows.Count > 0)
        {
            for (int i = 0; i < _table.Rows.Count; i++)
            {
                _row = dt.NewRow();
                _row["RowNumber"] = (i + 1);
                _row["AttributeLabel"] = (string)_table.Rows[i]["ATTRB"];
                _row["AttributeValue"] = (string)_table.Rows[i]["VALUE"];

                dt.Rows.Add(_row);
            }

            //Store the DataTable in ViewState
            ViewState["CurrentTableAsset"] = dt;

            grvAttribute.DataSource = dt;
            grvAttribute.DataBind();

            SetPreviousDataAsset(OBJID);
        }
        else
        {
            lblAssetDetail.Visible = false;
            grvAttribute.Visible = false;
            //btnAdd.Visible = false;
        }
    }

    private void SetPreviousDataAsset(string _objid)
    {
        DataTable _data = AssetCatalog.GetAssetDetailByAssetID(_objid);

        int rowIndex = 0;
        if (ViewState["CurrentTableAsset"] != null)
        {
            DataTable dt = (DataTable)ViewState["CurrentTableAsset"];
            if (dt.Rows.Count > 0)
            {
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    //Set the Previous Selected Items on Each DropDownList on Postbacks
                    DropDownList ddlAssetAttribute = (DropDownList)grvAttribute.Rows[rowIndex].Cells[1].FindControl("ddlAssetAttribute");
                    TextBox txtValue = (TextBox)grvAttribute.Rows[rowIndex].Cells[2].FindControl("txtValue");

                    //Fill the DropDownList with Data
                    SetAssetAttribute(ddlAssetAttribute);
                    txtValue.Text = dt.Rows[i]["AttributeValue"].ToString();

                    ddlAssetAttribute.ClearSelection();
                    ddlAssetAttribute.SelectedValue = _data.Rows[i]["ATTID"].ToString();

                    rowIndex++;
                }
            }
        }
    }

    protected void SetImageFileDefault()
    {
        imgFile.ImageUrl = "http://www.placehold.it/200x150/EFEFEF/AAAAAA&amp;text=no+image";
    }

    protected void SetImageFile(string PLNID)
    {
        DataTable data = AssetCatalog.GetAssetImageByAssetID(PLNID);
        string _fileImage = string.Empty;

        if (data.Rows.Count > 0)
            _fileImage = data.Rows[0]["IMAGE"].ToString();

        string _fileURL = "../../Files/Asset_Image/" + _fileImage;

        if (_fileImage == string.Empty)
        {
            imgFile.ImageUrl = "http://www.placehold.it/200x150/EFEFEF/AAAAAA&amp;text=no+image";
        }
        else
        {
            imgFile.ImageUrl = _fileURL;
        }
    }

    protected void SetDataToController(string OBJID)
    {
        DataTable data = AssetCatalog.GetAssetHeaderByID(OBJID);

        txtAssetName.Text = data.Rows[0]["PLNNM"].ToString();
        txtNumber.Text = data.Rows[0]["PLNCD"].ToString();
        txtAssetNumber.Text = data.Rows[0]["ASTNO"].ToString();
        txtIdNumber.Text = data.Rows[0]["INVNO"].ToString();
        ddlGroup.SelectedValue = data.Rows[0]["MAJCD"].ToString();
        SetSubType(ddlGroup.SelectedValue);
        ddlSubGroup.SelectedValue = data.Rows[0]["PLNTY"].ToString();
        ddlOrganization.SelectedValue = data.Rows[0]["ORGCD"].ToString();
        ddlLocation.SelectedValue = data.Rows[0]["LOCCD"].ToString();
        txtBegda.Text = data.Rows[0]["EFFDT"].ToString() == string.Empty ? string.Empty : DateTimeFormat.ReverseDateVersionASP(data.Rows[0]["EFFDT"].ToString());
        txtEndda.Text = data.Rows[0]["EXPDT"].ToString() == string.Empty ? string.Empty : DateTimeFormat.ReverseDateVersionASP(data.Rows[0]["EXPDT"].ToString());
        ddlPerolehan.SelectedValue = data.Rows[0]["HOWGT"].ToString();
        txtTanggalPerolehan.Text = data.Rows[0]["GETDT"].ToString() == string.Empty ? string.Empty : DateTimeFormat.ReverseDateVersionASP(data.Rows[0]["GETDT"].ToString());
        ddlEmployee.SelectedValue = data.Rows[0]["HOLDR"].ToString();

        if (rbtStatusBaik.Attributes["Value"] == data.Rows[0]["STACD"].ToString())
            rbtStatusBaik.Checked = true;
        else if (rbtTidakProduktif.Attributes["Value"] == data.Rows[0]["STACD"].ToString())
            rbtTidakProduktif.Checked = true;
        else if (rbtStatusRusak.Attributes["Value"] == data.Rows[0]["STACD"].ToString())
            rbtStatusRusak.Checked = true;
        else
            rbtNonFisik.Checked = true;

        txtPeruntukan.Text = data.Rows[0]["ASTTO"].ToString();
        txtMTBF.Text = data.Rows[0]["MTBF"].ToString();
        txtNilaiAset.Text = Currency.SetNominalToRupiahFormat(Convert.ToInt32(Convert.ToDouble(data.Rows[0]["WORTH"])).ToString());
        txtKeterangan.Text = data.Rows[0]["ANNOT"].ToString();

        Session["_attrb"] = ddlGroup.SelectedValue;
    }

    protected void SetEmployee()
    {
        DataTable data = UserCatalog.GetEmployee();

        ddlEmployee.Items.Clear();
        ddlEmployee.Items.Add(new ListItem("Tanpa Pemegang Aset", "0"));
        for (int i = 0; i < data.Rows.Count; i++)
        {
            ddlEmployee.Items.Add(new ListItem(data.Rows[i]["PERNR"].ToString() + " - " + data.Rows[i]["CNAME"].ToString(), data.Rows[i]["PERNR"].ToString()));
        }
    }

    protected void SetMayorType()
    {
        DataTable data = AssetCatalog.GetAssetMayorTypes();

        ddlGroup.Items.Clear();
        for (int i = 0; i < data.Rows.Count; i++)
        {
            ddlGroup.Items.Add(new ListItem(data.Rows[i]["MAJOR"].ToString(), data.Rows[i]["MAJCD"].ToString()));
        }
    }

    protected void SetSubType(string MAJCD)
    {
        DataTable data = AssetCatalog.GetAssetSubtypeByMajorCode(MAJCD);

        ddlSubGroup.Items.Clear();
        for (int i = 0; i < data.Rows.Count; i++)
        {
            ddlSubGroup.Items.Add(new ListItem(data.Rows[i]["SUBNM"].ToString(), data.Rows[i]["SUBCD"].ToString()));
        }
    }

    protected void SetAssetBySubGroup(string SUBCD)
    {
        DataTable data = AssetCatalog.GetAssetHeaderBySubGroup(SUBCD);

        ddlAssetParent.Items.Clear();
        ddlAssetParent.Items.Add(new ListItem("Tidak Ada", "0"));
        for (int i = 0; i < data.Rows.Count; i++)
        {
            string _kodeAset = data.Rows[i]["ASTNO"].ToString() == string.Empty ? data.Rows[i]["PLNCD"].ToString() : data.Rows[i]["ASTNO"].ToString();
            ddlAssetParent.Items.Add(new ListItem(data.Rows[i]["PLNNM"].ToString() + " (" + _kodeAset + ")", data.Rows[i]["OBJID"].ToString()));
        }
    }

    protected void ddlSubGroup_SelectedIndexChanged(object sender, EventArgs e)
    {
        SetAssetBySubGroup(ddlSubGroup.SelectedValue);
    }

    protected void ddlGroup_SelectedIndexChanged(object sender, EventArgs e)
    {
        SetSubType(ddlGroup.SelectedValue);
        Session["_attrb"] = ddlGroup.SelectedValue;
        SetAssetBySubGroup(ddlSubGroup.SelectedValue);
        SetInitialRowAsset();
    }

    protected void SetCaraPerolehan()
    {
        ddlPerolehan.Items.Clear();
        ddlPerolehan.Items.Add(new ListItem("Pembelian Langsung", "Pembelian Langsung"));
        ddlPerolehan.Items.Add(new ListItem("Sewa", "Sewa"));
        ddlPerolehan.Items.Add(new ListItem("Hibah", "Hibah"));
    }

    protected void SetOrganisasi()
    {
        DataTable data = OrganizationCatalog.GetUnitOrganization();

        ddlOrganization.Items.Clear();
        for (int i = 0; i < data.Rows.Count; i++)
        {
            ddlOrganization.Items.Add(new ListItem(data.Rows[i]["ORGNM"].ToString(), data.Rows[i]["ORGCD"].ToString()));
        }
    }

    protected void SetLokasi()
    {
        DataTable data = AssetCatalog.GetClusterArea();

        ddlLocation.Items.Clear();
        for (int i = 0; i < data.Rows.Count; i++)
        {
            ddlLocation.Items.Add(new ListItem(data.Rows[i]["CLUST"].ToString(), data.Rows[i]["OBJID"].ToString()));
        }
    }

    protected DataSet CreateDataReport(DataTable dataTable, DateTime begda, DateTime endda, string ORGNM, bool isNeedPeriode)
    {
        DataSet dataSet = new DataSet();
        dataSet.Tables.Add(dataTable);
        dataSet.Tables.Add("Header");
        dataSet.Tables.Add("Footer");


        dataSet.Tables["Header"].Columns.Add("ORGNM", typeof(string));
        dataSet.Tables["Header"].Columns.Add("PERIO", typeof(string));

        if (isNeedPeriode)
            dataSet.Tables["Header"].Rows.Add(new object[] { ORGNM, DateTimeFormat.GetDateFormat(begda.ToString()) + " - " + DateTimeFormat.GetDateFormat(endda.ToString()) });
        else
            dataSet.Tables["Header"].Rows.Add(new object[] { ORGNM, "-" });

        dataSet.Tables["Footer"].Columns.Add("PRTDT", typeof(string));
        dataSet.Tables["Footer"].Columns.Add("PDTTM", typeof(string));
        dataSet.Tables["Footer"].Columns.Add("RVPOS", typeof(string));
        dataSet.Tables["Footer"].Columns.Add("RVWNM", typeof(string));
        dataSet.Tables["Footer"].Columns.Add("RVWPN", typeof(string));
        dataSet.Tables["Footer"].Rows.Add(new object[] { DateTimeFormat.GetDateFormat(DateTime.Today.ToString()), DateTimeFormat.GetDateTimeFormat(DateTime.Now.ToString()), Session["prorg"].ToString(), Session["name"].ToString(), Session["username"].ToString() });

        return dataSet;
    }

    protected String GenerateData(string objid)
    {
        StringBuilder _table = new StringBuilder();

        if (Session["viewState"] != null)
        {
            DateTime _initDate = Convert.ToDateTime(DateTimeFormat.ReverseDateVersionSQL(txtPlanBegda.Text));
            DateTime _endDate = Convert.ToDateTime(DateTimeFormat.ReverseDateVersionSQL(txtPlanEndda.Text));

            DataTable _data = PreventiveMaintenance.GetAssetMaintenanceHistory(objid, _initDate, _endDate, true);
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
        else
        {
            DataTable _data = PreventiveMaintenance.GetAssetMaintenanceHistory(objid, DateTime.Now, DateTime.Now, false);
            Session["CurrentDataSet"] = CreateDataReport(_data, DateTime.Now, DateTime.Now, ddlOrganization.SelectedItem.Text, false);

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

        return _table.ToString();
    }

    protected void btnOkay_Click(object sender, EventArgs e)
    {
        if (txtPlanBegda.Text == string.Empty)
        {
            ClientScript.RegisterStartupScript(this.GetType(), "myalert", "alert('" + "Informasi tanggal inisial rencana tidak boleh kosong" + "');", true);
        }
        else if (txtPlanEndda.Text == string.Empty)
        {
            ClientScript.RegisterStartupScript(this.GetType(), "myalert", "alert('" + "Informasi tanggal akhir rencana tidak boleh kosong" + "');", true);
        }
        else
        {
            Session["viewState"] = true;
        }
        
        this.btnOkay.Focus();
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
                                Preventive Maintenance | History of Maintenance
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
                                            <label class="col-sm-2 control-label"></label>
                                            <div class="col-lg-3 col-md-3">
                                                <span class="help-block"></span>
                                            </div>
                                            <div class="col-lg-3 col-md-3">
                                                <span class="help-block"></span>
                                            </div>
                                            <div class="col-lg-3 col-md-3">
                                                <span class="help-block"></span>
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <label class="col-sm-2 control-label"></label>
                                            <div class="col-lg-4 col-md-4">
                                                <div class="row">
                                                    <div class="col-lg-12 col-md-12">
                                                        <span class="help-block">Nama Aset</span>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-lg-12 col-md-12">
                                                        <asp:TextBox ID="txtAssetName" runat="server" class="form-control  m-bot15" Enabled="false" CssClass ="form-control form-control-inline input-medium update"></asp:TextBox>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-lg-1 col-md-1"></div>
                                            <div class="col-lg-4 col-md-4">
                                                <div class="row">
                                                    <div class="col-lg-12 col-md-12">
                                                        <span class="help-block popovers" data-original-title='Informasi Aset' data-content='ID Alat digunakan untuk informasi penomoran alat oleh QA' data-placement='left' data-trigger='hover'>ID Alat</span>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-lg-12 col-md-12">
                                                        <asp:TextBox ID="txtIdNumber" runat="server" class="form-control  m-bot15" Enabled="false" CssClass ="form-control form-control-inline input-medium update"></asp:TextBox>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <label class="col-sm-2 control-label"></label>
                                            <div class="col-lg-4 col-md-4">
                                                <div class="row">
                                                    <div class="col-lg-12 col-md-12">
                                                        <span class="help-block">Nomor Aset</span>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-lg-12 col-md-12">
                                                        <asp:TextBox ID="txtAssetNumber" runat="server" class="form-control  m-bot15" Enabled="false" CssClass ="form-control form-control-inline input-medium update"></asp:TextBox>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-lg-1 col-md-1"></div>
                                            <div class="col-lg-4 col-md-4">
                                                <div class="row">
                                                    <div class="col-lg-12 col-md-12">
                                                        <span class="help-block popovers" data-original-title='Informasi Aset' data-content='Nomor inventaris digunakan untuk penomoran aset oleh manajemen aset' data-placement='left' data-trigger='hover'>Nomor Inventaris</span>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-lg-12 col-md-12">
                                                        <asp:TextBox ID="txtNumber" runat="server" class="form-control  m-bot15" Enabled="false" CssClass ="form-control form-control-inline input-medium update"></asp:TextBox>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <label class="col-sm-2 control-label"></label>
                                            <div class="col-lg-4 col-md-4">
                                                <div class="row">
                                                    <div class="col-lg-12 col-md-12">
                                                        <span class="help-block">Pemegang Aset</span>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-lg-12 col-md-12">
                                                        <asp:DropDownList ID="ddlEmployee" runat="server" class="chosen" Enabled="false" CssClass ="form-control form-control-inline input-medium update"></asp:DropDownList>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <label class="col-sm-2 control-label"></label>
                                            <div class="col-lg-4 col-md-4">
                                                <div class="row">
                                                    <div class="col-lg-12 col-md-12">
                                                        <span class="help-block">Group</span>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-lg-12 col-md-12">
                                                        <asp:DropDownList ID="ddlGroup" runat="server" class="chosen" OnSelectedIndexChanged="ddlGroup_SelectedIndexChanged" AutoPostBack="true" Enabled="false" CssClass ="form-control form-control-inline input-medium update"></asp:DropDownList>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-lg-1 col-md-1"></div>
                                            <div class="col-lg-4 col-md-4">
                                                <div class="row">
                                                    <div class="col-lg-12 col-md-12">
                                                        <span class="help-block">Sub Group</span>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-lg-12 col-md-12">
                                                        <asp:DropDownList ID="ddlSubGroup" runat="server" class="chosen" OnSelectedIndexChanged="ddlSubGroup_SelectedIndexChanged" AutoPostBack="true" Enabled="false" CssClass ="form-control form-control-inline input-medium update"></asp:DropDownList>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <label class="col-sm-2 control-label"></label>
                                            <div class="col-lg-4 col-md-4">
                                                <div class="row">
                                                    <div class="col-lg-12 col-md-12">
                                                        <span class="help-block">Organisasi</span>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-lg-12 col-md-12">
                                                        <asp:DropDownList ID="ddlOrganization" runat="server" class="chosen" Enabled="false" CssClass ="form-control form-control-inline input-medium update"></asp:DropDownList>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-lg-1 col-md-1"></div>
                                            <div class="col-lg-4 col-md-4">
                                                <div class="row">
                                                    <div class="col-lg-12 col-md-12">
                                                        <span class="help-block">Lokasi</span>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-lg-12 col-md-12">
                                                        <asp:DropDownList ID="ddlLocation" runat="server" class="chosen" Enabled="false" CssClass ="form-control form-control-inline input-medium update"></asp:DropDownList>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <label class="col-sm-2 control-label"></label>
                                            <div class="col-lg-4 col-md-4">
                                                <div class="row">
                                                    <div class="col-lg-12 col-md-12">
                                                        <span class="help-block">Mulai Tanggal</span>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-lg-12 col-md-12">
                                                        <asp:TextBox ID="txtBegda" runat="server" class="form-control form-control-inline input-medium default-date-picker" Enabled="false" CssClass ="form-control form-control-inline input-medium update"></asp:TextBox>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-lg-1 col-md-1"></div>
                                            <div class="col-lg-4 col-md-4">
                                                <div class="row">
                                                    <div class="col-lg-12 col-md-12">
                                                        <span class="help-block">Berakhir Tanggal</span>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-lg-12 col-md-12">
                                                        <asp:TextBox ID="txtEndda" runat="server" class="form-control form-control-inline input-medium default-date-picker" Enabled="false" CssClass ="form-control form-control-inline input-medium update"></asp:TextBox>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <label class="col-sm-2 control-label"></label>
                                            <div class="col-lg-4 col-md-4">
                                                <div class="row">
                                                    <div class="col-lg-12 col-md-12">
                                                        <span class="help-block">Cara Perolehan</span>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-lg-12 col-md-12">
                                                        <asp:DropDownList ID="ddlPerolehan" runat="server" class="chosen"  Enabled="false" CssClass ="form-control form-control-inline input-medium update"></asp:DropDownList>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-lg-1 col-md-1"></div>
                                            <div class="col-lg-4 col-md-4">
                                                <div class="row">
                                                    <div class="col-lg-12 col-md-12">
                                                        <span class="help-block">Tanggal Perolehan</span>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-lg-12 col-md-12">
                                                        <asp:TextBox ID="txtTanggalPerolehan" runat="server" class="form-control form-control-inline input-medium default-date-picker" Enabled="false" CssClass ="form-control form-control-inline input-medium update"></asp:TextBox>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <label class="col-sm-2 control-label">Status Aset</label>
                                            <div class="col-lg-10 col-md-10">
                                                <div class="col-lg-3 col-md-3">
                                                    <div class="radio">
                                                        <asp:RadioButton runat="server" GroupName="NewStatus" ID="rbtStatusBaik" value="1" Text="Aset Baik" Enabled="false"/>
                                                    </div>
                                                </div>
                                                <div class="col-lg-3 col-md-3">
                                                    <div class="radio">
                                                        <div class="form-group">
                                                            <asp:RadioButton runat="server" GroupName="NewStatus" ID="rbtStatusRusak" value="2" Text="Aset Rusak" Enabled="false"/>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-lg-3 col-md-3">
                                                    <div class="radio">
                                                        <div class="form-group">
                                                            <asp:RadioButton runat="server" GroupName="NewStatus" ID="rbtNonFisik" value="3" Text="Fisik Tidak Ada" Enabled="false"/>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-lg-3 col-md-3">
                                                    <div class="radio">
                                                        <div class="form-group">
                                                                <asp:RadioButton runat="server" GroupName="NewStatus" ID="rbtTidakProduktif" value="4" Text="Aset Tidak Produktif" Enabled="false"/>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="form-group">
                                        <asp:Label runat="server" ID="lblNilaiAset" class="col-sm-2 control-label popovers" data-original-title='Informasi Aset' data-content='Nilai Aset. Silakan isikan dengan 1 jika aset merupakan aset tidak tetap atau tidak bernilai. Format aset dalam satuan mata uang Rupiah (Rp).' data-placement='right' data-trigger='hover' Text="Nilai Buku"></asp:Label>
                                            <div class="col-lg-4 col-md-4 col-sm-4">
                                                <asp:TextBox ID="txtNilaiAset" runat="server" class="form-control  m-bot15"  Enabled="false" CssClass ="form-control form-control-inline input-medium update"></asp:TextBox>
                                            </div>
                                        </div>

                                        <div class="form-group">
                                        <label class="col-sm-2 control-label">Peruntukan</label>
                                            <div class="col-lg-9 col-md-9 col-sm-9">
                                                <asp:TextBox ID="txtPeruntukan" runat="server" class="form-control  m-bot15" TextMode="MultiLine" Rows="2" Enabled="false" CssClass ="form-control form-control-inline input-medium update"></asp:TextBox>
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <label class="col-sm-2 control-label popovers" data-original-title='Informasi Aset' data-content='Mean Time Between Failures. Standard periode yang diberikan untuk melakukan perawatan terhadap aset' data-placement='right' data-trigger='hover'>MTBF (Hari)</label>
                                            <div class="col-lg-4 col-md-4">
                                                <asp:TextBox ID="txtMTBF" runat="server" class="form-control m-bot15" Enabled="false" CssClass ="form-control form-control-inline input-medium update"></asp:TextBox>
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <label class="col-sm-2 control-label">Keterangan</label>
                                            <div class="col-lg-9 col-md-9 col-sm-9">
                                                <asp:TextBox ID="txtKeterangan" runat="server" class="form-control m-bot15" TextMode="MultiLine" Rows="3" MaxLength="200" Enabled="false" CssClass ="form-control form-control-inline input-medium update"></asp:TextBox>
                                            </div>
                                        </div>
                                        

                                        <div class="form-group">
                                            <label class="col-sm-2 control-label popovers" data-original-title='Informasi Aset' data-content='Relasi aset. Silakan pilih induk aset apabila aset yang akan didaftarkan merupakan bagian dari aset yang telah terdaftar' data-placement='right' data-trigger='hover'>Induk Aset</label>
                                            <div class="col-lg-9 col-md-9 col-sm-9">
                                                <asp:DropDownList ID="ddlAssetParent" runat="server" class="chosen" Enabled="false" CssClass ="form-control form-control-inline input-medium update"></asp:DropDownList>
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <asp:Label ID="lblFileUpload" runat="server" class="col-sm-2 control-label  popovers" data-original-title='Informasi Aset' data-content='Upload Image. Upload gambar untuk memvisualisasikan aset dalam bentuk gambar, format JPG/JPEG/PNG' data-placement='right' data-trigger='hover' Text="Upload Image"></asp:Label>
                                            <div class="col-lg-4 col-md-4">
                                                <div class="fileupload fileupload-new" data-provides="fileupload">
                                                    <div class="fileupload-new thumbnail" style="width: 200px; height: 150px;">
                                                        <asp:Image ID="imgFile" runat="server" alt="" />
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <div class="col-sm-12">
                                                <p style="font-size: 15px; margin-bottom: 30px;margin-top: 30px;" align="center">
                                                <asp:Label runat="server" ID="lblAssetDetail" ><strong>DETAIL ASET</strong></asp:Label></p>
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <div class="col-sm-2 control-label">
                                                <%--<asp:Button class="btn btn-round btn-green" Visible="true" ID="btnAdd" runat="server" Text="Add +" OnClick="ButtonAddAssetDetail_Click" EnableViewState="true"></asp:Button>--%>
                                            </div>
                                            <div class="col-sm-9">
                                                <asp:GridView ID="grvAttribute" Width="100%" BorderStyle="None" HeaderStyle-HorizontalAlign="Left" HeaderStyle-VerticalAlign="Middle" runat="server" ShowFooter="true" class="table table-striped table-bordered table-condensed" AutoGenerateColumns="false">
                                                    <Columns>
                                                        <asp:BoundField HeaderStyle-HorizontalAlign="Left" HeaderStyle-VerticalAlign="Middle" ItemStyle-HorizontalAlign="Center" FooterStyle-BorderStyle="None" ItemStyle-BorderStyle="None" HeaderStyle-BorderStyle="None" Visible="false" />
                                                        <asp:TemplateField HeaderStyle-HorizontalAlign="Left" HeaderStyle-VerticalAlign="Middle" FooterStyle-BorderStyle="None" ItemStyle-BorderStyle="None" HeaderStyle-BorderStyle="None" HeaderText="Atribut Aset">
                                                            <HeaderStyle Width="70%" HorizontalAlign="Left" VerticalAlign="Middle" />
                                                            <ItemTemplate>
                                                                <asp:DropDownList ID="ddlAssetAttribute" runat="server" class="chosen" Enabled="false" CssClass="form-control form-control-inline input-medium update"></asp:DropDownList>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderStyle-HorizontalAlign="Left" HeaderStyle-VerticalAlign="Middle" FooterStyle-BorderStyle="None" ItemStyle-BorderStyle="None" HeaderStyle-BorderStyle="None" HeaderText="Informasi">
                                                            <HeaderStyle Width="30%" HorizontalAlign="Left" VerticalAlign="Middle" />
                                                            <ItemTemplate>
                                                                <asp:TextBox ID="txtValue" runat="server" class="form-control" style="text-align:left;" autocomplete="off" Enabled="false" CssClass="form-control form-control-inline input-medium update"></asp:TextBox>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <%--<asp:CommandField ItemStyle-HorizontalAlign="Center" ItemStyle-VerticalAlign="Middle" ControlStyle-CssClass="btn btn-red" FooterStyle-BorderStyle="None"  ItemStyle-BorderStyle="None" HeaderStyle-BorderStyle="None" ButtonType="Link" ShowDeleteButton="true" ItemStyle-Width="150" DeleteText="X" />--%>
                                                    </Columns>
                                                </asp:GridView>
                                            </div>
                                            <div class="col-sm-2">
                                            </div>
                                        </div>
                                        
                                        <div class="form-group">
                                            <div class="col-sm-12">
                                                <p style="font-size: 15px; margin-bottom: 30px;margin-top: 30px;" align="center">
                                                <asp:Label runat="server" ID="Label1" ><strong>MAINTENANCE HISTORY</strong></asp:Label></p>
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
                                Preventive Maintenance | History of Asset Maintenance 
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
                                                    <li><asp:HyperLink runat="server" ></asp:HyperLink></li>
                                                    <li><a href="../Reporting/AssetMaintenanceHistoryReporting.aspx"><i class="fa fa-print"></i> Print Document</a></li>
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
                                                    <th>Realisasi Sebelumnya</th>
                                                    <th>Rencana Selanjutnya</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <%  Response.Write(GenerateData(Cryptography.Decrypt(Request.QueryString["objid"], true))); %>
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