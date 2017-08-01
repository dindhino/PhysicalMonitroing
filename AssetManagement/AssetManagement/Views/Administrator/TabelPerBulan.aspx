<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TabelPerBulan.aspx.cs" Inherits="AssetManagement.Views.Administrator.TabelPerBulan" %>

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
            jenis.Text = "TEMPERATUR";
            GetNilai();
        }
    }

    protected String GenerateData()
    {
        StringBuilder _table = new StringBuilder();
        String strConnString = ConfigurationManager.ConnectionStrings["BiofarmaConnectionTest"].ConnectionString;
        String strQuery = "select * from asset.PlantMeasurement where PLTTY like 'T%'";
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
            if (table.Rows.Count != 0)
            {
                for (int i = 0; i < table.Rows.Count; i++)
                {

                    _table.Append("<tr class=''>");
                    _table.Append("<td>" + DateTimeFormat.GetDateFormat(table.Rows[i]["TRADT"].ToString()) + "</td>");
                    _table.Append("<td>" + DateTime.Parse(table.Rows[i]["TRADT"].ToString()).ToString("dddd", new System.Globalization.CultureInfo("id-ID")) + "</td>");
                    _table.Append("<td>" + DateTime.Parse(table.Rows[i]["TRADT"].ToString()).ToString("HH:mm", new System.Globalization.CultureInfo("id-ID")) + "</td>");
                    _table.Append("<td>" + table.Rows[i]["RESLT"].ToString() + "</td>");
                    if (table.Rows[i]["TRAST"].ToString() == "N")
                        _table.Append("<td> Normal </td>");
                    else if (table.Rows[i]["TRAST"].ToString() == "O")
                        _table.Append("<td> OOS </td>");
                    _table.Append("<td>" + table.Rows[i]["DESCR"].ToString() + "</td>");
                    _table.Append("</tr>");
                }
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
    
    protected void GetNilai()
    {
        StringBuilder _table = new StringBuilder();
        String strConnString = ConfigurationManager.ConnectionStrings["BiofarmaConnectionTest"].ConnectionString;
        String strQuery = "SELECT min(reslt) as min, max(reslt) as max, avg(reslt) as avg, SUM(CASE WHEN trast='O' THEN 1 ELSE 0 END) as oos FROM [asset].[PlantMeasurement] where PLTTY like 'T%'";
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
            if (table.Rows.Count != 0)
            {
                nmin.Text = table.Rows[0]["min"].ToString();
                nmax.Text = table.Rows[0]["max"].ToString();
                navg.Text = table.Rows[0]["avg"].ToString();
                noos.Text = table.Rows[0]["oos"].ToString();   
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
</script>
<script type = "text/javascript">
    function PrintPanel() {
        var panel = document.getElementById("<%=pnlContents.ClientID %>");
        var printWindow = window;
        printWindow.document.write('<html><head><title>LAPORAN PEMANTAUAN RUANGAN PER BULAN</title>');
        printWindow.document.write('</head><body >');
        printWindow.document.write(panel.innerHTML);
        printWindow.document.write('</body></html>');
        printWindow.document.close();
        setTimeout(function () {
            printWindow.print();
        }, 500);
        return false;
    }
    </script>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body onload="PrintPanel()">
    <form id="form1" runat="server">
        <div>
            <asp:Panel id="pnlContents" runat = "server">
                <div style="margin-left: auto; margin-right: auto; text-align: center;">
                    <asp:Label runat="server" align="center">LAPORAN PEMANTAUAN <asp:Label ID="jenis" runat="server">[JENIS MONITORING]</asp:Label> RUANGAN PER BULAN</asp:Label>
                </div>
                <br /><br />

                <asp:Label>Bagian: <asp:Label runat="server" ID="bagian">[BAGIAN]</asp:Label></asp:Label><br />
                <asp:Label>Gedung: <asp:Label runat="server" ID="gedung">[GEDUNG]</asp:Label></asp:Label><br />
                <asp:Label>Ruangan: <asp:Label runat="server" ID="ruangan">[RUANGAN]</asp:Label></asp:Label><br />
                <asp:Label>Bulan: <asp:Label runat="server" ID="bulan">[BULAN]</asp:Label></asp:Label><br />
                <asp:Label>Tahun: <asp:Label runat="server" ID="tahun">[TAHUN]</asp:Label></asp:Label><br />
                <asp:Label>Minimum Alert: <asp:Label runat="server" ID="minal">[MINIMUM ALERT]</asp:Label></asp:Label><br />
                <asp:Label>Maximum Alert: <asp:Label runat="server" ID="maxal">[MAXIMUM ALERT]</asp:Label></asp:Label><br />
                <asp:Label>Minimum Action: <asp:Label runat="server" ID="minac">[MININUM ACTION]</asp:Label></asp:Label><br />
                <asp:Label>Maximum Action: <asp:Label runat="server" ID="maxac">[MAXIMUM ACTION]</asp:Label></asp:Label><br />
                <br /><br />

                <table border="1">
                    <thead>
                        <tr>
                            <th>Tanggal</th>   
                            <th>Hari</th>    
                            <th>Jam</th>    
                            <th>Hasil</th>   
                            <th>Status</th>
                            <th>Keterangan</th>
                        </tr>
                    </thead>
                    <tbody>
				        <%  Response.Write(GenerateData()); %>
                    </tbody>
                </table>
                <br /><br/>

                <asp:Label>Nilai Minimum: <asp:Label runat="server" ID="nmin">[Nilai Minimum]</asp:Label></asp:Label><br />
                <asp:Label>Nilai Maximum: <asp:Label runat="server" ID="nmax">[Nilai Maximum]</asp:Label></asp:Label><br />
                <asp:Label>Nilai Rata-rata: <asp:Label runat="server" ID="navg">[Niali Rata-rata]</asp:Label></asp:Label><br />
                <asp:Label>Jumalah OOS: <asp:Label runat="server" ID="noos">[Jumlah OOS]</asp:Label></asp:Label><br />
            </asp:Panel>
        </div>
    </form>
</body>
</html>
