﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AssetDisposal.aspx.cs" Inherits="AssetManagement.Views.Administrator.AssetDisposal" %>

<%@ Import Namespace="Biofarma.AssetManagement.Data.DataAccess" %>
<%@ Import Namespace="Biofarma.AssetManagement.Presentation" %>
<%@ Import Namespace="Biofarma.AssetManagement.Business.Entity" %>
<%@ Import Namespace="Biofarma.Framework.Security" %>
<%@ Import Namespace="Biofarma.Framework.Entity" %>
<%@ Import Namespace="Biofarma.Presentation.Component" %>
<%@ Import Namespace="Biofarma.Framework.Converter" %>
<%@ Import Namespace="Biofarma.Data.DataAccess" %>
<%@ Import Namespace="System.Web.Configuration" %>
<%@ Import Namespace="Biofarma.Business.Activity" %>
<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="System.Data" %>

<!DOCTYPE html>
<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        //SessionCreator();
        if (Session["username"] == null && Session["password"] == null) Response.Redirect(WebConfigurationManager.AppSettings["LoginTo"]);
        if (!IsPostBack)
        {
            Session["isExist"] = null;
            
            CreateDefaultFormControl();
            SetImageFileDefault();
            
            SetMayorType();
            SetSubType(ddlGroup.SelectedValue);
            SetAssetBySubGroup(ddlSubGroup.SelectedValue);
            Session["_attrb"] = ddlGroup.SelectedValue;
            
            SetInitialRow();
            SetOrganisasi();
            SetLokasi();
            SetCaraPerolehan();
            SetEmployee();
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
    
    protected int GetAssetByAssetNumber(string ASTNO)
    {
        DataTable data = AssetCatalog.GetAssetHeaderByInventoryNumber(ASTNO);

        if (data.Rows.Count > 0)
            return Convert.ToInt32(data.Rows[0]["OBJID"]);
        else
        {
            data = AssetCatalog.GetAssetHeaderByPlantCode(ASTNO);

            if (data.Rows.Count > 0)
                return Convert.ToInt32(data.Rows[0]["OBJID"]);
            else 
            {
                if (data.Rows.Count > 0)
                    return Convert.ToInt32(data.Rows[0]["OBJID"]);
                else
                {
                    data = AssetCatalog.GetAssetHeaderByAssetNumber(ASTNO);

                    if (data.Rows.Count > 0)
                        return Convert.ToInt32(data.Rows[0]["OBJID"]);
                    else
                    {
                        return 0;
                    }
                }
            }
        }
    }
    
    protected void ValidateAssetNumber(string ASTNO)
    {
        int _objid = GetAssetByAssetNumber(ASTNO);
        Session["objid"] = _objid.ToString();
        
        if (_objid > 0)
        {
            SetDataToController(_objid.ToString());
            SetAssetDetailToDataTable(_objid.ToString());
            SetImageFile(_objid.ToString());
            Session["isExist"] = true;
        }
        else
        {
            ClientScript.RegisterStartupScript(this.GetType(), "myalert", "alert('" + "NOMOR ASET TIDAK TERDAFTAR" + "');", true);
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
        SetImageFile(OBJID);
        
        Session["_attrb"] = ddlGroup.SelectedValue;
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

    protected void ddlSubGroup_SelectedIndexChanged(object sender, EventArgs e)
    {
        SetAssetBySubGroup(ddlSubGroup.SelectedValue);
    }

    protected void ddlGroup_SelectedIndexChanged(object sender, EventArgs e)
    {
        SetSubType(ddlGroup.SelectedValue);
        Session["_attrb"] = ddlGroup.SelectedValue;
        SetAssetBySubGroup(ddlSubGroup.SelectedValue);
        SetInitialRow();
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

    //save action
    protected void btnSave_Click(object sender, EventArgs e)
    {
        string passcode = string.Empty;

        if (ConfigurationManager.AppSettings["sso"] == ((int)ConfigurationStatus.Yes).ToString())
        {
            passcode = txtConfirmation.Text;
        }
        else
        {
            passcode = Cryptography.Encrypt(txtConfirmation.Text, true);
        }

        if (passcode == Session["password"].ToString())
        {
            if (!rbtNewNonFisik.Checked && !rbtNewStatusBaik.Checked && !rbtNewStatusRusak.Checked && !rbtNewTidakProduktif.Checked)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "myalert", "alert('" + "Informasi status aset penghapusbukuan tidak boleh kosong" + "');", true);
            }
            else if (txtNilaiBuku.Text == string.Empty)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "myalert", "alert('" + "Informasi nilai buku tidak boleh kosong" + "');", true);
            }
            else if (!Validation.IsValidInteger(txtNilaiBuku.Text))
            {
                ClientScript.RegisterStartupScript(this.GetType(), "myalert", "alert('" + "Nilai buku harus bilangan bulat positif" + "');", true);
            }
            else
            {
                UpdateData();
                Response.Redirect("Asset.aspx");
            }
        }
        else
        {
            ClientScript.RegisterStartupScript(this.GetType(), "myalert", "alert('Your Password is Incorrect');", true);
        }
    }
    
    protected string GetFileName(FileUpload file)
    {
        if (file.HasFile)
            return FileFormat.RenameFile(txtNumber.Text, file);
        else
            return string.Empty;
    }
    
    //Update set action
    protected void UpdateData()
    {
        int _objid = Session["objid"] != null ? Convert.ToInt32(Session["objid"]) : 0;
        UpdateAssetDisposal(_objid.ToString());
    }

    protected void UpdateAssetDisposal(string OBJID)
    {
        string _statusCode = rbtNewStatusBaik.Checked ? rbtNewStatusBaik.Attributes["Value"] : (rbtNewTidakProduktif.Checked ? rbtNewTidakProduktif.Attributes["Value"] : (rbtNewStatusRusak.Checked ? rbtNewStatusRusak.Attributes["Value"] : rbtNewNonFisik.Attributes["Value"]));
        string _statusName = rbtNewStatusBaik.Checked ? rbtNewStatusBaik.Text : (rbtNewTidakProduktif.Checked ? rbtNewTidakProduktif.Text : (rbtNewStatusRusak.Checked ? rbtNewStatusRusak.Text : rbtNewNonFisik.Text));
        string _kodePenghapusan = rbtHibah.Checked ? rbtHibah.Attributes["Value"] : rbtLelang.Attributes["Value"];
        string _jenisPenghapusan = rbtHibah.Checked ? rbtHibah.Text : rbtLelang.Text;
        

        string _refCode = Code.CreateSequenceCode("D" + DateTime.Today.Month.ToString() + DateTime.Today.Year.ToString(), ((int)WorkflowType.Disposal).ToString(), 2, AssetWorkflow.GetAssetDisposalMaxNumber().ToString(), 3);

        AssetCatalog.UpdateAssetDisposal(OBJID, _refCode, ((int)ApprovalStatus.Unapproved).ToString(), DateTime.Now.ToString(), txtNilaiBuku.Text, _statusCode, _statusName, _kodePenghapusan, _jenisPenghapusan, string.Empty, string.Empty, (string)Session["username"]);
        AssetWorkflow.InsertWorkFlow(_refCode, ((int)WorkflowUser.UnitUser).ToString(), ((int)WorkflowType.Disposal).ToString(), Session["username"].ToString(), Session["poscd"].ToString(), string.Empty, ((int)WorkflowStatus.Request).ToString(), Session["username"].ToString());
        
    }

    //Gridview need to evaluate
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
            ViewState["CurrentTable"] = dt;

            grvAttribute.DataSource = dt;
            grvAttribute.DataBind();

            SetPreviousData(OBJID);
        }
        else
        {
            lblAssetDetail.Visible = false;
            grvAttribute.Visible = false;
        }

    }

    protected void InsertAssetDetail(string PLNID)
    {
        if (ViewState["CurrentTable"] != null)
        {   
            DataTable dtCurrentTable = (DataTable)ViewState["CurrentTable"];
            
            if (dtCurrentTable.Rows.Count > 0)
            {
                for (int rowIndex = 0; rowIndex < dtCurrentTable.Rows.Count; rowIndex++)
                {
                    DropDownList ddlAssetAttribute = (DropDownList)grvAttribute.Rows[rowIndex].Cells[1].FindControl("ddlAssetAttribute");
                    TextBox txtValue = (TextBox)grvAttribute.Rows[rowIndex].Cells[2].FindControl("txtValue");

                    if (txtValue.Text != string.Empty)
                    {
                        AssetCatalog.UpdateAssetDetail(0, PLNID, ddlAssetAttribute.SelectedValue, ddlAssetAttribute.SelectedItem.Text, txtValue.Text, (string)Session["username"]);
                    }
                }
            }
        }
    }
    
    protected void EmptyAssetDetail(string PLNID)
    {
        AssetCatalog.DeleteAssetDetailByHeader(PLNID);
    }
    
    protected void DelimitAssetDetail(string PLNID)
    {
        AssetCatalog.DelimitAssetDetailByHeader(PLNID, (string) Session["username"]);
    }

    protected void SetInitialRow()
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
        ViewState["CurrentTable"] = dt;
        
        grvAttribute.DataSource = dt;
        grvAttribute.DataBind();

        //Extract and Fill the DropDownList with Data
        DropDownList ddlAssetAttribute = (DropDownList)grvAttribute.Rows[0].Cells[1].FindControl("ddlAssetAttribute");
        SetAssetAttribute(ddlAssetAttribute);
    }

    private void AddNewRowToGrid()
    {
        int rowIndex = 0;

        if (ViewState["CurrentTable"] != null)
        {
            DataTable dtCurrentTable = (DataTable)ViewState["CurrentTable"];
            DataRow drCurrentRow = null;
            if (dtCurrentTable.Rows.Count > 0)
            {
                for (int i = 1; i <= dtCurrentTable.Rows.Count; i++)
                {
                    //extract the TextBox values
                    DropDownList ddlAssetAttribute = (DropDownList)grvAttribute.Rows[rowIndex].Cells[1].FindControl("ddlAssetAttribute");
                    TextBox txtValue = (TextBox)grvAttribute.Rows[rowIndex].Cells[2].FindControl("txtValue");

                    drCurrentRow = dtCurrentTable.NewRow();
                    drCurrentRow["RowNumber"] = i + 1;

                    dtCurrentTable.Rows[i - 1]["AttributeLabel"] = ddlAssetAttribute.Text;
                    dtCurrentTable.Rows[i - 1]["AttributeValue"] = txtValue.Text;

                    rowIndex++;
                }
                dtCurrentTable.Rows.Add(drCurrentRow);
                ViewState["CurrentTable"] = dtCurrentTable;

                grvAttribute.DataSource = dtCurrentTable;
                grvAttribute.DataBind();
            }
        }
        else
        {
            Response.Write("ViewState is null");
        }
        
        //Set Previous Data on Postbacks
        SetPreviousData();
    }

    private void SetPreviousData()
    {
        int rowIndex = 0;
        if (ViewState["CurrentTable"] != null)
        {
            DataTable dt = (DataTable)ViewState["CurrentTable"];
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

                    if (i < dt.Rows.Count - 1)
                    {
                        ddlAssetAttribute.ClearSelection();
                        ddlAssetAttribute.SelectedValue = dt.Rows[i]["AttributeLabel"].ToString();
                    }
                    
                    rowIndex++;
                }
            }
        }
    }

    private void SetPreviousData(string _objid)
    {
        DataTable _data = AssetCatalog.GetAssetDetailByAssetID(_objid);
        
        int rowIndex = 0;
        if (ViewState["CurrentTable"] != null)
        {
            DataTable dt = (DataTable)ViewState["CurrentTable"];
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

    protected void ButtonAdd_Click(object sender, EventArgs e)
    {
        AddNewRowToGrid();
    }

    protected void OnRowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        int rowIndex = 0;
        int index = Convert.ToInt32(e.RowIndex);

        if (ViewState["CurrentTable"] != null)
        {
            DataTable dtCurrentTable = (DataTable)ViewState["CurrentTable"];
            DataRow drCurrentRow = null;
            if (dtCurrentTable.Rows.Count != 1)
            {
                for (int i = 1; i <= dtCurrentTable.Rows.Count; i++)
                {
                    //extract the TextBox values
                    DropDownList ddlAssetAttribute = (DropDownList)grvAttribute.Rows[rowIndex].Cells[1].FindControl("ddlAssetAttribute");
                    TextBox txtValue = (TextBox)grvAttribute.Rows[rowIndex].Cells[2].FindControl("txtValue");

                    drCurrentRow = dtCurrentTable.NewRow();
                    drCurrentRow["RowNumber"] = i + 1;

                    dtCurrentTable.Rows[i - 1]["AttributeLabel"] = ddlAssetAttribute.Text;
                    dtCurrentTable.Rows[i - 1]["AttributeValue"] = txtValue.Text;

                    rowIndex++;
                }
                DataTable dt = (DataTable)ViewState["CurrentTable"];
                dt.Rows[e.RowIndex].Delete();

                ViewState["CurrentTable"] = dtCurrentTable;
                grvAttribute.DataSource = dtCurrentTable;
                grvAttribute.DataBind();
            }
            
            //Set Previous Data on Postbacks
            SetPreviousData();
        }
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

    protected void btnCheck_Click(object sender, EventArgs e)
    {
        ValidateAssetNumber(txtVerifyNumber.Text);
    }

    protected void rbtPenghapusan_CheckedChanged(object sender, EventArgs e)
    {
        if (rbtNewStatusRusak.Checked)
        {
            rbtHibah.Checked = false;
            rbtLelang.Checked = true;
            btnOkay.Visible = true;
        }
        else if (rbtNewTidakProduktif.Checked)
        {
            rbtLelang.Checked = false;
            rbtHibah.Checked = true;
            btnOkay.Visible = true;
        }
        else if (rbtNewNonFisik.Checked)
        {
            rbtLelang.Checked = false;
            rbtHibah.Checked = false;
            btnOkay.Visible = true;
        }
        else
        {
            rbtLelang.Checked = false;
            rbtHibah.Checked = false;
            btnOkay.Visible = false;
        }
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
                                Disposal Form
                            </header>
                                <div class="panel-body">
                                    <div class="form-horizontal " runat="server">
                                        
                                        <div class="form-group">
                                            <label class="col-sm-2 control-label">Tanggal</label>
                                            <div class="col-lg-4 col-md-4 col-sm-4">
                                                <asp:TextBox ID="txtDate" runat="server" class="form-control  m-bot15" Enabled="false" CssClass="form-control form-control-inline input-medium update"></asp:TextBox>
                                            </div>
                                            <label class="col-sm-1 control-label">Operator</label>
                                            <div class="col-lg-4 col-md-4 col-sm-4">
                                                <asp:TextBox ID="txtOperator" runat="server" class="form-control  m-bot15" Enabled="false" CssClass ="form-control form-control-inline input-medium update"></asp:TextBox>
                                            </div>
                                        </div>

                                        <% if (Session["isExist"] == null) { %>

                                        <div class="form-group">
                                        <label class="col-sm-2 control-label">Nomor Aset</label>
                                            <div class="col-lg-4 col-md-4 col-sm-4">
                                                <asp:TextBox ID="txtVerifyNumber" runat="server" class="form-control  m-bot15"></asp:TextBox>
                                            </div>
                                        </div>
                                         
                                        <% } else { %>

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
                                            <div class="col-sm-12">
                                                <p style="font-size: 15px; margin-bottom: 30px;margin-top: 30px;" align="center">
                                                <asp:Label runat="server" ID="Label2" ><strong>PENGHAPUSBUKUAN ASET</strong></asp:Label></p>
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <label class="col-sm-2 control-label">Status Aset</label>
                                            <div class="col-lg-10 col-md-10">
                                                <div class="col-lg-3 col-md-3">
                                                    <div class="radio">
                                                        <asp:RadioButton runat="server" GroupName="NewStatus" ID="rbtNewStatusBaik" value="1" Text="Aset Baik" OnCheckedChanged="rbtPenghapusan_CheckedChanged" AutoPostBack="true" />
                                                    </div>
                                                </div>
                                                <div class="col-lg-3 col-md-3">
                                                    <div class="radio">
                                                        <div class="form-group">
                                                            <asp:RadioButton runat="server" GroupName="NewStatus" ID="rbtNewStatusRusak" value="2" Text="Aset Rusak" OnCheckedChanged="rbtPenghapusan_CheckedChanged" AutoPostBack="true" />
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-lg-3 col-md-3">
                                                    <div class="radio">
                                                        <div class="form-group">
                                                            <asp:RadioButton runat="server" GroupName="NewStatus" ID="rbtNewNonFisik" value="3" Text="Fisik Tidak Ada" OnCheckedChanged="rbtPenghapusan_CheckedChanged" AutoPostBack="true" />
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-lg-3 col-md-3">
                                                    <div class="radio">
                                                        <div class="form-group">
                                                                <asp:RadioButton runat="server" GroupName="NewStatus" ID="rbtNewTidakProduktif" value="4" Text="Aset Tidak Produktif" OnCheckedChanged="rbtPenghapusan_CheckedChanged" AutoPostBack="true" />
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="form-group">
                                        <asp:Label runat="server" ID="Label3" class="col-sm-2 control-label popovers" data-original-title='Informasi Aset' data-content='Nilai Aset. Silakan isikan dengan 1 jika aset merupakan aset tidak tetap atau tidak bernilai. Format aset dalam satuan mata uang Rupiah (Rp). Pada proses Panghapusbukuan / Disposal Nilai Aset baru adalah 1.' data-placement='right' data-trigger='hover' Text="Nilai Buku"></asp:Label>
                                            <div class="col-lg-3 col-md-3 col-sm-3">
                                                <asp:TextBox ID="txtNilaiBuku" runat="server" class="form-control  m-bot15" Text="1"></asp:TextBox>
                                            </div>
                                            <div class="col-lg-2 col-md-2 col-sm-2">
                                                <asp:TextBox ID="txtSatuanUang" runat="server" class="form-control  m-bot15" Text="Rupiah" Enabled="false" CssClass ="form-control form-control-inline input-medium update"></asp:TextBox>
                                            </div>
                                        </div>

                                         <div class="form-group">
                                            <label class="col-sm-2 control-label">Jenis Penghapusan</label>
                                            <div class="col-lg-10 col-md-10">
                                                <div class="col-lg-3 col-md-3">
                                                    <div class="radio">
                                                        <asp:RadioButton runat="server" GroupName="disposal" ID="rbtHibah" value="1" Text="Hibah" />
                                                    </div>
                                                </div>
                                                <div class="col-lg-3 col-md-3">
                                                    <div class="radio">
                                                        <div class="form-group">
                                                            <asp:RadioButton runat="server" GroupName="disposal" ID="rbtLelang" value="2" Text="Lelang"/>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <div class="col-sm-12">
                                                <p style="font-size: 15px; margin-bottom: 30px;margin-top: 30px;" align="center">
                                                <asp:Label runat="server" ID="Label1" ><strong>MASTER ASET</strong></asp:Label></p>
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
                                                        <span class="help-block">Nomor Register Aset Akuntansi</span>
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
                                                        <asp:DropDownList ID="ddlGroup" runat="server" class="chosen" OnSelectedIndexChanged="ddlGroup_SelectedIndexChanged" AutoPostBack="true"  Enabled="false" CssClass="form-control form-control-inline input-medium update"></asp:DropDownList>
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
                                                        <asp:DropDownList ID="ddlSubGroup" runat="server" class="chosen" OnSelectedIndexChanged="ddlSubGroup_SelectedIndexChanged" AutoPostBack="true" Enabled="false" CssClass="form-control form-control-inline input-medium update"></asp:DropDownList>
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
                                                        <asp:DropDownList ID="ddlOrganization" runat="server" class="chosen" Enabled="false" CssClass="form-control form-control-inline input-medium update"></asp:DropDownList>
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
                                                        <asp:DropDownList ID="ddlLocation" runat="server" class="chosen" Enabled="false" CssClass="form-control form-control-inline input-medium update"></asp:DropDownList>
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
                                                        <asp:TextBox ID="txtBegda" runat="server" class="form-control form-control-inline input-medium default-date-picker" Enabled="false" CssClass="form-control form-control-inline input-medium update"></asp:TextBox>
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
                                                        <asp:TextBox ID="txtEndda" runat="server" class="form-control form-control-inline input-medium default-date-picker" Enabled="false" CssClass="form-control form-control-inline input-medium update"></asp:TextBox>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <label class="col-sm-2 control-label"></label>
                                            <div class="col-lg-4 col-md-4">
                                                <div class="row">
                                                    <div class="col-lg-12 col-md-12">
                                                        <span class="help-block">Nilai Perolehan</span>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-lg-12 col-md-12">
                                                        <asp:TextBox ID="txtNilaiAset" runat="server" class="form-control  m-bot15" Enabled="false" CssClass="form-control form-control-inline input-medium update"></asp:TextBox>
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
                                                        <asp:DropDownList ID="ddlPerolehan" runat="server" class="chosen"  Enabled="false" CssClass="form-control form-control-inline input-medium update"></asp:DropDownList>
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
                                                        <asp:TextBox ID="txtTanggalPerolehan" runat="server" class="form-control form-control-inline input-medium default-date-picker" Enabled="false" CssClass="form-control form-control-inline input-medium update"></asp:TextBox>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <label class="col-sm-2 control-label">Status Aset</label>
                                            <div class="col-lg-10 col-md-10">
                                                <div class="col-lg-3 col-md-3">
                                                    <div class="radio">
                                                        <asp:RadioButton runat="server" GroupName="Status" ID="rbtStatusBaik" value="0" Text="Aset Baik" Enabled="false"/>
                                                    </div>
                                                </div>
                                                <div class="col-lg-3 col-md-3">
                                                    <div class="radio">
                                                        <div class="form-group">
                                                            <asp:RadioButton runat="server" GroupName="Status" ID="rbtStatusRusak" value="1" Text="Aset Rusak" Enabled="false"/>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-lg-3 col-md-3">
                                                    <div class="radio">
                                                        <div class="form-group">
                                                            <asp:RadioButton runat="server" GroupName="Status" ID="rbtNonFisik" value="2" Text="Fisik Tidak Ada" Enabled="false"/>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-lg-3 col-md-3">
                                                    <div class="radio">
                                                        <div class="form-group">
                                                                <asp:RadioButton runat="server" GroupName="Status" ID="rbtTidakProduktif" value="3" Text="Aset Tidak Produktif" Enabled="false"/>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="form-group">
                                        <label class="col-sm-2 control-label">Peruntukan</label>
                                            <div class="col-lg-9 col-md-9 col-sm-9">
                                                <asp:TextBox ID="txtPeruntukan" runat="server" class="form-control  m-bot15" TextMode="MultiLine" Rows="2" Enabled="false" CssClass="form-control form-control-inline input-medium update"></asp:TextBox>
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <label class="col-sm-2 control-label popovers" data-original-title='Informasi Aset' data-content='Mean Time Between Failures. Standard periode yang diberikan untuk melakukan perawatan terhadap aset' data-placement='right' data-trigger='hover'>MTBF (Hari)</label>
                                            <div class="col-lg-4 col-md-4">
                                                <asp:TextBox ID="txtMTBF" runat="server" class="form-control m-bot15" Enabled="false" CssClass="form-control form-control-inline input-medium update"></asp:TextBox>
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <label class="col-sm-2 control-label">Keterangan</label>
                                            <div class="col-lg-9 col-md-9 col-sm-9">
                                                <asp:TextBox ID="txtKeterangan" runat="server" class="form-control m-bot15" TextMode="MultiLine" Rows="3" MaxLength="200" Enabled="false" CssClass="form-control form-control-inline input-medium update"></asp:TextBox>
                                            </div>
                                        </div>
                                        

                                        <div class="form-group">
                                            <label class="col-sm-2 control-label popovers" data-original-title='Informasi Aset' data-content='Relasi aset. Silakan pilih induk aset apabila aset yang akan didaftarkan merupakan bagian dari aset yang telah terdaftar' data-placement='right' data-trigger='hover'>Induk Aset</label>
                                            <div class="col-lg-9 col-md-9 col-sm-9">
                                                <asp:DropDownList ID="ddlAssetParent" runat="server" class="chosen" Enabled="false" CssClass="form-control form-control-inline input-medium update"></asp:DropDownList>
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <asp:Label ID="lblFileUpload" runat="server" class="col-sm-2 control-label  popovers" data-original-title='Informasi Aset' data-content='Upload Image. Upload gambar untuk memvisualisasikan aset dalam bentuk gambar, format JPG/JPEG/PNG' data-placement='right' data-trigger='hover' Text="Image"></asp:Label>
                                            <div class="col-lg-4 col-md-4">
                                                <div class="fileupload fileupload-new" data-provides="fileupload">
                                                    <div class="fileupload-new thumbnail" style="width: 200px; height: 150px;">
                                                        <asp:Image ID="imgFile" runat="server" alt="" />
                                                    </div>
                                                    <div class="fileupload-preview fileupload-exists thumbnail" style="max-width: 200px; max-height: 150px; line-height: 20px;"></div>
                                                    <%--<div>
                                                        <span class="btn btn-white btn-file">
                                                            <span class="fileupload-new"><i class="fa fa-paperclip"></i> Select image</span>
                                                            <span class="fileupload-exists"><i class="fa fa-undo"></i> Change</span>
                                                            <asp:FileUpload runat="server" ID="fupImages" class="default" accept=".png,.jpg,.jpeg" />
                                                        </span>
                                                        <a href="#" class="btn btn-danger fileupload-exists" data-dismiss="fileupload"><i class="fa fa-trash-o"></i> Remove</a>
                                                    </div>--%>
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
                                                <asp:Button class="btn btn-round btn-green" Visible="false" ID="btnAdd" runat="server" Text="Add +" OnClick="ButtonAdd_Click" EnableViewState="true" ></asp:Button>
                                            </div>
                                            <div class="col-sm-9">
                                                <asp:GridView ID="grvAttribute" Width="100%" BorderStyle="None" OnRowDeleting="OnRowDeleting" HeaderStyle-HorizontalAlign="Left" HeaderStyle-VerticalAlign="Middle" runat="server" ShowFooter="true" class="table table-striped table-bordered table-condensed" AutoGenerateColumns="false">
                                                    <Columns>
                                                        <asp:BoundField HeaderStyle-HorizontalAlign="Left" HeaderStyle-VerticalAlign="Middle" ItemStyle-HorizontalAlign="Center" FooterStyle-BorderStyle="None" ItemStyle-BorderStyle="None" HeaderStyle-BorderStyle="None" Visible="false" />
                                                        <asp:TemplateField HeaderStyle-HorizontalAlign="Left" HeaderStyle-VerticalAlign="Middle" FooterStyle-BorderStyle="None" ItemStyle-BorderStyle="None" HeaderStyle-BorderStyle="None" HeaderText="Atribut Aset">
                                                            <HeaderStyle Width="70%" HorizontalAlign="Left" VerticalAlign="Middle" />
                                                            <ItemTemplate>
                                                                <asp:DropDownList ID="ddlAssetAttribute" runat="server" class="chosen"  Enabled="false" CssClass="form-control form-control-inline input-medium update"></asp:DropDownList>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderStyle-HorizontalAlign="Left" HeaderStyle-VerticalAlign="Middle" FooterStyle-BorderStyle="None" ItemStyle-BorderStyle="None" HeaderStyle-BorderStyle="None" HeaderText="Informasi">
                                                            <HeaderStyle Width="30%" HorizontalAlign="Left" VerticalAlign="Middle" />
                                                            <ItemTemplate>
                                                                <asp:TextBox ID="txtValue" runat="server" class="form-control" style="text-align:left;" autocomplete="off"  Enabled="false" CssClass="form-control form-control-inline input-medium update"></asp:TextBox>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <%--<asp:CommandField ItemStyle-HorizontalAlign="Center" ItemStyle-VerticalAlign="Middle" ControlStyle-CssClass="btn btn-red" FooterStyle-BorderStyle="None"  ItemStyle-BorderStyle="None" HeaderStyle-BorderStyle="None" ButtonType="Link" ShowDeleteButton="true" ItemStyle-Width="150" DeleteText="X" />--%>
                                                    </Columns>
                                                </asp:GridView>
                                            </div>
                                            <div class="col-sm-2">
                                            </div>
                                        </div>

                                        <% } %>

                                        <div class="form-group">
                                                <% if (Session["isExist"] != null) { %>
                                                <div class="col-sm-12" align="center">
		                                            <asp:LinkButton ID="btnBack" runat="server" class="btn btn-round btn-green" href="Dashboard.aspx" Text="<i class='fa fa-reply'></i> Back"> </asp:LinkButton>
                                                    <asp:LinkButton class="btn btn-round btn-green" Visible="true" ID="btnOkay" runat="server" Text="<i class='fa fa-check'></i> Save " data-toggle="modal" href="#ModalApproval"></asp:LinkButton>  
                                                </div>
                                                <% } else { %>
                                                <label class="col-sm-2 control-label"></label>
                                                <div class="col-sm-10">
		                                            <asp:LinkButton ID="btnCheck" runat="server" class="btn btn-round btn-green" OnClick="btnCheck_Click" Text="<i class='fa fa-check'></i> Verify"> </asp:LinkButton>
                                                </div>
                                                <% } %>
                                        </div>


                                        <!-- Modal -->
                                        <div aria-hidden="true" aria-labelledby="myModalLabel" role="dialog" tabindex="-1" id="ModalApproval" class="modal fade">
                                            <div class="modal-dialog">
                                                <div class="modal-content">
                                                    <div class="modal-header">
                                                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                                        <h4 class="modal-title">Digital Signature</h4>
                                                    </div>

                                                    <div class="modal-body">
                                                        <div class="" style="margin-left: 5px; margin-bottom: 25px;">
                                                            <p align="left">Welcome,</p>
                                                            <h4 style="color: #45CE77;" align="left"><% Response.Write((string)Session["name"]); %></h4>
                                                        </div>
                                                        <asp:TextBox ID="txtNote" runat="server" TextMode="MultiLine" placeholder="Your Note If Any" class="form-control placeholder-no-fix" Style="margin-bottom: 15px;" onkeypress="CheckAlphaNumeric(event);" MaxLength="200"></asp:TextBox>
                                                        <asp:TextBox ID="txtConfirmation" runat="server" TextMode="Password" Text="" placeholder="Password" class="form-control placeholder-no-fix" Style="margin-bottom: 15px;" MaxLength="32"></asp:TextBox>
                                                    </div>
                                                    <div class="modal-footer">
                                                        <asp:Button ID="btnClose" runat="server" data-dismiss="modal" class="btn btn-default" Text="Close"></asp:Button>
                                                        <asp:Button ID="btnSave" runat="server" class="btn btn-success" Text="Corfirm" OnClick="btnSave_Click"></asp:Button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <!-- modal -->
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
