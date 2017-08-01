using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace Biofarma.Service.ERP.Data
{
    public class DataManager : DatabaseManager
    {
        public static string GetDate()
        {
            return DateTime.Now.ToString(ConfigurationManager.AppSettings["DateTimeFormat"].ToString());
        }

        public static string DelimitByMinute()
        {
            return DateTime.Now.AddMinutes(-1).ToString(ConfigurationManager.AppSettings["DateTimeFormat"].ToString());
        }

        public static string DelimitByDay()
        {
            return DateTime.Now.AddDays(-1).ToString(ConfigurationManager.AppSettings["DateTimeFormat"].ToString());
        }

        public static string GetMaxDate()
        {
            return DateTime.MaxValue.ToString(ConfigurationManager.AppSettings["DateTimeFormat"].ToString());
        }

        public static string GetIncludeQuery(List<string> parameter)
        {
            StringBuilder _param = new StringBuilder();

            for (int i = 0; i < parameter.Count; i++)
            {
                if (i == (parameter.Count - 1))
                {
                    _param.Append("'" + parameter[i].ToString() + "'");
                }
                else
                {
                    _param.Append("'" + parameter[i].ToString() + "',");
                }
            }

            return _param.ToString();
        }

        public static string GetIncludeQueryInteger(List<string> parameter)
        {
            StringBuilder _param = new StringBuilder();

            for (int i = 0; i < parameter.Count; i++)
            {
                if (i == (parameter.Count - 1))
                {
                    _param.Append(parameter[i].ToString());
                }
                else
                {
                    _param.Append(parameter[i].ToString() + ",");
                }
            }

            return _param.ToString();
        }
    }

    public class RepositoryERP : DataManager
    {
        public static void InsertAsset(string ACQDT, string ASTGR, string GROUP, string ASTID, string ASTNM, string CONDI, string COCTR, string MATYP, string MAYOR, string VALUE, string INVNO, string GETDT, string CHGUS)
        {
            SqlConnection conn = GetConnection();
            StringBuilder query = new StringBuilder();
            
            query.Append(" INSERT INTO     ");
            query.Append(" asset.ERP_MASTER");
            query.Append(" ([BEGDA],       ");
            query.Append(" [ENDDA],        ");
            query.Append(" [ACQDT],        ");
            query.Append(" [ASTGR],        ");
            query.Append(" [GROUP],        ");
            query.Append(" [ASTID],        ");
            query.Append(" [ASTNM],        ");
            query.Append(" [CONDI],        ");
            query.Append(" [COCTR],        ");
            query.Append(" [MATYP],        ");
            query.Append(" [MAYOR],        ");
            query.Append(" [VALUE],        ");
            query.Append(" [INVNO],        ");
            query.Append(" [GETDT],        ");
            query.Append(" [CHGDT],        ");
            query.Append(" [CHGUS])        ");
            query.Append(" VALUES          ");
            query.Append(" (GETDATE(),     ");
            query.Append(" @ENDDA,         ");
            query.Append(" @ACQDT,         ");
            query.Append(" @ASTGR,         ");
            query.Append(" @GROUP,         ");
            query.Append(" @ASTID,         ");
            query.Append(" @ASTNM,         ");
            query.Append(" @CONDI,         ");
            query.Append(" @COCTR,         ");
            query.Append(" @MATYP,         ");
            query.Append(" @MAYOR,         ");
            query.Append(" @VALUE,         ");
            query.Append(" @INVNO,         ");
            query.Append(" @GETDT,         ");
            query.Append(" GETDATE(),      ");
            query.Append(" @CHGUS)         ");

            SqlCommand cmd = GetCommand(conn, query.ToString());
            cmd.Parameters.Add(GetParameter("@ENDDA", GetMaxDate()));
            cmd.Parameters.Add(GetParameter("@ACQDT", ACQDT));
            cmd.Parameters.Add(GetParameter("@ASTGR", ASTGR));
            cmd.Parameters.Add(GetParameter("@GROUP", GROUP));
            cmd.Parameters.Add(GetParameter("@ASTID", ASTID));
            cmd.Parameters.Add(GetParameter("@ASTNM", ASTNM));
            cmd.Parameters.Add(GetParameter("@CONDI", CONDI));
            cmd.Parameters.Add(GetParameter("@COCTR", COCTR));
            cmd.Parameters.Add(GetParameter("@MATYP", MATYP));
            cmd.Parameters.Add(GetParameter("@MAYOR", MAYOR));
            cmd.Parameters.Add(GetParameter("@VALUE", VALUE));
            cmd.Parameters.Add(GetParameter("@INVNO", INVNO));
            cmd.Parameters.Add(GetParameter("@GETDT", GETDT));
            cmd.Parameters.Add(GetParameter("@CHGUS", CHGUS));

            try
            {
                conn.Open();
                cmd.ExecuteNonQuery();
            }
            finally
            {
                conn.Close();
            }
        }
    }
}
