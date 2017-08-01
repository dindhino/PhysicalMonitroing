using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.DirectoryServices.AccountManagement;
using System.Configuration;

namespace Biofarma.Service.ActiveDirectory
{
    public class Authentication
    {
        protected static PrincipalContext GetPrincipalContext()
        {
            return new PrincipalContext(ContextType.Domain, ConfigurationManager.AppSettings["ActiveDirectoryDomain"], ConfigurationManager.AppSettings["ActiveDirectoryUsername"], ConfigurationManager.AppSettings["ActiveDirectoryPassword"]);
        }

        protected static UserPrincipal GetUserPrincipal()
        {
            return new UserPrincipal(GetPrincipalContext());
        }

        protected static PrincipalSearcher GetPrincipalSearcher()
        {
            return new PrincipalSearcher(GetUserPrincipal());
        }
    }
}
