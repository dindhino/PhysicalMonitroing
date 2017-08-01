<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MonitoringHum.aspx.cs" Inherits="AssetManagement.Views.Administrator.MonitoringHum" %>

<%@ Import Namespace="Biofarma.AssetManagement.Data.DataAccess" %>
<%@ Import Namespace="Biofarma.AssetManagement.Presentation" %>
<%@ Import Namespace="Biofarma.Framework.Security" %>
<%@ Import Namespace="Biofarma.Framework.Entity" %>
<%@ Import Namespace="Biofarma.Presentation.Component" %>
<%@ Import Namespace="Biofarma.Framework.Converter" %>
<%@ Import Namespace="System.Web.Configuration" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>

<!DOCTYPE html>
<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        //if (Session["username"] == null && Session["password"] == null) Response.Redirect(WebConfigurationManager.AppSettings["LoginTo"]);
        if (!IsPostBack)
        {
            if (Request.QueryString["actio"] != null)
            {
                string _tradt = Cryptography.Decrypt(Request.QueryString["tradt"], true);
                string _pltty = Cryptography.Decrypt(Request.QueryString["pltty"], true);
                string _pltid = Cryptography.Decrypt(Request.QueryString["pltid"], true);

                if (Request.QueryString["actio"] == "1")
                {
                    btnAdd.Text = "Simpan <i class='fa fa-floppy-o'></i>";
                    txtTime.Enabled = false;
                    ddlBagian.Enabled = false;
                    ddlGedung.Enabled = false;
                    ddlRuangan.Enabled = false;
                    txtHygrometer.ReadOnly = true;
                    txtMinac.ReadOnly = true;
                    txtMaxac.ReadOnly = true;
                    txtMinal.ReadOnly = true;
                    txtMaxal.ReadOnly = true;
                    txtHasil.ReadOnly = false;
                    txtKeterangan.ReadOnly = false;
                    txtTime.Text = _tradt;
                    GetSpec(_pltid);
                    GetMeas(_tradt, _pltty, _pltid);
                }
                else if (Request.QueryString["actio"] == "2")
                {
                    DeleteData(_tradt, _pltty, _pltid);
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Data berhasil dihapus');window.location ='MonitoringHum.aspx';", true);
                    //Response.Redirect("MonitoringHum.aspx");
                }
            }
            else
            {
                ddlBagian.Items.Clear();
                ddlBagian.Items.Add(new ListItem("----- Pilih Bagian -----", ""));
                ddlGedung.Items.Clear();
                ddlGedung.Items.Add(new ListItem("----- Pilih Gedung -----", ""));
                ddlRuangan.Items.Clear();
                ddlRuangan.Items.Add(new ListItem("----- Pilih Ruangan ----- ", ""));

                ddlBagian.AppendDataBoundItems = true;
                String strConnString = ConfigurationManager.ConnectionStrings["BiofarmaConnectionTest"].ConnectionString;
                String strQuery = "select * from bioumum.ORGANIZATION_DATA where OTYPE='O' order by ORGNM";
                SqlConnection con = new SqlConnection(strConnString);
                SqlCommand cmd = new SqlCommand();
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = strQuery;
                cmd.Connection = con;
                try
                {
                    con.Open();
                    ddlBagian.DataSource = cmd.ExecuteReader();
                    ddlBagian.DataTextField = "ORGNM";
                    ddlBagian.DataValueField = "ORGID";
                    ddlBagian.DataBind();
                    if (ddlBagian.Items.Count > 1)
                    {
                        ddlBagian.Enabled = true;
                    }
                    else
                    {
                        ddlBagian.Enabled = false;
                        ddlGedung.Enabled = false;
                        ddlRuangan.Enabled = false;
                    }
                }
                catch (Exception ex)
                {
                    throw ex;
                }
                finally
                {
                    con.Close();
                    con.Dispose();
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

    protected void GetSpec(String idplant)
    {
        String strConn = ConfigurationManager.ConnectionStrings["BiofarmaConnectionTest"].ConnectionString;
        SqlConnection con1 = new SqlConnection(strConn);
        String strQuery1 = String.Format("SELECT * FROM [asset].[PlantSpecification] where ENDDA>GETDATE() and SPCTY='H' and PLNT1='{0}' and PLNT2={0}", idplant);
        SqlCommand cmd1 = new SqlCommand();
        cmd1.CommandType = CommandType.Text;
        cmd1.CommandText = strQuery1;
        cmd1.Connection = con1;
        try
        {
            con1.Open();
            SqlDataAdapter adapter1 = new SqlDataAdapter(cmd1);
            DataTable table1 = new DataTable();
            adapter1.Fill(table1);
            table1.TableName = "Plant2";
            if (table1.Rows.Count != 0)
            {
                txtMinal.Text = table1.Rows[0]["MINAL"].ToString();
                txtMaxal.Text = table1.Rows[0]["MAXAL"].ToString();
                txtMinac.Text = table1.Rows[0]["MINAC"].ToString();
                txtMaxac.Text = table1.Rows[0]["MAXAC"].ToString();
                txtHygrometer.Text = table1.Rows[0]["SPCTY"].ToString() + "-" +
                                        table1.Rows[0]["PLNT1"].ToString() + "-" +
                                        table1.Rows[0]["PLNT2"].ToString();
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            con1.Close();
            con1.Dispose();
        }
    }

    protected void GetMeas(String tradt, String pltty, String pltid)
    {
        String strConn = ConfigurationManager.ConnectionStrings["BiofarmaConnectionTest"].ConnectionString;
        SqlConnection con1 = new SqlConnection(strConn);
        String strQuery1 = String.Format("SELECT * FROM [asset].[PlantMeasurement] where TRADT='{0}' and PLTTY= '{1}' and PLTID='{2}'", tradt, pltty, pltid);
        SqlCommand cmd1 = new SqlCommand();
        cmd1.CommandType = CommandType.Text;
        cmd1.CommandText = strQuery1;
        cmd1.Connection = con1;
        try
        {
            con1.Open();
            SqlDataAdapter adapter1 = new SqlDataAdapter(cmd1);
            DataTable table1 = new DataTable();
            adapter1.Fill(table1);
            table1.TableName = "Plant2";
            if (table1.Rows.Count != 0)
            {
                txtKeterangan.Text = table1.Rows[0]["DESCR"].ToString();
                txtHasil.Text = table1.Rows[0]["RESLT"].ToString();
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            con1.Close();
            con1.Dispose();
        }
    }

    protected void ddlBagian_SelectedIndexChanged(object sender, EventArgs e)
    {
        ddlGedung.Items.Clear();
        ddlGedung.Items.Add(new ListItem("----- Pilih Gedung -----", ""));
        ddlRuangan.Items.Clear();
        ddlRuangan.Items.Add(new ListItem("----- Pilih Ruangan ----- ", ""));

        ddlGedung.AppendDataBoundItems = true;
        String strConnString = ConfigurationManager.ConnectionStrings["BiofarmaConnectionTest"].ConnectionString;
        String strQuery = "select * from asset.PLANT_MASTER join bioumum.ORGANIZATION_DATA on (asset.PLANT_MASTER.ORGCD=bioumum.ORGANIZATION_DATA.ORGCD) where asset.PLANT_MASTER.MAJCD = 'BGN' and bioumum.ORGANIZATION_DATA.ORGID=@orgid order by PLNNM";
        SqlConnection con = new SqlConnection(strConnString);
        SqlCommand cmd = new SqlCommand();
        cmd.Parameters.AddWithValue("@orgid", ddlBagian.SelectedItem.Value);
        cmd.CommandType = CommandType.Text;
        cmd.CommandText = strQuery;
        cmd.Connection = con;
        try
        {
            con.Open();
            ddlGedung.DataSource = cmd.ExecuteReader();
            ddlGedung.DataTextField = "PLNNM";
            ddlGedung.DataValueField = "OBJID";
            ddlGedung.DataBind();
            if (ddlGedung.Items.Count > 1)
            {
                ddlGedung.Enabled = true;
            }
            else
            {
                ddlGedung.Enabled = false;
                ddlRuangan.Enabled = false;
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            con.Close();
            con.Dispose();
        }
    }

    protected void ddlGedung_SelectedIndexChanged(object sender, EventArgs e)
    {
        ddlRuangan.Items.Clear();
        ddlRuangan.Items.Add(new ListItem("----- Pilih Ruangan -----", ""));
        ddlRuangan.AppendDataBoundItems = true;
        String strConnString = ConfigurationManager.ConnectionStrings["BiofarmaConnectionTest"].ConnectionString;
        String strQuery = "select * from asset.PLANT_MASTER join asset.PLANT_RELATION on (asset.PLANT_MASTER.OBJID=asset.PLANT_RELATION.CHILD) where MAJCD='ROM' and asset.PLANT_RELATION.PARNT=@objid";
        SqlConnection con = new SqlConnection(strConnString);
        SqlCommand cmd = new SqlCommand();
        cmd.Parameters.AddWithValue("@objid",
                              ddlGedung.SelectedItem.Value);
        cmd.CommandType = CommandType.Text;
        cmd.CommandText = strQuery;
        cmd.Connection = con;
        try
        {
            con.Open();
            ddlRuangan.DataSource = cmd.ExecuteReader();
            ddlRuangan.DataTextField = "PLNNM";
            ddlRuangan.DataValueField = "OBJID";
            ddlRuangan.DataBind();
            if (ddlRuangan.Items.Count > 1)
            {
                ddlRuangan.Enabled = true;
            }
            else
            {
                ddlRuangan.Enabled = false;
            }

        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            con.Close();
            con.Dispose();
        }
    }

    protected void ddlRuangan_SelectedIndexChanged(object sender, EventArgs e)
    {
        String strConnString = ConfigurationManager.ConnectionStrings["BiofarmaConnectionTest"].ConnectionString;
        String strQuery = "select * from asset.PlantSpecification where ENDDA>GETDATE() and SPCTY='H' and PLNT1=@objid and PLNT2=@objid";
        SqlConnection con = new SqlConnection(strConnString);
        SqlCommand cmd = new SqlCommand();
        cmd.Parameters.AddWithValue("@objid",
                              ddlRuangan.SelectedItem.Value);
        cmd.CommandType = CommandType.Text;
        cmd.CommandText = strQuery;
        cmd.Connection = con;
        try
        {
            con.Open();
            DataTable table = new DataTable();
            SqlDataAdapter adapter = new SqlDataAdapter(cmd);
            adapter.Fill(table);
            table.TableName = "Alat";

            if (table.Rows.Count != 0)
            {
                txtHygrometer.Text = table.Rows[0]["SPCTY"].ToString() + "-" +
                                        table.Rows[0]["PLNT1"].ToString() + "-" +
                                        table.Rows[0]["PLNT2"].ToString();
                txtMinal.Text = table.Rows[0]["MINAL"].ToString();
                txtMaxal.Text = table.Rows[0]["MAXAL"].ToString();
                txtMinac.Text = table.Rows[0]["MINAC"].ToString();
                txtMaxac.Text = table.Rows[0]["MAXAC"].ToString();
                txtKeterangan.ReadOnly = false;
                txtHasil.ReadOnly = false;
            }
            else
            {
                txtHygrometer.Text = "Alat tidak ditemukan";
            }

        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            con.Close();
            con.Dispose();
        }
    }

    protected String GenerateData()
    {
        StringBuilder _table = new StringBuilder();
        String strConnString = ConfigurationManager.ConnectionStrings["BiofarmaConnectionTest"].ConnectionString;
        String strQuery = "select * from asset.PlantMeasurement where PLTTY like 'H%' order by TRADT";
        SqlConnection con = new SqlConnection(strConnString);
        SqlCommand cmd = new SqlCommand();
        cmd.CommandType = CommandType.Text;
        cmd.CommandText = strQuery;
        cmd.Connection = con;
        try
        {
            con.Open();
            DataTable table = new DataTable();
            SqlDataAdapter adapter = new SqlDataAdapter(cmd);
            adapter.Fill(table);
            table.TableName = "PlantMeasurement";
            for (int i = 0; i < table.Rows.Count; i++)
            {
                string _action = GetAction(table.Rows[i]["TRADT"].ToString(), table.Rows[i]["PLTTY"].ToString(), table.Rows[i]["PLTID"].ToString());
                _table.Append("<tr class=''>");
                _table.Append("<td>" + (i + 1).ToString() + "</td>");
                String strConn = ConfigurationManager.ConnectionStrings["BiofarmaConnectionTest"].ConnectionString;
                SqlConnection con1 = new SqlConnection(strConn);
                String pl = table.Rows[i]["PLTID"].ToString();
                String strQuery1 = String.Format("SELECT * FROM [asset].[PLANT_MASTER] where OBJID='{0}'", pl);
                SqlCommand cmd1 = new SqlCommand();
                cmd1.CommandType = CommandType.Text;
                cmd1.CommandText = strQuery1;
                cmd1.Connection = con1;
                try
                {
                    con1.Open();
                    SqlDataAdapter adapter1 = new SqlDataAdapter(cmd1);
                    DataTable table1 = new DataTable();
                    adapter1.Fill(table1);
                    table1.TableName = "Plant1";
                    _table.Append("<td>" + table1.Rows[0]["PLNNM"].ToString() + "</td>");
                }
                catch (Exception ex)
                {
                    throw ex;
                }
                finally
                {
                    con1.Close();
                    con1.Dispose();
                }
                _table.Append("<td>" + DateTimeFormat.GetDateFormat(table.Rows[i]["TRADT"].ToString()) + "</td>");
                _table.Append("<td>" + DateTime.Parse(table.Rows[i]["TRADT"].ToString()).ToString("dddd", new System.Globalization.CultureInfo("id-ID")) + "</td>");
                _table.Append("<td>" + DateTime.Parse(table.Rows[i]["TRADT"].ToString()).ToString("HH:mm", new System.Globalization.CultureInfo("id-ID")) + "</td>");
                _table.Append("<td>" + table.Rows[i]["RESLT"].ToString() + "</td>");
                if (table.Rows[i]["TRAST"].ToString() == "N")
                    _table.Append("<td> Normal </td>");
                else if (table.Rows[i]["TRAST"].ToString() == "O")
                    _table.Append("<td> OOS </td>");
                _table.Append("<td>" + table.Rows[i]["DESCR"].ToString() + "</td>");
                _table.Append("<td>" + _action + "</td>");
                _table.Append("</tr>");
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            con.Close();
            con.Dispose();
        }
        return _table.ToString();
    }

    protected string GetAction(string TRADT, string PLTTY, string PLTID)
    {
        StringBuilder element = new StringBuilder();
        element.Append("<a class='btn btn-warning popovers' style='color:white;margin-bottom:5px;' href='MonitoringHum.aspx?actio=1&tradt=" + Cryptography.Encrypt(TRADT, true) + "&pltty=" + Cryptography.Encrypt(PLTTY, true) + "&pltid=" + Cryptography.Encrypt(PLTID, true) + "' data-content='Silakan klik untuk melakukan preview dan update data' data-placement='left' data-trigger='hover'><i class='fa fa-edit'></i></a> ");
        element.Append("<a class='btn btn-danger popovers' style='color:white;margin-bottom:5px;' href='MonitoringHum.aspx?actio=2&tradt=" + Cryptography.Encrypt(TRADT, true) + "&pltty=" + Cryptography.Encrypt(PLTTY, true) + "&pltid=" + Cryptography.Encrypt(PLTID, true) + "' data-content='Silakan klik untuk menghapus data. Apakah Anda yakin?' data-placement='left' data-trigger='hover'><i class='fa fa-trash-o'></i></a> ");
        return element.ToString();
    }

    protected void DeleteData(string tradt, string pltty, string pltid)
    {
        String strConn = ConfigurationManager.ConnectionStrings["BiofarmaConnectionTest"].ConnectionString;
        SqlConnection conn = new SqlConnection(strConn);

        StringBuilder query = new StringBuilder();
        query.Append(" DELETE FROM asset.PlantMeasurement  ");
        query.Append(" WHERE TRADT=@tradt AND                ");
        query.Append(" PLTTY=@pltty AND                      ");
        query.Append(" PLTID=@pltid                          ");

        SqlCommand cmd = new SqlCommand();
        cmd.Parameters.AddWithValue("@tradt", tradt);
        cmd.Parameters.AddWithValue("@pltty", pltty);
        cmd.Parameters.AddWithValue("@pltid", pltid);
        cmd.CommandType = CommandType.Text;
        cmd.CommandText = query.ToString();
        cmd.Connection = conn;
        try
        {
            conn.Open();
            cmd.ExecuteNonQuery();
        }
        finally
        {
            conn.Close();
        }
    }

    protected void btnAdd_Click(object sender, EventArgs e)
    {
        if (txtTime.Text == string.Empty)
        {
            ClientScript.RegisterStartupScript(this.GetType(), "myalert", "alert('" + "Informasi tanggal dan jam tidak boleh kosong" + "');", true);
        }
        else if (txtHygrometer.Text == string.Empty)
        {
            ClientScript.RegisterStartupScript(this.GetType(), "myalert", "alert('" + "Informasi hygrometer tidak boleh kosong" + "');", true);
        }
        else if (txtHygrometer.Text == "Alat tidak ditemukan")
        {
            ClientScript.RegisterStartupScript(this.GetType(), "myalert", "alert('" + "Informasi hygrometer tidak diketahui" + "');", true);
        }
        else if (txtHasil.Text == string.Empty)
        {
            ClientScript.RegisterStartupScript(this.GetType(), "myalert", "alert('" + "Informasi hasil tidak boleh kosong" + "');", true);
        }
        else
        {
            String strConnString = ConfigurationManager.ConnectionStrings["BiofarmaConnectionTest"].ConnectionString;
            SqlConnection conn = new SqlConnection(strConnString);
            try
            {
                if (Request.QueryString["actio"] != null)
                {
                    if (Request.QueryString["actio"] == "1")
                    {
                        conn.Open();
                        string query = "UPDATE asset.PlantMeasurement SET RESLT=@RESLT, TRAST=@TRAST, DESCR=@DESCR, CHGDT=@CHGDT, CHUSR=@CHUSR WHERE TRADT=@TRADT AND PLTID=@PLTID";
                        SqlCommand myCommand = new SqlCommand(query, conn);
                        myCommand.Parameters.AddWithValue("@TRADT", txtTime.Text);
                        myCommand.Parameters.AddWithValue("@PLTID", Cryptography.Decrypt(Request.QueryString["pltid"], true));
                        myCommand.Parameters.AddWithValue("@RESLT", txtHasil.Text);
                        if (float.Parse(txtHasil.Text) > float.Parse(txtMaxal.Text) || float.Parse(txtHasil.Text) > float.Parse(txtMaxac.Text) || float.Parse(txtHasil.Text) < float.Parse(txtMinac.Text) || float.Parse(txtHasil.Text) < float.Parse(txtMinal.Text))
                        {
                            myCommand.Parameters.AddWithValue("@TRAST", 'O');
                        }
                        else
                        {
                            myCommand.Parameters.AddWithValue("@TRAST", 'N');
                        }
                        myCommand.Parameters.AddWithValue("@DESCR", txtKeterangan.Text);
                        myCommand.Parameters.AddWithValue("@CHGDT", DateTime.Now.ToString("yyyy/MM/dd"));
                        myCommand.Parameters.AddWithValue("@CHUSR", (string)Session["username"]);
                        myCommand.ExecuteNonQuery();
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Data berhasil disimpan');window.location ='MonitoringHum.aspx';", true);
                    }
                }
                else
                {
                    conn.Open();
                    string query = "INSERT INTO asset.PlantMeasurement (BUSID, TRADT, PLTTY, PLTID, RESLT, TRAST, DESCR, CHGDT, CHUSR)";
                    query += "VALUES (@BUSID, @TRADT, @PLTTY, @PLTID, @RESLT, @TRAST, @DESCR, @CHGDT, @CHUSR)";
                    SqlCommand myCommand = new SqlCommand(query, conn);
                    myCommand.Parameters.AddWithValue("@BUSID", "1");
                    myCommand.Parameters.AddWithValue("@TRADT", txtTime.Text);
                    myCommand.Parameters.AddWithValue("@PLTTY", "H-" + ddlRuangan.SelectedItem.Value);
                    myCommand.Parameters.AddWithValue("@PLTID", ddlRuangan.SelectedItem.Value);
                    myCommand.Parameters.AddWithValue("@RESLT", txtHasil.Text);
                    if (float.Parse(txtHasil.Text) > float.Parse(txtMaxal.Text) || float.Parse(txtHasil.Text) > float.Parse(txtMaxac.Text) || float.Parse(txtHasil.Text) < float.Parse(txtMinac.Text) || float.Parse(txtHasil.Text) < float.Parse(txtMinal.Text))
                    {
                        myCommand.Parameters.AddWithValue("@TRAST", 'O');
                    }
                    else
                    {
                        myCommand.Parameters.AddWithValue("@TRAST", 'N');
                    }
                    myCommand.Parameters.AddWithValue("@DESCR", txtKeterangan.Text);
                    myCommand.Parameters.AddWithValue("@CHGDT", DateTime.Now.ToString("yyyy/MM/dd"));
                    myCommand.Parameters.AddWithValue("@CHUSR", "DHINO");
                    myCommand.ExecuteNonQuery();
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Data berhasil ditambahkan');window.location ='MonitoringHum.aspx';", true);
                    //Response.Redirect("MonitoringHum.aspx");
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                conn.Close();
            }

        }
    }
</script>

<html lang="en">
<head>
    <% Response.Write(Basic.GetMetaScript()); %>

    <title><% Response.Write(ConfigurationManager.AppSettings["App_Name"]); %></title>

    <% Response.Write(CSS.GetCoreStyle()); %>
    <% Response.Write(CSS.GetCustomStyle()); %>
    <% Response.Write(CSS.GetTableStyle()); %>

    <script src="../../Scripts/bootstrap-datetimepicker/js/datetimepicker.js"></script>
    <link rel="stylesheet" href="../../Scripts/bootstrap-datetimepicker/css/datetimepicker.css">
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
                                Physical Monitoring | Monitoring Kelembaban
                              <span class="tools pull-right">
                                  <a class="fa fa-chevron-down" href="javascript:;"></a>
                              </span>
                            </header>
                                <div class="panel-body">
                                    <div class="form-horizontal " runat="server">

                                        <div class="form-group">
                                            <label class="col-sm-2 control-label">Jenis Monitoring</label>
                                            <div class="col-lg-4 col-md-4 col-sm-4">
                                                <asp:TextBox ID="txtJenisMonitoring" runat="server" class="form-control m-bot15" Text="HUMIDITY" disabled></asp:TextBox>
                                            </div>
                                            <label class="col-sm-1 control-label">Tanggal, Jam</label>
                                            <div class="col-lg-4 col-md-4 col-sm-4">
                                                <asp:TextBox ID="txtTime" runat="server" class="form-control m-bot15 datetimepicker1"></asp:TextBox>
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <label class="col-sm-2 control-label">Bagian</label>
                                            <div class="col-lg-4 col-md-4 col-sm-4">
                                                <asp:DropDownList ID="ddlBagian" runat="server" class="form-control chosen-select m-bot15" AutoPostBack ="true" OnSelectedIndexChanged="ddlBagian_SelectedIndexChanged">
                                                    <asp:ListItem Value="" Text="----- Pilih Bagian -----"></asp:ListItem>
                                                </asp:DropDownList>
                                            </div>
                                            <label class="col-sm-1 control-label">Minimum Alert</label>
                                                <div class="col-lg-4 col-md-4 col-sm-4">
                                                    <asp:TextBox ID="txtMinal" runat="server" class="form-control m-bot15" ReadOnly="true"></asp:TextBox>
                                                </div>
                                        </div>

                                        <div class="form-group">
                                            <label class="col-sm-2 control-label">Gedung</label>
                                            <div class="col-lg-4 col-md-4 col-sm-4">
                                                <asp:DropDownList ID="ddlGedung" runat="server" class="form-control chosen-select m-bot15" AutoPostBack ="true" Enabled="false" OnSelectedIndexChanged="ddlGedung_SelectedIndexChanged">
                                                    <asp:ListItem Value="" Text="----- Pilih Gedung -----"></asp:ListItem>
                                                </asp:DropDownList>
                                            </div>
                                            <label class="col-sm-1 control-label">Maximum Alert</label>
                                                <div class="col-lg-4 col-md-4 col-sm-4">
                                                    <asp:TextBox ID="txtMaxal" runat="server" class="form-control m-bot15" ReadOnly="true"></asp:TextBox>
                                                </div>
                                        </div>

                                        <div class="form-group">
                                            <label class="col-sm-2 control-label">Ruangan</label>
                                            <div class="col-lg-4 col-md-4 col-sm-4">
                                                <asp:DropDownList ID="ddlRuangan" runat="server" class="form-control chosen-select m-bot15" AutoPostBack ="true" Enabled = "false"  OnSelectedIndexChanged="ddlRuangan_SelectedIndexChanged">
                                                    <asp:ListItem Value="" Text="----- Pilih Ruangan -----"></asp:ListItem>
                                                </asp:DropDownList>
                                            </div>
                                            <label class="col-sm-1 control-label">Minimum Action</label>
                                                <div class="col-lg-4 col-md-4 col-sm-4">
                                                    <asp:TextBox ID="txtMinac" runat="server" class="form-control m-bot15" ReadOnly="true"></asp:TextBox>
                                                </div>
                                        </div>

                                        <div class="form-group">
                                            <label class="col-sm-2 control-label">Hygrometer</label>
                                                <div class="col-lg-4 col-md-4 col-sm-4">
                                                    <asp:TextBox ID="txtHygrometer" runat="server" class="form-control m-bot15" ReadOnly="true"></asp:TextBox>
                                                </div>
                                            <label class="col-sm-1 control-label">Maximum Action</label>
                                                <div class="col-lg-4 col-md-4 col-sm-4">
                                                    <asp:TextBox ID="txtMaxac" runat="server" class="form-control m-bot15" ReadOnly="true"></asp:TextBox>
                                                </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-sm-2 control-label">Keterangan</label>
                                                <div class="col-lg-4 col-md-4 col-sm-4">
                                                    <asp:TextBox ID="txtKeterangan" runat="server" class="form-control m-bot15" ReadOnly="true"></asp:TextBox>
                                                </div>
                                            <label class="col-sm-1 control-label">Hasil</label>
                                                <div class="col-lg-4 col-md-4 col-sm-4">
                                                    <asp:TextBox ID="txtHasil" runat="server" class="form-control m-bot15" ReadOnly="true"></asp:TextBox>
                                                </div>
                                        </div>

                                        <div class="form-group">
                                            <label class="col-sm-2 control-label"></label>
                                            <div class="col-lg-4 col-md-4">
                                                <asp:LinkButton class="btn btn-round btn-green" Visible="true" ID="btnAdd" runat="server" Text="Tambah <i class='fa fa-plus'></i>" OnClick="btnAdd_Click"/>
                                                <asp:LinkButton class="btn btn-round btn-danger" Visible="true" ID="btnCancel" runat="server" Text="Batal <i class='fa fa-times'></i>" href="../../Views/Administrator/MonitoringHum.aspx" />
                                            </div>
                                        </div>

                                        

                                    </div>
                                </div>
                           
                        </section>
                        <section class="panel">
                            
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
                                                    <li><a href="#"><i class="fa fa-print"></i> Print Document </a></li>
                                                </ul>
                                            </div>
                                        </div>
                                        <table class="table table-striped table-hover table-bordered" id="dynamic-table">
                                            <thead>
                                                <tr>    
                                                    <th>No.</th>    
                                                    <th>Ruangan</th>   
                                                    <th>Tanggal</th>       
                                                    <th>Hari</th>
                                                    <th>Jam</th>
                                                    <th>Hasil</th>       
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
<script type="text/javascript">
    var config = {
        '.chosen-select': {},
        '.chosen-select-deselect': { allow_single_deselect: true },
        '.chosen-select-no-single': { disable_search_threshold: 10 },
        '.chosen-select-no-results': { no_results_text: 'Oops, nothing found!' },
        '.chosen-select-width': { width: "95%" }
    }
    for (var selector in config) {
        $(selector).chosen(config[selector]);
    }
    $('.datetimepicker1').datetimepicker({
        startDate: '+0d',
        format: "mm/dd/yyyy hh:ii",
        autoclose: true,
        todayBtn: true,
        pickerPosition: "bottom-left"
    });
</script>
</html>
