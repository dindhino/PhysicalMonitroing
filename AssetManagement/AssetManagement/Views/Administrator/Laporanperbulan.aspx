<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Laporanperbulan.aspx.cs" Inherits="AssetManagement.Views.Administrator.Laporanperbulan" %>

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

    protected void SessionCreator()
    {
        Session["username"] = "1906";
        Session["name"] = "Allan Prakosa";
        Session["password"] = "BIOFARMA";
        Session["email"] = "allanprakosa@biofarma.co.id";
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
                                    Laporan Monitoring | Laporan Per Bulan
                                </header>
                                <div class="panel-body">
                                    <div class="form-horizontal " runat="server">
                                        <div class="form-group">
                                            <label class="col-sm-2 control-label">Bagian</label>
                                            <div class="col-lg-4 col-md-4 col-sm-4">
                                                <asp:DropDownList ID="ddlBagian" runat="server" class="form-control chosen-select m-bot15" AutoPostBack ="true" OnSelectedIndexChanged="ddlBagian_SelectedIndexChanged">
                                                    <asp:ListItem Value="" Text="----- Pilih Bagian -----"></asp:ListItem>
                                                </asp:DropDownList>
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <label class="col-sm-2 control-label">Gedung</label>
                                            <div class="col-lg-4 col-md-4 col-sm-4">
                                                <asp:DropDownList ID="ddlGedung" runat="server" class="form-control chosen-select m-bot15" AutoPostBack ="true" Enabled="false" OnSelectedIndexChanged="ddlGedung_SelectedIndexChanged">
                                                    <asp:ListItem Value="" Text="----- Pilih Gedung -----"></asp:ListItem>
                                                </asp:DropDownList>
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <label class="col-sm-2 control-label">Ruangan</label>
                                            <div class="col-lg-4 col-md-4 col-sm-4">
                                                <asp:DropDownList ID="ddlRuangan" runat="server" class="form-control chosen-select m-bot15" AutoPostBack ="true" Enabled="false" OnSelectedIndexChanged="ddlRuangan_SelectedIndexChanged">
                                                    <asp:ListItem Value="" Text="----- Pilih Ruangan -----"></asp:ListItem>
                                                </asp:DropDownList>
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <label class="col-sm-2 control-label">Bulan</label>
                                            <div class="col-lg-4 col-md-4 col-sm-4">
                                                <select class="form-control m-bot15" id="txtBulan">
                                                    <option value="">----- Pilih Bulan -----</option>
                                                    <option value="01">Januari</option>
                                                    <option value="02">Februari</option>
                                                    <option value="03">Maret</option>
                                                    <option value="04">April</option>
                                                    <option value="05">Mei</option>
                                                    <option value="06">Juni</option>
                                                    <option value="07">Juli</option>
                                                    <option value="08">Agustus</option>
                                                    <option value="09">September</option>
                                                    <option value="10">Oktober</option>
                                                    <option value="11">November</option>
                                                    <option value="12">Desember</option>
                                                </select>
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <label class="col-sm-2 control-label">Tahun</label>
                                            <div class="col-lg-4 col-md-4 col-sm-4">
                                                <asp:TextBox ID="txtTahun" runat="server" class="form-control m-bot15" type="number" Text="2017"></asp:TextBox>
                                            </div>
                                        </div>

                                        <br />

                                        <div class="form-group">
                                            <label class="col-sm-2 control-label">Termometer</label>
                                            <div class="col-lg-4 col-md-4 col-sm-4">
                                                <div class="i-checks"><label> <input type="radio" value="termtabel" name="a"> <i></i> Tabel Data </label></div>
                                                <div class="i-checks"><label> <input type="radio" value="termgrafik" name="a"> <i></i> Grafik Data </label></div>
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <label class="col-sm-2 control-label">Kelembaban</label>
                                            <div class="col-lg-4 col-md-4 col-sm-4">
                                                <div class="i-checks"><label> <input type="radio" value="klmtabel" name="a"> <i></i> Tabel Data </label></div>
                                                <div class="i-checks"><label> <input type="radio" value="klmgrafik" name="a"> <i></i> Grafik Data </label></div>
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <label class="col-sm-2 control-label">Perbedaan Tekanan</label>
                                            <div class="col-lg-4 col-md-4 col-sm-4">
                                                <div class="i-checks"><label> <input type="radio" value="diftabel" name="a"> <i></i> Tabel Data </label></div>
                                                <div class="i-checks"><label> <input type="radio" value="difgrafik" name="a"> <i></i> Grafik Data </label></div>
                                            </div>
                                        </div>
                               

                                        <div class="form-group">
                                            <label class="col-sm-2 control-label"></label>
                                            <div class="col-lg-4 col-md-4 col-sm-4">
                                                <asp:LinkButton class="btn btn-round btn-green" Visible="true" ID="btnAdd" runat="server" Text="Proses  <i class='fa fa-plus'></i>" href="../../Views/Administrator/TabelPerBulan.aspx" target="_blank"/>
                                                <asp:LinkButton class="btn btn-round btn-danger" Visible="true" ID="btnCancel" runat="server" Text="Batal <i class='fa fa-times'></i>" href="../../Views/Administrator/Laporanperbulan.aspx" />
                                            </div>
                                        </div>

                                    </div>
                                </div>
                            </section>
                        </div>
                    </div>
                </form>
            </section>
        </section>
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
