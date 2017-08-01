<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AssetMaintenanceForm.aspx.cs" Inherits="AssetManagement.Views.Administrator.AssetMaintenanceForm" %>

<%@ Import Namespace="Biofarma.AssetManagement.Data.DataAccess" %>
<%@ Import Namespace="Biofarma.AssetManagement.Presentation" %>
<%@ Import Namespace="AssetManagement.Entity" %>
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
            CreateDefaultFormControl();
            SetImageFileDefault();
            
            SetMayorType();
            SetSubType(ddlGroup.SelectedValue);
            SetAssetBySubGroup(ddlSubGroup.SelectedValue);
            Session["_attrb"] = ddlGroup.SelectedValue;

            SetInitialRowAsset();
            SetInitialRowMaintenance();
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
                    SetAssetMaintenanceToDataTable(_objid);
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
    
    protected DateTime CalculateNextMaintenanceDate(string LastMaintenance, string PeriodeValue, string PeriodeUnit)
    {
        DateTime _lastMaintenance = Convert.ToDateTime(DateTimeFormat.ReverseDateVersionSQL(LastMaintenance));
        int _interval = Convert.ToInt32(PeriodeValue);

        if (PeriodeUnit.ToLower() == SatuanWaktu.Tahun.ToString().ToLower())
        {
            return _lastMaintenance.AddYears(_interval);
        }
        else if (PeriodeUnit.ToLower() == SatuanWaktu.Bulan.ToString().ToLower())
        {
            return _lastMaintenance.AddMonths(_interval);
        }
        else if (PeriodeUnit.ToLower() == SatuanWaktu.Minggu.ToString().ToLower())
        {
            return _lastMaintenance.AddDays(_interval * 7);
        }
        else if (PeriodeUnit.ToLower() == SatuanWaktu.Hari.ToString().ToLower())
        {
            return _lastMaintenance.AddDays(_interval);
        }
        else
        {
            return DateTime.MaxValue;
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
        txtNumber.Text = data.Rows[0]["INVNO"].ToString(); 
        txtAssetNumber.Text = data.Rows[0]["ASTNO"].ToString();
        txtIdNumber.Text = data.Rows[0]["PLNCD"].ToString();
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
            UpdateData();
            Response.Redirect("Asset.aspx");
        }
        else
        {
            ClientScript.RegisterStartupScript(this.GetType(), "myalert", "alert('Your Password is Incorrect');", true);
        }
    }

    //Update set action
    protected void UpdateData()
    {
        int _objid = Request.QueryString["objid"] != null ? Convert.ToInt32(Cryptography.Decrypt(Request.QueryString["objid"], true)) : 0;        
        DelimitAssetMaintenance(_objid.ToString());
        InsertAssetMaintenance(_objid.ToString());
    }

    protected void UpdateDataDeviation(string PLNID)
    {
        AssetCatalog.UpdatePlantDeviation(0, PLNID, ((int)DeviationType.PreventiveMaintenance).ToString(), DeviationType.PreventiveMaintenance.ToString(), DateTime.Now.ToString(), string.Empty, (string)Session["username"]);
    }

    //Gridview Asset Detail need to evaluate
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

    protected void InsertAssetMaintenance(string PLNID)
    {
        if (ViewState["CurrentTableMaintenance"] != null)
        {
            DataTable dtCurrentTable = (DataTable)ViewState["CurrentTableMaintenance"];

            if (dtCurrentTable.Rows.Count > 0)
            {
                for (int rowIndex = 0; rowIndex < dtCurrentTable.Rows.Count; rowIndex++)
                {
                    DropDownList ddlMaintainGroup = (DropDownList)grvMaintenance.Rows[rowIndex].Cells[1].FindControl("ddlMaintainGroup");
                    DropDownList ddlMaintainSubGroup = (DropDownList)grvMaintenance.Rows[rowIndex].Cells[2].FindControl("ddlMaintainSubGroup");
                    TextBox txtPeriode = (TextBox)grvMaintenance.Rows[rowIndex].Cells[3].FindControl("txtPeriode");
                    TextBox txtLastMaintenance = (TextBox)grvMaintenance.Rows[rowIndex].Cells[4].FindControl("txtLastMaintenance");

                    if (txtLastMaintenance.Text != string.Empty)
                    {
                        string periodeValue = txtPeriode.Text.Split(' ')[0];
                        string periodeUnit = txtPeriode.Text.Split(' ')[1];

                        AssetCatalog.InsertPlantMaintenance(0, PLNID, ddlMaintainGroup.SelectedValue, ddlMaintainGroup.SelectedItem.Text, ddlMaintainSubGroup.SelectedValue, ddlMaintainSubGroup.SelectedItem.Text, periodeValue, periodeUnit, DateTimeFormat.ReverseDateVersionSQL(txtLastMaintenance.Text), CalculateNextMaintenanceDate(txtLastMaintenance.Text, periodeValue, periodeUnit).ToString(), (string)Session["username"]);
                    }
                }
            }
        }
    }

    protected void EmptyAssetMaintenance(string PLNID)
    {
        AssetCatalog.DeletePlantMaintenanceByPlantID(PLNID);
    }

    protected void DelimitAssetMaintenance(string PLNID)
    {
        AssetCatalog.DelimitPlantMaintenanceByPlantID(PLNID, (string)Session["username"]);
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

                    if (i < dt.Rows.Count)
                    {
                        ddlAssetAttribute.ClearSelection();
                        ddlAssetAttribute.SelectedValue = _data.Rows[i]["ATTID"].ToString();
                    }
                    
                    rowIndex++;
                }
            }
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

    //Gridview Aset Maintenance Need to Evaluate
    protected void SetAssetMaintenanceToDataTable(string OBJID)
    {
        DataTable _table = AssetCatalog.GetPlantMaintenanceByPlantID(OBJID);
        DataRow _row = null;

        DataTable dt = new DataTable();
        dt.Columns.Add(new DataColumn("RowNumber", typeof(string)));
        dt.Columns.Add(new DataColumn("Group", typeof(string)));
        dt.Columns.Add(new DataColumn("SubGroup", typeof(string)));
        dt.Columns.Add(new DataColumn("Periode", typeof(string)));
        dt.Columns.Add(new DataColumn("LastMaintenance", typeof(string)));

        if (_table.Rows.Count > 0)
        {
            for (int i = 0; i < _table.Rows.Count; i++)
            {
                _row = dt.NewRow();
                _row["RowNumber"] = (i + 1);
                _row["Group"] = _table.Rows[i]["TSKID"].ToString();
                _row["SubGroup"] = _table.Rows[i]["STKID"].ToString();
                _row["Periode"] = _table.Rows[i]["PERIO"].ToString() + " " + _table.Rows[i]["PUNIT"].ToString();
                _row["LastMaintenance"] = _table.Rows[i]["LASTM"].ToString() == string.Empty ? string.Empty : DateTimeFormat.ReverseDateVersionASP(_table.Rows[i]["LASTM"].ToString());

                dt.Rows.Add(_row);
            }

            //Store the DataTable in ViewState
            ViewState["CurrentTableMaintenance"] = dt;

            grvMaintenance.DataSource = dt;
            grvMaintenance.DataBind();

            SetPreviousDataMaintenance();
        }
        else
        {
            SetInitialRowMaintenance();
        }

    }

    protected void SetInitialRowMaintenance()
    {
        DataTable dt = new DataTable();
        DataRow dr = null;
        dt.Columns.Add(new DataColumn("RowNumber", typeof(string)));
        dt.Columns.Add(new DataColumn("Group", typeof(string)));
        dt.Columns.Add(new DataColumn("SubGroup", typeof(string)));
        dt.Columns.Add(new DataColumn("Periode", typeof(string)));
        dt.Columns.Add(new DataColumn("LastMaintenance", typeof(string)));

        dr = dt.NewRow();
        dr["RowNumber"] = 1;
        dr["Group"] = string.Empty;
        dr["SubGroup"] = string.Empty;
        dr["Periode"] = string.Empty;
        dr["LastMaintenance"] = string.Empty;
        dt.Rows.Add(dr);

        //Store the DataTable in ViewState
        ViewState["CurrentTableMaintenance"] = dt;

        grvMaintenance.DataSource = dt;
        grvMaintenance.DataBind();

        //Extract and Fill the DropDownList with Data
        DropDownList ddlMaintainGroup = (DropDownList)grvMaintenance.Rows[0].Cells[1].FindControl("ddlMaintainGroup");
        SetAssetMaintenanceGroup(ddlMaintainGroup);
        
        DropDownList ddlMaintainSubGroup = (DropDownList)grvMaintenance.Rows[0].Cells[2].FindControl("ddlMaintainSubGroup");
        SetAssetMaintenanceSubGroup(ddlMaintainSubGroup, ddlMaintainGroup.SelectedValue);
        
        TextBox txtMaintenancePeriode = (TextBox)grvMaintenance.Rows[0].Cells[3].FindControl("txtPeriode");
        SetPeriode(ddlMaintainSubGroup, txtMaintenancePeriode);
    }

    private void AddNewRowToGridMaintenance()
    {
        int rowIndex = 0;

        if (ViewState["CurrentTableMaintenance"] != null)
        {
            DataTable dtCurrentTable = (DataTable)ViewState["CurrentTableMaintenance"];
            DataRow drCurrentRow = null;
            if (dtCurrentTable.Rows.Count > 0)
            {
                for (int i = 1; i <= dtCurrentTable.Rows.Count; i++)
                {
                    //extract the TextBox values
                    DropDownList ddlMaintainGroup = (DropDownList)grvMaintenance.Rows[rowIndex].Cells[1].FindControl("ddlMaintainGroup");
                    DropDownList ddlMaintainSubGroup = (DropDownList)grvMaintenance.Rows[rowIndex].Cells[2].FindControl("ddlMaintainSubGroup");
                    TextBox txtPeriode = (TextBox)grvMaintenance.Rows[rowIndex].Cells[3].FindControl("txtPeriode");
                    TextBox txtLastMaintenance = (TextBox)grvMaintenance.Rows[rowIndex].Cells[4].FindControl("txtLastMaintenance");

                    drCurrentRow = dtCurrentTable.NewRow();
                    drCurrentRow["RowNumber"] = i + 1;

                    dtCurrentTable.Rows[i - 1]["Group"] = ddlMaintainGroup.Text;
                    dtCurrentTable.Rows[i - 1]["SubGroup"] = ddlMaintainSubGroup.Text;
                    dtCurrentTable.Rows[i - 1]["Periode"] = txtPeriode.Text;
                    dtCurrentTable.Rows[i - 1]["LastMaintenance"] = txtLastMaintenance.Text;

                    rowIndex++;
                }
                dtCurrentTable.Rows.Add(drCurrentRow);
                ViewState["CurrentTableMaintenance"] = dtCurrentTable;

                grvMaintenance.DataSource = dtCurrentTable;
                grvMaintenance.DataBind();
            }
        }
        else
        {
            Response.Write("ViewState is null");
        }

        //Set Previous Data on Postbacks
        SetPreviousDataMaintenance();
    }

    private void SetPreviousDataMaintenance()
    {
        int rowIndex = 0;
        if (ViewState["CurrentTableMaintenance"] != null)
        {
            DataTable dt = (DataTable)ViewState["CurrentTableMaintenance"];
            if (dt.Rows.Count > 0)
            {
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    //Set the Previous Selected Items on Each DropDownList on Postbacks
                    DropDownList ddlMaintainGroup = (DropDownList)grvMaintenance.Rows[rowIndex].Cells[1].FindControl("ddlMaintainGroup");
                    DropDownList ddlMaintainSubGroup = (DropDownList)grvMaintenance.Rows[rowIndex].Cells[2].FindControl("ddlMaintainSubGroup");
                    TextBox txtPeriode = (TextBox)grvMaintenance.Rows[rowIndex].Cells[3].FindControl("txtPeriode");
                    TextBox txtLastMaintenance = (TextBox)grvMaintenance.Rows[rowIndex].Cells[4].FindControl("txtLastMaintenance");

                    //Fill the DropDownList with Data
                    SetAssetMaintenanceGroup(ddlMaintainGroup);
                    SetAssetMaintenanceSubGroup(ddlMaintainSubGroup, ddlMaintainGroup.SelectedValue);
                    SetPeriode(ddlMaintainSubGroup, txtPeriode);

                    if (i < dt.Rows.Count)
                    {
                        txtLastMaintenance.Text = dt.Rows[i]["LastMaintenance"].ToString();
                        
                        ddlMaintainGroup.ClearSelection();
                        ddlMaintainGroup.SelectedValue = dt.Rows[i]["Group"].ToString();

                        SetAssetMaintenanceSubGroup(ddlMaintainSubGroup, ddlMaintainGroup.SelectedValue);
                        ddlMaintainSubGroup.ClearSelection();
                        ddlMaintainSubGroup.SelectedValue = dt.Rows[i]["SubGroup"].ToString();

                        SetPeriode(ddlMaintainSubGroup, txtPeriode);
                    }

                    rowIndex++;
                }
            }
        }
    }
    
    protected void OnRowDeletingMaintenance(object sender, GridViewDeleteEventArgs e)
    {
        if (ViewState["CurrentTableMaintenance"] != null)
        {
            DataTable dtCurrentTable = (DataTable)ViewState["CurrentTableMaintenance"];
            if (dtCurrentTable.Rows.Count != 1)
            {
                DataTable dt = (DataTable)ViewState["CurrentTableMaintenance"];
                dt.Rows[e.RowIndex].Delete();

                ViewState["CurrentTableMaintenance"] = dtCurrentTable;
                grvMaintenance.DataSource = dtCurrentTable;
                grvMaintenance.DataBind();
            }

            //Set Previous Data on Postbacks
            if (((DataTable)ViewState["CurrentTableMaintenance"]).Rows.Count != 1) SetPreviousDataMaintenance();
        }
        btnOkay.Focus();
    }

    protected void SetAssetMaintenanceGroup(DropDownList ddlMaintainGroup)
    {
        DataTable _table = AssetCatalog.GetTaskGroups();

        ddlMaintainGroup.Items.Clear();
        for (int index = 0; index < _table.Rows.Count; index++)
        {
            ddlMaintainGroup.Items.Add(new ListItem(_table.Rows[index]["TASK"].ToString(), _table.Rows[index]["OBJID"].ToString()));
        }
    }

    protected void SetAssetMaintenanceSubGroup(DropDownList ddlMaintainSubGroup, string TSKID)
    {
        DataTable _table = AssetCatalog.GetTaskScheduleByTaskGroup(TSKID);

        ddlMaintainSubGroup.Items.Clear();
        for (int index = 0; index < _table.Rows.Count; index++)
        {
            ddlMaintainSubGroup.Items.Add(new ListItem(_table.Rows[index]["STASK"].ToString(), _table.Rows[index]["OBJID"].ToString()));
        }
    }

    protected void SetPeriode(DropDownList ddlMaintenanceSubGroup, TextBox txtMaintenancePeriode)
    {
        txtMaintenancePeriode.Text = string.Empty;

        if (ddlMaintenanceSubGroup.Items.Count > 0)
        {
            SetAssetMaintenancePeriode(txtMaintenancePeriode, ddlMaintenanceSubGroup.SelectedValue);
        }
    }

    protected void SetAssetMaintenancePeriode(TextBox txtMaintenancePeriode, string STASK)
    {
        DataTable data = AssetCatalog.GetTaskScheduleByID(STASK);

        if (data.Rows.Count > 0)
        {
            txtMaintenancePeriode.Text = data.Rows[0]["PERIO"].ToString() + " " + data.Rows[0]["PUNIT"].ToString();
        }
    }

    protected void btnAddMaintenance_Click(object sender, EventArgs e)
    {
        AddNewRowToGridMaintenance();
        btnOkay.Focus();
    }

    protected void ddlMaintainGroup_SelectedIndexChanged(object sender, EventArgs e)
    {
        DropDownList ddlMaintainGroup = (DropDownList)sender;
        string groupCode = ddlMaintainGroup.SelectedValue;

        // Get the GridViewRow in which this master DropDownList exists
        GridViewRow row = (GridViewRow)ddlMaintainGroup.Parent.NamingContainer;
        
        // Find all of the other DropDownLists within the same row and bind them
        DropDownList ddlMaintainSubGroup = (DropDownList)row.FindControl("ddlMaintainSubGroup");
        ddlMaintainSubGroup.DataSource = AssetCatalog.GetTaskScheduleByTaskGroup(groupCode);
        ddlMaintainSubGroup.DataValueField = "OBJID";
        ddlMaintainSubGroup.DataTextField = "STASK";
        ddlMaintainSubGroup.DataBind();

        TextBox txtPeriode = (TextBox)row.FindControl("txtPeriode");

        DataTable data = AssetCatalog.GetTaskScheduleByID(ddlMaintainSubGroup.SelectedValue);

        if (data.Rows.Count > 0)
        {
            txtPeriode.Text = data.Rows[0]["PERIO"].ToString() + " " + data.Rows[0]["PUNIT"].ToString();
        }

        btnOkay.Focus();
    }

    protected void ddlMaintainSubGroup_SelectedIndexChanged(object sender, EventArgs e)
    {
        DropDownList ddlMaintainSubGroup = (DropDownList)sender;
        string subGroupCode = ddlMaintainSubGroup.SelectedValue;

        // Get the GridViewRow in which this master DropDownList exists
        GridViewRow row = (GridViewRow)ddlMaintainSubGroup.NamingContainer;

        // Find all of the other DropDownLists within the same row and bind them
        TextBox txtPeriode = (TextBox)row.FindControl("txtPeriode");

        DataTable data = AssetCatalog.GetTaskScheduleByID(subGroupCode);

        if (data.Rows.Count > 0)
        {
            txtPeriode.Text = data.Rows[0]["PERIO"].ToString() + " " + data.Rows[0]["PUNIT"].ToString();
        }

        btnOkay.Focus();
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
                                Master Aset
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
                                                    <div class="fileupload-preview fileupload-exists thumbnail" style="max-width: 200px; max-height: 150px; line-height: 20px;"></div>
                                                    <div>
                                                        <a href="#" class="btn btn-danger fileupload-exists" data-dismiss="fileupload"><i class="fa fa-trash-o"></i> Remove</a>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <div class="col-sm-12">
                                                <p style="font-size: 15px; margin-bottom: 30px;margin-top: 30px;" align="center">
                                                <asp:Label runat="server" ID="Label1" ><strong>MAINTAIN ASET</strong></asp:Label></p>
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <div class="col-sm-2 control-label">
                                                <asp:Button class="btn btn-round btn-green" Visible="true" ID="btnAddMaintenance" runat="server" Text="Add +" OnClick="btnAddMaintenance_Click" EnableViewState="true"></asp:Button>
                                            </div>
                                            <div class="col-sm-9">
                                                <asp:GridView ID="grvMaintenance" Width="100%" BorderStyle="None" OnRowDeleting="OnRowDeletingMaintenance" HeaderStyle-HorizontalAlign="Left" HeaderStyle-VerticalAlign="Middle" runat="server" ShowFooter="true" class="table table-striped table-bordered table-condensed" AutoGenerateColumns="false">
                                                    <Columns>
                                                        <asp:BoundField HeaderStyle-HorizontalAlign="Left" HeaderStyle-VerticalAlign="Middle" ItemStyle-HorizontalAlign="Center" FooterStyle-BorderStyle="None" ItemStyle-BorderStyle="None" HeaderStyle-BorderStyle="None" Visible="false" />
                                                        <asp:TemplateField HeaderStyle-HorizontalAlign="Left" HeaderStyle-VerticalAlign="Middle" FooterStyle-BorderStyle="None" ItemStyle-BorderStyle="None" HeaderStyle-BorderStyle="None" HeaderText="Group">
                                                            <HeaderStyle Width="30%" HorizontalAlign="Left" VerticalAlign="Middle" />
                                                            <ItemTemplate>
                                                                <asp:DropDownList ID="ddlMaintainGroup" runat="server" class="chosen" AutoPostBack="true" OnSelectedIndexChanged="ddlMaintainGroup_SelectedIndexChanged"></asp:DropDownList>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderStyle-HorizontalAlign="Left" HeaderStyle-VerticalAlign="Middle" FooterStyle-BorderStyle="None" ItemStyle-BorderStyle="None" HeaderStyle-BorderStyle="None" HeaderText="Sub Group">
                                                            <HeaderStyle Width="30%" HorizontalAlign="Left" VerticalAlign="Middle" />
                                                            <ItemTemplate>
                                                                <asp:DropDownList ID="ddlMaintainSubGroup" runat="server" class="chosen" AutoPostBack="true" OnSelectedIndexChanged="ddlMaintainSubGroup_SelectedIndexChanged"></asp:DropDownList>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderStyle-HorizontalAlign="Left" HeaderStyle-VerticalAlign="Middle" FooterStyle-BorderStyle="None" ItemStyle-BorderStyle="None" HeaderStyle-BorderStyle="None" HeaderText="Periode">
                                                            <HeaderStyle Width="20%" HorizontalAlign="Left" VerticalAlign="Middle" />
                                                            <ItemTemplate>
                                                                <asp:TextBox ID="txtPeriode" runat="server" CssClass="form-control form-control-inline input-medium update" Enabled="false" style="text-align:left;" autocomplete="off"></asp:TextBox>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderStyle-HorizontalAlign="Left" HeaderStyle-VerticalAlign="Middle" FooterStyle-BorderStyle="None" ItemStyle-BorderStyle="None" HeaderStyle-BorderStyle="None" HeaderText="Tanggal Terakhir">
                                                            <HeaderStyle Width="20%" HorizontalAlign="Left" VerticalAlign="Middle" />
                                                            <ItemTemplate>
                                                                <asp:TextBox ID="txtLastMaintenance" runat="server" class="form-control form-control-inline input-medium default-date-picker" style="text-align:left;" autocomplete="off"></asp:TextBox>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:CommandField ItemStyle-HorizontalAlign="Center" ItemStyle-VerticalAlign="Middle" ControlStyle-CssClass="btn btn-red" FooterStyle-BorderStyle="None"  ItemStyle-BorderStyle="None" HeaderStyle-BorderStyle="None" ButtonType="Link" ShowDeleteButton="true" ItemStyle-Width="150" DeleteText="X" />
                                                    </Columns>
                                                </asp:GridView>
                                            </div>
                                            <div class="col-sm-2">
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
                                                                <asp:DropDownList ID="ddlAssetAttribute" runat="server" class="chosen"  Enabled="false" CssClass ="form-control form-control-inline input-medium update"></asp:DropDownList>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderStyle-HorizontalAlign="Left" HeaderStyle-VerticalAlign="Middle" FooterStyle-BorderStyle="None" ItemStyle-BorderStyle="None" HeaderStyle-BorderStyle="None" HeaderText="Informasi">
                                                            <HeaderStyle Width="30%" HorizontalAlign="Left" VerticalAlign="Middle" />
                                                            <ItemTemplate>
                                                                <asp:TextBox ID="txtValue" runat="server" class="form-control" style="text-align:left;" autocomplete="off"  Enabled="false" CssClass ="form-control form-control-inline input-medium update"></asp:TextBox>
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
                                        <label class="col-sm-2 control-label"></label>
                                            <div class="col-sm-6">
		                                        <asp:LinkButton ID="btnBack" runat="server" class="btn btn-round btn-green" href="Asset.aspx" Text="<i class='fa fa-reply'></i> Back"> </asp:LinkButton>
                                                <asp:LinkButton class="btn btn-round btn-green" Visible="true" ID="btnOkay" runat="server" Text="<i class='fa fa-check'></i> Save " data-toggle="modal" href="#ModalApproval"></asp:LinkButton>
                                            </div>
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