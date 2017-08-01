<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="GatewayCTI.aspx.cs" Inherits="AssetManagement.Views.Application.GatewayCTI" %>

<%@ Import Namespace="System.Web.Configuration" %>
<%@ Import Namespace="System.Net" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="Biofarma.Service.PortalCTI.AccessCTI" %>
<%@ Import Namespace="Biofarma.Framework.Entity" %>

<!DOCTYPE html>
<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {        
        string errorMessage = string.Empty;
        string sessionKey = Request.QueryString["token"] == null ? string.Empty : Request.QueryString["token"]; //Token encrypted by CTI system for each user
        Session["username"] = null;
        if (!sessionKey.Trim().Equals(string.Empty) && Session["username"] == null)
        {
            CTIAppUsers wsApp = new CTIAppUsers();
            WsAppAuthClient wsServiceClient = new WsAppAuthClient();
            this.ConfigureToWebServiceCTI(wsServiceClient);
            string ip_address = Request.ServerVariables["REMOTE_ADDR"];
            
            try
            {
                //try to make sure if user already defined as role as they are in application by user email from current IP
                CTIAppUsers resultUserServer = wsServiceClient.getUserPortal(sessionKey.Trim(), ip_address);
                if (resultUserServer != null)
                {
                    //user successfully log in to CTI Portal
                    LoginToCTI(resultUserServer.Email.ToLower(), resultUserServer.Password); 
                }
                else
                {
                    Response.Write("You are not registered as user in the application.");
                }
            }
            catch (Exception ex)
            {
                errorMessage = ex.Message.ToString();
                Response.Write(errorMessage);
            }
            finally
            {
                wsServiceClient.Close();
            }
        }

    }

    protected void SetUserDataToSession(DataTable data, string password)
    {
        Session.Clear();
        Session["username"] = data.Rows[0]["PERNR"].ToString();
        Session["password"] = password;
        Session["email"] = data.Rows[0]["EMAIL"].ToString();
        Session["name"] = data.Rows[0]["CNAME"].ToString();
        Session["coctr"] = data.Rows[0]["COCTR"].ToString();
        Session["pstyp"] = data.Rows[0]["PSTYP"].ToString();
        Session["posid"] = data.Rows[0]["POSID"].ToString();
        Session["prorg"] = data.Rows[0]["PRORG"].ToString();
        
        //add into your enum 1 fol local, 0 for portal CTI 
        //enum LoginGateway : byte { PortalCTI, LocalApplication }
        WebConfigurationManager.AppSettings["Gateway"] = ((int)LoginGateway.PortalCTI).ToString(); 
        Session.Timeout = 300;
    }

    protected bool ValidateUser(string email, string password)
    {
        bool _isValid = false;

        if (getUserFromLocal(email) != null)
        {
            SetUserDataToSession(getUserFromLocal(email), password);
            _isValid = true;
        }

        return _isValid;
    }

    protected DataTable getUserFromLocal(string email)
    {
        return null; //UserCatalog.GetActiveUserFromCTI(email);
    }

    protected void LoginToCTI(string email, string password)
    {
        if (ValidateUser(email, password))
        {
            Response.Redirect("PageHome.aspx"); //Set Home Page
        }
    }

    protected void ConfigureToWebServiceCTI(WsAppAuthClient proxy)
    {
        //Configuration for data retrival from Portal CTI (Integrated Web Service Mode)
        proxy.ClientCredentials.Windows.ClientCredential.Domain = ConfigurationManager.AppSettings["DomainCTI"];
        proxy.ClientCredentials.Windows.ClientCredential.UserName = ConfigurationManager.AppSettings["UsernameCTI"];
        proxy.ClientCredentials.Windows.ClientCredential.Password = ConfigurationManager.AppSettings["PasswordCTI"];
    }
    
    
</script>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        Please Contact 37424 for technical support.    
    </div>
    </form>
</body>
</html>
