using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Biofarma.AssetManagement.Presentation
{
    class Notification
    {
        public static String GetSuccessNotification(string header, string message)
        {
            StringBuilder script = new StringBuilder();
            script.Append(" <div class='alert alert-block alert-success fade in' align='center'>");
            script.Append(" <button data-dismiss='alert' class='close close-sm' type='button'>  ");
            script.Append(" <i class='fa fa-times'></i>                                         ");
            script.Append(" </button>                                                           ");
            script.Append(" <h4>                                                                ");
            script.Append(" <i class='icon-ok-sign'></i>                                        ");
            script.Append(header);
            script.Append(" </h4>                                                               ");
            script.Append(" <p> " + message + " </p>                                            ");
            script.Append(" </div>                                                              ");
            return script.ToString();
        }

        public static String GetFailedNotification(string message)
        {
            StringBuilder script = new StringBuilder();
            script.Append(" <div class='alert alert-block alert-danger fade in' align='center'> ");
            script.Append(" <button data-dismiss='alert' class='close close-sm' type='button'>  ");
            script.Append(" <i class='fa fa-times'></i>                                         ");
            script.Append(" </button>                                                           ");
            script.Append(" <strong> " + message + " </strong>                                   ");
            script.Append(" </div>                                                              ");
            return script.ToString();
        }

        public static String GetInfoNotification(string message)
        {
            StringBuilder script = new StringBuilder();
            script.Append(" <div class='alert alert-info fade in' align='center'>               ");
            script.Append(" <button data-dismiss='alert' class='close close-sm' type='button'>  ");
            script.Append(" <i class='fa fa-times'></i>                                         ");
            script.Append(" </button>                                                           ");
            script.Append(" <strong>" + message + "</strong>                                    ");
            script.Append(" </div>                                                              ");
            return script.ToString();
        }
    }
}
