<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SignIn.aspx.cs" Inherits="AssetManagement.Views.Application.SignIn" %>

<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Configuration" %>
<%@ Import Namespace="Biofarma.Framework.Security" %>
<%@ Import Namespace="Biofarma.Business.Activity" %>
<%@ Import Namespace="Biofarma.Presentation.Component" %>
<%@ Import Namespace="Biofarma.Framework.Entity" %>
<%@ Import Namespace="Biofarma.Data.DataAccess" %>
<%@ Import Namespace="Biofarma.AssetManagement.Presentation" %>
<%@ Import Namespace="Biofarma.Service.ActiveDirectory" %>
<%@ Import Namespace="System.Web.Configuration" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        Request.Cookies.Clear();
        Session.Clear();
        
        if (Session["counter"] == null)
        {
            Session.Clear();
            Session["counter"] = "0";
        }

        HtmlGenericControl css = new HtmlGenericControl("head");
    }

    protected void ValidateLogin()
    {
        if (!ValidateNullInputUsername(txtUsername.Value))
        {
            ClientScript.RegisterStartupScript(this.GetType(), "myalert", "alert('" + "USERNAME IS REQUIRED" + "');", true);
        }
        else if (!ValidateNullInputPassword(txtPassword.Value))
        {
            ClientScript.RegisterStartupScript(this.GetType(), "myalert", "alert('" + "PASSWORD IS REQUIRED" + "');", true);
        }
        else if (!ValidateLoginCounter())
        {
            //you already attempted login 3 times, your account will be locked | run password lock (belum diimplementasi)
            LockPassword(txtUsername.Value);
            ClientScript.RegisterStartupScript(this.GetType(), "myalert", "alert('" + "YOU ALREADY 3 TIMES WRONG PASSWORD, YOUR ACCOUNT HAS BEEN LOCKED" + "');", true);
            return;
        }
        else if (!ValidateExistingUser(txtUsername.Value, txtPassword.Value))
        {
            ClientScript.RegisterStartupScript(this.GetType(), "myalert", "alert('" + "USERNAME OR PASSWORD IS NOT RECOGNIZED" + "');", true);
            CountLoginAttemp();
            return;
        }
        else
        {
            DataTable value = GetUserData(txtUsername.Value, txtPassword.Value);
            DataTable role = GetRole(txtUsername.Value);

            if (!ValidatePasswordLocked(Convert.ToBoolean(value.Rows[0]["PLOCK"])))
            {
                ClientScript.RegisterStartupScript(this.GetType(), "myalert", "alert('" + "YOUR ACCOUNT IS LOCKED" + "');", true);
            }
            else if (!ValidatePasswordPeriode(Convert.ToInt16(value.Rows[0]["PSPRD"])))
            {
                ClientScript.RegisterStartupScript(this.GetType(), "myalert", "alert('" + "YOUR PASSWORD IS EXPIRED" + "');", true);
            }
            else if (role.Rows.Count == 0)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "myalert", "alert('" + "YOUR USERNAME WAS NOT REGISTERED" + "');", true);
            }
            else
            {
                SetUserDataToSession(value, role);
                Response.Redirect("../Administrator/Dashboard.aspx");
            }
        }
        return;
    }

    protected void ValidateLoginActiveDirectory()
    {
        if (!ValidateNullInputUsername(txtUsername.Value))
        {
            ClientScript.RegisterStartupScript(this.GetType(), "myalert", "alert('" + "USERNAME IS REQUIRED" + "');", true);
        }
        else if (!ValidateNullInputPassword(txtPassword.Value))
        {
            ClientScript.RegisterStartupScript(this.GetType(), "myalert", "alert('" + "PASSWORD IS REQUIRED" + "');", true);
        }
        else if (!ValidateLoginCounter())
        {
            //you already attempted login 3 times, your account will be locked | run password lock (belum diimplementasi)
            LockPassword(txtUsername.Value);
            ClientScript.RegisterStartupScript(this.GetType(), "myalert", "alert('" + "YOU ALREADY 3 TIMES WRONG PASSWORD, YOUR ACCOUNT HAS BEEN LOCKED" + "');", true);
            return;
        }
        else
        {
            if (ActiveDirectoryManager.VerifyUsernamePassword(txtUsername.Value, txtPassword.Value))
            {
                DataTable value = GetUserData(txtUsername.Value + ConfigurationManager.AppSettings["mail_domain"]);
                DataTable role = new DataTable();
                
                if (value.Rows.Count > 0) role = GetRole(value.Rows[0]["PERNR"].ToString());    
                
                if (role.Rows.Count == 0)
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "myalert", "alert('" + "YOUR USERNAME WAS NOT REGISTERED" + "');", true);
                }
                else
                {
                    SetUserDataToSession(value, role);
                    Response.Redirect("../Administrator/Dashboard.aspx");
                }
            }
            else
            {
                ClientScript.RegisterStartupScript(this.GetType(), "myalert", "alert('" + "USERNAME AND PASSWORD DID NOT MATCH" + "');", true);
            }
        }
        return;
    }

    protected bool ValidateNullInputUsername(string username)
    {
        if (username.Trim().Length > 0)
            return true;
        else
            return false;
    }

    protected bool ValidateNullInputPassword(string password)
    {
        if (password.Trim().Length > 0)
            return true;
        else
            return false;
    }

    protected bool ValidateExistingUser(string username, string password)
    {
        //add counter
        if (GetUserData(username, password) != null)
            return true;
        else
            return false;
    }

    protected bool ValidateLoginCounter()
    {
        if (Convert.ToInt16(Session["counter"]) < 3)
            return true;
        else
            return false;
    }

    protected bool ValidatePasswordLocked(bool locked)
    {
        if (!locked)
            return true;
        else
            return false;
    }

    protected bool ValidatePasswordPeriode(int period)
    {
        if (period <= 90)
            return true;
        else
            return false;
    }

    protected void LockPassword(string username)
    {
        //lock catalog by username
    }

    protected void CountLoginAttemp()
    {
        Session["counter"] = Convert.ToInt16(Session["counter"]) + 1;
    }

    protected DataTable GetUserData(string username, string password)
    {
        return UserCatalog.GetActiveUser(username, Cryptography.Encrypt(password, true));
    }

    protected DataTable GetUserData(string username)
    {
        return UserCatalog.GetActiveUserByEmail(username);
    }

    protected DataTable GetRole(string username)
    {
        return UserCatalog.GetUserOtority(username);
    }

    protected void SetUserDataToSession(DataTable data, DataTable role)
    {
        Session.Clear();
        Session["username"] = data.Rows[0]["PERNR"].ToString();
        Session["password"] = txtPassword.Value;
        Session["email"] = data.Rows[0]["EMAIL"].ToString();
        Session["name"] = data.Rows[0]["CNAME"].ToString();
        Session["coctr"] = data.Rows[0]["COCTR"].ToString();
        Session["pstyp"] = data.Rows[0]["PSTYP"].ToString();
        Session["posid"] = data.Rows[0]["POSID"].ToString();
        Session["poscd"] = data.Rows[0]["POSCD"].ToString();
        Session["prorg"] = data.Rows[0]["PRORG"].ToString();
        Session["rolid"] = role.Rows[0]["ROLID"].ToString();
        Session["clsid"] = role.Rows[0]["CLSID"].ToString();
        WebConfigurationManager.AppSettings["UserMenu"] = string.Empty;
        Session.Timeout = 300;
    }
    
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        if (ConfigurationManager.AppSettings["sso"] == ((int)ConfigurationStatus.Yes).ToString())
        {
            ValidateLoginActiveDirectory();
        }
        else
        {
            ValidateLogin();
        }
    }
    
