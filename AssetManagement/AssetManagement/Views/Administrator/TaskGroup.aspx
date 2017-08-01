<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TaskGroup.aspx.cs" Inherits="AssetManagement.Views.Administrator.TaskGroup" %>

<%@ Import Namespace="Biofarma.AssetManagement.Data.DataAccess" %>
<%@ Import Namespace="Biofarma.AssetManagement.Presentation" %>
<%@ Import Namespace="Biofarma.Framework.Security" %>
<%@ Import Namespace="Biofarma.Framework.Entity" %>
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
            CreateDefaultFormControl();
            
            if (Request.QueryString["actio"] != null)
            {
                string _objid = Cryptography.Decrypt(Request.QueryString["objid"], true);
                
                if (Request.QueryString["actio"] == "1")
                {
                    btnAdd.Text = "<i class='fa fa-floppy-o'></i> Save";
                    btnCancel.Visible = true;
                    SetDataToController(_objid);
                }
                else if (Request.QueryString["actio"] == "2")
                {
                    DelimitData(_objid);
                    Response.Redirect("TaskGroup.aspx");
                }
                else if (Request.QueryString["actio"] == "3")
                {
                    DeleteData(_objid);
                    Response.Redirect("TaskGroup.aspx");
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

    protected void SetDataToController(string OBJID)
    {
        DataTable data = AssetCatalog.GetTaskGroupByID(OBJID);

        txtTask.Text = data.Rows[0]["TASK"].ToString();
        txtDescription.Text = data.Rows[0]["DESCR"].ToString();
    }

    //Add
    protected void btnAdd_Click(object sender, EventArgs e)
    {
        if (txtTask.Text == string.Empty)
        {
            ClientScript.RegisterStartupScript(this.GetType(), "myalert", "alert('" + "Informasi grup pekerjaan tidak boleh kosong" + "');", true);
        }
        else if (txtDescription.Text == string.Empty)
        {
            ClientScript.RegisterStartupScript(this.GetType(), "myalert", "alert('" + "Informasi deskripsi grup pekerjaan tidak boleh kosong" + "');", true);
        }
        else
        {
            if (Request.QueryString["actio"] != null)
            {
                if (Request.QueryString["actio"] == "1")
                {
                    UpdateData(Cryptography.Decrypt(Request.QueryString["objid"], true));
                }
            }
            else
            {
                UpdateData("0");
            }
            Response.Redirect("TaskGroup.aspx");
        }
    }
    
    //Update
    protected void UpdateData(string OBJID)
    {
        AssetCatalog.UpdateTaskGroup(Convert.ToInt32(OBJID), txtTask.Text, txtDescription.Text, (string)Session["username"]);
    }
    
    //Delimit
    protected void DelimitData(string OBJID)
    {
        AssetCatalog.DelimitTaskGroup(OBJID, (string)Session["username"]);
    }
    
    //Delete
    protected void DeleteData(string OBJID)
    {
        AssetCatalog.DeleteTaskGroup(OBJID);
    }
    
    //View
    protected string GetAction(string OBJID)
    {
        StringBuilder element = new StringBuilder();

        //Preview Detail
        element.Append("<a class='btn btn-warning popovers' style='color:white;margin-bottom:5px;' href='TaskGroup.aspx?actio=1&objid=" + Cryptography.Encrypt(OBJID, true) + "' data-content='Silakan klik untuk melakukan preview dan update data' data-placement='left' data-trigger='hover'><i class='fa fa-edit'></i></a> ");
        element.Append("<a class='btn btn-default popovers' style='color:white;margin-bottom:5px;' href='TaskGroup.aspx?actio=2&objid=" + Cryptography.Encrypt(OBJID, true) + "' data-content='Silakan klik untuk melakukan delimit data. Apakah Anda Yakin?' data-placement='left' data-trigger='hover'><i class='fa fa-recycle'></i></a> ");
        element.Append("<a class='btn btn-danger popovers' style='color:white;margin-bottom:5px;' href='TaskGroup.aspx?actio=3&objid=" + Cryptography.Encrypt(OBJID, true) + "' data-content='Silakan klik untuk menghapus data. Apakah Anda yakin?' data-placement='left' data-trigger='hover'><i class='fa fa-trash-o'></i></a> ");
        
        return element.ToString();
    }

    protected String GenerateData()
    {
        StringBuilder _table = new StringBuilder();

        DataTable table = AssetCatalog.GetTaskGroups();

        for (int i = 0; i < table.Rows.Count; i++)
        {
            string _action = GetAction(table.Rows[i]["OBJID"].ToString());
            _table.Append("<tr class=''>");
            _table.Append("<td>" + table.Rows[i]["TASK"].ToString() + "</td>");
            _table.Append("<td>" + table.Rows[i]["DESCR"].ToString() + "</td>");
            _table.Append("<td align='center' width='15%'>" + _action + "</td>");
            _table.Append("</tr>");
        }

        return _table.ToString();
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
                                Preventive Maintenance | Form Task Group
                              <span class="tools pull-right">
                                  <a class="fa fa-times" href="javascript:;"></a>
                              </span>
                            </header>
                                <div class="panel-body">
                                    <div class="form-horizontal " runat="server">

                                        <div class="form-group">
                                            <label class="col-sm-2 control-label">Tanggal</label>
                                            <div class="col-lg-4 col-md-4 col-sm-4">
                                                <asp:TextBox ID="txtDate" runat="server" class="form-control  m-bot15"></asp:TextBox>
                                            </div>
                                            <label class="col-sm-1 control-label">Operator</label>
                                            <div class="col-lg-4 col-md-4 col-sm-4">
                                                <asp:TextBox ID="txtOperator" runat="server" class="form-control m-bot15"></asp:TextBox>
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <label class="col-sm-2 control-label">Nama Group</label>
                                            <div class="col-lg-4 col-md-4 col-sm-4">
                                                <asp:TextBox ID="txtTask" runat="server" class="form-control  m-bot15" MaxLength="70">
                                                </asp:TextBox>
                                            </div>
                                        </div>

                                        <div class="form-group">
                                        <label class="col-sm-2 control-label">Deskripsi</label>
                                            <div class="col-lg-4 col-md-4 col-sm-4">
                                                <asp:TextBox ID="txtDescription" runat="server" class="form-control  m-bot15" TextMode="MultiLine" Rows="2" MaxLength="200" ></asp:TextBox>
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <label class="col-sm-2 control-label"></label>
                                            <div class="col-lg-4 col-md-4">
                                                <asp:LinkButton class="btn btn-round btn-green" Visible="true" ID="btnAdd" runat="server" Text="Add  <i class='fa fa-plus'></i>" OnClick="btnAdd_Click" />
                                                <asp:LinkButton class="btn btn-round btn-danger" Visible="false" ID="btnCancel" runat="server" Text="Back <i class='fa fa-times'></i>" href="../../Views/Administrator/TaskGroup.aspx" />
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
                                Preventive Maintenance | Task Group
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
                                                    <li><a href="#"><i class="fa fa-print"></i> Print Document</a></li>
                                                </ul>
                                            </div>
                                        </div>
                                        <table class="table table-striped table-hover table-bordered" id="dynamic-table">
                                            <thead>
                                                <tr>
                                                    <th>Nama Group</th>       
                                                    <th>Deskripsi</th>     
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
</html>