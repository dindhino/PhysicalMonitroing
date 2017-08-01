using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web.UI.WebControls;
using System.IO;

namespace Biofarma.Framework.Entity
{
    public class FileManager
    {
        public static string RenameFile(string name, FileUpload file)
        {
            return name + Path.GetExtension(file.FileName);
        }
    }
}
