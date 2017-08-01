using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Biofarma.Data.DataAgent;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace Biofarma.Data.DataAccess
{
    public class DataCatalog : Database
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

    public class ParameterCatalog : DataCatalog
    {
        public static DataTable GetParameterByType(string PRMTY)
        {
            SqlConnection conn = GetConnection();
            StringBuilder query = new StringBuilder();

            query.Append(" SELECT                                   ");
            query.Append(" BEGDA, ENDDA, PRMID, PRMTY, PRMKD, PRMNM ");
            query.Append(" FROM                                     ");
            query.Append(" bioumum.PARAMETER                        ");
            query.Append(" WHERE                                    ");
            query.Append(" PRMTY = @PRMTY ORDER BY PRMNM            ");

            SqlCommand cmd = GetCommand(conn, query.ToString());
            
            cmd.Parameters.Add(GetParameter("@PRMTY", PRMTY));

            try
            {
                conn.Open();
                DataTable data = new DataTable();
                SqlDataAdapter adapter = GetAdapter(cmd);
                adapter.Fill(data);
                data.TableName = "Parameter";

                return data;
            }
            finally
            {
                conn.Close();
            }
        }
    }

    public class OrganizationCatalog : DataCatalog
    {
        public static DataTable GetDivision()
        {
            SqlConnection conn = GetConnection();
            StringBuilder query = new StringBuilder();

            query.Append(" SELECT                    ");
            query.Append(" OTYPE, ORGID, ORGCD,      ");
            query.Append(" ORGNM, ORGEN, OQACD       ");
            query.Append(" FROM                      ");
            query.Append(" bioumum.ORGANIZATION_DATA ");
            query.Append(" WHERE OTYPE = 'D'         ");
            query.Append(" ORDER BY ORGNM            ");

            SqlCommand cmd = GetCommand(conn, query.ToString());

            try
            {
                conn.Open();
                DataTable data = new DataTable();
                SqlDataAdapter adapter = GetAdapter(cmd);
                adapter.Fill(data);
                data.TableName = "Divisi";
                return data;
            }
            finally
            {
                conn.Close();
            }
        }

        public static DataTable GetBagianSeksi()
        {
            SqlConnection conn = GetConnection();
            StringBuilder query = new StringBuilder();

            query.Append(" SELECT                    ");
            query.Append(" OTYPE, ORGID, ORGCD,      ");
            query.Append(" ORGNM, ORGEN, OQACD       ");
            query.Append(" FROM                      ");
            query.Append(" bioumum.ORGANIZATION_DATA ");
            query.Append(" WHERE OTYPE IN ('B','E')  ");
            query.Append(" ORDER BY ORGNM            ");

            SqlCommand cmd = GetCommand(conn, query.ToString());

            try
            {
                conn.Open();
                DataTable data = new DataTable();
                SqlDataAdapter adapter = GetAdapter(cmd);
                adapter.Fill(data);
                data.TableName = "Organization";
                return data;
            }
            finally
            {
                conn.Close();
            }
        }

        public static DataTable GetOrganizationDataByORGID(string ORGID)
        {
            SqlConnection conn = GetConnection();

            StringBuilder sqlCmd = new StringBuilder();

            sqlCmd.Append(" SELECT TOP 1                                      ");
            sqlCmd.Append(" OL.OICLD, OD.ORGCD, OD.ORGNM,                     ");
            sqlCmd.Append(" COALESCE(UD.PERNR, '') PERNR,                     ");
            sqlCmd.Append(" COALESCE(UD.CNAME,'') CNAME,                      ");
            sqlCmd.Append(" COALESCE(UD.JOBID,'') JOBID,                      ");
            sqlCmd.Append(" COALESCE(UD.JOBCD, '') JOBCD,                     ");
            sqlCmd.Append(" COALESCE(UD.PRJOB, '') PRJOB,                     ");
            sqlCmd.Append(" OL.OIPRT, ODP.ORGCD, ODP.ORGNM,                   ");
            sqlCmd.Append(" OL.STRID, OL.OTCLD, OL.[LEVEL],                   ");
            sqlCmd.Append(" COALESCE(OS.ORGST, 'X') ORGST,                    ");
            sqlCmd.Append(" COALESCE(UD.PSTYP,                                ");
            sqlCmd.Append(" COALESCE(OP.POSTY, '')) PSTYP,                    ");
            sqlCmd.Append(" OP.POSTY                                          ");
            sqlCmd.Append(" FROM                                              ");
            sqlCmd.Append(" bioumum.ORGANIZATION_DATA OD                      ");
            sqlCmd.Append(" FULL JOIN bioumum.USER_DATA UD                    ");
            sqlCmd.Append(" ON UD.POSID = OD.ORGID AND                        ");
            sqlCmd.Append(" UD.BEGDA <= GETDATE() AND                         ");
            sqlCmd.Append(" UD.ENDDA >= GETDATE(),                            ");
            sqlCmd.Append(" bioumum.ORGANIZATIONAL_RELATION OL                ");
            sqlCmd.Append(" FULL JOIN bioumum.ORGANIZATIONAL_STATUS OS        ");
            sqlCmd.Append(" ON OL.OICLD = OS.ORGID AND                        ");
            sqlCmd.Append(" OS.BEGDA <= GETDATE() AND                         ");
            sqlCmd.Append(" OS.ENDDA >= GETDATE()                             ");
            sqlCmd.Append(" FULL JOIN bioumum.ORGANIZATIONAL_POSITION_TYPE OP ");
            sqlCmd.Append(" ON OL.OICLD = OP.ORGID                            ");
            sqlCmd.Append(" AND OP.BEGDA <= GETDATE() AND                     ");
            sqlCmd.Append(" OP.ENDDA >GETDATE(),                              ");
            sqlCmd.Append(" bioumum.ORGANIZATION_DATA ODP                     ");
            sqlCmd.Append(" WHERE                                             ");
            sqlCmd.Append(" OD.BEGDA <= GETDATE() AND                         ");
            sqlCmd.Append(" OD.ENDDA >= GETDATE() AND                         ");
            sqlCmd.Append(" OL.BEGDA <= GETDATE() AND                         ");
            sqlCmd.Append(" OL.ENDDA >= GETDATE() AND                         ");
            sqlCmd.Append(" ODP.BEGDA <= GETDATE() AND                        ");
            sqlCmd.Append(" ODP.ENDDA >= GETDATE() AND                        ");
            sqlCmd.Append(" OD.ORGID = OL.OICLD AND                           ");
            sqlCmd.Append(" ODP.ORGID = OL.OIPRT AND                          ");
            sqlCmd.Append(" OL.OICLD = @ORGID                                 ");

            SqlCommand cmd = GetCommand(conn, sqlCmd.ToString());
            cmd.Parameters.Add(GetParameter("@ORGID", ORGID));

            try
            {
                conn.Open();
                DataTable data = new DataTable();
                SqlDataAdapter adapter = GetAdapter(cmd);
                adapter.Fill(data);
                data.TableName = "Organization";
                return data;
            }
            finally
            {
                conn.Close();
            }
        }

        public static DataTable GetOrganizationParentByORGID(string ORGID, string PSTYP)
        {
            SqlConnection conn = GetConnection();

            StringBuilder sqlCmd = new StringBuilder();

            sqlCmd.Append(" SELECT TOP 1                                     ");
            sqlCmd.Append(" OL.OICLD, OD.ORGCD, OD.ORGNM,                    ");
            sqlCmd.Append(" COALESCE(UD.PERNR, '') PERNR,                    ");
            sqlCmd.Append(" COALESCE(UD.CNAME,'') CNAME,                     ");
            sqlCmd.Append(" COALESCE(UD.JOBID,'') JOBID,                     ");
            sqlCmd.Append(" COALESCE(UD.JOBCD, '') JOBCD,                    ");
            sqlCmd.Append(" COALESCE(UD.PRJOB, '') PRJOB,                    ");
            sqlCmd.Append(" OL.OIPRT, ODP.ORGCD, ODP.ORGNM,                  ");
            sqlCmd.Append(" OL.STRID, OL.OTCLD, OL.[LEVEL],                  ");
            sqlCmd.Append(" COALESCE(OS.ORGST, 'X') ORGST,                   ");
            sqlCmd.Append(" COALESCE(UD.PSTYP,                               ");
            sqlCmd.Append(" COALESCE(OP.POSTY, '')) PSTYP,                   ");
            sqlCmd.Append(" OP.POSTY                                         ");
            sqlCmd.Append(" FROM                                             ");
            sqlCmd.Append(" bioumum.ORGANIZATION_DATA OD                     ");
            sqlCmd.Append(" FULL JOIN bioumum.USER_DATA UD                   ");
            sqlCmd.Append(" ON UD.POSID = OD.ORGID                           ");
            sqlCmd.Append(" AND UD.BEGDA <= GETDATE()                        ");
            sqlCmd.Append(" AND UD.ENDDA >= GETDATE(),                       ");
            sqlCmd.Append(" bioumum.ORGANIZATIONAL_RELATION OL               ");
            sqlCmd.Append(" FULL JOIN bioumum.ORGANIZATIONAL_STATUS OS       ");
            sqlCmd.Append(" ON OL.OICLD = OS.ORGID                           ");
            sqlCmd.Append(" AND OS.BEGDA <= GETDATE()                        ");
            sqlCmd.Append(" AND OS.ENDDA >= GETDATE()                        ");
            sqlCmd.Append(" FULL JOIN bioumum.ORGANIZATIONAL_POSITION_TYPE OP");
            sqlCmd.Append(" ON OL.OICLD = OP.ORGID                           ");
            sqlCmd.Append(" AND OP.BEGDA <= GETDATE()                        ");
            sqlCmd.Append(" AND OP.ENDDA >GETDATE(),                         ");
            sqlCmd.Append(" bioumum.ORGANIZATION_DATA ODP                    ");
            sqlCmd.Append(" WHERE                                            ");
            sqlCmd.Append(" OD.BEGDA <= GETDATE()                            ");
            sqlCmd.Append(" AND OD.ENDDA >= GETDATE()                        ");
            sqlCmd.Append(" AND OL.BEGDA <= GETDATE()                        ");
            sqlCmd.Append(" AND OL.ENDDA >= GETDATE()                        ");
            sqlCmd.Append(" AND ODP.BEGDA <= GETDATE()                       ");
            sqlCmd.Append(" AND ODP.ENDDA >= GETDATE()                       ");
            sqlCmd.Append(" AND OD.ORGID = OL.OICLD                          ");
            sqlCmd.Append(" AND ODP.ORGID = OL.OIPRT                         ");
            sqlCmd.Append(" AND OL.OIPRT = @ORGID                            ");
            sqlCmd.Append(" AND UD.PSTYP IN @PSTYP                           ");

            SqlCommand cmd = GetCommand(conn, sqlCmd.ToString());
            cmd.Parameters.Add(GetParameter("@ORGID", ORGID));
            cmd.Parameters.Add(GetParameter("@PSTYP", PSTYP));

            try
            {
                conn.Open();
                DataTable data = new DataTable();
                SqlDataAdapter adapter = GetAdapter(cmd);
                adapter.Fill(data);
                data.TableName = "Organization";
                return data;
            }
            finally
            {
                conn.Close();
            }
        }

        public static DataTable GetChiefByPositionAndPSType(string POSID, string PSTYP)
        {
            string[] levelPemeriksa = PSTYP.Replace("'", "").Split(',');

            DataTable _data = GetOrganizationDataByORGID(POSID);
            int i = Array.IndexOf(levelPemeriksa, _data.ToString());
            bool isEmpty = false;
            int idx = 0;

            while (Array.IndexOf(levelPemeriksa, _data.Rows[0]["PSTYP"].ToString()) <= -1)
            {
                if (idx > 0) _data = GetOrganizationDataByORGID(_data.Rows[0]["OIPRT"].ToString());

                if (_data.Rows.Count == 0)
                {
                    isEmpty = true;
                    break;
                }

                if (Array.IndexOf(levelPemeriksa, _data.Rows[0]["PSTYP"].ToString()) > -1) break;


                if (GetOrganizationParentByORGID(_data.Rows[0]["OIPRT"].ToString(), PSTYP) != null)
                    _data = GetOrganizationParentByORGID(_data.Rows[0]["OIPRT"].ToString(), PSTYP);

                if (_data.Rows.Count == 0)
                {
                    isEmpty = true;
                    break;
                }

                if ("00" == _data.Rows[0]["PSTYP"].ToString() || "1" == _data.Rows[0]["OIPRT"].ToString()) break;
                idx++;
            }

            if (isEmpty)
            {
                return null;
            }
            else
            {
                return _data;
            }
        }

        public static DataTable GetUnitOrganization()
        {
            SqlConnection conn = GetConnection();
            StringBuilder query = new StringBuilder();

            query.Append(" SELECT ORGID, ORGCD, ORGNM       ");
            query.Append(" FROM bioumum.ORGANIZATION_DATA   ");
            query.Append(" WHERE BEGDA <= GETDATE() AND     ");
            query.Append(" ENDDA >= GETDATE()               ");
            query.Append(" AND OTYPE = 'O'                  ");
            query.Append(" ORDER BY ORGNM                   ");

            SqlCommand cmd = GetCommand(conn, query.ToString());

            try
            {
                conn.Open();
                DataTable data = new DataTable();
                SqlDataAdapter adapter = GetAdapter(cmd);
                adapter.Fill(data);
                data.TableName = "Organization";
                return data;
            }
            finally
            {
                conn.Close();
            }
        }
    }

    public class UserCatalog : DataCatalog
    {
        public static void InsertEmail(string PERNR, string EMAIL, string USRDT)
        {
            SqlConnection conn = GetConnection();
            string query = @"INSERT INTO bioumum.USER_EMAIL (BEGDA, ENDDA, PERNR, EMAIL, CHGDT, USRDT)
                            VALUES ('" + GetDate() + "','" + GetMaxDate() + "','" + PERNR + "','" + EMAIL + "','" + GetDate() + "','" + USRDT + "');";

            SqlCommand cmd = GetCommand(conn, query);

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

        public static void UpdateEmail(string PERNR, string EMAIL, string USRDT)
        {
            SqlConnection conn = GetConnection();
            string query = @"UPDATE bioumum.USER_EMAIL SET ENDDA = '" + DelimitByMinute() + "', CHGDT = '" + GetDate() + "', USRDT = '" + USRDT + "' WHEREPERNR = '" + PERNR + "' AND BEGDA <= GETDATE() AND ENDDA >= GETDATE());";

            SqlCommand cmd = GetCommand(conn, query);

            try
            {
                conn.Open();
                cmd.ExecuteNonQuery();
            }
            finally
            {
                conn.Close();
                InsertEmail(PERNR, EMAIL, USRDT);
            }
        }

        public static void EmptyLocalUserEmail()
        {
            SqlConnection conn = GetConnection();
            string query = @"TRUNCATE TABLE bioumum.USER_EMAIL";

            SqlCommand cmd = GetCommand(conn, query);

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

        public static int ValidateLocalUserEmail(string EMAIL)
        {
            SqlConnection conn = GetConnection();
            StringBuilder query = new StringBuilder();

            query.Append(" SELECT                  ");
            query.Append(" COUNT(*)                ");
            query.Append(" FROM bioumum.USER_EMAIL ");
            query.Append(" WHERE                   ");
            query.Append(" EMAIL = '" + EMAIL + "' ");
            query.Append(" AND BEGDA <= GETDATE()  ");
            query.Append(" AND ENDDA >= GETDATE()  ");

            SqlCommand cmd = GetCommand(conn, query.ToString());

            try
            {
                conn.Open();
                int result = 0;
                SqlDataReader reader = GetDataReader(cmd);

                while (reader.Read())
                {
                    result = Convert.ToInt16(reader[0]);
                }

                return result;
            }
            finally
            {
                conn.Close();
            }
        }

        public static string GetUserEmailByPERNR(string PERNR)
        {
            SqlConnection conn = GetConnection();
            StringBuilder query = new StringBuilder();

            query.Append(" SELECT                  ");
            query.Append(" EMAIL                   ");
            query.Append(" FROM bioumum.USER_EMAIL ");
            query.Append(" WHERE                   ");
            query.Append(" PERNR = '" + PERNR + "' ");
            query.Append(" AND BEGDA <= GETDATE()  ");
            query.Append(" AND ENDDA >= GETDATE()  ");

            SqlCommand cmd = GetCommand(conn, query.ToString());

            try
            {
                conn.Open();
                string result = null;
                SqlDataReader reader = GetDataReader(cmd);

                while (reader.Read())
                {
                    result = reader[0].ToString();
                }

                return result;
            }
            finally
            {
                conn.Close();
            }
        }

        public static DataTable GetUserByEmail(string EMAIL)
        {
            SqlConnection conn = GetConnection();
            StringBuilder query = new StringBuilder();

            query.Append(" SELECT U.PERNR, U.CNAME      ");
            query.Append(" FROM bioumum.USER_DATA U ");
            query.Append(" JOIN  bioumum.USER_EMAIL E   ");
            query.Append(" ON U.PERNR = E.PERNR         ");
            query.Append(" WHERE                        ");
            query.Append(" EMAIL = '" + EMAIL + "'      ");
            query.Append(" AND E.BEGDA <= GETDATE()     ");
            query.Append(" AND E.ENDDA >= GETDATE()     ");

            SqlCommand cmd = GetCommand(conn, query.ToString());

            try
            {
                conn.Open();
                DataTable data = new DataTable();
                SqlDataAdapter adapter = GetAdapter(cmd);
                adapter.Fill(data);
                data.TableName = "User";

                return data;
            }
            finally
            {
                conn.Close();
            }
        }

        public static void InsertPassword(string PERNR, string PASSW, string USRDT)
        {
            SqlConnection conn = GetConnection();
            string query = @"INSERT INTO bioumum.USER_PASSWORD (BEGDA, ENDDA, PERNR, PASSW, CHGDT, USRDT)
                            VALUES ('" + GetDate() + "','" + GetMaxDate() + "','" + PERNR + "','" + PASSW + "','" + GetDate() + "','" + USRDT + "');";

            SqlCommand cmd = GetCommand(conn, query);

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

        public static void UpdatePassword(string PERNR, string PASSW, string USRDT)
        {
            SqlConnection conn = GetConnection();
            string query = @"UPDATE bioumum.USER_PASSWORD SET ENDDA = '" + DelimitByMinute() + "', CHGDT = '" + GetDate() + "', USRDT = '" + USRDT + "' WHEREPERNR = '" + PERNR + "' AND BEGDA <= GETDATE() AND ENDDA >= GETDATE());";

            SqlCommand cmd = GetCommand(conn, query);

            try
            {
                conn.Open();
                cmd.ExecuteNonQuery();
            }
            finally
            {
                conn.Close();
                InsertPassword(PERNR, PASSW, USRDT);
            }
        }

        public static int GetPasswordActivePeriod(string PERNR)
        {
            SqlConnection conn = GetConnection();
            string query = @"SELECT BEGDA, Convert(int,(GETDATE() - BEGDA))
                            FROM bioumum.USER_PASSWORD WHERE PERNR = '" + PERNR + "' AND BEGDA <= GETDATE() AND ENDDA >= GETDATE();";

            SqlCommand cmd = GetCommand(conn, query);

            try
            {
                conn.Open();
                SqlDataReader reader = GetDataReader(cmd);
                reader.Read();
                return Convert.ToInt16(reader[1]);
            }
            finally
            {
                conn.Close();
            }
        }

        public static void InsertUserRole(string PERNR, string ROLID, string USRDT)
        {
            SqlConnection conn = GetConnection();
            string query = @"INSERT INTO bioumum.USER_OTORITY (BEGDA, ENDDA, PERNR, ROLID, CHGDT, USRDT)
                            VALUES ('" + GetDate() + "','" + GetMaxDate() + "','" + PERNR + "','" + ROLID + "','" + GetDate() + "','" + USRDT + "');";

            SqlCommand cmd = GetCommand(conn, query);

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

        public static void UpdateUserRole(string PERNR, string ROLID, string USRDT)
        {
            SqlConnection conn = GetConnection();
            string query = @"UPDATE bioumum.USER_OTORITY SET ENDDA = '" + DelimitByMinute() + "', CHGDT = '" + GetDate() + "', USRDT = '" + USRDT + "' WHERE PERNR = '" + PERNR + "' AND BEGDA <= GETDATE() AND ENDDA >= GETDATE());";

            SqlCommand cmd = GetCommand(conn, query);

            try
            {
                conn.Open();
                cmd.ExecuteNonQuery();
            }
            finally
            {
                conn.Close();
                InsertPassword(PERNR, ROLID, USRDT);
            }
        }

        public static DataTable GetUserRole()
        {
            SqlConnection conn = GetConnection();
            string query = @"SELECT DISTINCT ROLID, ROLNM
                            FROM bioumum.USER_ROLE ORDER BY ROLNM";
            SqlCommand cmd = GetCommand(conn, query);

            try
            {
                conn.Open();
                DataTable data = new DataTable();
                SqlDataAdapter adapter = GetAdapter(cmd);
                adapter.Fill(data);
                data.TableName = "Role";

                return data;
            }
            finally
            {
                conn.Close();
            }
        }

        public static DataTable GetUserApplicationAccount()
        {
            SqlConnection conn = GetConnection();

            StringBuilder query = new StringBuilder();

            query.Append(" SELECT UD.PERNR, UD.CNAME, US.COCNM, UE.EMAIL, UR.ROLNM             ");
            query.Append(" FROM                                                                ");
            query.Append(" bioumum.USER_ROLE UR, bioumum.USER_OTORITY UO,                      ");
            query.Append(" bioumum.USER_DATA UD, bioumum.USER_EMAIL UE                     ");
            query.Append(" WHERE                                                               ");
            query.Append(" UO.PERNR = UD.PERNR AND UD.PERNR = UE.PERNR AND UR.ROLID = UO.ROLID ");
            query.Append(" AND UO.BEGDA <= GETDATE() AND UO.ENDDA >= GETDATE()                 ");
            query.Append(" AND UR.BEGDA <= GETDATE() AND UR.ENDDA >= GETDATE()                 ");
            query.Append(" AND UE.BEGDA <= GETDATE() AND UE.ENDDA >= GETDATE()                 ");
            query.Append(" GROUP BY UD.PERNR, UD.CNAME, US.COCNM, UE.EMAIL, UR.ROLNM           ");

            SqlCommand cmd = GetCommand(conn, query.ToString());

            try
            {
                conn.Open();
                DataTable data = new DataTable();
                SqlDataAdapter adapter = GetAdapter(cmd);
                adapter.Fill(data);
                data.TableName = "User";

                return data;
            }
            finally
            {
                conn.Close();
            }
        }

        public static int ValidateNIKEmployee(string NIK)
        {
            SqlConnection conn = GetConnection();
            string query = @"SELECT DISTINCT COUNT(*)
                            FROM bioumum.USER_DATA
                            WHERE PERNR = '" + NIK + "'";
            SqlCommand cmd = GetCommand(conn, query);

            try
            {
                conn.Open();
                SqlDataReader reader = GetDataReader(cmd);
                reader.Read();
                return Convert.ToInt16(reader[0]);
            }
            finally
            {
                conn.Close();
            }
        }

        public static bool IsPasswordActive(string PERNR)
        {
            SqlConnection conn = GetConnection();
            StringBuilder query = new StringBuilder();

            query.Append(" SELECT COUNT(*)         ");
            query.Append(" FROM                    ");
            query.Append(" bioumum.USER_PASSWORD   ");
            query.Append(" WHERE                   ");
            query.Append(" PERNR = '" + PERNR + "' ");

            SqlCommand cmd = GetCommand(conn, query.ToString());

            try
            {
                conn.Open();
                SqlDataReader reader = GetDataReader(cmd);
                reader.Read();

                return (Convert.ToInt16(reader[0]) == 0 ? false : true);
            }
            finally
            {
                conn.Close();
            }
        }

        public static object[] GetUserApplicationData(string PERNR)
        {
            SqlConnection conn = GetConnection();
            StringBuilder query = new StringBuilder();

            query.Append(" SELECT US.PERNR, US.CNAME, US.PRPOS, US.PRORG, US.GRPNM, US.SGRNM, US.PSGRP, UE.EMAIL, US.COCNM ");
            query.Append(" FROM bioumum.USER_DATA US, bioumum.USER_EMAIL UE                                            ");
            query.Append(" WHERE                                                                                           ");
            query.Append(" AND UE.BEGDA <= GETDATE() AND UE.ENDDA >= GETDATE()                                             ");
            query.Append(" AND US.BEGDA <= GETDATE() AND US.ENDDA >= GETDATE()                                             ");
            query.Append(" AND US.PERNR = UE.PERNR AND US.PERNR = '" + PERNR + "'                                          ");

            SqlCommand cmd = GetCommand(conn, query.ToString());

            try
            {
                conn.Open();
                SqlDataReader reader = GetDataReader(cmd);
                object[] user = null;
                while (reader.Read())
                {
                    object[] values = { reader[0].ToString(), reader[1].ToString(), reader[2].ToString(), reader[3].ToString(), reader[4].ToString(), reader[5].ToString(), reader[6].ToString(), reader[7].ToString(), reader[8].ToString() };
                    user = values;
                }
                return user;
            }
            finally
            {
                conn.Close();
            }
        }

        public static DataTable GetUserData(string PERNR)
        {
            SqlConnection conn = GetConnection();
            StringBuilder query = new StringBuilder();

            query.Append(" SELECT                        ");
            query.Append(" US.PERNR, US.CNAME, US.PRPOS, ");
            query.Append(" US.PRORG, US.PSTYP, US.POSID, ");
            query.Append(" US.GRPNM, US.SGRNM, US.PSGRP, ");
            query.Append(" EM.EMAIL, US.ORGCD, PS.PASSW  ");
            query.Append(" FROM                          ");
            query.Append(" bioumum.USER_DATA US,     ");
            query.Append(" bioumum.USER_EMAIL EM,        ");
            query.Append(" bioumum.USER_PASSWORD PS      ");
            query.Append(" WHERE                         ");
            query.Append(" EM.PERNR = US.PERNR AND       ");
            query.Append(" PS.PERNR = US.PERNR AND       ");
            query.Append(" US.PERNR = '" + PERNR + "'    ");

            SqlCommand cmd = GetCommand(conn, query.ToString());

            try
            {
                conn.Open();
                DataTable data = new DataTable();
                SqlDataAdapter adapter = GetAdapter(cmd);
                adapter.Fill(data);
                data.TableName = "User";

                return data;
            }
            finally
            {
                conn.Close();
            }
        }

        public static DataTable GetEmployee()
        {
            SqlConnection conn = GetConnection();
            StringBuilder query = new StringBuilder();

            query.Append(" SELECT               ");
            query.Append(" US.PERNR, US.CNAME   ");
            query.Append(" FROM                 ");
            query.Append(" bioumum.USER_DATA US ");
            query.Append(" ORDER BY CNAME       ");

            SqlCommand cmd = GetCommand(conn, query.ToString());

            try
            {
                conn.Open();
                DataTable data = new DataTable();
                SqlDataAdapter adapter = GetAdapter(cmd);
                adapter.Fill(data);
                data.TableName = "Employee";

                return data;
            }
            finally
            {
                conn.Close();
            }
        }

        public static DataTable GetActiveUser(string PERNR, string PASSW)
        {
            SqlConnection conn = GetConnection();
            StringBuilder query = new StringBuilder();

            query.Append(" SELECT                                                         ");
            query.Append(" US.PERNR, PS.PASSW, EM.EMAIL, US.CNAME, US.COCTR, PS.PLOCK,    ");
            query.Append(" DATEDIFF(DAY,PS.BEGDA,GETDATE()) AS PSPRD, US.PSTYP, US.POSID, ");
            query.Append(" US.POSCD, US.COCNM, US.PRORG                                   ");
            query.Append(" FROM                                                           ");
            query.Append(" bioumum.USER_DATA US,                                          ");
            query.Append(" bioumum.USER_EMAIL EM,                                         ");
            query.Append(" bioumum.USER_PASSWORD PS                                       ");
            query.Append(" WHERE                                                          ");
            query.Append(" US.PERNR = EM.PERNR AND US.PERNR = PS.PERNR                    ");
            query.Append(" AND EM.BEGDA <= GETDATE() AND EM.ENDDA >= GETDATE()            ");
            query.Append(" AND PS.BEGDA <= GETDATE() AND PS.ENDDA >= GETDATE()            ");
            query.Append(" AND US.PERNR = '" + PERNR + "' AND PS.PASSW = '" + PASSW + "'  ");

            SqlCommand cmd = GetCommand(conn, query.ToString());

            try
            {
                conn.Open();
                DataTable data = new DataTable();
                SqlDataAdapter adapter = GetAdapter(cmd);
                adapter.Fill(data);
                data.TableName = "ActiveUser";

                return data;
            }
            finally
            {
                conn.Close();
            }
        }

        public static DataTable GetActiveUserByEmail(string EMAIL)
        {
            SqlConnection conn = GetConnection();
            StringBuilder query = new StringBuilder();

            query.Append(" SELECT                                               ");
            query.Append(" US.PERNR, EM.EMAIL, US.CNAME,                        ");
            query.Append(" US.COCTR, US.PSTYP, US.POSID,                        ");
            query.Append(" US.POSCD, US.COCNM, US.PRORG                         ");
            query.Append(" FROM                                                 ");
            query.Append(" bioumum.USER_DATA US,                                ");
            query.Append(" bioumum.USER_EMAIL EM                                ");
            query.Append(" WHERE                                                ");
            query.Append(" US.PERNR = EM.PERNR                                  ");
            query.Append(" AND EM.BEGDA <= GETDATE() AND EM.ENDDA >= GETDATE()  ");
            query.Append(" AND EM.EMAIL = '" + EMAIL + "'                       ");

            SqlCommand cmd = GetCommand(conn, query.ToString());

            try
            {
                conn.Open();
                DataTable data = new DataTable();
                SqlDataAdapter adapter = GetAdapter(cmd);
                adapter.Fill(data);
                data.TableName = "ActiveUser";

                return data;
            }
            finally
            {
                conn.Close();
            }
        }

        public static DataTable GetActiveUserFromCTI(string EMAIL)
        {
            SqlConnection conn = GetConnection();
            StringBuilder query = new StringBuilder();

            query.Append(" SELECT                                                   ");
            query.Append(" US.PERNR, EM.EMAIL, US.CNAME,                            ");
            query.Append(" US.COCTR, US.PSTYP, US.POSID,                            ");
            query.Append(" US.COCNM, US.PRORG                                       ");
            query.Append(" FROM                                                     ");
            query.Append(" bioumum.USER_DATA US, bioumum.USER_EMAIL EM          ");
            query.Append(" WHERE                                                    ");
            query.Append(" US.PERNR = EM.PERNR AND EM.BEGDA <= GETDATE()            ");
            query.Append(" AND EM.ENDDA >= GETDATE() AND EM.EMAIL = '" + EMAIL + "' ");

            SqlCommand cmd = GetCommand(conn, query.ToString());

            try
            {
                conn.Open();
                DataTable data = new DataTable();
                SqlDataAdapter adapter = GetAdapter(cmd);
                adapter.Fill(data);
                data.TableName = "ActiveUser";

                return data;
            }
            finally
            {
                conn.Close();
            }
        }

        public static DataTable GetAllActiveUser()
        {
            SqlConnection conn = GetConnection();
            StringBuilder query = new StringBuilder();

            query.Append(" SELECT                                                                  ");
            query.Append(" US.PERNR, US.CNAME, US.PRPOS, US.PRORG, US.GRPNM, US.SGRNM, US.PSGRP    ");
            query.Append(" FROM                                                                    ");
            query.Append(" bioumum.USER_DATA US                                                ");
            query.Append(" ORDER BY US.PERNR;                                                      ");

            SqlCommand cmd = GetCommand(conn, query.ToString());

            try
            {
                conn.Open();
                DataTable data = new DataTable();
                SqlDataAdapter adapter = GetAdapter(cmd);
                adapter.Fill(data);
                data.TableName = "ActiveUser";

                return data;
            }
            finally
            {
                conn.Close();
            }
        }

        //USER OTORITY BCC
        public static void InsertUserOtority(string OBJID, string PERNR, string ROLID, string USRDT)
        {
            SqlConnection conn = GetConnection();
            StringBuilder query = new StringBuilder();

            query.Append(" INSERT INTO asset.USER_AUTHORITY                                 ");
            query.Append(" (BEGDA, ENDDA, OBJID, PERNR, ROLID, CHGDT, USRDT)                ");
            query.Append(" VALUES                                                           ");
            query.Append(" ('" + GetDate() + "', '" + GetMaxDate() + "', '" + OBJID + "'    ");
            query.Append(" ,'" + PERNR + "', '" + ROLID + "', '" + GetDate() + "'           ");
            query.Append(" ,'" + USRDT + "')                                                ");

            SqlCommand cmd = GetCommand(conn, query.ToString());

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

        public static void UpdateUserOtority(string OBJID, string PERNR, string ROLID, string USRDT)
        {
            SqlConnection conn = GetConnection();
            string query = @"UPDATE asset.USER_AUTHORITY SET ENDDA = '" + DelimitByMinute() + "', CHGDT = '" + GetDate() + "', USRDT = '" + USRDT + "' WHERE PERNR = '" + PERNR + "'  AND OBJID = '" + OBJID + "' AND ROLID = '" + ROLID + "' AND BEGDA <= GETDATE() AND ENDDA >= GETDATE()";

            SqlCommand cmd = GetCommand(conn, query);

            try
            {
                conn.Open();
                cmd.ExecuteNonQuery();
            }
            finally
            {
                conn.Close();
                InsertUserOtority(OBJID, PERNR, ROLID, USRDT);
            }
        }

        public static void DelimitUserOtority(int OBJID, string PERNR, string ROLID, string USRDT)
        {
            SqlConnection conn = GetConnection();
            string query = @"UPDATE asset.USER_AUTHORITY SET ENDDA = '" + DelimitByMinute() + "', CHGDT = '" + GetDate() + "', USRDT = '" + USRDT + "' WHERE PERNR = '" + PERNR + "' AND OBJID = '" + OBJID + "' AND ROLID = '" + ROLID + "' AND BEGDA <= GETDATE() AND ENDDA >= GETDATE();";

            SqlCommand cmd = GetCommand(conn, query);

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

        public static void DeleteUserOtority(string OBJID, string PERNR, string ROLID, string USRDT)
        {
            SqlConnection conn = GetConnection();
            string query = @"DELETE asset.USER_AUTHORITY WHERE PERNR = '" + PERNR + "' AND OBJID = '" + OBJID + "' AND ROLID = '" + ROLID + "' AND BEGDA <= GETDATE() AND ENDDA >= GETDATE();";

            SqlCommand cmd = GetCommand(conn, query);

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

        public static DataTable GetUserOtority(string PERNR)
        {
            SqlConnection conn = GetConnection();
            StringBuilder query = new StringBuilder();

            query.Append(" SELECT                                        ");
            query.Append(" PERNR, ROLID                           ");
            query.Append(" FROM asset.USER_AUTHORITY                     ");
            query.Append(" WHERE PERNR = '" + PERNR + "'                 ");
            query.Append(" AND BEGDA <= GETDATE() AND ENDDA >= GETDATE() ");

            SqlCommand cmd = GetCommand(conn, query.ToString());

            try
            {
                conn.Open();
                DataTable data = new DataTable();
                SqlDataAdapter adapter = GetAdapter(cmd);
                adapter.Fill(data);
                data.TableName = "ActiveUser";

                return data;
            }
            finally
            {
                conn.Close();
            }
        }
    }
}
