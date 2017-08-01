using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Mail;
using System.Text;
using System.Configuration;
using System.Web;
using System.Web.Configuration;
using Biofarma.Data.DataAccess;

namespace Biofarma.AssetManagement.Business.Activity
{
    public class Email
    {
        protected static void SendMail(MailMessage mailMessage)
        {
            SmtpClient client = new SmtpClient();

            try
            {
                client.Send(mailMessage);
            }
            finally
            {
                client.Dispose();
            }
        }
    }

    public class EmailNotification : Email
    {

        private static string CreateNotificationMessage(string name, string textBody)
        {
            StringBuilder _message = new StringBuilder();
            _message.Append("Dear " + name + ",");
            _message.Append(Environment.NewLine + "<br />");
            _message.Append(Environment.NewLine + "<br />");
            _message.Append(textBody);
            _message.Append(Environment.NewLine + "<br />");
            _message.Append(Environment.NewLine + "<br />");
            _message.Append("Terima kasih atas perhatiannya.");
            _message.Append(Environment.NewLine + "<br />");
            _message.Append(Environment.NewLine + "<br />");
            _message.Append("Salam,");
            _message.Append(Environment.NewLine + "<br />");
            _message.Append(ConfigurationManager.AppSettings["MailName"]);

            return _message.ToString();
        }

        public static void SendEmail(string name, string email, string textBody)
        {
            MailMessage mailMsg = new MailMessage();
            mailMsg.IsBodyHtml = true;
            mailMsg.From = new MailAddress(WebConfigurationManager.AppSettings["MailAddress"], WebConfigurationManager.AppSettings["MailName"]);

            mailMsg.To.Add(email);

            mailMsg.Subject = WebConfigurationManager.AppSettings["MailSubject"];
            mailMsg.Body = CreateNotificationMessage(name, textBody);
            mailMsg.HeadersEncoding = System.Text.Encoding.UTF8;
            mailMsg.BodyEncoding = System.Text.Encoding.UTF8;

            SendMail(mailMsg);
        }

        public static void SendEmailByNIK(string CNAME, string PERNR, string TBODY)
        {
            string _email = UserCatalog.GetUserEmailByPERNR(PERNR);
            if (_email != null)
            {
                using (MailMessage mailMsg = new MailMessage())
                {
                    mailMsg.IsBodyHtml = true;
                    mailMsg.From = new MailAddress(WebConfigurationManager.AppSettings["MailModerator"], WebConfigurationManager.AppSettings["MailModeratorName"]);

                    mailMsg.To.Add(_email);

                    mailMsg.Subject = "[NO-REPLY] Asset Management Bio Farma";
                    mailMsg.Body = CreateNotificationMessage(CNAME, TBODY);
                    mailMsg.HeadersEncoding = System.Text.Encoding.UTF8;
                    mailMsg.BodyEncoding = System.Text.Encoding.UTF8;

                    SendMail(mailMsg);
                }
            }
        }

        public static void SendEmailUpdatedMaintenanceNotification(string pernr, string name, string plncd, string plnnm, string stknm, string note, string lastm)
        {
            StringBuilder _tbody = new StringBuilder();
            _tbody.Append("Kami sampaikan bahwa aset / plant " + plnnm + " dengan kode " + plncd + " telah dilakukan pemeliharaan (" + stknm + ") pada tanggal " + lastm + "."); _tbody.Append("<br/>");
            _tbody.Append("Catatan Deviasi : " + note == string.Empty ? "-" : note);

            SendEmailByNIK(name, pernr, _tbody.ToString());
        }

        public static void SendEmailDisposalRequest(string pernr, string name, string plncd, string plnnm, string note, string lastm)
        {
            StringBuilder _tbody = new StringBuilder();
            _tbody.Append("Anda telah mengajukan penghapusbukuan aset " + plnnm + " dengan kode aset " + plncd + " pada tanggal " + lastm + "."); _tbody.Append("<br/>");
            _tbody.Append("Catatan : " + note == string.Empty ? "-" : note);

            SendEmailByNIK(name, pernr, _tbody.ToString());
        }

        public static void SendEmailDisposalProcceed(string pernr, string name, string plncd, string plnnm, string note, string lastm, string status)
        {
            StringBuilder _tbody = new StringBuilder();
            _tbody.Append("Pengajuan penghapusbukuan aset " + plnnm + " dengan kode aset " + plncd + " pada tanggal " + lastm + " telah diproses dengan status " + status + "."); _tbody.Append("<br/>");
            _tbody.Append("Catatan : " + note == string.Empty ? "-" : note);

            SendEmailByNIK(name, pernr, _tbody.ToString());
        }

        //public static void SendEmailDisposalRequest(string pernr, string name, string plncd, string plnnm, string note, string lastm)
        //{
        //    StringBuilder _tbody = new StringBuilder();
        //    _tbody.Append("Anda telah mengajukan penghapusbukuan aset " + plnnm + " dengan kode aset " + plncd + " pada tanggal " + lastm + "."); _tbody.Append("<br/>");
        //    _tbody.Append("Catatan : " + note == string.Empty ? "-" : note);

        //    SendEmailByNIK(name, pernr, _tbody.ToString());
        //}

        public static void SendEmailTranferProcceed(string pernr, string name, string plncd, string plnnm, string note, string lastm, string status)
        {
            StringBuilder _tbody = new StringBuilder();
            _tbody.Append("Pengajuan penghapusbukuan aset " + plnnm + " dengan kode aset " + plncd + " pada tanggal " + lastm + " telah diproses dengan status " + status + "."); _tbody.Append("<br/>");
            _tbody.Append("Catatan : " + note == string.Empty ? "-" : note);

            SendEmailByNIK(name, pernr, _tbody.ToString());
        }
    }
}