</script>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="Allan Prakosa">
    <link rel="shortcut icon" href="../../Scripts/UserPanel/img/favicon.html">

    <title>Sign In</title>

    <!-- Bootstrap core CSS -->
    <link href="../../Scripts/UserPanel/bs3/css/bootstrap.min.css" rel="stylesheet">
    <link href="../../Scripts/UserPanel/css/bootstrap-reset.css" rel="stylesheet">
    <!--external css-->
    
    <link href='../../Scripts/UserPanel/assets/font-awesome-4.1.0/css/font-awesome.min.css' rel='stylesheet' />
    <!-- Custom styles for this template -->
    <link href="../../Scripts/UserPanel/css/style.css" rel="stylesheet">
    <link href="../../Scripts/UserPanel/css/style-responsive.css" rel="stylesheet" />
</head>

<body class="lock-screen" onload="startTime()">

    <div class="lock-wrapper">

        <div id="time"></div>


        <div class="lock-box text-center">
            <form runat="server">
            <asp:Panel ID="pnlSignIn" runat="server" DefaultButton="btnSubmit" Width="100%" >
            <div class="lock-name">
                <div role="form" class="form-inline">
                    <div class="form-group">
                        <input runat="server" type="text" style="border:none" placeholder="Username" id="txtUsername" class="form-control lock-input"></div>
                    </div>
                </div>
                
            <img src="../../Gallery/Contents/logo.png" alt="lock avatar"/>
            <div class="lock-pwd">
                <div role="form" class="form-inline">
                    <div class="form-group">
                        <input runat="server" type="password" placeholder="Password" id="txtPassword" class="form-control lock-input">
                        <asp:LinkButton runat="server" ID="btnSubmit" class="btn btn-lock" OnClick="btnSubmit_Click">
                            <i class="fa fa-arrow-right"></i>
                        </asp:LinkButton>
                    </div>
                </div>
            </div>
        </asp:Panel>
        </form>
        </div>
    </div>
    <script>
        function startTime() {
            var today = new Date();
            var h = today.getHours();
            var m = today.getMinutes();
            var s = today.getSeconds();
            // add a zero in front of numbers<10
            m = checkTime(m);
            s = checkTime(s);
            document.getElementById('time').innerHTML = h + ":" + m + ":" + s;
            t = setTimeout(function () { startTime() }, 500);
        }

        function checkTime(i) {
            if (i < 10) {
                i = "0" + i;
            }
            return i;
        }
    </script>
</body>
</html>
