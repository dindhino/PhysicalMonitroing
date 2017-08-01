<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PrintChartPerBulan.aspx.cs" Inherits="AssetManagement.Views.PrintChartPerBulan" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<%@ Import Namespace="Biofarma.AssetManagement.Data.DataAccess" %>
<%@ Import Namespace="Biofarma.AssetManagement.Presentation" %>
<%@ Import Namespace="Biofarma.Framework.Security" %>
<%@ Import Namespace="Biofarma.Framework.Entity" %>
<%@ Import Namespace="Biofarma.Presentation.Component" %>
<%@ Import Namespace="Biofarma.Framework.Converter" %>
<%@ Import Namespace="System.Web.Configuration" %>
<%@ Import Namespace="System.Configuration" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>

<!DOCTYPE html>
<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string query = "select tradt, reslt from asset.PlantMeasurement where pltty like 'T%' order by tradt";
            DataTable dt = GetData(query);

            string[] x = new string[dt.Rows.Count];
            decimal[] y = new decimal[dt.Rows.Count];
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                x[i] = dt.Rows[i]["tradt"].ToString();
                y[i] = Convert.ToInt32(dt.Rows[i]["reslt"]);
            }
            LineChart1.Series.Add(new AjaxControlToolkit.LineChartSeries { Data = y });
            LineChart1.CategoriesAxis = string.Join(",", x);
            LineChart1.ChartTitle = "Monitoring Termometer";
            if (x.Length > 3)
            {
                LineChart1.ChartWidth = (x.Length * 150).ToString();
            }
            LineChart1.Visible = true;
        }
    }

    private static DataTable GetData(string query)
    {
        DataTable dt = new DataTable();
        string constr = ConfigurationManager.ConnectionStrings["LocalPM"].ConnectionString;
        using (SqlConnection con = new SqlConnection(constr))
        {
            using (SqlCommand cmd = new SqlCommand(query))
            {
                using (SqlDataAdapter sda = new SqlDataAdapter())
                {
                    cmd.CommandType = CommandType.Text;
                    cmd.Connection = con;
                    sda.SelectCommand = cmd;
                    sda.Fill(dt);
                }
            }
            return dt;
        }
    }
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    
</head>
<body>
    <form id="form1" runat="server">
        <p align="center">Grafik Pemantauan Temperatur</p>
        <p align="center">Bagian: </p>
        <p align="center">Gedung: </p>
        <p align="center">Ruangan: </p>
        <p align="center">Bulan: </p>
        <p align="center">Tahun: </p>
        <cc1:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server">
        </cc1:ToolkitScriptManager>
        <cc1:LineChart ID="LineChart1" runat="server" ChartHeight="300" ChartWidth="450"
            ChartType="Basic" ChartTitleColor="#0E426C" Visible="false" CategoryAxisLineColor="#D08AD9"
            ValueAxisLineColor="#D08AD9" BaseLineColor="#A156AB">
        </cc1:LineChart>
    </form>
</body>
</html>
