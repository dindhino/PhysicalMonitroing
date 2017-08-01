using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;
using System.Web;
using System.Web.UI.WebControls;

namespace Biofarma.Business.Activity
{
    public class FileFormat
    {
        public static string RenameFile(string name, FileUpload file)
        {
            return name + Path.GetExtension(file.FileName).ToLower();
        }

        public static string RenameFile(string directory)
        {
            return new DirectoryInfo(HttpContext.Current.Server.MapPath("~/" + directory + "/")).FullName;
        }
    }
}
