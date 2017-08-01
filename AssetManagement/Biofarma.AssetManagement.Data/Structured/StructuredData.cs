using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using Biofarma.Framework.Entity;
using Biofarma.Data.DataAgent;
using System.Configuration;

namespace Biofarma.AssetManagement.Data.Structured
{
    public class StructuredData : Database
    {
        public static List<Menu> GetMenus(string PERNR)
        {
            SqlConnection conn = GetConnection();
            StringBuilder query = new StringBuilder();

            query.Append(" SELECT DISTINCT                                      ");
            query.Append(" MN.MENID, MN.MENAM, MN.MNURL,                        ");
            query.Append(" MN.MNPID, MN.MNSEQ, MN.MNICO                         ");
            query.Append(" FROM                                                 ");
            query.Append(" asset.USER_AUTHORITY OT,                             ");
            query.Append(" asset.ROLE_MENU_RELATION RM,                         ");
            query.Append(" asset.USER_ROLE RL,                                  ");
            query.Append(" asset.USER_MENU MN                                   ");
            query.Append(" WHERE OT.ROLID = RL.ROLID                            ");
            query.Append(" AND RM.ROLID = OT.ROLID AND RM.MENID = MN.MENID      ");
            query.Append(" AND MN.BEGDA <= GETDATE() AND MN.ENDDA >= GETDATE()  ");
            query.Append(" AND OT.BEGDA <= GETDATE() AND OT.ENDDA >= GETDATE()  ");
            query.Append(" AND RL.BEGDA <= GETDATE() AND RL.ENDDA >= GETDATE()  ");
            query.Append(" AND OT.PERNR = @PERNR                                ");
            query.Append(" AND RL.APPID = @APPID                                ");
            query.Append(" ORDER BY MN.MNPID ASC, MN.MNSEQ ASC                  ");

            SqlCommand cmd = GetCommand(conn, query.ToString());
            cmd.Parameters.Add(GetParameter("@PERNR", PERNR));
            cmd.Parameters.Add(GetParameter("@APPID", ConfigurationManager.AppSettings["ApplicationID"]));

            try
            {
                conn.Open();
                SqlDataReader reader = GetDataReader(cmd);
                List<Menu> menu = new List<Menu>();
                while (reader.Read())
                {
                    Menu m = new Menu();

                    m.Id = Convert.ToInt16(reader["MENID"]);
                    m.MenuName = Convert.ToString(reader["MENAM"]);
                    m.NavUrl = Convert.ToString(reader["MNURL"]);
                    m.IconClass = Convert.ToString(reader["MNICO"]);

                    if (reader["MNPID"].ToString() != "0")
                    {
                        m.Parent = new Menu();
                        m.Parent.Id = Convert.ToInt16(reader["MNPID"]);
                    }

                    menu.Add(m);
                }
                return menu;
            }
            finally
            {
                conn.Close();
                cmd.Dispose();
                conn.Dispose();
            }
        }
    }
}
