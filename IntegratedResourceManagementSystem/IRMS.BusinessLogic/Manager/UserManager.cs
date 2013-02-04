using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using IRMS.ObjectModel;
using BLToolkit;
using BLToolkit.Data;
using IRMS.BusinessLogic.DataAccess;
using Microsoft.VisualBasic;
using Microsoft.VisualBasic;

namespace IRMS.BusinessLogic.Manager
{
    public class UserManager
    {
        #region Accessor
        UserClassAccessor Accessor
        {
            [System.Diagnostics.DebuggerStepThrough]
            get { return UserClassAccessor.CreateInstance(); }
        }
        #endregion

        private UsersClass systemuser = new UsersClass();

        public UsersClass FindUser(string UserName)
        {
            systemuser = Accessor.FindUser(UserName);
            return systemuser;
        }
        public bool ConfirmPassword(string Password)
        {
            bool bResult = false;

            try
            {
                if (string.IsNullOrEmpty(systemuser.Username))
                    return bResult;

                if (systemuser.UserPass == EncryptPassword(Password))
                    bResult = true;
            }
            catch (Exception except)
            { 
            }
            return bResult; 
        }

        private string EncryptPassword(string sText)
        {
            StringBuilder sbValue = new StringBuilder();
            for (int i = 1; i <= sText.Length; i++)
            {
                sbValue.Append(Strings.Chr(Strings.Asc(sText.Substring(i-1,1)) + i * 2));
            }

            return sbValue.ToString();
        }
    }
}
