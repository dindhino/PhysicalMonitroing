using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.DirectoryServices.AccountManagement;
using Biofarma.Data.DataAccess;

namespace Biofarma.Service.ActiveDirectory
{
    public class ActiveDirectoryManager : Authentication
    {
        public static void SyncActiveUserEmailsToLocal(string username)
        {
            foreach (UserPrincipal result in GetPrincipalSearcher().FindAll())
            {
                if (result.Enabled == true && result.EmailAddress != string.Empty && result.EmailAddress != null && result.Description != string.Empty && result.Description != null && result.DisplayName != string.Empty && result.DisplayName != null)
                {
                    UserCatalog.InsertEmail(result.Description, result.EmailAddress, username);
                }
            }
        }
        public static bool VerifyUsernamePassword(string username, string password)
        {
            PrincipalContext principalContext = GetPrincipalContext();
            return principalContext.ValidateCredentials(username, password);
        }

        public static string GetUserEmailByNIK(string PERNR)
        {
            bool _isFound = false;
            string _email = null;

            foreach (UserPrincipal result in GetPrincipalSearcher().FindAll())
            {
                if (result.Enabled == true && result.EmailAddress != "" && result.EmailAddress != null && result.Description == PERNR && result.DisplayName != "" && result.DisplayName != null)
                {
                    _email = result.EmailAddress;
                    _isFound = true;
                    break;
                }
            }

            if (_isFound)
            {
                return _email;
            }
            else
            {
                return null;
            }
        }

        public static string GetUserNumberByEmail(string Email)
        {
            bool _isFound = false;
            string _personalNumber = null;

            foreach (UserPrincipal result in GetPrincipalSearcher().FindAll())
            {
                if (result.Enabled == true && result.Description != "" && result.Description != null && result.EmailAddress == Email && result.DisplayName != "" && result.DisplayName != null)
                {
                    _personalNumber = result.Description;
                    _isFound = true;
                    break;
                }
            }

            if (_isFound)
            {
                return _personalNumber;
            }
            else
            {
                return null;
            }
        }
    }
}
