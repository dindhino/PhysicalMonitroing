<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Laporanpertahun.aspx.cs" Inherits="AssetManagement.Views.Administrator.Laporanpertahun" %>

<%@ Import Namespace="Biofarma.AssetManagement.Data.DataAccess" %>
<%@ Import Namespace="Biofarma.AssetManagement.Presentation" %>
<%@ Import Namespace="Biofarma.Framework.Security" %>
<%@ Import Namespace="Biofarma.Framework.Entity" %>
<%@ Import Namespace="Biofarma.Presentation.Component" %>
<%@ Import Namespace="Biofarma.Framework.Converter" %>
<%@ Import Namespace="System.Web.Configuration" %>
<%@ Import Namespace="System.Data" %>

<!DOCTYPE html>

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
                                    Laporan Monitoring | Laporan Per Tahun
                                  <span class="tools pull-right">
                                      <a class="fa fa-times" href="javascript:;"></a>
                                  </span>
                                </header>
                                <div class="panel-body">
                                    <div class="form-horizontal " runat="server">
                                        <div class="form-group">
                                            <label class="col-sm-2 control-label">Bagian</label>
                                            <div class="col-lg-8 col-md-8 col-sm-8">
                                                <select class="form-control m-b" id="txtBagian">
                                                    <option value="">----- Pilih Bagian -----</option>
                                                    <option value="">Bagian 1</option>
                                                    <option value="">Bagian 2</option>
                                                    <option value="">Bagian 3</option>
                                                </select>
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <label class="col-sm-2 control-label">Ruangan</label>
                                            <div class="col-lg-8 col-md-8 col-sm-8">
                                                <select class="form-control m-b" id="txtRuangan">
                                                    <option value="">----- Pilih Ruangan -----</option>
                                                    <option value="">Ruangan 1</option>
                                                    <option value="">Ruangan 2</option>
                                                    <option value="">Ruangan 3</option>
                                                </select>
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <label class="col-sm-2 control-label">Tahun</label>
                                            <div class="col-lg-8 col-md-8 col-sm-8">
                                                <asp:TextBox ID="txtTahun" runat="server" class="form-control m-bot15" type="number" Text="2017"></asp:TextBox>
                                            </div>
                                        </div>

                                       <br />

                                        <div class="form-group">
                                            <label class="col-sm-2 control-label">Termometer</label>
                                            <div class="col-lg-8 col-md-8 col-sm-8">
                                                <div class="i-checks"><label> <input type="radio" value="termtabel" name="a"> <i></i> Tabel Data </label></div>
                                                <div class="i-checks"><label> <input type="radio" value="termgrafik" name="a"> <i></i> Grafik Data </label></div>
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <label class="col-sm-2 control-label">Kelembaban</label>
                                            <div class="col-lg-8 col-md-8 col-sm-8">
                                                <div class="i-checks"><label> <input type="radio" value="klmtabel" name="a"> <i></i> Tabel Data </label></div>
                                                <div class="i-checks"><label> <input type="radio" value="klmgrafik" name="a"> <i></i> Grafik Data </label></div>
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <label class="col-sm-2 control-label">Perbedaan Tekanan</label>
                                            <div class="col-lg-8 col-md-8 col-sm-8">
                                                <div class="i-checks"><label> <input type="radio" value="diftabel" name="a"> <i></i> Tabel Data </label></div>
                                                <div class="i-checks"><label> <input type="radio" value="difgrafik" name="a"> <i></i> Grafik Data </label></div>
                                            </div>
                                        </div>
                               
                                        <br /><br />

                                        <div class="form-group">
                                            <label class="col-sm-2 control-label"></label>
                                            <div class="col-lg-4 col-md-4">
                                                <asp:LinkButton class="btn btn-round btn-green" Visible="true" ID="btnAdd" runat="server" Text="Proses  <i class='fa fa-plus'></i>" />
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
</html>
