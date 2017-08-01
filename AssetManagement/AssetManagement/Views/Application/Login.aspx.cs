using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using CacheManager.Core;

namespace AssetManagement.Views.Application
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            var cache = CacheFactory.Build("AssetCache", settings =>
            {
                settings.WithSystemRuntimeCacheHandle("UserCred");
            });
        }
    }
}