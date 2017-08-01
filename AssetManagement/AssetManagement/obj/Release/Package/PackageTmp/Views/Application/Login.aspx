<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="AssetManagement.Views.Application.Login" %>

<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Configuration" %>
<%@ Import Namespace="Biofarma.Framework.Security" %>
<%@ Import Namespace="Biofarma.Business.Activity" %>
<%@ Import Namespace="Biofarma.Presentation.Component" %>
<%@ Import Namespace="Biofarma.Framework.Entity" %>
<%@ Import Namespace="Biofarma.Data.DataAccess" %>
<%@ Import Namespace="Biofarma.AssetManagement.Presentation" %>
<%@ Import Namespace="Biofarma.AssetManagement.Presentation.Scripts" %>
<%@ Import Namespace="Biofarma.Service.ActiveDirectory" %>
<%@ Import Namespace="System.Web.Configuration" %>

<!DOCTYPE html>
<script runat="server">
        
    protected void Page_Load(object sender, EventArgs e)
    {
        Request.Cookies.Clear();
        
        if (!IsPostBack)
        {
            if (Request.QueryString["logout"] != null)
            {
                Session.Clear();
            }
        }

        if (Session["counter"] == null)
        {
            Session.Clear();
            Session["counter"] = "0";
        }
        
        HtmlGenericControl css = new HtmlGenericControl("head");
    }

    protected void ValidateLogin()
    {
        if (!ValidateNullInputUsername(txtUsername.Text))
        {
            ClientScript.RegisterStartupScript(this.GetType(), "myalert", "alert('" + "USERNAME IS REQUIRED" + "');", true);
        }
        else if (!ValidateNullInputPassword(txtPassword.Text))
        {
            ClientScript.RegisterStartupScript(this.GetType(), "myalert", "alert('" + "PASSWORD IS REQUIRED" + "');", true);
        }
        else if (!ValidateLoginCounter())
        {
            //you already attempted login 3 times, your account will be locked | run password lock (belum diimplementasi)
            LockPassword(txtUsername.Text);
            ClientScript.RegisterStartupScript(this.GetType(), "myalert", "alert('" + "YOU ALREADY 3 TIMES WRONG PASSWORD, YOUR ACCOUNT HAS BEEN LOCKED" + "');", true);
            return;
        }
        else if (!ValidateExistingUser(txtUsername.Text, txtPassword.Text))
        {
            ClientScript.RegisterStartupScript(this.GetType(), "myalert", "alert('" + "USERNAME OR PASSWORD IS NOT RECOGNIZED" + "');", true);
            CountLoginAttemp();
            return;
        }
        else
        {
            DataTable value = GetUserData(txtUsername.Text, txtPassword.Text);
            DataTable role = GetRole(txtUsername.Text);

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
        if (!ValidateNullInputUsername(txtUsername.Text))
        {
            ClientScript.RegisterStartupScript(this.GetType(), "myalert", "alert('" + "USERNAME IS REQUIRED" + "');", true);
        }
        else if (!ValidateNullInputPassword(txtPassword.Text))
        {
            ClientScript.RegisterStartupScript(this.GetType(), "myalert", "alert('" + "PASSWORD IS REQUIRED" + "');", true);
        }
        else if (!ValidateLoginCounter())
        {
            //you already attempted login 3 times, your account will be locked | run password lock (belum diimplementasi)
            LockPassword(txtUsername.Text);
            ClientScript.RegisterStartupScript(this.GetType(), "myalert", "alert('" + "YOU ALREADY 3 TIMES WRONG PASSWORD, YOUR ACCOUNT HAS BEEN LOCKED" + "');", true);
            return;
        }
        else
        {
            if (ActiveDirectoryManager.VerifyUsernamePassword(txtUsername.Text, txtPassword.Text))
            {
                DataTable value = GetUserData(txtUsername.Text + ConfigurationManager.AppSettings["mail_domain"]);
                DataTable role = GetRole(value.Rows[0]["PERNR"].ToString());    
                
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

    protected bool ValidateUsernameLength(string username)
    {
        if (username.Trim().Length < 5)
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
        return UserCatalog.GetActiveUser(Filtering.FilterValidSqlQuery(username), Cryptography.Encrypt(Filtering.FilterValidSqlQuery(password), true));
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
        Session["password"] = txtPassword.Text;
        Session["email"] = data.Rows[0]["EMAIL"].ToString();
        Session["name"] = data.Rows[0]["CNAME"].ToString();
        Session["coctr"] = data.Rows[0]["COCTR"].ToString();
        Session["pstyp"] = data.Rows[0]["PSTYP"].ToString();
        Session["posid"] = data.Rows[0]["POSID"].ToString();
        Session["poscd"] = data.Rows[0]["POSCD"].ToString();
        Session["prorg"] = data.Rows[0]["PRORG"].ToString();
        Session["rolid"] = role.Rows[0]["ROLID"].ToString();
        Session["menu"] = SidebarMenuTree.GenerateMenu(data.Rows[0]["PERNR"].ToString());
        Session.Timeout = 300;
    }



    protected void btnLogin_Click(object sender, EventArgs e)
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
<html lang="en">
<head>
    <% Response.Write(Basic.GetMetaScript()); %>
    
    <title>Login</title>
    <% Response.Write(CSS.GetCoreStyle()); %>

    <% Response.Write(CSS.GetCustomStyle()); %>
</head>

  <body class="login-body" style="background:url(../../Images/dashboard.jpg);background-size:cover;">
    <div class="container">
      <form runat="server" class="form-signin">
        <h2 class="form-signin-heading">sign in now</h2>
        <div class="login-wrap">
            <div class="user-login-info">
                <asp:TextBox ID="txtUsername" class="form-control" runat="server" placeholder="Username" autocomplete="off"></asp:TextBox>
                <asp:TextBox ID="txtPassword" type="password" runat="server" class="form-control" placeholder="Password" autocomplete="off"></asp:TextBox>
            </div>
            <label class="checkbox">
                <span class="pull-right">
                    <a data-toggle="modal" href="#myModal"> Forgot Password?</a>
                </span>
            </label>
            <asp:Button ID="btnLogin" runat="server" Text="Sign In" class="btn btn-lg btn-login btn-block" OnClick="btnLogin_Click"></asp:Button>
        </div>
          <!-- Modal -->
          <div aria-hidden="true" aria-labelledby="myModalLabel" role="dialog" tabindex="-1" id="myModal" class="modal fade">
              <div class="modal-dialog">
                  <div class="modal-content">
                      <div class="modal-header">
                          <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                          <h4 class="modal-title">Forgot Password ?</h4>
                      </div>
                      <div class="modal-body">
                          <p>Enter your e-mail address below to reset your password.</p>
                          <asp:TextBox ID="txtEmail" runat="server" placeholder="Email" class="form-control placeholder-no-fix" autocomplete="off"></asp:TextBox>
                      </div>
                      <div class="modal-footer">
                          <asp:Button ID="btnCancel" runat="server" data-dismiss="modal" class="btn btn-default" Text="Cancel"></asp:Button>
                          <asp:Button ID="btnSubmit" runat="server" class="btn btn-danger" Text="Submit"></asp:Button>
                      </div>
                  </div>
              </div>
          </div>
          <!-- modal -->
      </form>
    </div>



    <!-- Placed js at the end of the document so the pages load faster -->
    <% Response.Write(Javascript.GetCoreScript()); %>

  </body>
</html>
