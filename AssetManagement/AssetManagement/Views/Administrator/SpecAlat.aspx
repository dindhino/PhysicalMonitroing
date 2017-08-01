<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SpecAlat.aspx.cs" Inherits="AssetManagement.Views.Administrator.SpecAlat" %>

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
                string _spcty = Cryptography.Decrypt(Request.QueryString["spcty"], true);
                string _plnt1 = Cryptography.Decrypt(Request.QueryString["plnt1"], true);
                string _plnt2 = Cryptography.Decrypt(Request.QueryString["plnt2"], true);

                if (Request.QueryString["actio"] == "1")
                {
                    btnAdd.Text = "Simpan <i class='fa fa-floppy-o'></i>";
                    ddlSpecType.Enabled = false;
                    ddlBagian.Enabled = false;
                    ddlGedung.Enabled = false;
                    ddlRuangan.Enabled = false;
                    ddlRuangan2.Enabled = false;
                    txtMaxac.Enabled = true;
                    txtMinac.Enabled = true;
                    txtMaxal.Enabled = true;
                    txtMinal.Enabled = true;
                    GetSpec(_spcty, _plnt1, _plnt2);
                }
                else if (Request.QueryString["actio"] == "2")
                {
                    DelimitData(_spcty, _plnt1, _plnt2);
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Data berhasil di-delimit');window.location ='SpecAlat.aspx';", true);
                }
                else if (Request.QueryString["actio"] == "3")
                {
                    DeleteData(_spcty, _plnt1, _plnt2);
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Data berhasil dihapus');window.location ='SpecAlat.aspx';", true);
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
    
    protected void GetSpec(String spcty, String plnt1, String plnt2)
    {
        String strConn = ConfigurationManager.ConnectionStrings["BiofarmaConnectionTest"].ConnectionString;
        SqlConnection con1 = new SqlConnection(strConn);
        String strQuery1 = "SELECT * FROM [asset].[PlantSpecification] where ENDDA>GETDATE() and SPCTY=@SPCTY and PLNT1=@PLNT1 and PLNT2=@PLNT2";
        SqlCommand cmd1 = new SqlCommand();
        cmd1.CommandType = CommandType.Text;
        cmd1.CommandText = strQuery1;
        cmd1.Connection = con1;
        cmd1.Parameters.AddWithValue("@SPCTY", spcty);
        cmd1.Parameters.AddWithValue("@PLNT1", plnt1);
        cmd1.Parameters.AddWithValue("@PLNT2", plnt2);
        try
        {
            con1.Open();
            SqlDataAdapter adapter1 = new SqlDataAdapter(cmd1);
            DataTable table1 = new DataTable();
            adapter1.Fill(table1);
            table1.TableName = "PlantSpec";
            if (table1.Rows.Count != 0)
            {
                txtMinal.Text = table1.Rows[0]["MINAL"].ToString();
                txtMaxal.Text = table1.Rows[0]["MAXAL"].ToString();
                txtMinac.Text = table1.Rows[0]["MINAC"].ToString();
                txtMaxac.Text = table1.Rows[0]["MAXAC"].ToString();
                if (table1.Rows[0]["SPCTY"].ToString() == "T")
                {
                    ddlSpecType.SelectedItem.Text = "Termometer";
                    ddlSpecType.SelectedItem.Value = "T";
                }
                else if (table1.Rows[0]["SPCTY"].ToString() == "H")
                {
                    ddlSpecType.SelectedItem.Text = "Hygrometer";
                    ddlSpecType.SelectedItem.Value = "H";
                }
                else if (table1.Rows[0]["SPCTY"].ToString() == "P")
                {
                    ddlSpecType.SelectedItem.Text = "Pressure";
                    ddlSpecType.SelectedItem.Value = "P";
                }

                SqlConnection con2 = new SqlConnection(strConn);
                String strQuery2 = "SELECT * FROM [asset].[PlantSpecification] join [asset].[PLANT_MASTER] on ([asset].[PlantSpecification].PLNT1 = [asset].[PLANT_MASTER].OBJID) where [asset].[PlantSpecification].SPCTY=@SPCTY and [asset].[PlantSpecification].PLNT1=@PLNT1 and [asset].[PlantSpecification].ENDDA > GETDATE()";
                SqlCommand cmd2 = new SqlCommand();
                cmd2.CommandType = CommandType.Text;
                cmd2.CommandText = strQuery2;
                cmd2.Connection = con2;
                cmd2.Parameters.AddWithValue("@SPCTY", spcty);
                cmd2.Parameters.AddWithValue("@PLNT1", plnt1);
                try
                {
                    con2.Open();
                    SqlDataAdapter adapter2 = new SqlDataAdapter(cmd2);
                    DataTable table2 = new DataTable();
                    adapter2.Fill(table2);
                    table2.TableName = "Plantt1";
                    if (table2.Rows.Count != 0)
                    {
                        ddlRuangan.SelectedItem.Text = table2.Rows[0]["PLNNM"].ToString();
                        ddlRuangan.SelectedItem.Value = table2.Rows[0]["OBJID"].ToString();
                    }
                }
                catch (Exception ex)
                {
                    throw ex;
                }
                finally
                {
                    con2.Close();
                    con2.Dispose();
                }

                SqlConnection con3 = new SqlConnection(strConn);
                String strQuery3 = "SELECT * FROM [asset].[PlantSpecification] join [asset].[PLANT_MASTER] on ([asset].[PlantSpecification].PLNT2 = [asset].[PLANT_MASTER].OBJID) where [asset].[PlantSpecification].SPCTY=@SPCTY and [asset].[PlantSpecification].PLNT2=@PLNT2 and [asset].[PlantSpecification].ENDDA > GETDATE()";
                SqlCommand cmd3 = new SqlCommand();
                cmd3.CommandType = CommandType.Text;
                cmd3.CommandText = strQuery3;
                cmd3.Connection = con3;
                cmd3.Parameters.AddWithValue("@SPCTY", spcty);
                cmd3.Parameters.AddWithValue("@PLNT2", plnt2);
                try
                {
                    con3.Open();
                    SqlDataAdapter adapter3 = new SqlDataAdapter(cmd3);
                    DataTable table3 = new DataTable();
                    adapter3.Fill(table3);
                    table3.TableName = "Plantt2";
                    if (table3.Rows.Count != 0)
                    {
                        ddlRuangan2.SelectedItem.Text = table3.Rows[0]["PLNNM"].ToString();
                        ddlRuangan2.SelectedItem.Value = table3.Rows[0]["OBJID"].ToString();
                    }
                }
                catch (Exception ex)
                {
                    throw ex;
                }
                finally
                {
                    con3.Close();
                    con3.Dispose();
                }
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
    
    protected void DelimitData(String spcty, String plnt1, String plnt2)
    {
        String strConnString = ConfigurationManager.ConnectionStrings["BiofarmaConnectionTest"].ConnectionString;
        SqlConnection conn = new SqlConnection(strConnString);
        try
        {
            conn.Open();
            string query = "UPDATE asset.PlantSpecification SET ENDDA=GETDATE(), CHGDT=GETDATE(), CHUSR=@CHUSR WHERE SPCTY=@SPCTY and PLNT1=@PLNT1 and PLNT2=@PLNT2";
            SqlCommand myCommand = new SqlCommand(query, conn);
            myCommand.Parameters.AddWithValue("@SPCTY", spcty);
            myCommand.Parameters.AddWithValue("@PLNT1", plnt1);
            myCommand.Parameters.AddWithValue("@PLNT2", plnt2);
            myCommand.Parameters.AddWithValue("@CHUSR", (string)Session["username"]);
            myCommand.ExecuteNonQuery();
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

    protected void btnAdd_Click(object sender, EventArgs e)
    {
        if (txtMaxal.Text == string.Empty)
        {
            ClientScript.RegisterStartupScript(this.GetType(), "myalert", "alert('" + "Informasi maximum alert tidak boleh kosong" + "');", true);
        }
        else if (txtMinal.Text == string.Empty)
        {
            ClientScript.RegisterStartupScript(this.GetType(), "myalert", "alert('" + "Informasi minimum alert tidak boleh kosong" + "');", true);
        }
        else if (txtMaxac.Text == string.Empty)
        {
            ClientScript.RegisterStartupScript(this.GetType(), "myalert", "alert('" + "Informasi maximum action tidak boleh kosong" + "');", true);
        }
        else if (txtMinac.Text == string.Empty)
        {
            ClientScript.RegisterStartupScript(this.GetType(), "myalert", "alert('" + "Informasi minimum action tidak boleh kosong" + "');", true);
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
                        string _spcty = Cryptography.Decrypt(Request.QueryString["spcty"], true);
                        string _plnt1 = Cryptography.Decrypt(Request.QueryString["plnt1"], true);
                        string _plnt2 = Cryptography.Decrypt(Request.QueryString["plnt2"], true);
                        DelimitData(_spcty, _plnt1, _plnt2);
                    }
                }
                conn.Open();
                string querycek = String.Format("SELECT TOP 1 SPCTY FROM asset.PlantSpecification WHERE ENDDA>GETDATE() and SPCTY='{0}' and PLNT1={1} and PLNT2={2}", ddlSpecType.SelectedItem.Value, ddlRuangan.SelectedItem.Value, ddlRuangan2.SelectedItem.Value);
                SqlCommand cek = new SqlCommand(querycek, conn);
                using (SqlDataReader reader = cek.ExecuteReader())
                {
                    if (reader.Read())
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Alat sudah tersedia pada ruangan tersebut');window.location ='SpecAlat.aspx';", true);
                    }
                    else
                    {
                        string query = "INSERT INTO asset.PlantSpecification (BUSID, BEGDA, ENDDA, SPCTY, PLTT1, PLNT1, PLTT2, PLNT2, MINAL, MAXAL, MINAC, MAXAC, CHGDT, CHUSR)";
                        query += "VALUES (@BUSID, @BEGDA, @ENDDA, @SPCTY, @PLTT1, @PLNT1, @PLTT2, @PLNT2, @MINAL, @MAXAL, @MINAC, @MAXAC, @CHGDT, @CHUSR)";
                        SqlCommand myCommand = new SqlCommand(query, conn);
                        myCommand.Parameters.AddWithValue("@BUSID", "1");
                        myCommand.Parameters.AddWithValue("@BEGDA", DateTime.Now.ToString("yyyy/MM/dd"));
                        myCommand.Parameters.AddWithValue("@ENDDA", "9999-12-31");
                        myCommand.Parameters.AddWithValue("@SPCTY", ddlSpecType.SelectedItem.Value);
                        myCommand.Parameters.AddWithValue("@PLTT1", "ROM1");
                        myCommand.Parameters.AddWithValue("@PLNT1", ddlRuangan.SelectedItem.Value);
                        myCommand.Parameters.AddWithValue("@PLTT2", "ROM1");
                        myCommand.Parameters.AddWithValue("@PLNT2", ddlRuangan2.SelectedItem.Value);
                        myCommand.Parameters.AddWithValue("@MINAL", txtMinal.Text);
                        myCommand.Parameters.AddWithValue("@MAXAL", txtMaxal.Text);
                        myCommand.Parameters.AddWithValue("@MINAC", txtMinac.Text);
                        myCommand.Parameters.AddWithValue("@MAXAC", txtMaxac.Text);
                        myCommand.Parameters.AddWithValue("@CHGDT", DateTime.Now.ToString("yyyy/MM/dd"));
                        myCommand.Parameters.AddWithValue("@CHUSR", (string)Session["username"]);
                        myCommand.ExecuteNonQuery();
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Data berhasil disimpan');window.location ='SpecAlat.aspx';", true);
                    }
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally {
                conn.Close();
            }
        }
        
    }
    
    protected String GenerateData()
    {
        StringBuilder _table = new StringBuilder();
        DataTable table = new DataTable();
        
        String strConnString = ConfigurationManager.ConnectionStrings["BiofarmaConnectionTest"].ConnectionString;
        SqlConnection conn = new SqlConnection(strConnString);
        StringBuilder query = new StringBuilder();
        String strQuery = "SELECT * FROM asset.PlantSpecification where [asset].[PlantSpecification].ENDDA > GETDATE() order by SPCTY";

        SqlCommand cmd = new SqlCommand();
        cmd.CommandType = CommandType.Text;
        cmd.CommandText = strQuery;
        cmd.Connection = conn;
        try
        {
            conn.Open();
            SqlDataAdapter adapter = new SqlDataAdapter(cmd);
            adapter.Fill(table);
            table.TableName = "PlantSpecification";
            if (table.Rows.Count != 0)
            {
                for (int i = 0; i < table.Rows.Count; i++)
                {
                    _table.Append("<tr class=''>");
                    if (table.Rows[i]["SPCTY"].ToString() == "T")
                        _table.Append("<td>Termometer</td>");
                    else if (table.Rows[i]["SPCTY"].ToString() == "H")
                        _table.Append("<td>Hygrometer</td>");
                    else if (table.Rows[i]["SPCTY"].ToString() == "P")
                        _table.Append("<td>Pressure</td>");
                    string _action = GetAction(table.Rows[i]["SPCTY"].ToString(), table.Rows[i]["PLNT1"].ToString(), table.Rows[i]["PLNT2"].ToString());
                    SqlConnection con1 = new SqlConnection(strConnString);
                    StringBuilder query1 = new StringBuilder();
                    String sp = table.Rows[i]["SPCTY"].ToString();
                    String pl = table.Rows[i]["PLNT1"].ToString();
                    String strQuery1 = String.Format("SELECT * FROM [asset].[PlantSpecification] join [asset].[PLANT_MASTER] on ([asset].[PlantSpecification].PLNT1 = [asset].[PLANT_MASTER].OBJID) where [asset].[PlantSpecification].SPCTY='{0}' and [asset].[PlantSpecification].PLNT1='{1}' and [asset].[PlantSpecification].ENDDA > GETDATE()", sp, pl);
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
                    con1 = new SqlConnection(strConnString);
                    query1 = new StringBuilder();
                    sp = table.Rows[i]["SPCTY"].ToString();
                    pl = table.Rows[i]["PLNT2"].ToString();
                    strQuery1 = String.Format("SELECT * FROM [asset].[PlantSpecification] join [asset].[PLANT_MASTER] on ([asset].[PlantSpecification].PLNT2 = [asset].[PLANT_MASTER].OBJID) where [asset].[PlantSpecification].SPCTY='{0}' and [asset].[PlantSpecification].PLNT2='{1}' and [asset].[PlantSpecification].ENDDA > GETDATE()", sp, pl);
                    cmd1 = new SqlCommand();
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
                    _table.Append("<td>" + table.Rows[i]["MINAL"].ToString() + "</td>");
                    _table.Append("<td>" + table.Rows[i]["MAXAL"].ToString() + "</td>");
                    _table.Append("<td>" + table.Rows[i]["MINAC"].ToString() + "</td>");
                    _table.Append("<td>" + table.Rows[i]["MAXAC"].ToString() + "</td>");
                    _table.Append("<td>" + _action + "</td>");
                    _table.Append("</tr>");
                }
            }
            return _table.ToString();
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            conn.Close();
            conn.Dispose();
        }
    }

    protected string GetAction(string SPCTY, string PLNT1, string PLNT2)
    {
        StringBuilder element = new StringBuilder();
        element.Append("<a class='btn btn-warning popovers' style='color:white;margin-bottom:5px;' href='SpecAlat.aspx?actio=1&spcty=" + Cryptography.Encrypt(SPCTY, true) + "&plnt1=" + Cryptography.Encrypt(PLNT1, true) + "&plnt2=" + Cryptography.Encrypt(PLNT2, true) + "' data-content='Silakan klik untuk melakukan preview dan update data' data-placement='left' data-trigger='hover'><i class='fa fa-edit'></i></a> ");
        element.Append("<a class='btn btn-default popovers' style='color:white;margin-bottom:5px;' href='SpecAlat.aspx?actio=2&spcty=" + Cryptography.Encrypt(SPCTY, true) + "&plnt1=" + Cryptography.Encrypt(PLNT1, true) + "&plnt2=" + Cryptography.Encrypt(PLNT2, true) + "' data-content='Silakan klik untuk melakukan delimit data. Apakah Anda yakin?' data-placement='left' data-trigger='hover'><i class='fa fa-recycle'></i></a> ");
        element.Append("<a class='btn btn-danger popovers' style='color:white;margin-bottom:5px;' href='SpecAlat.aspx?actio=3&spcty=" + Cryptography.Encrypt(SPCTY, true) + "&plnt1=" + Cryptography.Encrypt(PLNT1, true) + "&plnt2=" + Cryptography.Encrypt(PLNT2, true) + "' data-content='Silakan klik untuk menghapus data. Apakah Anda yakin?' data-placement='left' data-trigger='hover'><i class='fa fa-trash-o'></i></a> ");

        return element.ToString();
    }
    
    protected void ddlSpecType_SelectedIndexChanged(object sender, EventArgs e)
    {
        ddlBagian.Items.Clear();
        ddlBagian.Items.Add(new ListItem("----- Pilih Bagian -----", ""));
        ddlGedung.Items.Clear();
        ddlGedung.Items.Add(new ListItem("----- Pilih Gedung -----", ""));
        ddlRuangan.Items.Clear();
        ddlRuangan.Items.Add(new ListItem("----- Pilih Ruangan 1 ----- ", ""));

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

    protected void ddlBagian_SelectedIndexChanged(object sender, EventArgs e)
    {
        ddlGedung.Items.Clear();
        ddlGedung.Items.Add(new ListItem("----- Pilih Gedung -----", ""));
        ddlRuangan.Items.Clear();
        ddlRuangan.Items.Add(new ListItem("----- Pilih Ruangan 1 ----- ", ""));

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
        ddlRuangan.Items.Add(new ListItem("----- Pilih Ruangan 1 -----", ""));
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
        if (ddlSpecType.SelectedItem.Value == "T" || ddlSpecType.SelectedItem.Value == "H")
        {
            ddlRuangan2.SelectedItem.Text = ddlRuangan.SelectedItem.Text;
            ddlRuangan2.SelectedItem.Value = ddlRuangan.SelectedItem.Value;
            txtMinal.Enabled = true;
            txtMaxal.Enabled = true;
            txtMinac.Enabled = true;
            txtMaxac.Enabled = true;
        }
        else if (ddlSpecType.SelectedItem.Value == "P")
        {
            ddlRuangan2.Items.Clear();
            ddlRuangan2.Items.Add(new ListItem("----- Pilih Ruangan 2 -----", ""));
            ddlRuangan.AppendDataBoundItems = true;
            String strConnString = ConfigurationManager.ConnectionStrings["BiofarmaConnectionTest"].ConnectionString;
            String strQuery = "select * from asset.PLANT_MASTER join asset.PLANT_RELATION on (asset.PLANT_MASTER.OBJID=asset.PLANT_RELATION.CHILD) where MAJCD='ROM' and asset.PLANT_RELATION.PARNT=@objid";
            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand();
            cmd.Parameters.AddWithValue("@objid", ddlGedung.SelectedItem.Value);
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = strQuery;
            cmd.Connection = con;
            try
            {
                con.Open();
                ddlRuangan2.DataSource = cmd.ExecuteReader();
                ddlRuangan2.DataTextField = "PLNNM";
                ddlRuangan2.DataValueField = "OBJID";
                ddlRuangan2.DataBind();
                if (ddlRuangan2.Items.Count > 1)
                {
                    ddlRuangan2.Enabled = true;
                }
                else
                {
                    ddlRuangan2.Enabled = false;
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

    protected void ddlRuangan2_SelectedIndexChanged(object sender, EventArgs e)
    {
        txtMinal.Enabled = true;
        txtMaxal.Enabled = true;
        txtMinac.Enabled = true;
        txtMaxac.Enabled = true;
    }
    
    protected void DeleteData(string spcty, string plnt1, string plnt2)
    {
        String strConn = ConfigurationManager.ConnectionStrings["BiofarmaConnectionTest"].ConnectionString;
        SqlConnection conn = new SqlConnection(strConn);
        
        StringBuilder query = new StringBuilder();
        query.Append(" DELETE FROM asset.PlantSpecification  ");
        query.Append(" WHERE SPCTY=@spcty AND                ");
        query.Append(" PLNT1=@plnt1 AND                      ");
        query.Append(" PLNT2=@plnt2                          ");
        
        SqlCommand cmd = new SqlCommand();
        cmd.Parameters.AddWithValue("@spcty", spcty);
        cmd.Parameters.AddWithValue("@plnt1", plnt1);
        cmd.Parameters.AddWithValue("@plnt2", plnt2);
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
                                Physical Monitoring | Spesifikasi Alat
                              <span class="tools pull-right">
                                  <a class="fa fa-chevron-down" href="javascript:;"></a>
                              </span>
                            </header>
                                <div class="panel-body">
                                    <div class="form-horizontal " runat="server">
                                        <div class="form-group">
                                            <label class="col-sm-2 control-label">Tipe Spesifikasi</label>
                                            <div class="col-lg-4 col-md-4 col-sm-4">
                                                <asp:DropDownList ID="ddlSpecType" runat="server" class="form-control  m-bot15" AutoPostBack ="true" Enabled = "true"  OnSelectedIndexChanged="ddlSpecType_SelectedIndexChanged">
                                                    <asp:ListItem Value="" Text="----- Pilih Tipe Spesifikasi -----"></asp:ListItem>
                                                    <asp:ListItem Value="T" Text="Termometer"></asp:ListItem>
                                                    <asp:ListItem Value="H" Text="Hygrometer"></asp:ListItem>
                                                    <asp:ListItem Value="P" Text="Differential Pressure Gauge"></asp:ListItem>
                                                </asp:DropDownList>
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <label class="col-sm-2 control-label">Bagian</label>
                                            <div class="col-lg-4 col-md-4 col-sm-4">
                                                <asp:DropDownList ID="ddlBagian" runat="server" class="form-control chosen-select m-bot15" AutoPostBack ="true" Enabled = "false"  OnSelectedIndexChanged="ddlBagian_SelectedIndexChanged">
                                                    <asp:ListItem Value="" Text="----- Pilih Bagian -----"></asp:ListItem>
                                                </asp:DropDownList>
                                            </div>
                                            <label class="col-sm-1 control-label">Gedung</label>
                                            <div class="col-lg-4 col-md-4 col-sm-4">
                                                <asp:DropDownList ID="ddlGedung" runat="server" class="form-control chosen-select m-bot15" AutoPostBack ="true" Enabled = "false"  OnSelectedIndexChanged="ddlGedung_SelectedIndexChanged">
                                                    <asp:ListItem Value="" Text="----- Pilih Gedung -----"></asp:ListItem>
                                                </asp:DropDownList>
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <label class="col-sm-2 control-label">Ruangan 1</label>
                                            <div class="col-lg-4 col-md-4 col-sm-4">
                                                <asp:DropDownList ID="ddlRuangan" runat="server" class="form-control chosen-select m-bot15" AutoPostBack ="true" Enabled = "false"  OnSelectedIndexChanged="ddlRuangan_SelectedIndexChanged">
                                                    <asp:ListItem Value="" Text="----- Pilih Ruangan 1 -----"></asp:ListItem>
                                                </asp:DropDownList>
                                            </div>
                                            <label class="col-sm-1 control-label">Ruangan 2</label>
                                            <div class="col-lg-4 col-md-4 col-sm-4">
                                                <asp:DropDownList ID="ddlRuangan2" runat="server" class="form-control chosen-select m-bot15" Enabled = "false" AutoPostBack="true" OnSelectedIndexChanged="ddlRuangan2_SelectedIndexChanged">
                                                    <asp:ListItem Value="" Text="----- Pilih Ruangan 2 -----"></asp:ListItem>
                                                </asp:DropDownList>
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <label class="col-sm-2 control-label">Minimum Alert</label>
                                            <div class="col-lg-4 col-md-4 col-sm-4">
                                                <asp:TextBox ID="txtMinal" type="number" step="0.000001" runat="server" class="form-control  m-bot15" Enabled = "false">
                                                </asp:TextBox>
                                            </div>
                                            <label class="col-sm-1 control-label">Maximum Alert</label>
                                            <div class="col-lg-4 col-md-4 col-sm-4">
                                                <asp:TextBox ID="txtMaxal" type="number" step="0.000001" runat="server" class="form-control  m-bot15" Enabled = "false">

                                                </asp:TextBox>
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <label class="col-sm-2 control-label">Minimum Action</label>
                                            <div class="col-lg-4 col-md-4 col-sm-4">
                                                <asp:TextBox ID="txtMinac" type="number" step="0.000001" runat="server" class="form-control  m-bot15" Enabled = "false">
                                                </asp:TextBox>
                                            </div>
                                            <label class="col-sm-1 control-label">Maximum Action</label>
                                            <div class="col-lg-4 col-md-4 col-sm-4">
                                                <asp:TextBox ID="txtMaxac" type="number" step="0.000001" runat="server" class="form-control  m-bot15" Enabled = "false">

                                                </asp:TextBox>
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <label class="col-sm-2 control-label"></label>
                                            <div class="col-lg-4 col-md-4">
                                                <asp:LinkButton class="btn btn-round btn-green" Visible="true" ID="btnAdd" runat="server" Text="Tambah  <i class='fa fa-plus'></i>" OnClick="btnAdd_Click" />
                                                <asp:LinkButton class="btn btn-round btn-danger" Visible="true" ID="btnCancel" runat="server" Text="Batal <i class='fa fa-times'></i>" href="../../Views/Administrator/SpecAlat.aspx" />
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
                                                    <li><a href="#"><i class="fa fa-print"></i> Print Document</a></li>
                                                </ul>
                                            </div>
                                        </div>
                                        <table class="table table-striped table-hover table-bordered" id="dynamic-table">
                                            <thead>
                                                <tr>
                                                    <th>Tipe Spesifikasi</th>       
                                                    <th>Plant 1</th>       
                                                    <th>Plant 2</th>
                                                    <th>Minimal Alert</th>
                                                    <th>Maximal Alert</th>
                                                    <th>Minimal Action</th>
                                                    <th>Maximal Action</th>
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
</script>
</html>
