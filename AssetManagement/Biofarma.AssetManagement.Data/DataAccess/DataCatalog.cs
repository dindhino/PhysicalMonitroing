using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Biofarma.Data.DataAccess;
using System.Data;
using System.Data.SqlClient;

namespace Biofarma.AssetManagement.Data.DataAccess
{
    public class AssetCatalog : DataCatalog
    {
        //Get Object ID
        public static int GetPlantMasterMaxObjectID()
        {
            SqlConnection conn = GetConnection();
            StringBuilder query = new StringBuilder();

            query.Append(" SELECT (COALESCE(MAX([OBJID]),0) + 1) VALUE ");
            query.Append(" FROM asset.PLANT_MASTER                     ");

            SqlCommand cmd = GetCommand(conn, query.ToString());

            try
            {
                conn.Open();
                SqlDataReader reader = GetDataReader(cmd);
                int data = 0;
                while (reader.Read())
                {
                    data = Convert.ToInt32(reader[0]);
                }
                return data;
            }
            finally
            {
                conn.Close();
            }
        }

        public static int GetPlantDetailMaxObjectID()
        {
            SqlConnection conn = GetConnection();
            StringBuilder query = new StringBuilder();

            query.Append(" SELECT (COALESCE(MAX([OBJID]),0) + 1) VALUE ");
            query.Append(" FROM asset.PLANT_DETAIL                     ");

            SqlCommand cmd = GetCommand(conn, query.ToString());

            try
            {
                conn.Open();
                SqlDataReader reader = GetDataReader(cmd);
                int data = 0;
                while (reader.Read())
                {
                    data = Convert.ToInt32(reader[0]);
                }
                return data;
            }
            finally
            {
                conn.Close();
            }
        }

        public static int GetPlantMajorMaxObjectID()
        {
            SqlConnection conn = GetConnection();
            StringBuilder query = new StringBuilder();

            query.Append(" SELECT (COALESCE(MAX([OBJID]),0) + 1) VALUE ");
            query.Append(" FROM asset.PLANT_MAJOR                      ");

            SqlCommand cmd = GetCommand(conn, query.ToString());

            try
            {
                conn.Open();
                SqlDataReader reader = GetDataReader(cmd);
                int data = 0;
                while (reader.Read())
                {
                    data = Convert.ToInt32(reader[0]);
                }
                return data;
            }
            finally
            {
                conn.Close();
            }
        }

        public static int GetPlantSubtypeMaxObjectID()
        {
            SqlConnection conn = GetConnection();
            StringBuilder query = new StringBuilder();

            query.Append(" SELECT (COALESCE(MAX([OBJID]),0) + 1) VALUE ");
            query.Append(" FROM asset.PLANT_SUBTYPE                    ");

            SqlCommand cmd = GetCommand(conn, query.ToString());

            try
            {
                conn.Open();
                SqlDataReader reader = GetDataReader(cmd);
                int data = 0;
                while (reader.Read())
                {
                    data = Convert.ToInt32(reader[0]);
                }
                return data;
            }
            finally
            {
                conn.Close();
            }
        }

        public static int GetPlantAttributeMaxObjectID()
        {
            SqlConnection conn = GetConnection();
            StringBuilder query = new StringBuilder();

            query.Append(" SELECT (COALESCE(MAX([OBJID]),0) + 1) VALUE ");
            query.Append(" FROM asset.PLANT_ATTRIBUTE                  ");

            SqlCommand cmd = GetCommand(conn, query.ToString());

            try
            {
                conn.Open();
                SqlDataReader reader = GetDataReader(cmd);
                int data = 0;
                while (reader.Read())
                {
                    data = Convert.ToInt32(reader[0]);
                }
                return data;
            }
            finally
            {
                conn.Close();
            }
        }

        public static int GetClusterAreaMaxObjectID()
        {
            SqlConnection conn = GetConnection();
            StringBuilder query = new StringBuilder();

            query.Append(" SELECT (COALESCE(MAX([OBJID]),0) + 1) VALUE ");
            query.Append(" FROM asset.CLUSTER_AREA                     ");

            SqlCommand cmd = GetCommand(conn, query.ToString());

            try
            {
                conn.Open();
                SqlDataReader reader = GetDataReader(cmd);
                int data = 0;
                while (reader.Read())
                {
                    data = Convert.ToInt32(reader[0]);
                }
                return data;
            }
            finally
            {
                conn.Close();
            }
        }

        public static int GetPlantDocumentMaxObjectID()
        {
            SqlConnection conn = GetConnection();
            StringBuilder query = new StringBuilder();

            query.Append(" SELECT (COALESCE(MAX([OBJID]),0) + 1) VALUE ");
            query.Append(" FROM asset.PLANT_DOCUMENT                   ");

            SqlCommand cmd = GetCommand(conn, query.ToString());

            try
            {
                conn.Open();
                SqlDataReader reader = GetDataReader(cmd);
                int data = 0;
                while (reader.Read())
                {
                    data = Convert.ToInt32(reader[0]);
                }
                return data;
            }
            finally
            {
                conn.Close();
            }
        }

        public static int GetPlantDeviationMaxObjectID()
        {
            SqlConnection conn = GetConnection();
            StringBuilder query = new StringBuilder();

            query.Append(" SELECT (COALESCE(MAX([OBJID]),0) + 1) VALUE ");
            query.Append(" FROM asset.PLANT_DEVIATION                  ");

            SqlCommand cmd = GetCommand(conn, query.ToString());

            try
            {
                conn.Open();
                SqlDataReader reader = GetDataReader(cmd);
                int data = 0;
                while (reader.Read())
                {
                    data = Convert.ToInt32(reader[0]);
                }
                return data;
            }
            finally
            {
                conn.Close();
            }
        }

        public static int GetPlantMaintenanceMaxObjectID()
        {
            SqlConnection conn = GetConnection();
            StringBuilder query = new StringBuilder();

            query.Append(" SELECT (COALESCE(MAX([OBJID]),0) + 1) VALUE ");
            query.Append(" FROM asset.PLANT_MAINTENANCE                ");

            SqlCommand cmd = GetCommand(conn, query.ToString());

            try
            {
                conn.Open();
                SqlDataReader reader = GetDataReader(cmd);
                int data = 0;
                while (reader.Read())
                {
                    data = Convert.ToInt32(reader[0]);
                }
                return data;
            }
            finally
            {
                conn.Close();
            }
        }

        public static int GetPlantRelationMaxObjectID()
        {
            SqlConnection conn = GetConnection();
            StringBuilder query = new StringBuilder();

            query.Append(" SELECT (COALESCE(MAX([OBJID]),0) + 1) VALUE ");
            query.Append(" FROM asset.PLANT_RELATION                   ");

            SqlCommand cmd = GetCommand(conn, query.ToString());

            try
            {
                conn.Open();
                SqlDataReader reader = GetDataReader(cmd);
                int data = 0;
                while (reader.Read())
                {
                    data = Convert.ToInt32(reader[0]);
                }
                return data;
            }
            finally
            {
                conn.Close();
            }
        }

        public static int GetTaskGroupMaxObjectID()
        {
            SqlConnection conn = GetConnection();
            StringBuilder query = new StringBuilder();

            query.Append(" SELECT (COALESCE(MAX([OBJID]),0) + 1) VALUE ");
            query.Append(" FROM asset.TASK_GROUP                       ");

            SqlCommand cmd = GetCommand(conn, query.ToString());

            try
            {
                conn.Open();
                SqlDataReader reader = GetDataReader(cmd);
                int data = 0;
                while (reader.Read())
                {
                    data = Convert.ToInt32(reader[0]);
                }
                return data;
            }
            finally
            {
                conn.Close();
            }
        }

        public static int GetDocumentMasterMaxObjectID()
        {
            SqlConnection conn = GetConnection();
            StringBuilder query = new StringBuilder();

            query.Append(" SELECT (COALESCE(MAX([OBJID]),0) + 1) VALUE ");
            query.Append(" FROM asset.DOCUMENT_MASTER                  ");

            SqlCommand cmd = GetCommand(conn, query.ToString());

            try
            {
                conn.Open();
                SqlDataReader reader = GetDataReader(cmd);
                int data = 0;
                while (reader.Read())
                {
                    data = Convert.ToInt32(reader[0]);
                }
                return data;
            }
            finally
            {
                conn.Close();
            }
        }

        public static int GetAssetImageMaxObjectID()
        {
            SqlConnection conn = GetConnection();
            StringBuilder query = new StringBuilder();

            query.Append(" SELECT (COALESCE(MAX([OBJID]),0) + 1) VALUE ");
            query.Append(" FROM asset.PLANT_IMAGE                      ");

            SqlCommand cmd = GetCommand(conn, query.ToString());

            try
            {
                conn.Open();
                SqlDataReader reader = GetDataReader(cmd);
                int data = 0;
                while (reader.Read())
                {
                    data = Convert.ToInt32(reader[0]);
                }
                return data;
            }
            finally
            {
                conn.Close();
            }
        }

        public static int GetTaskScheduleMaxObjectID()
        {
            SqlConnection conn = GetConnection();
            StringBuilder query = new StringBuilder();

            query.Append(" SELECT (COALESCE(MAX([OBJID]),0) + 1) VALUE ");
            query.Append(" FROM asset.TASK_SCHEDULE                    ");

            SqlCommand cmd = GetCommand(conn, query.ToString());

            try
            {
                conn.Open();
                SqlDataReader reader = GetDataReader(cmd);
                int data = 0;
                while (reader.Read())
                {
                    data = Convert.ToInt32(reader[0]);
                }
                return data;
            }
            finally
            {
                conn.Close();
            }
        }

        public static int GetPlantMutationMaxObjectID()
        {
            SqlConnection conn = GetConnection();
            StringBuilder query = new StringBuilder();

            query.Append(" SELECT (COALESCE(MAX([OBJID]),0) + 1) VALUE ");
            query.Append(" FROM asset.PLANT_TRANSFER                   ");

            SqlCommand cmd = GetCommand(conn, query.ToString());

            try
            {
                conn.Open();
                SqlDataReader reader = GetDataReader(cmd);
                int data = 0;
                while (reader.Read())
                {
                    data = Convert.ToInt32(reader[0]);
                }
                return data;
            }
            finally
            {
                conn.Close();
            }
        }

        public static int GetPlantDisposalMaxObjectID()
        {
            SqlConnection conn = GetConnection();
            StringBuilder query = new StringBuilder();

            query.Append(" SELECT (COALESCE(MAX([OBJID]),0) + 1) VALUE ");
            query.Append(" FROM asset.PLANT_DISPOSAL                   ");

            SqlCommand cmd = GetCommand(conn, query.ToString());

            try
            {
                conn.Open();
                SqlDataReader reader = GetDataReader(cmd);
                int data = 0;
                while (reader.Read())
                {
                    data = Convert.ToInt32(reader[0]);
                }
                return data;
            }
            finally
            {
                conn.Close();
            }
        }

        //<summary>
        //Added by Najih, 21/10/2016, this method is used to get asset header by using filter
        //</summary>
        public static DataTable GetAssetHeadersByFilter(string UNIT, string LOCATION, string MAJOR)
        {
            SqlConnection conn = GetConnection();
            StringBuilder query = new StringBuilder();

            query.Append(" SELECT                   ");
            query.Append(" RECID, OBJID, EFFDT,     ");
            query.Append(" EXPDT, PLNNM, MAJCD,     ");
            query.Append(" MAJOR, PLNTY, PLTNM,     ");
            query.Append(" PLNCD, ASTNO, ORGCD,     ");
            query.Append(" ORGNM, LOCCD, LOCNM,     ");
            query.Append(" HOWGT, GETDT, ASTTO,     ");
            query.Append(" STACD, STANM, ANNOT,     ");
            query.Append(" INVNO, MTBF , WORTH,     ");
            query.Append(" HOLDR, HOLNM             ");
            query.Append(" FROM asset.PLANT_MASTER  ");
            query.Append(" WHERE                    ");
            query.Append(" BEGDA <= GETDATE() AND   ");
            query.Append(" ENDDA >= GETDATE() AND   ");
            query.Append(" MAJCD = @MAJCD           ");
            query.Append(" AND ORGCD = @ORGCD       ");
            query.Append(" AND LOCCD = @LOCAT       ");
            query.Append(" ORDER BY PLNNM           ");

            SqlCommand cmd = GetCommand(conn, query.ToString());
            cmd.Parameters.Add(GetParameter("@MAJCD", MAJOR));
            cmd.Parameters.Add(GetParameter("@ORGCD", UNIT));
            cmd.Parameters.Add(GetParameter("@LOCAT", LOCATION));

            try
            {
                conn.Open();
                DataTable data = new DataTable();
                SqlDataAdapter adapter = GetAdapter(cmd);
                adapter.Fill(data);
                data.TableName = "AssetHeader";
                return data;
            }
            finally
            {
                conn.Close();
            }
        }

        //QUERY MASTER ASSET
        public static int InsertAssetHeader(int OBJID, string EFFDT, string EXPDT, string PLNNM, string MAJCD, string MAJOR, string PLNTY, string PLTNM, string PLNCD, string ASTNO, string INVNO, string ORGCD, string ORGNM, string LOCCD, string LOCNM, string HOWGT, string GETDT, string ASTTO, string STACD, string STANM, string MTBF, string WORTH, string ANNOT, string HOLDR, string HOLNM, string CHGUS)
        {
            SqlConnection conn = GetConnection();
            StringBuilder query = new StringBuilder();
            int _objid = OBJID == 0 ? GetPlantMasterMaxObjectID() : OBJID;

            query.Append(" INSERT INTO asset.PLANT_MASTER               ");
            query.Append(" (BEGDA, ENDDA, OBJID, EFFDT,                 ");
            query.Append(" EXPDT, PLNNM, MAJCD, MAJOR, PLNTY,           ");
            query.Append(" PLTNM, PLNCD, ASTNO, ORGCD, ORGNM,           ");
            query.Append(" LOCCD, LOCNM, HOWGT, GETDT, ASTTO,           ");
            query.Append(" INVNO, STACD, STANM, MTBF, WORTH,            ");
            query.Append(" ANNOT, HOLDR, HOLNM, CHGDT, CHGUS)           ");
            query.Append("  VALUES                                      ");
            query.Append(" (GETDATE(), @ENDDA, @OBJID, @EFFDT,          ");
            query.Append("  @EXPDT, @PLNNM, @MAJCD, @MAJOR, @PLNTY,     ");
            query.Append("  @PLTNM, @PLNCD, @ASTNO, @ORGCD, @ORGNM,     ");
            query.Append("  @LOCCD, @LOCNM, @HOWGT, @GETDT, @ASTTO,     ");
            query.Append("  @INVNO, @STACD, @STANM, @MTBF, @WORTH,      ");
            query.Append("  @ANNOT, @HOLDR, @HOLNM, GETDATE(), @CHGUS)  ");

            SqlCommand cmd = GetCommand(conn, query.ToString());
            cmd.Parameters.Add(GetParameter("@ENDDA", GetMaxDate()));
            cmd.Parameters.Add(GetParameter("@OBJID", _objid));
            cmd.Parameters.Add(GetParameter("@EFFDT", EFFDT));
            cmd.Parameters.Add(GetParameter("@EXPDT", EXPDT));
            cmd.Parameters.Add(GetParameter("@PLNNM", PLNNM));
            cmd.Parameters.Add(GetParameter("@MAJCD", MAJCD));
            cmd.Parameters.Add(GetParameter("@MAJOR", MAJOR));
            cmd.Parameters.Add(GetParameter("@PLNTY", PLNTY));
            cmd.Parameters.Add(GetParameter("@PLTNM", PLTNM));
            cmd.Parameters.Add(GetParameter("@PLNCD", PLNCD));
            cmd.Parameters.Add(GetParameter("@ASTNO", ASTNO));
            cmd.Parameters.Add(GetParameter("@ORGCD", ORGCD));
            cmd.Parameters.Add(GetParameter("@ORGNM", ORGNM));
            cmd.Parameters.Add(GetParameter("@LOCCD", LOCCD));
            cmd.Parameters.Add(GetParameter("@LOCNM", LOCNM));
            cmd.Parameters.Add(GetParameter("@HOWGT", HOWGT));
            cmd.Parameters.Add(GetParameter("@GETDT", GETDT));
            cmd.Parameters.Add(GetParameter("@ASTTO", ASTTO));
            cmd.Parameters.Add(GetParameter("@INVNO", INVNO));
            cmd.Parameters.Add(GetParameter("@STACD", STACD));
            cmd.Parameters.Add(GetParameter("@STANM", STANM));
            cmd.Parameters.Add(GetParameter("@MTBF", MTBF));
            cmd.Parameters.Add(GetParameter("@WORTH", WORTH));
            cmd.Parameters.Add(GetParameter("@ANNOT", ANNOT));
            cmd.Parameters.Add(GetParameter("@HOLDR", HOLDR));
            cmd.Parameters.Add(GetParameter("@HOLNM", HOLNM));
            cmd.Parameters.Add(GetParameter("@CHGUS", CHGUS));

            try
            {
                conn.Open();
                cmd.ExecuteNonQuery();
                return _objid;
            }
            finally
            {
                conn.Close();
            }
        }

        public static int UpdateAssetHeader(int OBJID, string EFFDT, string EXPDT, string PLNNM, string MAJCD, string MAJOR, string PLNTY, string PLTNM, string PLNCD, string ASTNO, string INVNO, string ORGCD, string ORGNM, string LOCCD, string LOCNM, string HOWGT, string GETDT, string ASTTO, string STACD, string STANM, string MTBF, string WORTH, string ANNOT, string HOLDR, string HOLNM, string CHGUS)
        {
            if (OBJID != 0)
            {
                DelimitAssetHeader(OBJID.ToString(), CHGUS);
            }

            int _objid = InsertAssetHeader(OBJID, EFFDT, EXPDT, PLNNM, MAJCD, MAJOR, PLNTY, PLTNM, PLNCD, ASTNO, INVNO, ORGCD, ORGNM, LOCCD, LOCNM, HOWGT, GETDT, ASTTO, STACD, STANM, MTBF, WORTH, ANNOT, HOLDR, HOLNM,  CHGUS);

            return _objid;
        }

        public static void DelimitAssetHeader(string OBJID, string CHGUS)
        {
            SqlConnection conn = GetConnection();
            StringBuilder query = new StringBuilder();

            query.Append(" UPDATE asset.PLANT_MASTER ");
            query.Append(" SET ENDDA = GETDATE(),       ");
            query.Append(" CHGDT = GETDATE(),           ");
            query.Append(" CHGUS = @CHGUS            ");
            query.Append(" WHERE OBJID = @OBJID AND  ");
            query.Append(" BEGDA <= GETDATE() AND    ");
            query.Append(" ENDDA >= GETDATE()        ");

            SqlCommand cmd = GetCommand(conn, query.ToString());
            cmd.Parameters.Add(GetParameter("@CHGUS", CHGUS));
            cmd.Parameters.Add(GetParameter("@OBJID", OBJID));

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

        public static void DeleteAssetHeader(string OBJID)
        {
            SqlConnection conn = GetConnection();
            StringBuilder query = new StringBuilder();

            query.Append(" DELETE FROM asset.PLANT_MASTER ");
            query.Append(" WHERE OBJID = @OBJID AND       ");
            query.Append(" BEGDA <= GETDATE() AND         ");
            query.Append(" ENDDA >= GETDATE()             ");

            SqlCommand cmd = GetCommand(conn, query.ToString());
            cmd.Parameters.Add(GetParameter("@OBJID", OBJID));

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

        public static DataTable GetAssetHeaders()
        {
            SqlConnection conn = GetConnection();
            StringBuilder query = new StringBuilder();

            query.Append(" SELECT                   ");
            query.Append(" RECID, OBJID, EFFDT,     ");
            query.Append(" EXPDT, PLNNM, MAJCD,     ");
            query.Append(" MAJOR, PLNTY, PLTNM,     ");
            query.Append(" PLNCD, ASTNO, ORGCD,     ");
            query.Append(" ORGNM, LOCCD, LOCNM,     ");
            query.Append(" HOWGT, GETDT, ASTTO,     ");
            query.Append(" STACD, STANM, ANNOT,     ");
            query.Append(" INVNO, MTBF , WORTH,     ");
            query.Append(" HOLDR, HOLNM             ");
            query.Append(" FROM asset.PLANT_MASTER  ");
            query.Append(" WHERE                    ");
            query.Append(" BEGDA <= GETDATE() AND   ");
            query.Append(" ENDDA >= GETDATE()       ");
            query.Append(" ORDER BY PLNNM           ");

            SqlCommand cmd = GetCommand(conn, query.ToString());

            try
            {
                conn.Open();
                DataTable data = new DataTable();
                SqlDataAdapter adapter = GetAdapter(cmd);
                adapter.Fill(data);
                data.TableName = "AssetHeader";
                return data;
            }
            finally
            {
                conn.Close();
            }
        }

        public static DataTable GetAssetHeadersByMajor(string MAJOR)
        {
            SqlConnection conn = GetConnection();
            StringBuilder query = new StringBuilder();

            query.Append(" SELECT                   ");
            query.Append(" RECID, OBJID, EFFDT,     ");
            query.Append(" EXPDT, PLNNM, MAJCD,     ");
            query.Append(" MAJOR, PLNTY, PLTNM,     ");
            query.Append(" PLNCD, ASTNO, ORGCD,     ");
            query.Append(" ORGNM, LOCCD, LOCNM,     ");
            query.Append(" HOWGT, GETDT, ASTTO,     ");
            query.Append(" STACD, STANM, ANNOT,     ");
            query.Append(" INVNO, MTBF , WORTH,     ");
            query.Append(" HOLDR, HOLNM             ");
            query.Append(" FROM asset.PLANT_MASTER  ");
            query.Append(" WHERE                    ");
            query.Append(" BEGDA <= GETDATE() AND   ");
            query.Append(" ENDDA >= GETDATE() AND   ");
            query.Append(" MAJCD = @MAJCD           ");
            query.Append(" ORDER BY PLNNM           ");

            SqlCommand cmd = GetCommand(conn, query.ToString());
            cmd.Parameters.Add(GetParameter("@MAJCD", MAJOR));

            try
            {
                conn.Open();
                DataTable data = new DataTable();
                SqlDataAdapter adapter = GetAdapter(cmd);
                adapter.Fill(data);
                data.TableName = "AssetHeader";
                return data;
            }
            finally
            {
                conn.Close();
            }
        }

        public static DataTable GetAssetHeadersByMajorReversed(string MAJOR)
        {
            SqlConnection conn = GetConnection();
            StringBuilder query = new StringBuilder();

            query.Append(" SELECT                   ");
            query.Append(" RECID, OBJID, EFFDT,     ");
            query.Append(" EXPDT, PLNNM, MAJCD,     ");
            query.Append(" MAJOR, PLNTY, PLTNM,     ");
            query.Append(" PLNCD, ASTNO, ORGCD,     ");
            query.Append(" ORGNM, LOCCD, LOCNM,     ");
            query.Append(" HOWGT, GETDT, ASTTO,     ");
            query.Append(" STACD, STANM, ANNOT,     ");
            query.Append(" INVNO, MTBF , WORTH,     ");
            query.Append(" HOLDR, HOLNM             ");
            query.Append(" FROM asset.PLANT_MASTER  ");
            query.Append(" WHERE                    ");
            query.Append(" BEGDA <= GETDATE() AND   ");
            query.Append(" ENDDA >= GETDATE() AND   ");
            query.Append(" MAJCD != @MAJCD           ");
            query.Append(" ORDER BY PLNNM           ");

            SqlCommand cmd = GetCommand(conn, query.ToString());
            cmd.Parameters.Add(GetParameter("@MAJCD", MAJOR));

            try
            {
                conn.Open();
                DataTable data = new DataTable();
                SqlDataAdapter adapter = GetAdapter(cmd);
                adapter.Fill(data);
                data.TableName = "AssetHeader";
                return data;
            }
            finally
            {
                conn.Close();
            }
        }

        public static DataTable GetAssetHeaderByID(string OBJID)
        {
            SqlConnection conn = GetConnection();
            StringBuilder query = new StringBuilder();

            query.Append(" SELECT                   ");
            query.Append(" RECID, OBJID, EFFDT,     ");
            query.Append(" EXPDT, PLNNM, MAJCD,     ");
            query.Append(" MAJOR, PLNTY, PLTNM,     ");
            query.Append(" PLNCD, ASTNO, ORGCD,     ");
            query.Append(" ORGNM, LOCCD, LOCNM,     ");
            query.Append(" HOWGT, GETDT, ASTTO,     ");
            query.Append(" STACD, STANM, ANNOT,     ");
            query.Append(" INVNO, MTBF , WORTH,     ");
            query.Append(" HOLDR, HOLNM             ");
            query.Append(" FROM asset.PLANT_MASTER  ");
            query.Append(" WHERE                    ");
            query.Append(" BEGDA <= GETDATE() AND   ");
            query.Append(" ENDDA >= GETDATE() AND   ");
            query.Append(" OBJID = @OBJID           ");

            SqlCommand cmd = GetCommand(conn, query.ToString());
            cmd.Parameters.Add(GetParameter("@OBJID", OBJID));

            try
            {
                conn.Open();
                DataTable data = new DataTable();
                SqlDataAdapter adapter = GetAdapter(cmd);
                adapter.Fill(data);
                data.TableName = "AssetHeader";
                return data;
            }
            finally
            {
                conn.Close();
            }
        }

        public static DataTable GetAssetHeaderByAssetNumber(string ASTNO)
        {
            SqlConnection conn = GetConnection();
            StringBuilder query = new StringBuilder();

            query.Append(" SELECT                   ");
            query.Append(" RECID, OBJID, EFFDT,     ");
            query.Append(" EXPDT, PLNNM, MAJCD,     ");
            query.Append(" MAJOR, PLNTY, PLTNM,     ");
            query.Append(" PLNCD, ASTNO, ORGCD,     ");
            query.Append(" ORGNM, LOCCD, LOCNM,     ");
            query.Append(" HOWGT, GETDT, ASTTO,     ");
            query.Append(" STACD, STANM, ANNOT,     ");
            query.Append(" INVNO, MTBF , WORTH,     ");
            query.Append(" HOLDR, HOLNM             ");
            query.Append(" FROM asset.PLANT_MASTER  ");
            query.Append(" WHERE                    ");
            query.Append(" BEGDA <= GETDATE() AND   ");
            query.Append(" ENDDA >= GETDATE() AND   ");
            query.Append(" ASTNO = @ASTNO           ");

            SqlCommand cmd = GetCommand(conn, query.ToString());
            cmd.Parameters.Add(GetParameter("@ASTNO", ASTNO));

            try
            {
                conn.Open();
                DataTable data = new DataTable();
                SqlDataAdapter adapter = GetAdapter(cmd);
                adapter.Fill(data);
                data.TableName = "AssetHeader";
                return data;
            }
            finally
            {
                conn.Close();
            }
        }

        public static DataTable GetAssetHeaderByPlantCode(string PLNCD)
        {
            SqlConnection conn = GetConnection();
            StringBuilder query = new StringBuilder();

            query.Append(" SELECT                   ");
            query.Append(" RECID, OBJID, EFFDT,     ");
            query.Append(" EXPDT, PLNNM, MAJCD,     ");
            query.Append(" MAJOR, PLNTY, PLTNM,     ");
            query.Append(" PLNCD, ASTNO, ORGCD,     ");
            query.Append(" ORGNM, LOCCD, LOCNM,     ");
            query.Append(" HOWGT, GETDT, ASTTO,     ");
            query.Append(" STACD, STANM, ANNOT,     ");
            query.Append(" INVNO, MTBF , WORTH,     ");
            query.Append(" HOLDR, HOLNM             ");
            query.Append(" FROM asset.PLANT_MASTER  ");
            query.Append(" WHERE                    ");
            query.Append(" BEGDA <= GETDATE() AND   ");
            query.Append(" ENDDA >= GETDATE() AND   ");
            query.Append(" PLNCD = @PLNCD           ");

            SqlCommand cmd = GetCommand(conn, query.ToString());
            cmd.Parameters.Add(GetParameter("@PLNCD", PLNCD));

            try
            {
                conn.Open();
                DataTable data = new DataTable();
                SqlDataAdapter adapter = GetAdapter(cmd);
                adapter.Fill(data);
                data.TableName = "AssetHeader";
                return data;
            }
            finally
            {
                conn.Close();
            }
        }

        public static DataTable GetAssetHeaderByInventoryNumber(string INVNO)
        {
            SqlConnection conn = GetConnection();
            StringBuilder query = new StringBuilder();

            query.Append(" SELECT                   ");
            query.Append(" RECID, OBJID, EFFDT,     ");
            query.Append(" EXPDT, PLNNM, MAJCD,     ");
            query.Append(" MAJOR, PLNTY, PLTNM,     ");
            query.Append(" PLNCD, ASTNO, ORGCD,     ");
            query.Append(" ORGNM, LOCCD, LOCNM,     ");
            query.Append(" HOWGT, GETDT, ASTTO,     ");
            query.Append(" STACD, STANM, ANNOT,     ");
            query.Append(" INVNO, MTBF , WORTH,     ");
            query.Append(" HOLDR, HOLNM             ");
            query.Append(" FROM asset.PLANT_MASTER  ");
            query.Append(" WHERE                    ");
            query.Append(" BEGDA <= GETDATE() AND   ");
            query.Append(" ENDDA >= GETDATE() AND   ");
            query.Append(" INVNO = @INVNO           ");

            SqlCommand cmd = GetCommand(conn, query.ToString());
            cmd.Parameters.Add(GetParameter("@INVNO", INVNO));

            try
            {
                conn.Open();
                DataTable data = new DataTable();
                SqlDataAdapter adapter = GetAdapter(cmd);
                adapter.Fill(data);
                data.TableName = "AssetHeader";
                return data;
            }
            finally
            {
                conn.Close();
            }
        }

        public static DataTable GetAssetHeaderByGroup(string MAJCD)
        {
            SqlConnection conn = GetConnection();
            StringBuilder query = new StringBuilder();

            query.Append(" SELECT                   ");
            query.Append(" RECID, OBJID, EFFDT,     ");
            query.Append(" EXPDT, PLNNM, MAJCD,     ");
            query.Append(" MAJOR, PLNTY, PLTNM,     ");
            query.Append(" PLNCD, ASTNO, ORGCD,     ");
            query.Append(" ORGNM, LOCCD, LOCNM,     ");
            query.Append(" HOWGT, GETDT, ASTTO,     ");
            query.Append(" STACD, STANM, ANNOT,     ");
            query.Append(" INVNO, MTBF , WORTH,     ");
            query.Append(" HOLDR, HOLNM             ");
            query.Append(" FROM asset.PLANT_MASTER  ");
            query.Append(" WHERE                    ");
            query.Append(" BEGDA <= GETDATE() AND   ");
            query.Append(" ENDDA >= GETDATE() AND   ");
            query.Append(" MAJCD = @MAJCD           ");
            query.Append(" ORDER BY PLNNM           ");

            SqlCommand cmd = GetCommand(conn, query.ToString());
            cmd.Parameters.Add(GetParameter("@MAJCD", MAJCD));

            try
            {
                conn.Open();
                DataTable data = new DataTable();
                SqlDataAdapter adapter = GetAdapter(cmd);
                adapter.Fill(data);
                data.TableName = "AssetHeader";
                return data;
            }
            finally
            {
                conn.Close();
            }
        }

        public static DataTable GetAssetHeaderBySubGroup(string SUBCD)
        {
            SqlConnection conn = GetConnection();
            StringBuilder query = new StringBuilder();

            query.Append(" SELECT                   ");
            query.Append(" RECID, OBJID, EFFDT,     ");
            query.Append(" EXPDT, PLNNM, MAJCD,     ");
            query.Append(" MAJOR, PLNTY, PLTNM,     ");
            query.Append(" PLNCD, ASTNO, ORGCD,     ");
            query.Append(" ORGNM, LOCCD, LOCNM,     ");
            query.Append(" HOWGT, GETDT, ASTTO,     ");
            query.Append(" STACD, STANM, ANNOT,     ");
            query.Append(" INVNO, MTBF , WORTH,     ");
            query.Append(" HOLDR, HOLNM             ");
            query.Append(" FROM asset.PLANT_MASTER  ");
            query.Append(" WHERE                    ");
            query.Append(" BEGDA <= GETDATE() AND   ");
            query.Append(" ENDDA >= GETDATE() AND   ");
            query.Append(" PLNTY = @SUBCD           ");
            query.Append(" ORDER BY PLNNM           ");

            SqlCommand cmd = GetCommand(conn, query.ToString());
            cmd.Parameters.Add(GetParameter("@SUBCD", SUBCD));

            try
            {
                conn.Open();
                DataTable data = new DataTable();
                SqlDataAdapter adapter = GetAdapter(cmd);
                adapter.Fill(data);
                data.TableName = "AssetHeader";
                return data;
            }
            finally
            {
                conn.Close();
            }
        }

        //QUERY ASSET DETAIL
        public static int InsertAssetDetail(int OBJID, string PLNID, string ATTID, string ATTRB, string VALUE, string CHGUS)
        {
            SqlConnection conn = GetConnection();
            StringBuilder query = new StringBuilder();
            int _objid = OBJID == 0 ? GetPlantDetailMaxObjectID() : OBJID;

            query.Append(" INSERT INTO asset.PLANT_DETAIL           ");
            query.Append(" (BEGDA, ENDDA, OBJID, PLNID,             ");
            query.Append("  ATTID, ATTRB, VALUE, CHGDT, CHGUS)      ");
            query.Append("  VALUES                                  ");
            query.Append(" (GETDATE(), @ENDDA, @OBJID, @PLNID,         ");
            query.Append("  @ATTID, @ATTRB, @VALUE, GETDATE(), @CHGUS) ");

            SqlCommand cmd = GetCommand(conn, query.ToString());
            cmd.Parameters.Add(GetParameter("@ENDDA", GetMaxDate()));
            cmd.Parameters.Add(GetParameter("@OBJID", _objid));
            cmd.Parameters.Add(GetParameter("@PLNID", PLNID));
            cmd.Parameters.Add(GetParameter("@ATTID", ATTID));
            cmd.Parameters.Add(GetParameter("@ATTRB", ATTRB));
            cmd.Parameters.Add(GetParameter("@VALUE", VALUE));
            cmd.Parameters.Add(GetParameter("@CHGUS", CHGUS));

            try
            {
                conn.Open();
                cmd.ExecuteNonQuery();
                return _objid;
            }
            finally
            {
                conn.Close();
            }
        }

        public static void UpdateAssetDetail(int OBJID, string PLNID, string ATTID, string ATTRB, string VALUE, string CHGUS)
        {
            if (OBJID != 0)
            {
                DelimitAssetDetail(OBJID.ToString(), CHGUS);
            }

            InsertAssetDetail(OBJID, PLNID, ATTID, ATTRB, VALUE, CHGUS);
        }

        public static void DelimitAssetDetail(string OBJID, string CHGUS)
        {
            SqlConnection conn = GetConnection();
            StringBuilder query = new StringBuilder();

            query.Append(" UPDATE asset.PLANT_DETAIL ");
            query.Append(" SET ENDDA = GETDATE(),       ");
            query.Append(" CHGDT = GETDATE(),           ");
            query.Append(" CHGUS = @CHGUS            ");
            query.Append(" WHERE OBJID = @OBJID AND  ");
            query.Append(" BEGDA <= GETDATE() AND    ");
            query.Append(" ENDDA >= GETDATE()        ");

            SqlCommand cmd = GetCommand(conn, query.ToString());
            cmd.Parameters.Add(GetParameter("@CHGUS", CHGUS));
            cmd.Parameters.Add(GetParameter("@OBJID", OBJID));

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

        public static void DelimitAssetDetailByHeader(string PLNID, string CHGUS)
        {
            SqlConnection conn = GetConnection();
            StringBuilder query = new StringBuilder();

            query.Append(" UPDATE asset.PLANT_DETAIL ");
            query.Append(" SET ENDDA = GETDATE(),       ");
            query.Append(" CHGDT = GETDATE(),           ");
            query.Append(" CHGUS = @CHGUS            ");
            query.Append(" WHERE PLNID = @PLNID AND  ");
            query.Append(" BEGDA <= GETDATE() AND    ");
            query.Append(" ENDDA >= GETDATE()        ");

            SqlCommand cmd = GetCommand(conn, query.ToString());
            cmd.Parameters.Add(GetParameter("@CHGUS", CHGUS));
            cmd.Parameters.Add(GetParameter("@PLNID", PLNID));

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

        public static void DeleteAssetDetail(string OBJID)
        {
            SqlConnection conn = GetConnection();
            StringBuilder query = new StringBuilder();

            query.Append(" DELETE FROM asset.PLANT_DETAIL ");
            query.Append(" WHERE OBJID = @OBJID AND       ");
            query.Append(" BEGDA <= GETDATE() AND         ");
            query.Append(" ENDDA >= GETDATE()             ");

            SqlCommand cmd = GetCommand(conn, query.ToString());
            cmd.Parameters.Add(GetParameter("@OBJID", OBJID));

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

        public static void DeleteAssetDetailByHeader(string PLNID)
        {
            SqlConnection conn = GetConnection();
            StringBuilder query = new StringBuilder();

            query.Append(" DELETE FROM asset.PLANT_DETAIL ");
            query.Append(" WHERE PLNID = @PLNID AND       ");
            query.Append(" BEGDA <= GETDATE() AND         ");
            query.Append(" ENDDA >= GETDATE()             ");

            SqlCommand cmd = GetCommand(conn, query.ToString());
            cmd.Parameters.Add(GetParameter("@PLNID", PLNID));

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

        public static DataTable GetAssetDetails()
        {
            SqlConnection conn = GetConnection();
            StringBuilder query = new StringBuilder();

            query.Append(" SELECT                   ");
            query.Append(" RECID, OBJID, PLNID,     ");
            query.Append(" ATTID, ATTRB, VALUE      ");
            query.Append(" FROM  asset.PLANT_DETAIL ");
            query.Append(" WHERE                    ");
            query.Append(" BEGDA <= GETDATE() AND   ");
            query.Append(" ENDDA >= GETDATE()       ");
            query.Append(" ORDER BY ATTRB           ");

            SqlCommand cmd = GetCommand(conn, query.ToString());

            try
            {
                conn.Open();
                DataTable data = new DataTable();
                SqlDataAdapter adapter = GetAdapter(cmd);
                adapter.Fill(data);
                data.TableName = "Asset Detail";
                return data;
            }
            finally
            {
                conn.Close();
            }
        }

        public static DataTable GetAssetDetailByAssetID(string PLNID)
        {
            SqlConnection conn = GetConnection();
            StringBuilder query = new StringBuilder();

            query.Append(" SELECT                   ");
            query.Append(" RECID, OBJID, PLNID,     ");
            query.Append(" ATTID, ATTRB, VALUE      ");
            query.Append(" FROM  asset.PLANT_DETAIL ");
            query.Append(" WHERE                    ");
            query.Append(" BEGDA <= GETDATE() AND   ");
            query.Append(" ENDDA >= GETDATE() AND   ");
            query.Append(" PLNID = @PLNID           ");
            query.Append(" ORDER BY ATTRB           ");

            SqlCommand cmd = GetCommand(conn, query.ToString());
            cmd.Parameters.Add(GetParameter("@PLNID", PLNID));

            try
            {
                conn.Open();
                DataTable data = new DataTable();
                SqlDataAdapter adapter = GetAdapter(cmd);
                adapter.Fill(data);
                data.TableName = "Asset Detail";
                return data;
            }
            finally
            {
                conn.Close();
            }
        }

        //QUERY MAYOR TYPE
        public static int InsertAssetMayorType(int OBJID, string MAJCD, string MAJOR, string TYPCD, string TYPNM, string CHGUS)
        {
            SqlConnection conn = GetConnection();
            StringBuilder query = new StringBuilder();
            int _objid = OBJID == 0 ? GetPlantMajorMaxObjectID() : OBJID;

            query.Append(" INSERT INTO asset.PLANT_MAJOR            ");
            query.Append(" (BEGDA, ENDDA, OBJID, MAJCD,             ");
            query.Append("  MAJOR, TYPCD, TYPNM, CHGDT, CHGUS)      ");
            query.Append("  VALUES                                  ");
            query.Append(" (GETDATE(), @ENDDA, @OBJID, @MAJCD,         ");
            query.Append("  @MAJOR, @TYPCD, @TYPNM, GETDATE(), @CHGUS) ");

            SqlCommand cmd = GetCommand(conn, query.ToString());
            cmd.Parameters.Add(GetParameter("@ENDDA", GetMaxDate()));
            cmd.Parameters.Add(GetParameter("@OBJID", _objid));
            cmd.Parameters.Add(GetParameter("@MAJCD", MAJCD));
            cmd.Parameters.Add(GetParameter("@MAJOR", MAJOR));
            cmd.Parameters.Add(GetParameter("@TYPCD", TYPCD));
            cmd.Parameters.Add(GetParameter("@TYPNM", TYPNM));
            cmd.Parameters.Add(GetParameter("@CHGUS", CHGUS));

            try
            {
                conn.Open();
                cmd.ExecuteNonQuery();
                return _objid;
            }
            finally
            {
                conn.Close();
            }
        }

        public static void UpdateAssetMayorType(int OBJID, string MAJCD, string MAJOR, string TYPCD, string TYPNM, string CHGUS)
        {
            if (OBJID != 0)
            {
                DelimitAssetMayorType(OBJID.ToString(), CHGUS);
            }

            InsertAssetMayorType(OBJID, MAJCD, MAJOR, TYPCD, TYPNM, CHGUS);
        }

        public static void DelimitAssetMayorType(string OBJID, string CHGUS)
        {
            SqlConnection conn = GetConnection();
            StringBuilder query = new StringBuilder();

            query.Append(" UPDATE asset.PLANT_MAJOR  ");
            query.Append(" SET ENDDA = GETDATE(),       ");
            query.Append(" CHGDT = GETDATE(),           ");
            query.Append(" CHGUS = @CHGUS            ");
            query.Append(" WHERE OBJID = @OBJID AND  ");
            query.Append(" BEGDA <= GETDATE() AND    ");
            query.Append(" ENDDA >= GETDATE()        ");

            SqlCommand cmd = GetCommand(conn, query.ToString());
            cmd.Parameters.Add(GetParameter("@CHGUS", CHGUS));
            cmd.Parameters.Add(GetParameter("@OBJID", OBJID));

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

        public static void DeleteAssetMayorType(string OBJID)
        {
            SqlConnection conn = GetConnection();
            StringBuilder query = new StringBuilder();

            query.Append(" DELETE FROM asset.PLANT_MAJOR  ");
            query.Append(" WHERE OBJID = @OBJID AND       ");
            query.Append(" BEGDA <= GETDATE() AND         ");
            query.Append(" ENDDA >= GETDATE()             ");

            SqlCommand cmd = GetCommand(conn, query.ToString());
            cmd.Parameters.Add(GetParameter("@OBJID", OBJID));

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

        public static DataTable GetAssetMayorTypes()
        {
            SqlConnection conn = GetConnection();
            StringBuilder query = new StringBuilder();

            query.Append(" SELECT                   ");
            query.Append(" RECID, OBJID, MAJCD,     ");
            query.Append(" MAJOR, TYPCD, TYPNM      ");
            query.Append(" FROM asset.PLANT_MAJOR   ");
            query.Append(" WHERE                    ");
            query.Append(" BEGDA <= GETDATE() AND   ");
            query.Append(" ENDDA >= GETDATE()       ");
            query.Append(" ORDER BY MAJOR           ");

            SqlCommand cmd = GetCommand(conn, query.ToString());

            try
            {
                conn.Open();
                DataTable data = new DataTable();
                SqlDataAdapter adapter = GetAdapter(cmd);
                adapter.Fill(data);
                data.TableName = "MayorType";
                return data;
            }
            finally
            {
                conn.Close();
            }
        }

        public static DataTable GetAssetMayorTypeByID(string OBJID)
        {
            SqlConnection conn = GetConnection();
            StringBuilder query = new StringBuilder();

            query.Append(" SELECT                   ");
            query.Append(" RECID, OBJID, MAJCD,     ");
            query.Append(" MAJOR, TYPCD, TYPNM      ");
            query.Append(" FROM asset.PLANT_MAJOR   ");
            query.Append(" WHERE                    ");
            query.Append(" BEGDA <= GETDATE() AND   ");
            query.Append(" ENDDA >= GETDATE() AND   ");
            query.Append(" OBJID = @OBJID           ");

            SqlCommand cmd = GetCommand(conn, query.ToString());
            cmd.Parameters.Add(GetParameter("@OBJID", OBJID));

            try
            {
                conn.Open();
                DataTable data = new DataTable();
                SqlDataAdapter adapter = GetAdapter(cmd);
                adapter.Fill(data);
                data.TableName = "MayorType";
                return data;
            }
            finally
            {
                conn.Close();
            }
        }

        //QUERY SUB TYPE
        public static int InsertAssetSubtype(int OBJID, string MAJCD, string MAJOR, string SUBCD, string SUBNM, string ASTMS, string MSUNT, string CHGUS)
        {
            SqlConnection conn = GetConnection();
            StringBuilder query = new StringBuilder();
            int _objid = OBJID == 0 ? GetPlantSubtypeMaxObjectID() : OBJID;

            query.Append(" INSERT INTO asset.PLANT_SUBTYPE              ");
            query.Append(" (BEGDA, ENDDA, OBJID, MAJCD, MAJOR,          ");
            query.Append(" SUBCD, SUBNM, ASTMS,                         ");
            query.Append("  MSUNT, CHGDT, CHGUS)                        ");
            query.Append("  VALUES                                      ");
            query.Append(" (GETDATE(), @ENDDA, @OBJID, @MAJCD, @MAJOR,  ");
            query.Append("  @SUBCD, @SUBNM, @ASTMS, @MSUNT, GETDATE(), @CHGUS) ");

            SqlCommand cmd = GetCommand(conn, query.ToString());
            cmd.Parameters.Add(GetParameter("@ENDDA", GetMaxDate()));
            cmd.Parameters.Add(GetParameter("@OBJID", _objid));
            cmd.Parameters.Add(GetParameter("@MAJCD", MAJCD));
            cmd.Parameters.Add(GetParameter("@MAJOR", MAJOR));
            cmd.Parameters.Add(GetParameter("@SUBCD", SUBCD));
            cmd.Parameters.Add(GetParameter("@SUBNM", SUBNM));
            cmd.Parameters.Add(GetParameter("@ASTMS", ASTMS));
            cmd.Parameters.Add(GetParameter("@MSUNT", MSUNT));
            cmd.Parameters.Add(GetParameter("@CHGUS", CHGUS));

            try
            {
                conn.Open();
                cmd.ExecuteNonQuery();
                return _objid;
            }
            finally
            {
                conn.Close();
            }
        }

        public static void UpdateAssetSubtype(int OBJID, string MAJCD, string MAJOR, string SUBCD, string SUBNM, string ASTMS, string MSUNT, string CHGUS)
        {
            if (OBJID != 0)
            {
                DelimitAssetSubtype(OBJID.ToString(), CHGUS);
            }

            InsertAssetSubtype(OBJID, MAJCD, MAJOR, SUBCD, SUBNM, ASTMS, MSUNT, CHGUS);
        }

        public static void DelimitAssetSubtype(string OBJID, string CHGUS)
        {
            SqlConnection conn = GetConnection();
            StringBuilder query = new StringBuilder();

            query.Append(" UPDATE asset.PLANT_SUBTYPE");
            query.Append(" SET ENDDA = GETDATE(),       ");
            query.Append(" CHGDT = GETDATE(),           ");
            query.Append(" CHGUS = @CHGUS            ");
            query.Append(" WHERE OBJID = @OBJID AND  ");
            query.Append(" BEGDA <= GETDATE() AND    ");
            query.Append(" ENDDA >= GETDATE()        ");

            SqlCommand cmd = GetCommand(conn, query.ToString());
            cmd.Parameters.Add(GetParameter("@CHGUS", CHGUS));
            cmd.Parameters.Add(GetParameter("@OBJID", OBJID));

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

        public static void DeleteAssetSubtype(string OBJID)
        {
            SqlConnection conn = GetConnection();
            StringBuilder query = new StringBuilder();

            query.Append(" DELETE FROM asset.PLANT_SUBTYPE");
            query.Append(" WHERE OBJID = @OBJID AND       ");
            query.Append(" BEGDA <= GETDATE() AND         ");
            query.Append(" ENDDA >= GETDATE()             ");

            SqlCommand cmd = GetCommand(conn, query.ToString());
            cmd.Parameters.Add(GetParameter("@OBJID", OBJID));

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

        public static DataTable GetAssetSubtypes()
        {
            SqlConnection conn = GetConnection();
            StringBuilder query = new StringBuilder();

            query.Append(" SELECT                   ");
            query.Append(" RECID, OBJID,            ");
            query.Append(" MAJCD, MAJOR,            ");
            query.Append(" SUBCD, SUBNM,            ");
            query.Append(" ASTMS, MSUNT             ");
            query.Append(" FROM asset.PLANT_SUBTYPE ");
            query.Append(" WHERE                    ");
            query.Append(" BEGDA <= GETDATE() AND   ");
            query.Append(" ENDDA >= GETDATE()       ");
            query.Append(" ORDER BY MAJOR, SUBNM    ");

            SqlCommand cmd = GetCommand(conn, query.ToString());

            try
            {
                conn.Open();
                DataTable data = new DataTable();
                SqlDataAdapter adapter = GetAdapter(cmd);
                adapter.Fill(data);
                data.TableName = "Subtype";
                return data;
            }
            finally
            {
                conn.Close();
            }
        }

        public static DataTable GetAssetSubtypeByID(string OBJID)
        {
            SqlConnection conn = GetConnection();
            StringBuilder query = new StringBuilder();

            query.Append(" SELECT                   ");
            query.Append(" RECID, OBJID,            ");
            query.Append(" MAJCD, MAJOR,            ");
            query.Append(" SUBCD, SUBNM, ASTMS      ");
            query.Append(" FROM asset.PLANT_SUBTYPE ");
            query.Append(" WHERE                    ");
            query.Append(" BEGDA <= GETDATE() AND   ");
            query.Append(" ENDDA >= GETDATE() AND   ");
            query.Append(" OBJID = @OBJID           ");

            SqlCommand cmd = GetCommand(conn, query.ToString());
            cmd.Parameters.Add(GetParameter("@OBJID", OBJID));

            try
            {
                conn.Open();
                DataTable data = new DataTable();
                SqlDataAdapter adapter = GetAdapter(cmd);
                adapter.Fill(data);
                data.TableName = "Subtype";
                return data;
            }
            finally
            {
                conn.Close();
            }
        }

        //QUERY ASSET ATTRIBUTE
        public static int InsertAssetAttribute(int OBJID, string ATTRB, string ATTYP, string ATTNM, string DESCR, string CHGUS)
        {
            SqlConnection conn = GetConnection();
            StringBuilder query = new StringBuilder();
            int _objid = OBJID == 0 ? GetPlantAttributeMaxObjectID() : OBJID;

            query.Append(" INSERT INTO asset.PLANT_ATTRIBUTE        ");
            query.Append(" (BEGDA, ENDDA, OBJID, ATTRB,             ");
            query.Append("  ATTYP, ATTNM, DESCR, CHGDT, CHGUS)      ");
            query.Append("  VALUES                                  ");
            query.Append(" (GETDATE(), @ENDDA, @OBJID, @ATTRB,         ");
            query.Append("  @ATTYP, @ATTNM, @DESCR, GETDATE(), @CHGUS) ");

            SqlCommand cmd = GetCommand(conn, query.ToString());
            cmd.Parameters.Add(GetParameter("@ENDDA", GetMaxDate()));
            cmd.Parameters.Add(GetParameter("@OBJID", _objid));
            cmd.Parameters.Add(GetParameter("@ATTRB", ATTRB));
            cmd.Parameters.Add(GetParameter("@ATTYP", ATTYP));
            cmd.Parameters.Add(GetParameter("@ATTNM", ATTNM));
            cmd.Parameters.Add(GetParameter("@DESCR", DESCR));
            cmd.Parameters.Add(GetParameter("@CHGUS", CHGUS));

            try
            {
                conn.Open();
                cmd.ExecuteNonQuery();
                return _objid;
            }
            finally
            {
                conn.Close();
            }
        }

        public static void UpdateAssetAttribute(int OBJID, string ATTRB, string ATTYP, string ATTNM, string DESCR, string CHGUS)
        {
            if (OBJID != 0)
            {
                DelimitAssetAttribute(OBJID.ToString(), CHGUS);
            }

            InsertAssetAttribute(OBJID, ATTRB, ATTYP, ATTNM, DESCR, CHGUS);
        }

        public static void DelimitAssetAttribute(string OBJID, string CHGUS)
        {
            SqlConnection conn = GetConnection();
            StringBuilder query = new StringBuilder();

            query.Append(" UPDATE asset.PLANT_ATTRIBUTE ");
            query.Append(" SET ENDDA = GETDATE(),          ");
            query.Append(" CHGDT = GETDATE(),              ");
            query.Append(" CHGUS = @CHGUS               ");
            query.Append(" WHERE OBJID = @OBJID AND     ");
            query.Append(" BEGDA <= GETDATE() AND       ");
            query.Append(" ENDDA >= GETDATE()           ");

            SqlCommand cmd = GetCommand(conn, query.ToString());
            cmd.Parameters.Add(GetParameter("@CHGUS", CHGUS));
            cmd.Parameters.Add(GetParameter("@OBJID", OBJID));

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

        public static void DeleteAssetAttribute(string OBJID)
        {
            SqlConnection conn = GetConnection();
            StringBuilder query = new StringBuilder();

            query.Append(" DELETE FROM asset.PLANT_ATTRIBUTE ");
            query.Append(" WHERE OBJID = @OBJID AND          ");
            query.Append(" BEGDA <= GETDATE() AND            ");
            query.Append(" ENDDA >= GETDATE()                ");

            SqlCommand cmd = GetCommand(conn, query.ToString());
            cmd.Parameters.Add(GetParameter("@OBJID", OBJID));

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

        public static DataTable GetAssetAttributes()
        {
            SqlConnection conn = GetConnection();
            StringBuilder query = new StringBuilder();

            query.Append(" SELECT                       ");
            query.Append(" RECID, OBJID, ATTRB,         ");
            query.Append(" ATTYP, ATTNM, DESCR          ");
            query.Append(" FROM asset.PLANT_ATTRIBUTE   ");
            query.Append(" WHERE                        ");
            query.Append(" BEGDA <= GETDATE() AND       ");
            query.Append(" ENDDA >= GETDATE()           ");
            query.Append(" ORDER BY ATTNM               ");

            SqlCommand cmd = GetCommand(conn, query.ToString());

            try
            {
                conn.Open();
                DataTable data = new DataTable();
                SqlDataAdapter adapter = GetAdapter(cmd);
                adapter.Fill(data);
                data.TableName = "Attribute";
                return data;
            }
            finally
            {
                conn.Close();
            }
        }

        public static DataTable GetAssetAttributesByGroup(string ATTRB)
        {
            SqlConnection conn = GetConnection();
            StringBuilder query = new StringBuilder();

            query.Append(" SELECT                       ");
            query.Append(" RECID, OBJID, ATTRB,         ");
            query.Append(" ATTYP, ATTNM, DESCR          ");
            query.Append(" FROM asset.PLANT_ATTRIBUTE   ");
            query.Append(" WHERE                        ");
            query.Append(" BEGDA <= GETDATE() AND       ");
            query.Append(" ENDDA >= GETDATE() AND       ");
            query.Append(" ATTRB = @ATTRB               ");
            query.Append(" ORDER BY ATTNM               ");

            SqlCommand cmd = GetCommand(conn, query.ToString());
            cmd.Parameters.Add(GetParameter("@ATTRB", ATTRB));

            try
            {
                conn.Open();
                DataTable data = new DataTable();
                SqlDataAdapter adapter = GetAdapter(cmd);
                adapter.Fill(data);
                data.TableName = "Attribute";
                return data;
            }
            finally
            {
                conn.Close();
            }
        }

        public static DataTable GetAssetSubtypeByMajorCode(string MAJCD)
        {
            SqlConnection conn = GetConnection();
            StringBuilder query = new StringBuilder();

            query.Append(" SELECT                   ");
            query.Append(" RECID, OBJID,            ");
            query.Append(" MAJCD, MAJOR,            ");
            query.Append(" SUBCD, SUBNM, ASTMS      ");
            query.Append(" FROM asset.PLANT_SUBTYPE ");
            query.Append(" WHERE                    ");
            query.Append(" BEGDA <= GETDATE() AND   ");
            query.Append(" ENDDA >= GETDATE() AND   ");
            query.Append(" MAJCD = @MAJCD           ");
            query.Append(" ORDER BY MAJOR, SUBNM    ");

            SqlCommand cmd = GetCommand(conn, query.ToString());
            cmd.Parameters.Add(GetParameter("@MAJCD", MAJCD));

            try
            {
                conn.Open();
                DataTable data = new DataTable();
                SqlDataAdapter adapter = GetAdapter(cmd);
                adapter.Fill(data);
                data.TableName = "Subtype";
                return data;
            }
            finally
            {
                conn.Close();
            }
        }

        public static DataTable GetAssetSubtypeBySubCode(string SUBCD)
        {
            SqlConnection conn = GetConnection();
            StringBuilder query = new StringBuilder();

            query.Append(" SELECT                   ");
            query.Append(" RECID, OBJID,            ");
            query.Append(" MAJCD, MAJOR,            ");
            query.Append(" SUBCD, SUBNM, ASTMS      ");
            query.Append(" FROM asset.PLANT_SUBTYPE ");
            query.Append(" WHERE                    ");
            query.Append(" BEGDA <= GETDATE() AND   ");
            query.Append(" ENDDA >= GETDATE() AND   ");
            query.Append(" SUBCD = @SUBCD           ");
            query.Append(" ORDER BY MAJOR, SUBNM    ");

            SqlCommand cmd = GetCommand(conn, query.ToString());
            cmd.Parameters.Add(GetParameter("@SUBCD", SUBCD));

            try
            {
                conn.Open();
                DataTable data = new DataTable();
                SqlDataAdapter adapter = GetAdapter(cmd);
                adapter.Fill(data);
                data.TableName = "Subtype";
                return data;
            }
            finally
            {
                conn.Close();
            }
        }

        public static DataTable GetAssetAttributeByID(string OBJID)
        {
            SqlConnection conn = GetConnection();
            StringBuilder query = new StringBuilder();

            query.Append(" SELECT                       ");
            query.Append(" RECID, OBJID, ATTRB,         ");
            query.Append(" ATTYP, ATTNM, DESCR          ");
            query.Append(" FROM asset.PLANT_ATTRIBUTE   ");
            query.Append(" WHERE                        ");
            query.Append(" BEGDA <= GETDATE() AND       ");
            query.Append(" ENDDA >= GETDATE() AND       ");
            query.Append(" OBJID = @OBJID               ");

            SqlCommand cmd = GetCommand(conn, query.ToString());
            cmd.Parameters.Add(GetParameter("@OBJID", OBJID));

            try
            {
                conn.Open();
                DataTable data = new DataTable();
                SqlDataAdapter adapter = GetAdapter(cmd);
                adapter.Fill(data);
                data.TableName = "Attribute";
                return data;
            }
            finally
            {
                conn.Close();
            }
        }

        //QUERY CLUSTER AREA
        public static int InsertClusterArea(int OBJID, string CLUST, string DESCR, string CHGUS)
        {
            SqlConnection conn = GetConnection();
            StringBuilder query = new StringBuilder();
            int _objid = OBJID == 0 ? GetClusterAreaMaxObjectID() : OBJID;

            query.Append(" INSERT INTO asset.CLUSTER_AREA    ");
            query.Append(" (BEGDA, ENDDA, OBJID,             ");
            query.Append("  CLUST, DESCR, CHGDT, CHGUS)      ");
            query.Append("  VALUES                           ");
            query.Append(" (GETDATE(), @ENDDA, @OBJID,       ");
            query.Append("  @CLUST, @DESCR, GETDATE(), @CHGUS)");

            SqlCommand cmd = GetCommand(conn, query.ToString());
            cmd.Parameters.Add(GetParameter("@ENDDA", GetMaxDate()));
            cmd.Parameters.Add(GetParameter("@OBJID", _objid));
            cmd.Parameters.Add(GetParameter("@CLUST", CLUST));
            cmd.Parameters.Add(GetParameter("@DESCR", DESCR));
            cmd.Parameters.Add(GetParameter("@CHGUS", CHGUS));

            try
            {
                conn.Open();
                cmd.ExecuteNonQuery();
                return _objid;
            }
            finally
            {
                conn.Close();
            }
        }

        public static void UpdateClusterArea(int OBJID, string CLUST, string DESCR, string CHGUS)
        {
            if (OBJID != 0)
            {
                DelimitClusterArea(OBJID.ToString(), CHGUS);
            }

            InsertClusterArea(OBJID, CLUST, DESCR, CHGUS);
        }

        public static void DelimitClusterArea(string OBJID, string CHGUS)
        {
            SqlConnection conn = GetConnection();
            StringBuilder query = new StringBuilder();

            query.Append(" UPDATE asset.CLUSTER_AREA ");
            query.Append(" SET ENDDA = GETDATE(),    ");
            query.Append(" CHGDT = GETDATE(),        ");
            query.Append(" CHGUS = @CHGUS            ");
            query.Append(" WHERE OBJID = @OBJID AND  ");
            query.Append(" BEGDA <= GETDATE() AND    ");
            query.Append(" ENDDA >= GETDATE()        ");

            SqlCommand cmd = GetCommand(conn, query.ToString());
            cmd.Parameters.Add(GetParameter("@CHGUS", CHGUS));
            cmd.Parameters.Add(GetParameter("@OBJID", OBJID));

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

        public static void DeleteClusterArea(string OBJID)
        {
            SqlConnection conn = GetConnection();
            StringBuilder query = new StringBuilder();

            query.Append(" DELETE FROM asset.CLUSTER_AREA ");
            query.Append(" WHERE OBJID = @OBJID AND       ");
            query.Append(" BEGDA <= GETDATE() AND         ");
            query.Append(" ENDDA >= GETDATE()             ");

            SqlCommand cmd = GetCommand(conn, query.ToString());
            cmd.Parameters.Add(GetParameter("@OBJID", OBJID));

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

        public static DataTable GetClusterArea()
        {
            SqlConnection conn = GetConnection();
            StringBuilder query = new StringBuilder();

            query.Append(" SELECT                   ");
            query.Append(" RECID, OBJID,            ");
            query.Append(" CLUST, DESCR             ");
            query.Append(" FROM asset.CLUSTER_AREA  ");
            query.Append(" WHERE                    ");
            query.Append(" BEGDA <= GETDATE() AND   ");
            query.Append(" ENDDA >= GETDATE()       ");
            query.Append(" ORDER BY CLUST           ");

            SqlCommand cmd = GetCommand(conn, query.ToString());

            try
            {
                conn.Open();
                DataTable data = new DataTable();
                SqlDataAdapter adapter = GetAdapter(cmd);
                adapter.Fill(data);
                data.TableName = "Cluster";
                return data;
            }
            finally
            {
                conn.Close();
            }
        }

        public static DataTable GetClusterAreaByID(string OBJID)
        {
            SqlConnection conn = GetConnection();
            StringBuilder query = new StringBuilder();

            query.Append(" SELECT                   ");
            query.Append(" RECID, OBJID,            ");
            query.Append(" CLUST, DESCR             ");
            query.Append(" FROM asset.CLUSTER_AREA  ");
            query.Append(" WHERE                    ");
            query.Append(" BEGDA <= GETDATE() AND   ");
            query.Append(" ENDDA >= GETDATE() AND   ");
            query.Append(" OBJID = @OBJID           ");

            SqlCommand cmd = GetCommand(conn, query.ToString());
            cmd.Parameters.Add(GetParameter("@OBJID", OBJID));

            try
            {
                conn.Open();
                DataTable data = new DataTable();
                SqlDataAdapter adapter = GetAdapter(cmd);
                adapter.Fill(data);
                data.TableName = "Cluster";
                return data;
            }
            finally
            {
                conn.Close();
            }
        }

        public static bool IsNonAssetTypeByGroup()
        {
            SqlConnection conn = GetConnection();
            StringBuilder query = new StringBuilder();

            query.Append(" SELECT                 ");
            query.Append(" COUNT (*) VALUE        ");
            query.Append(" FROM                   ");
            query.Append(" asset.PLANT_MAJOR      ");
            query.Append(" WHERE                  ");
            query.Append(" BEGDA <= GetDate() AND ");
            query.Append(" ENDDA >= GetDate() AND ");
            query.Append(" MAJCD = 'NON'          ");

            SqlCommand cmd = GetCommand(conn, query.ToString());

            try
            {
                conn.Open();
                DataTable data = new DataTable();
                SqlDataAdapter adapter = GetAdapter(cmd);
                adapter.Fill(data);
                data.TableName = "Group";
                return (Convert.ToInt16(data.Rows[0]["VALUE"]) == 0 ? false : true);
            }
            finally
            {
                conn.Close();
            }
        }

        //QUERY ASSET DOCUMENT
        public static int InsertPlantDocument(int OBJID, string PLNID, string DOTYP, string DOTNM, string DOCNO, string ANNOT, string FILE, string CHGUS)
        {
            SqlConnection conn = GetConnection();
            StringBuilder query = new StringBuilder();
            int _objid = OBJID == 0 ? GetPlantDocumentMaxObjectID() : OBJID;

            query.Append(" INSERT INTO asset.PLANT_DOCUMENT     ");
            query.Append(" (BEGDA, ENDDA, OBJID, PLNID,         ");
            query.Append("  DOTYP, DOTNM, DOCNO, ANNOT,         ");
            query.Append("  [FILE], CHGDT, CHGUS)               ");
            query.Append("  VALUES                              ");
            query.Append(" (GETDATE(), @ENDDA, @OBJID, @PLNID,  ");
            query.Append("  @DOTYP, @DOTNM, @DOCNO, @ANNOT,     ");
            query.Append("  @FILE, GETDATE(), @CHGUS)           ");

            SqlCommand cmd = GetCommand(conn, query.ToString());
            cmd.Parameters.Add(GetParameter("@ENDDA", GetMaxDate()));
            cmd.Parameters.Add(GetParameter("@OBJID", _objid));
            cmd.Parameters.Add(GetParameter("@PLNID", PLNID));
            cmd.Parameters.Add(GetParameter("@DOTYP", DOTYP));
            cmd.Parameters.Add(GetParameter("@DOTNM", DOTNM));
            cmd.Parameters.Add(GetParameter("@DOCNO", DOCNO));
            cmd.Parameters.Add(GetParameter("@ANNOT", ANNOT));
            cmd.Parameters.Add(GetParameter("@FILE", FILE));
            cmd.Parameters.Add(GetParameter("@CHGUS", CHGUS));

            try
            {
                conn.Open();
                cmd.ExecuteNonQuery();
                return _objid;
            }
            finally
            {
                conn.Close();
            }
        }

        public static void UpdatePlantDocument(int OBJID, string PLNID, string DOTYP, string DOTNM, string DOCNO, string ANNOT, string FILE, string CHGUS)
        {
            if (OBJID != 0)
            {
                DelimitPlantDocumentByID(OBJID.ToString(), CHGUS);
            }

            InsertPlantDocument(OBJID, PLNID, DOTYP, DOTNM, DOCNO, ANNOT, FILE, CHGUS);
        }

        public static void DelimitPlantDocumentByID(string OBJID, string CHGUS)
        {
            SqlConnection conn = GetConnection();
            StringBuilder query = new StringBuilder();

            query.Append(" UPDATE asset.PLANT_DOCUMENT  ");
            query.Append(" SET ENDDA = GETDATE(),       ");
            query.Append(" CHGDT = GETDATE(),           ");
            query.Append(" CHGUS = @CHGUS               ");
            query.Append(" WHERE OBJID = @OBJID AND     ");
            query.Append(" BEGDA <= GETDATE() AND       ");
            query.Append(" ENDDA >= GETDATE()           ");

            SqlCommand cmd = GetCommand(conn, query.ToString());
            cmd.Parameters.Add(GetParameter("@CHGUS", CHGUS));
            cmd.Parameters.Add(GetParameter("@OBJID", OBJID));

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

        public static void DelimitPlantDocumentByDocTypeID(string PLNID, string DOTYP, string CHGUS)
        {
            SqlConnection conn = GetConnection();
            StringBuilder query = new StringBuilder();

            query.Append(" UPDATE asset.PLANT_DOCUMENT  ");
            query.Append(" SET ENDDA = GETDATE(),       ");
            query.Append(" CHGDT = GETDATE(),           ");
            query.Append(" CHGUS = @CHGUS               ");
            query.Append(" WHERE PLNID = @PLNID AND     ");
            query.Append(" DOTYP = @DOTYP AND     ");
            query.Append(" BEGDA <= GETDATE() AND       ");
            query.Append(" ENDDA >= GETDATE()           ");

            SqlCommand cmd = GetCommand(conn, query.ToString());
            cmd.Parameters.Add(GetParameter("@CHGUS", CHGUS));
            cmd.Parameters.Add(GetParameter("@PLNID", PLNID));
            cmd.Parameters.Add(GetParameter("@DOTYP", DOTYP));

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

        public static void DelimitPlantDocumentByPlantID(string PLNID, string CHGUS)
        {
            SqlConnection conn = GetConnection();
            StringBuilder query = new StringBuilder();

            query.Append(" UPDATE asset.PLANT_DOCUMENT  ");
            query.Append(" SET ENDDA = GETDATE(),       ");
            query.Append(" CHGDT = GETDATE(),           ");
            query.Append(" CHGUS = @CHGUS               ");
            query.Append(" WHERE PLNID = @PLNID AND     ");
            query.Append(" BEGDA <= GETDATE() AND       ");
            query.Append(" ENDDA >= GETDATE()           ");

            SqlCommand cmd = GetCommand(conn, query.ToString());
            cmd.Parameters.Add(GetParameter("@CHGUS", CHGUS));
            cmd.Parameters.Add(GetParameter("@PLNID", PLNID));

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

        public static void DelimitPlantDocumentByDocumentType(string DOTYP, string CHGUS)
        {
            SqlConnection conn = GetConnection();
            StringBuilder query = new StringBuilder();

            query.Append(" UPDATE asset.PLANT_DOCUMENT  ");
            query.Append(" SET ENDDA = GETDATE(),       ");
            query.Append(" CHGDT = GETDATE(),           ");
            query.Append(" CHGUS = @CHGUS               ");
            query.Append(" WHERE DOTYP = @DOTYP AND     ");
            query.Append(" BEGDA <= GETDATE() AND       ");
            query.Append(" ENDDA >= GETDATE()           ");

            SqlCommand cmd = GetCommand(conn, query.ToString());
            cmd.Parameters.Add(GetParameter("@CHGUS", CHGUS));
            cmd.Parameters.Add(GetParameter("@DOTYP", DOTYP));

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

        public static void DeletePlantDocumentByID(string OBJID)
        {
            SqlConnection conn = GetConnection();
            StringBuilder query = new StringBuilder();

            query.Append(" DELETE FROM asset.PLANT_DOCUMENT ");
            query.Append(" WHERE OBJID = @OBJID AND         ");
            query.Append(" BEGDA <= GETDATE() AND           ");
            query.Append(" ENDDA >= GETDATE()               ");

            SqlCommand cmd = GetCommand(conn, query.ToString());
            cmd.Parameters.Add(GetParameter("@OBJID", OBJID));

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

        public static void DeletePlantDocumentByPlantID(string PLNID)
        {
            SqlConnection conn = GetConnection();
            StringBuilder query = new StringBuilder();

            query.Append(" DELETE FROM asset.PLANT_DOCUMENT ");
            query.Append(" WHERE PLNID = @PLNID AND         ");
            query.Append(" BEGDA <= GETDATE() AND           ");
            query.Append(" ENDDA >= GETDATE()               ");

            SqlCommand cmd = GetCommand(conn, query.ToString());
            cmd.Parameters.Add(GetParameter("@PLNID", PLNID));

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

        public static DataTable GetPlantDocuments()
        {
            SqlConnection conn = GetConnection();
            StringBuilder query = new StringBuilder();

            query.Append(" SELECT                       ");
            query.Append(" RECID, OBJID, PLNID, DOTYP,  ");
            query.Append(" DOTNM, DOCNO, ANNOT, [FILE]  ");
            query.Append(" FROM asset.PLANT_DOCUMENT    ");
            query.Append(" WHERE                        ");
            query.Append(" BEGDA <= GETDATE() AND       ");
            query.Append(" ENDDA >= GETDATE()           ");
            query.Append(" ORDER BY DOTNM               ");

            SqlCommand cmd = GetCommand(conn, query.ToString());

            try
            {
                conn.Open();
                DataTable data = new DataTable();
                SqlDataAdapter adapter = GetAdapter(cmd);
                adapter.Fill(data);
                data.TableName = "Document";
                return data;
            }
            finally
            {
                conn.Close();
            }
        }

        public static DataTable GetPlantDocumentByID(string OBJID)
        {
            SqlConnection conn = GetConnection();
            StringBuilder query = new StringBuilder();

            query.Append(" SELECT                       ");
            query.Append(" RECID, OBJID, PLNID, DOTYP,  ");
            query.Append(" DOTNM, DOCNO, ANNOT, FILE    ");
            query.Append(" FROM asset.PLANT_DOCUMENT    ");
            query.Append(" WHERE                        ");
            query.Append(" BEGDA <= GETDATE() AND       ");
            query.Append(" ENDDA >= GETDATE() AND       ");
            query.Append(" OBJID = @OBJID               ");

            SqlCommand cmd = GetCommand(conn, query.ToString());
            cmd.Parameters.Add(GetParameter("@OBJID", OBJID));

            try
            {
                conn.Open();
                DataTable data = new DataTable();
                SqlDataAdapter adapter = GetAdapter(cmd);
                adapter.Fill(data);
                data.TableName = "Document";
                return data;
            }
            finally
            {
                conn.Close();
            }
        }

        public static DataTable GetPlantDocumentByPlantID(string PLNID)
        {
            SqlConnection conn = GetConnection();
            StringBuilder query = new StringBuilder();

            query.Append(" SELECT                       ");
            query.Append(" RECID, OBJID, PLNID, DOTYP,  ");
            query.Append(" DOTNM, DOCNO, ANNOT, [FILE]  ");
            query.Append(" FROM asset.PLANT_DOCUMENT    ");
            query.Append(" WHERE                        ");
            query.Append(" BEGDA <= GETDATE() AND       ");
            query.Append(" ENDDA >= GETDATE() AND       ");
            query.Append(" PLNID = @PLNID               ");

            SqlCommand cmd = GetCommand(conn, query.ToString());
            cmd.Parameters.Add(GetParameter("@PLNID", PLNID));

            try
            {
                conn.Open();
                DataTable data = new DataTable();
                SqlDataAdapter adapter = GetAdapter(cmd);
                adapter.Fill(data);
                data.TableName = "Document";
                return data;
            }
            finally
            {
                conn.Close();
            }
        }

        //QUERY ASSET DEVIATION
        public static int InsertPlantDeviation(int OBJID, string PLNID, string DEVTY, string DEVNM, string DEVDT, string ANNOT, string CHGUS)
        {
            SqlConnection conn = GetConnection();
            StringBuilder query = new StringBuilder();
            int _objid = OBJID == 0 ? GetPlantDeviationMaxObjectID() : OBJID;

            query.Append(" INSERT INTO asset.PLANT_DEVIATION    ");
            query.Append(" (BEGDA, ENDDA, OBJID, PLNID,         ");
            query.Append("  DEVTY, DEVNM, DEVDT, ANNOT,         ");
            query.Append("  CHGDT, CHGUS)                       ");
            query.Append("  VALUES                              ");
            query.Append(" (GETDATE(), @ENDDA, @OBJID, @PLNID,  ");
            query.Append("  @DEVTY, @DEVNM, @DEVDT, @ANNOT,     ");
            query.Append("  GETDATE(), @CHGUS)                  ");

            SqlCommand cmd = GetCommand(conn, query.ToString());
            cmd.Parameters.Add(GetParameter("@ENDDA", GetMaxDate()));
            cmd.Parameters.Add(GetParameter("@OBJID", _objid));
            cmd.Parameters.Add(GetParameter("@PLNID", PLNID));
            cmd.Parameters.Add(GetParameter("@DEVTY", DEVTY));
            cmd.Parameters.Add(GetParameter("@DEVNM", DEVNM));
            cmd.Parameters.Add(GetParameter("@DEVDT", DEVDT));
            cmd.Parameters.Add(GetParameter("@ANNOT", ANNOT));
            cmd.Parameters.Add(GetParameter("@CHGUS", CHGUS));

            try
            {
                conn.Open();
                cmd.ExecuteNonQuery();
                return _objid;
            }
            finally
            {
                conn.Close();
            }
        }

        public static void UpdatePlantDeviation(int OBJID, string PLNID, string DEVTY, string DEVNM, string DEVDT, string ANNOT, string CHGUS)
        {
            if (OBJID != 0)
            {
                DelimitPlantDeviationByPlantID(OBJID.ToString(), CHGUS);
            }

            InsertPlantDeviation(OBJID, PLNID, DEVTY, DEVNM, DEVDT, ANNOT, CHGUS);
        }

        public static void DelimitPlantDeviationByPlantID(string PLNID, string CHGUS)
        {
            SqlConnection conn = GetConnection();
            StringBuilder query = new StringBuilder();

            query.Append(" UPDATE asset.PLANT_DEVIATION ");
            query.Append(" SET ENDDA = GETDATE(),       ");
            query.Append(" CHGDT = GETDATE(),           ");
            query.Append(" CHGUS = @CHGUS               ");
            query.Append(" WHERE PLNID = @PLNID AND     ");
            query.Append(" BEGDA <= GETDATE() AND       ");
            query.Append(" ENDDA >= GETDATE()           ");

            SqlCommand cmd = GetCommand(conn, query.ToString());
            cmd.Parameters.Add(GetParameter("@CHGUS", CHGUS));
            cmd.Parameters.Add(GetParameter("@PLNID", PLNID));

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

        public static void DeletePlantDeviationByPlantID(string PLNID)
        {
            SqlConnection conn = GetConnection();
            StringBuilder query = new StringBuilder();

            query.Append(" DELETE FROM asset.PLANT_DEVIATION ");
            query.Append(" WHERE PLNID = @PLNID AND          ");
            query.Append(" BEGDA <= GETDATE() AND            ");
            query.Append(" ENDDA >= GETDATE()                ");

            SqlCommand cmd = GetCommand(conn, query.ToString());
            cmd.Parameters.Add(GetParameter("@PLNID", PLNID));

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

        public static DataTable GetPlantDeviationByPlantID(string PLNID)
        {
            SqlConnection conn = GetConnection();
            StringBuilder query = new StringBuilder();

            query.Append(" SELECT                     ");
            query.Append(" RECID, OBJID, PLNID,       ");
            query.Append(" DEVTY, DEVNM, DEVDT,       ");
            query.Append(" ANNOT                      ");
            query.Append(" FROM asset.PLANT_DEVIATION ");
            query.Append(" WHERE                      ");
            query.Append(" BEGDA <= GETDATE() AND     ");
            query.Append(" ENDDA >= GETDATE() AND     ");
            query.Append(" PLNID = @PLNID             ");

            SqlCommand cmd = GetCommand(conn, query.ToString());
            cmd.Parameters.Add(GetParameter("@PLNID", PLNID));

            try
            {
                conn.Open();
                DataTable data = new DataTable();
                SqlDataAdapter adapter = GetAdapter(cmd);
                adapter.Fill(data);
                data.TableName = "Deviation";
                return data;
            }
            finally
            {
                conn.Close();
            }
        }

        //QUERY TASK GROUP
        public static int InsertTaskGroup(int OBJID, string TASK, string DESCR, string CHGUS)
        {
            SqlConnection conn = GetConnection();
            StringBuilder query = new StringBuilder();
            int _objid = OBJID == 0 ? GetTaskGroupMaxObjectID() : OBJID;

            query.Append(" INSERT INTO asset.TASK_GROUP         ");
            query.Append(" (BEGDA, ENDDA, OBJID,                ");
            query.Append(" TASK, DESCR, CHGDT, CHGUS)           ");
            query.Append("  VALUES                              ");
            query.Append(" (GETDATE(), @ENDDA, @OBJID,          ");
            query.Append(" @TASK, @DESCR, GETDATE(), @CHGUS)    ");

            SqlCommand cmd = GetCommand(conn, query.ToString());
            cmd.Parameters.Add(GetParameter("@ENDDA", GetMaxDate()));
            cmd.Parameters.Add(GetParameter("@OBJID", _objid));
            cmd.Parameters.Add(GetParameter("@TASK", TASK));
            cmd.Parameters.Add(GetParameter("@DESCR", DESCR));
            cmd.Parameters.Add(GetParameter("@CHGUS", CHGUS));

            try
            {
                conn.Open();
                cmd.ExecuteNonQuery();
                return _objid;
            }
            finally
            {
                conn.Close();
            }
        }

        public static void UpdateTaskGroup(int OBJID, string TASK, string DESCR, string CHGUS)
        {
            if (OBJID != 0)
            {
                DelimitTaskGroup(OBJID.ToString(), CHGUS);
            }

            InsertTaskGroup(OBJID, TASK, DESCR, CHGUS);
        }

        public static void DelimitTaskGroup(string OBJID, string CHGUS)
        {
            SqlConnection conn = GetConnection();
            StringBuilder query = new StringBuilder();

            query.Append(" UPDATE asset.TASK_GROUP  ");
            query.Append(" SET ENDDA = GETDATE(),   ");
            query.Append(" CHGDT = GETDATE(),       ");
            query.Append(" CHGUS = @CHGUS           ");
            query.Append(" WHERE OBJID = @OBJID AND ");
            query.Append(" BEGDA <= GETDATE() AND   ");
            query.Append(" ENDDA >= GETDATE()       ");

            SqlCommand cmd = GetCommand(conn, query.ToString());
            cmd.Parameters.Add(GetParameter("@CHGUS", CHGUS));
            cmd.Parameters.Add(GetParameter("@OBJID", OBJID));

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

        public static void DeleteTaskGroup(string OBJID)
        {
            SqlConnection conn = GetConnection();
            StringBuilder query = new StringBuilder();

            query.Append(" DELETE FROM asset.TASK_GROUP ");
            query.Append(" WHERE OBJID = @OBJID AND     ");
            query.Append(" BEGDA <= GETDATE() AND       ");
            query.Append(" ENDDA >= GETDATE()           ");

            SqlCommand cmd = GetCommand(conn, query.ToString());
            cmd.Parameters.Add(GetParameter("@OBJID", OBJID));

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

        public static DataTable GetTaskGroups()
        {
            SqlConnection conn = GetConnection();
            StringBuilder query = new StringBuilder();

            query.Append(" SELECT                    ");
            query.Append(" RECID, OBJID,             ");
            query.Append(" TASK, DESCR               ");  
            query.Append(" FROM asset.TASK_GROUP     ");
            query.Append(" WHERE                     ");
            query.Append(" BEGDA <= GETDATE() AND    ");
            query.Append(" ENDDA >= GETDATE()        ");
            query.Append(" ORDER BY TASK             ");

            SqlCommand cmd = GetCommand(conn, query.ToString());

            try
            {
                conn.Open();
                DataTable data = new DataTable();
                SqlDataAdapter adapter = GetAdapter(cmd);
                adapter.Fill(data);
                data.TableName = "Task Group";
                return data;
            }
            finally
            {
                conn.Close();
            }
        }

        public static DataTable GetTaskGroupByID(string OBJID)
        {
            SqlConnection conn = GetConnection();
            StringBuilder query = new StringBuilder();

            query.Append(" SELECT                   ");
            query.Append(" RECID, OBJID,            ");
            query.Append(" TASK, DESCR              ");
            query.Append(" FROM asset.TASK_GROUP    ");
            query.Append(" WHERE                    ");
            query.Append(" BEGDA <= GETDATE() AND   ");
            query.Append(" ENDDA >= GETDATE() AND   ");
            query.Append(" OBJID = @OBJID           ");

            SqlCommand cmd = GetCommand(conn, query.ToString());
            cmd.Parameters.Add(GetParameter("@OBJID", OBJID));

            try
            {
                conn.Open();
                DataTable data = new DataTable();
                SqlDataAdapter adapter = GetAdapter(cmd);
                adapter.Fill(data);
                data.TableName = "Task Group";
                return data;
            }
            finally
            {
                conn.Close();
            }
        }

        //QUERY TASK SCHEDULE
        public static int InsertTaskSchedule(int OBJID, string TSKID, string TASK, string STASK, string DESCR, string PERIO, string PUNIT, string CHGUS)
        {
            SqlConnection conn = GetConnection();
            StringBuilder query = new StringBuilder();
            int _objid = OBJID == 0 ? GetTaskScheduleMaxObjectID() : OBJID;

            query.Append(" INSERT INTO asset.TASK_SCHEDULE    ");
            query.Append(" (BEGDA, ENDDA, OBJID, TSKID,       "); 
            query.Append("  TASK, STASK, DESCR, PERIO,        ");
            query.Append("  PUNIT, CHGDT, CHGUS)              ");
            query.Append("  VALUES                            ");
            query.Append(" (GETDATE(), @ENDDA, @OBJID, @TSKID,");
            query.Append("  @TASK, @STASK, @DESCR, @PERIO,    ");
            query.Append("  @PUNIT, GETDATE(), @CHGUS)        ");

            SqlCommand cmd = GetCommand(conn, query.ToString());
            cmd.Parameters.Add(GetParameter("@ENDDA", GetMaxDate()));
            cmd.Parameters.Add(GetParameter("@OBJID", _objid));
            cmd.Parameters.Add(GetParameter("@TSKID", TSKID));
            cmd.Parameters.Add(GetParameter("@TASK", TASK));
            cmd.Parameters.Add(GetParameter("@STASK", STASK));
            cmd.Parameters.Add(GetParameter("@DESCR", DESCR));
            cmd.Parameters.Add(GetParameter("@PERIO", PERIO));
            cmd.Parameters.Add(GetParameter("@PUNIT", PUNIT));
            cmd.Parameters.Add(GetParameter("@CHGUS", CHGUS));

            try
            {
                conn.Open();
                cmd.ExecuteNonQuery();
                return _objid;
            }
            finally
            {
                conn.Close();
            }
        }

        public static void UpdateTaskSchedule(int OBJID, string TSKID, string TASK, string STASK, string DESCR, string PERIO, string PUNIT, string CHGUS)
        {
            if (OBJID != 0)
            {
                DelimitTaskSchedule(OBJID.ToString(), CHGUS);
            }

            InsertTaskSchedule(OBJID, TSKID, TASK, STASK, DESCR, PERIO, PUNIT, CHGUS);
        }

        public static void DelimitTaskSchedule(string OBJID, string CHGUS)
        {
            SqlConnection conn = GetConnection();
            StringBuilder query = new StringBuilder();

            query.Append(" UPDATE asset.TASK_SCHEDULE   ");
            query.Append(" SET ENDDA = GETDATE(),       ");
            query.Append(" CHGDT = GETDATE(),           ");
            query.Append(" CHGUS = @CHGUS               ");
            query.Append(" WHERE OBJID = @OBJID AND     ");
            query.Append(" BEGDA <= GETDATE() AND       ");
            query.Append(" ENDDA >= GETDATE()           ");

            SqlCommand cmd = GetCommand(conn, query.ToString());
            cmd.Parameters.Add(GetParameter("@CHGUS", CHGUS));
            cmd.Parameters.Add(GetParameter("@OBJID", OBJID));

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

        public static void DeleteTaskSchedule(string OBJID)
        {
            SqlConnection conn = GetConnection();
            StringBuilder query = new StringBuilder();

            query.Append(" DELETE FROM asset.TASK_SCHEDULE  ");
            query.Append(" WHERE OBJID = @OBJID AND         ");
            query.Append(" BEGDA <= GETDATE() AND           ");
            query.Append(" ENDDA >= GETDATE()               ");

            SqlCommand cmd = GetCommand(conn, query.ToString());
            cmd.Parameters.Add(GetParameter("@OBJID", OBJID));

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

        public static DataTable GetTaskSchedules()
        {
            SqlConnection conn = GetConnection();
            StringBuilder query = new StringBuilder();

            query.Append(" SELECT                       ");
            query.Append(" RECID, OBJID, TSKID, TASK,   ");
            query.Append(" STASK, DESCR, PERIO, PUNIT   ");
            query.Append(" FROM asset.TASK_SCHEDULE     ");
            query.Append(" WHERE                        ");
            query.Append(" BEGDA <= GETDATE() AND       ");
            query.Append(" ENDDA >= GETDATE()           ");
            query.Append(" ORDER BY STASK               ");

            SqlCommand cmd = GetCommand(conn, query.ToString());

            try
            {
                conn.Open();
                DataTable data = new DataTable();
                SqlDataAdapter adapter = GetAdapter(cmd);
                adapter.Fill(data);
                data.TableName = "Task Schedule";
                return data;
            }
            finally
            {
                conn.Close();
            }
        }

        public static DataTable GetTaskScheduleByID(string OBJID)
        {
            SqlConnection conn = GetConnection();
            StringBuilder query = new StringBuilder();

            query.Append(" SELECT                       ");
            query.Append(" RECID, OBJID, TSKID, TASK,   ");
            query.Append(" STASK, DESCR, PERIO, PUNIT   ");
            query.Append(" FROM asset.TASK_SCHEDULE     ");
            query.Append(" WHERE                        ");
            query.Append(" BEGDA <= GETDATE() AND       ");
            query.Append(" ENDDA >= GETDATE() AND       ");
            query.Append(" OBJID = @OBJID               ");

            SqlCommand cmd = GetCommand(conn, query.ToString());
            cmd.Parameters.Add(GetParameter("@OBJID", OBJID));

            try
            {
                conn.Open();
                DataTable data = new DataTable();
                SqlDataAdapter adapter = GetAdapter(cmd);
                adapter.Fill(data);
                data.TableName = "Task Schedule";
                return data;
            }
            finally
            {
                conn.Close();
            }
        }

        public static DataTable GetTaskScheduleByTaskGroup(string TSKID)
        {
            SqlConnection conn = GetConnection();
            StringBuilder query = new StringBuilder();

            query.Append(" SELECT                       ");
            query.Append(" RECID, OBJID, TSKID, TASK,   ");
            query.Append(" STASK, DESCR, PERIO, PUNIT   ");
            query.Append(" FROM asset.TASK_SCHEDULE     ");
            query.Append(" WHERE                        ");
            query.Append(" BEGDA <= GETDATE() AND       ");
            query.Append(" ENDDA >= GETDATE() AND       ");
            query.Append(" TSKID = @TSKID               ");

            SqlCommand cmd = GetCommand(conn, query.ToString());
            cmd.Parameters.Add(GetParameter("@TSKID", TSKID));

            try
            {
                conn.Open();
                DataTable data = new DataTable();
                SqlDataAdapter adapter = GetAdapter(cmd);
                adapter.Fill(data);
                data.TableName = "Task Schedule";
                return data;
            }
            finally
            {
                conn.Close();
            }
        }

        //QUERY PLANT MAINTENANCE
        public static int InsertPlantMaintenance(int OBJID, string PLNID, string TSKID, string TASK, string STKID, string STASK, string PERIO, string PUNIT, string LASTM, string PLANM, string CHGUS)
        {
            SqlConnection conn = GetConnection();
            StringBuilder query = new StringBuilder();
            int _objid = OBJID == 0 ? GetPlantMaintenanceMaxObjectID() : OBJID;

            query.Append(" INSERT INTO asset.PLANT_MAINTENANCE  ");
            query.Append(" (BEGDA, ENDDA, OBJID,                ");
            query.Append("  PLNID, TSKID, STASK, TASK, STKID,   ");
            query.Append("  PERIO, PUNIT, LASTM,                ");
            query.Append("  PLANM, CHGDT, CHGUS)                ");
            query.Append("  VALUES                              ");
            query.Append(" (GETDATE(), @ENDDA, @OBJID,          ");
            query.Append("  @PLNID, @TSKID, @STASK, @TASK,      ");
            query.Append("  @STKID, @PERIO, @PUNIT, @LASTM,     ");
            query.Append("  @PLANM, GETDATE(), @CHGUS)          ");

            SqlCommand cmd = GetCommand(conn, query.ToString());
            cmd.Parameters.Add(GetParameter("@ENDDA", GetMaxDate()));
            cmd.Parameters.Add(GetParameter("@OBJID", _objid));
            cmd.Parameters.Add(GetParameter("@PLNID", PLNID));
            cmd.Parameters.Add(GetParameter("@TSKID", TSKID));
            cmd.Parameters.Add(GetParameter("@TASK", TASK));
            cmd.Parameters.Add(GetParameter("@STKID", STKID));
            cmd.Parameters.Add(GetParameter("@STASK", STASK));
            cmd.Parameters.Add(GetParameter("@PERIO", PERIO));
            cmd.Parameters.Add(GetParameter("@PUNIT", PUNIT));
            cmd.Parameters.Add(GetParameter("@LASTM", LASTM));
            cmd.Parameters.Add(GetParameter("@PLANM", PLANM));
            cmd.Parameters.Add(GetParameter("@CHGUS", CHGUS));

            try
            {
                conn.Open();
                cmd.ExecuteNonQuery();
                return _objid;
            }
            finally
            {
                conn.Close();
            }
        }

        public static void UpdatePlantMaintenance(int OBJID, string PLNID, string TSKID, string TASK, string STKID, string STASK, string PERIO, string PUNIT, string LASTM, string PLANM, string CHGUS)
        {
            if (OBJID != 0)
            {
                DelimitPlantMaintenance(OBJID.ToString(), CHGUS);
            }

            InsertPlantMaintenance(OBJID, PLNID, TSKID, TASK, STKID, STASK, PERIO, PUNIT, LASTM, PLANM, CHGUS);
        }

        public static int InsertPlantMaintenanceSchedule(int OBJID, string PLNID, string TSKID, string TASK, string STKID, string STASK, string PERIO, string PUNIT, string CHGUS)
        {
            SqlConnection conn = GetConnection();
            StringBuilder query = new StringBuilder();
            int _objid = OBJID == 0 ? GetPlantMaintenanceMaxObjectID() : OBJID;

            if (PUNIT.ToLower() == "hari")
            {
                query.Append(" INSERT INTO asset.PLANT_MAINTENANCE                           ");
                query.Append(" (BEGDA, ENDDA, OBJID,                                         ");
                query.Append("  PLNID, TSKID, STASK, TASK, STKID,                            ");
                query.Append("  PERIO, PUNIT, LASTM,                                         ");
                query.Append("  PLANM, CHGDT, CHGUS)                                         ");
                query.Append("  VALUES                                                       ");
                query.Append(" (GETDATE(), @ENDDA, @OBJID,                                   ");
                query.Append("  @PLNID, @TSKID, @STASK, @TASK,                               ");
                query.Append("  @STKID, @PERIO, @PUNIT,                                      ");
                query.Append("  GETDATE(), (SELECT DATEADD(DAY,@PERIO,CURRENT_TIMESTAMP)), ");
                query.Append("  GETDATE(), @CHGUS)                                           ");
            }
            else if (PUNIT.ToLower() == "minggu")
            {
                query.Append(" INSERT INTO asset.PLANT_MAINTENANCE                           ");
                query.Append(" (BEGDA, ENDDA, OBJID,                                         ");
                query.Append("  PLNID, TSKID, STASK, TASK, STKID,                            ");
                query.Append("  PERIO, PUNIT, LASTM,                                         ");
                query.Append("  PLANM, CHGDT, CHGUS)                                         ");
                query.Append("  VALUES                                                       ");
                query.Append(" (GETDATE(), @ENDDA, @OBJID,                                   ");
                query.Append("  @PLNID, @TSKID, @STASK, @TASK,                               ");
                query.Append("  @STKID, @PERIO, @PUNIT,                                      ");
                query.Append("  GETDATE(), (SELECT DATEADD(WEEK,@PERIO,CURRENT_TIMESTAMP)), ");
                query.Append("  GETDATE(), @CHGUS)                                           ");
            }
            else if (PUNIT.ToLower() == "bulan")
            {
                query.Append(" INSERT INTO asset.PLANT_MAINTENANCE                           ");
                query.Append(" (BEGDA, ENDDA, OBJID,                                         ");
                query.Append("  PLNID, TSKID, STASK, TASK, STKID,                            ");
                query.Append("  PERIO, PUNIT, LASTM,                                         ");
                query.Append("  PLANM, CHGDT, CHGUS)                                         ");
                query.Append("  VALUES                                                       ");
                query.Append(" (GETDATE(), @ENDDA, @OBJID,                                   ");
                query.Append("  @PLNID, @TSKID, @STASK, @TASK,                               ");
                query.Append("  @STKID, @PERIO, @PUNIT,                                      ");
                query.Append("  GETDATE(), (SELECT DATEADD(MONTH,@PERIO,CURRENT_TIMESTAMP)), ");
                query.Append("  GETDATE(), @CHGUS)                                           ");
            }
            else
            {
                query.Append(" INSERT INTO asset.PLANT_MAINTENANCE                           ");
                query.Append(" (BEGDA, ENDDA, OBJID,                                         ");
                query.Append("  PLNID, TSKID, STASK, TASK, STKID,                            ");
                query.Append("  PERIO, PUNIT, LASTM,                                         ");
                query.Append("  PLANM, CHGDT, CHGUS)                                         ");
                query.Append("  VALUES                                                       ");
                query.Append(" (GETDATE(), @ENDDA, @OBJID,                                   ");
                query.Append("  @PLNID, @TSKID, @STASK, @TASK,                               ");
                query.Append("  @STKID, @PERIO, @PUNIT,                                      ");
                query.Append("  GETDATE(), (SELECT DATEADD(YEAR,@PERIO,CURRENT_TIMESTAMP)),  ");
                query.Append("  GETDATE(), @CHGUS)                                           ");
            }

            SqlCommand cmd = GetCommand(conn, query.ToString());
            cmd.Parameters.Add(GetParameter("@ENDDA", GetMaxDate()));
            cmd.Parameters.Add(GetParameter("@OBJID", _objid));
            cmd.Parameters.Add(GetParameter("@PLNID", PLNID));
            cmd.Parameters.Add(GetParameter("@TSKID", TSKID));
            cmd.Parameters.Add(GetParameter("@TASK", TASK));
            cmd.Parameters.Add(GetParameter("@STKID", STKID));
            cmd.Parameters.Add(GetParameter("@STASK", STASK));
            cmd.Parameters.Add(GetParameter("@PERIO", Convert.ToInt32(PERIO)));
            cmd.Parameters.Add(GetParameter("@PUNIT", PUNIT));
            cmd.Parameters.Add(GetParameter("@CHGUS", CHGUS));

            try
            {
                conn.Open();
                cmd.ExecuteNonQuery();
                return _objid;
            }
            finally
            {
                conn.Close();
            }
        }

        public static void UpdatePlantMaintenanceSchedule(int OBJID, string PLNID, string TSKID, string TASK, string STKID, string STASK, string PERIO, string PUNIT, string CHGUS)
        {
            if (OBJID != 0)
            {
                DelimitPlantMaintenance(OBJID.ToString(), CHGUS);
            }

            InsertPlantMaintenanceSchedule(OBJID, PLNID, TSKID, TASK, STKID, STASK, PERIO, PUNIT, CHGUS);
        }

        public static void DelimitPlantMaintenance(string OBJID, string CHGUS)
        {
            SqlConnection conn = GetConnection();
            StringBuilder query = new StringBuilder();

            query.Append(" UPDATE asset.PLANT_MAINTENANCE   ");
            query.Append(" SET ENDDA = GETDATE(),           ");
            query.Append(" CHGDT = GETDATE(),               ");
            query.Append(" CHGUS = @CHGUS                   ");
            query.Append(" WHERE OBJID = @OBJID AND         ");
            query.Append(" BEGDA <= GETDATE() AND           ");
            query.Append(" ENDDA >= GETDATE()               ");

            SqlCommand cmd = GetCommand(conn, query.ToString());
            cmd.Parameters.Add(GetParameter("@CHGUS", CHGUS));
            cmd.Parameters.Add(GetParameter("@OBJID", OBJID));

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

        public static void DelimitPlantMaintenanceByPlantID(string PLNID, string CHGUS)
        {
            SqlConnection conn = GetConnection();
            StringBuilder query = new StringBuilder();

            query.Append(" UPDATE asset.PLANT_MAINTENANCE   ");
            query.Append(" SET ENDDA = GETDATE(),           ");
            query.Append(" CHGDT = GETDATE(),               ");
            query.Append(" CHGUS = @CHGUS                   ");
            query.Append(" WHERE PLNID = @PLNID AND         ");
            query.Append(" BEGDA <= GETDATE() AND           ");
            query.Append(" ENDDA >= GETDATE()               ");

            SqlCommand cmd = GetCommand(conn, query.ToString());
            cmd.Parameters.Add(GetParameter("@CHGUS", CHGUS));
            cmd.Parameters.Add(GetParameter("@PLNID", PLNID));

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

        public static void DeletePlantMaintenance(string OBJID)
        {
            SqlConnection conn = GetConnection();
            StringBuilder query = new StringBuilder();

            query.Append(" DELETE FROM asset.PLANT_MAINTENANCE  ");
            query.Append(" WHERE OBJID = @OBJID AND             ");
            query.Append(" BEGDA <= GETDATE() AND               ");
            query.Append(" ENDDA >= GETDATE()                   ");

            SqlCommand cmd = GetCommand(conn, query.ToString());
            cmd.Parameters.Add(GetParameter("@OBJID", OBJID));

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

        public static void DeletePlantMaintenanceByPlantID(string PLNID)
        {
            SqlConnection conn = GetConnection();
            StringBuilder query = new StringBuilder();

            query.Append(" DELETE FROM asset.PLANT_MAINTENANCE  ");
            query.Append(" WHERE PLNID = @PLNID AND             ");
            query.Append(" BEGDA <= GETDATE() AND               ");
            query.Append(" ENDDA >= GETDATE()                   ");

            SqlCommand cmd = GetCommand(conn, query.ToString());
            cmd.Parameters.Add(GetParameter("@PLNID", PLNID));

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

        public static DataTable GetPlantMaintenances()
        {
            SqlConnection conn = GetConnection();
            StringBuilder query = new StringBuilder();

            query.Append(" SELECT                               ");
            query.Append(" M.RECID, M.OBJID, M.PLNID,           ");
            query.Append(" P.PLNNM, P.PLNCD, M.TSKID,           ");
            query.Append(" M.TASK, M.STKID, M.STASK,            ");
            query.Append(" M.PERIO, M.PUNIT, M.LASTM,           ");
            query.Append(" M.PLANM                              ");
            query.Append(" FROM asset.PLANT_MAINTENANCE M JOIN  ");
            query.Append(" asset.PLANT_MASTER P ON              ");
            query.Append(" M.PLNID = P.OBJID AND                ");
            query.Append(" M.BEGDA <= GETDATE() AND             ");
            query.Append(" M.ENDDA >= GETDATE() AND             ");
            query.Append(" P.BEGDA <= GETDATE() AND             ");
            query.Append(" P.ENDDA >= GETDATE()                 ");  
            query.Append(" ORDER BY LASTM                       ");

            SqlCommand cmd = GetCommand(conn, query.ToString());

            try
            {
                conn.Open();
                DataTable data = new DataTable();
                SqlDataAdapter adapter = GetAdapter(cmd);
                adapter.Fill(data);
                data.TableName = "Maintenance";
                return data;
            }
            finally
            {
                conn.Close();
            }
        }

        public static DataTable GetPlantMaintenanceHistoryByOrganizationCode(string ORGCD)
        {
            SqlConnection conn = GetConnection();
            StringBuilder query = new StringBuilder();

            query.Append(" SELECT                               ");
            query.Append(" M.RECID, M.OBJID, M.PLNID,           ");
            query.Append(" P.PLNNM, P.PLNCD, M.TSKID,           ");
            query.Append(" M.TASK, M.STKID, M.STASK,            ");
            query.Append(" M.PERIO, M.PUNIT, M.LASTM,           ");
            query.Append(" M.PLANM, P.ORGNM                     ");
            query.Append(" FROM asset.PLANT_MAINTENANCE M JOIN  ");
            query.Append(" asset.PLANT_MASTER P ON              ");
            query.Append(" M.PLNID = P.OBJID AND                ");
            query.Append(" P.BEGDA <= GETDATE() AND             ");
            query.Append(" P.ENDDA >= GETDATE() AND             ");
            query.Append(" P.ORGCD = @ORGCD                     ");
            query.Append(" ORDER BY TASK, STASK, LASTM          ");

            SqlCommand cmd = GetCommand(conn, query.ToString());
            cmd.Parameters.Add(GetParameter("@ORGCD", ORGCD));

            try
            {
                conn.Open();
                DataTable data = new DataTable();
                SqlDataAdapter adapter = GetAdapter(cmd);
                adapter.Fill(data);
                data.TableName = "Maintenance";
                return data;
            }
            finally
            {
                conn.Close();
            }
        }

        public static DataTable GetPlantMaintenanceHistorybyPlantID(string PLNID)
        {
            SqlConnection conn = GetConnection();
            StringBuilder query = new StringBuilder();

            query.Append(" SELECT                               ");
            query.Append(" M.RECID, M.OBJID, M.PLNID,           ");
            query.Append(" P.PLNNM, P.PLNCD, M.TSKID,           ");
            query.Append(" M.TASK, M.STKID, M.STASK,            ");
            query.Append(" M.PERIO, M.PUNIT, M.LASTM,           ");
            query.Append(" M.PLANM, P.ORGNM                     ");
            query.Append(" FROM asset.PLANT_MAINTENANCE M JOIN  ");
            query.Append(" asset.PLANT_MASTER P ON              ");
            query.Append(" M.PLNID = P.OBJID AND                ");
            query.Append(" P.BEGDA <= GETDATE() AND             ");
            query.Append(" P.ENDDA >= GETDATE() AND             ");
            query.Append(" M.PLNID = @PLNID                     ");
            query.Append(" ORDER BY TASK, STASK, LASTM          ");

            SqlCommand cmd = GetCommand(conn, query.ToString());
            cmd.Parameters.Add(GetParameter("@PLNID", PLNID));

            try
            {
                conn.Open();
                DataTable data = new DataTable();
                SqlDataAdapter adapter = GetAdapter(cmd);
                adapter.Fill(data);
                data.TableName = "Maintenance";
                return data;
            }
            finally
            {
                conn.Close();
            }
        }

        public static DataTable GetPlantMaintenanceHistorybyPlantID(string PLNID, DateTime BEGDA, DateTime ENDDA)
        {
            SqlConnection conn = GetConnection();
            StringBuilder query = new StringBuilder();

            query.Append(" SELECT                               ");
            query.Append(" M.RECID, M.OBJID, M.PLNID,           ");
            query.Append(" P.PLNNM, P.PLNCD, M.TSKID,           ");
            query.Append(" M.TASK, M.STKID, M.STASK,            ");
            query.Append(" M.PERIO, M.PUNIT, M.LASTM,           ");
            query.Append(" M.PLANM, P.ORGNM                     ");
            query.Append(" FROM asset.PLANT_MAINTENANCE M JOIN  ");
            query.Append(" asset.PLANT_MASTER P ON              ");
            query.Append(" M.PLNID = P.OBJID AND                ");
            query.Append(" P.BEGDA <= GETDATE() AND             ");
            query.Append(" P.ENDDA >= GETDATE() AND             ");
            query.Append(" M.LASTM >= @BEGDA AND                ");
            query.Append(" M.LASTM <= @ENDDA AND                ");
            query.Append(" M.PLNID = @PLNID                     ");
            query.Append(" ORDER BY TASK, STASK, LASTM          ");

            SqlCommand cmd = GetCommand(conn, query.ToString());
            cmd.Parameters.Add(GetParameter("@PLNID", PLNID));
            cmd.Parameters.Add(GetParameter("@PLNID", BEGDA));
            cmd.Parameters.Add(GetParameter("@PLNID", ENDDA));

            try
            {
                conn.Open();
                DataTable data = new DataTable();
                SqlDataAdapter adapter = GetAdapter(cmd);
                adapter.Fill(data);
                data.TableName = "Maintenance";
                return data;
            }
            finally
            {
                conn.Close();
            }
        }

        public static DataTable GetPlantMaintenanceByOrganizationCode(string ORGCD)
        {
            SqlConnection conn = GetConnection();
            StringBuilder query = new StringBuilder();

            query.Append(" SELECT                               ");
            query.Append(" M.RECID, M.OBJID, M.PLNID,           ");
            query.Append(" P.PLNNM, P.PLNCD, M.TSKID,           ");
            query.Append(" M.TASK, M.STKID, M.STASK,            ");
            query.Append(" M.PERIO, M.PUNIT, M.LASTM,           ");
            query.Append(" M.PLANM                              ");
            query.Append(" FROM asset.PLANT_MAINTENANCE M JOIN  ");
            query.Append(" asset.PLANT_MASTER P ON              ");
            query.Append(" M.PLNID = P.OBJID AND                ");
            query.Append(" M.BEGDA <= GETDATE() AND             ");
            query.Append(" M.ENDDA >= GETDATE() AND             ");
            query.Append(" P.BEGDA <= GETDATE() AND             ");
            query.Append(" P.ENDDA >= GETDATE() AND             ");
            query.Append(" P.ORGCD = @ORGCD                     ");

            SqlCommand cmd = GetCommand(conn, query.ToString());
            cmd.Parameters.Add(GetParameter("@ORGCD", ORGCD));

            try
            {
                conn.Open();
                DataTable data = new DataTable();
                SqlDataAdapter adapter = GetAdapter(cmd);
                adapter.Fill(data);
                data.TableName = "Maintenance";
                return data;
            }
            finally
            {
                conn.Close();
            }
        }

        public static DataTable GetPlantMaintenanceByPlantID(string PLNID)
        {
            SqlConnection conn = GetConnection();
            StringBuilder query = new StringBuilder();

            query.Append(" SELECT                               ");
            query.Append(" M.RECID, M.OBJID, M.PLNID,           ");
            query.Append(" P.PLNNM, P.PLNCD, M.TSKID,           ");
            query.Append(" M.TASK, M.STKID, M.STASK,            ");
            query.Append(" M.PERIO, M.PUNIT, M.LASTM,           ");
            query.Append(" M.PLANM                              ");
            query.Append(" FROM asset.PLANT_MAINTENANCE M JOIN  ");
            query.Append(" asset.PLANT_MASTER P ON              ");
            query.Append(" M.PLNID = P.OBJID AND                ");
            query.Append(" M.BEGDA <= GETDATE() AND             ");
            query.Append(" M.ENDDA >= GETDATE() AND             ");
            query.Append(" P.BEGDA <= GETDATE() AND             ");
            query.Append(" P.ENDDA >= GETDATE() AND             ");
            query.Append(" M.PLNID = @PLNID                     ");

            SqlCommand cmd = GetCommand(conn, query.ToString());
            cmd.Parameters.Add(GetParameter("@PLNID", PLNID));

            try
            {
                conn.Open();
                DataTable data = new DataTable();
                SqlDataAdapter adapter = GetAdapter(cmd);
                adapter.Fill(data);
                data.TableName = "Maintenance";
                return data;
            }
            finally
            {
                conn.Close();
            }
        }

        public static DataTable GetPlantMaintenanceByID(string OBJID)
        {
            SqlConnection conn = GetConnection();
            StringBuilder query = new StringBuilder();

            query.Append(" SELECT                               ");
            query.Append(" M.RECID, M.OBJID, M.PLNID,           ");
            query.Append(" P.PLNNM, P.PLNCD, M.TSKID,           ");
            query.Append(" M.TASK, M.STKID, M.STASK,            ");
            query.Append(" M.PERIO, M.PUNIT, M.LASTM,           ");
            query.Append(" M.PLANM                              ");
            query.Append(" FROM asset.PLANT_MAINTENANCE M JOIN  ");
            query.Append(" asset.PLANT_MASTER P ON              ");
            query.Append(" M.PLNID = P.OBJID AND                ");
            query.Append(" M.BEGDA <= GETDATE() AND             ");
            query.Append(" M.ENDDA >= GETDATE() AND             ");
            query.Append(" P.BEGDA <= GETDATE() AND             ");
            query.Append(" P.ENDDA >= GETDATE() AND             ");
            query.Append(" M.OBJID = @OBJID                     ");

            SqlCommand cmd = GetCommand(conn, query.ToString());
            cmd.Parameters.Add(GetParameter("@OBJID", OBJID));

            try
            {
                conn.Open();
                DataTable data = new DataTable();
                SqlDataAdapter adapter = GetAdapter(cmd);
                adapter.Fill(data);
                data.TableName = "Maintenance";
                return data;
            }
            finally
            {
                conn.Close();
            }
        }

        //QUERY PLANT RELATION
        public static int InsertPlantRelation(int OBJID, string PARNT, string CHILD, string CHGUS)
        {
            SqlConnection conn = GetConnection();
            StringBuilder query = new StringBuilder();
            int _objid = OBJID == 0 ? GetPlantRelationMaxObjectID() : OBJID;

            query.Append(" INSERT INTO asset.PLANT_RELATION     ");
            query.Append(" (BEGDA, ENDDA, OBJID,                ");
            query.Append("  PARNT, CHILD, CHGDT, CHGUS)         ");
            query.Append("  VALUES                              ");
            query.Append(" (GETDATE(), @ENDDA, @OBJID,          ");
            query.Append("  @PARNT, @CHILD, GETDATE(), @CHGUS)  ");

            SqlCommand cmd = GetCommand(conn, query.ToString());
            cmd.Parameters.Add(GetParameter("@ENDDA", GetMaxDate()));
            cmd.Parameters.Add(GetParameter("@OBJID", _objid));
            cmd.Parameters.Add(GetParameter("@PARNT", PARNT));
            cmd.Parameters.Add(GetParameter("@CHILD", CHILD));
            cmd.Parameters.Add(GetParameter("@CHGUS", CHGUS));

            try
            {
                conn.Open();
                cmd.ExecuteNonQuery();
                return _objid;
            }
            finally
            {
                conn.Close();
            }
        }

        public static void UpdatePlantRelation(int OBJID, string PARNT, string CHILD, string CHGUS)
        {
            if (OBJID != 0)
            {
                DelimitPlantRelation(OBJID.ToString(), CHGUS);
            }

            InsertPlantRelation(OBJID, PARNT, CHILD, CHGUS);
        }

        public static void DelimitPlantRelation(string CHILD, string CHGUS)
        {
            SqlConnection conn = GetConnection();
            StringBuilder query = new StringBuilder();

            query.Append(" UPDATE asset.PLANT_RELATION  ");
            query.Append(" SET ENDDA = GETDATE(),       ");
            query.Append(" CHGDT = GETDATE(),           ");
            query.Append(" CHGUS = @CHGUS               ");
            query.Append(" WHERE CHILD = @CHILD AND     ");
            query.Append(" BEGDA <= GETDATE() AND       ");
            query.Append(" ENDDA >= GETDATE()           ");

            SqlCommand cmd = GetCommand(conn, query.ToString());
            cmd.Parameters.Add(GetParameter("@CHILD", CHILD));
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

        public static void DeletePlantRelation(string OBJID)
        {
            SqlConnection conn = GetConnection();
            StringBuilder query = new StringBuilder();

            query.Append(" DELETE FROM asset.PLANT_RELATION ");
            query.Append(" WHERE OBJID = @OBJID AND         ");
            query.Append(" BEGDA <= GETDATE() AND           ");
            query.Append(" ENDDA >= GETDATE()               ");

            SqlCommand cmd = GetCommand(conn, query.ToString());
            cmd.Parameters.Add(GetParameter("@OBJID", OBJID));

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

        public static DataTable GetPlantRelations()
        {
            SqlConnection conn = GetConnection();
            StringBuilder query = new StringBuilder();

            query.Append(" SELECT                       ");
            query.Append(" RECID, OBJID,                ");
            query.Append(" PARNT, CHILD                 ");
            query.Append(" FROM asset.PLANT_RELATION    ");
            query.Append(" WHERE                        ");
            query.Append(" BEGDA <= GETDATE() AND       ");
            query.Append(" ENDDA >= GETDATE()           ");
            query.Append(" ORDER BY CHILD               ");

            SqlCommand cmd = GetCommand(conn, query.ToString());

            try
            {
                conn.Open();
                DataTable data = new DataTable();
                SqlDataAdapter adapter = GetAdapter(cmd);
                adapter.Fill(data);
                data.TableName = "Relation";
                return data;
            }
            finally
            {
                conn.Close();
            }
        }

        public static DataTable GetPlantRelationByID(string OBJID)
        {
            SqlConnection conn = GetConnection();
            StringBuilder query = new StringBuilder();

            query.Append(" SELECT                       ");
            query.Append(" RECID, OBJID,                ");
            query.Append(" PARNT, CHILD                 ");
            query.Append(" FROM asset.PLANT_RELATION    ");
            query.Append(" WHERE                        ");
            query.Append(" BEGDA <= GETDATE() AND       ");
            query.Append(" ENDDA >= GETDATE() AND       ");
            query.Append(" OBJID = @OBJID               ");

            SqlCommand cmd = GetCommand(conn, query.ToString());
            cmd.Parameters.Add(GetParameter("@OBJID", OBJID));

            try
            {
                conn.Open();
                DataTable data = new DataTable();
                SqlDataAdapter adapter = GetAdapter(cmd);
                adapter.Fill(data);
                data.TableName = "Relation";
                return data;
            }
            finally
            {
                conn.Close();
            }
        }

        //QUERY ASSET IMAGE
        public static int InsertAssetImage(int OBJID, string PLNID, string IMAGE, string CHGUS)
        {
            SqlConnection conn = GetConnection();
            StringBuilder query = new StringBuilder();
            int _objid = OBJID == 0 ? GetAssetImageMaxObjectID() : OBJID;

            query.Append(" INSERT INTO asset.PLANT_IMAGE        ");
            query.Append(" (BEGDA, ENDDA, OBJID,                ");
            query.Append("  PLNID, IMAGE, CHGDT, CHGUS)         ");
            query.Append("  VALUES                              ");
            query.Append(" (GETDATE(), @ENDDA, @OBJID,          ");
            query.Append("  @PLNID, @IMAGE, GETDATE(), @CHGUS)  ");

            SqlCommand cmd = GetCommand(conn, query.ToString());
            cmd.Parameters.Add(GetParameter("@ENDDA", GetMaxDate()));
            cmd.Parameters.Add(GetParameter("@OBJID", _objid));
            cmd.Parameters.Add(GetParameter("@PLNID", PLNID));
            cmd.Parameters.Add(GetParameter("@IMAGE", IMAGE));
            cmd.Parameters.Add(GetParameter("@CHGUS", CHGUS));

            try
            {
                conn.Open();
                cmd.ExecuteNonQuery();
                return _objid;
            }
            finally
            {
                conn.Close();
            }
        }

        public static void UpdateAssetImage(int OBJID, string PLNID, string IMAGE, string CHGUS)
        {
            if (OBJID != 0)
            {
                DelimitAssetImage(OBJID.ToString(), CHGUS);
            }

            InsertAssetImage(OBJID, PLNID, IMAGE, CHGUS);
        }

        public static void DelimitAssetImage(string OBJID, string CHGUS)
        {
            SqlConnection conn = GetConnection();
            StringBuilder query = new StringBuilder();

            query.Append(" UPDATE asset.PLANT_IMAGE  ");
            query.Append(" SET ENDDA = GETDATE(),    ");
            query.Append(" CHGDT = GETDATE(),        ");
            query.Append(" CHGUS = @CHGUS            ");
            query.Append(" WHERE OBJID = @OBJID AND  ");
            query.Append(" BEGDA <= GETDATE() AND    ");
            query.Append(" ENDDA >= GETDATE()        ");

            SqlCommand cmd = GetCommand(conn, query.ToString());
            cmd.Parameters.Add(GetParameter("@CHGUS", CHGUS));
            cmd.Parameters.Add(GetParameter("@OBJID", OBJID));

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

        public static void DeleteAssetImage(string OBJID)
        {
            SqlConnection conn = GetConnection();
            StringBuilder query = new StringBuilder();

            query.Append(" DELETE FROM asset.PLANT_IMAGE ");
            query.Append(" WHERE OBJID = @OBJID AND      ");
            query.Append(" BEGDA <= GETDATE() AND        ");
            query.Append(" ENDDA >= GETDATE()            ");

            SqlCommand cmd = GetCommand(conn, query.ToString());
            cmd.Parameters.Add(GetParameter("@OBJID", OBJID));

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

        public static DataTable GetAssetImages()
        {
            SqlConnection conn = GetConnection();
            StringBuilder query = new StringBuilder();

            query.Append(" SELECT                 ");
            query.Append(" RECID, OBJID,          ");
            query.Append(" PLNID, IMAGE           ");
            query.Append(" FROM asset.PLANT_IMAGE ");
            query.Append(" WHERE                  ");
            query.Append(" BEGDA <= GETDATE() AND ");
            query.Append(" ENDDA >= GETDATE()     ");
            query.Append(" ORDER BY DOCNM         ");

            SqlCommand cmd = GetCommand(conn, query.ToString());

            try
            {
                conn.Open();
                DataTable data = new DataTable();
                SqlDataAdapter adapter = GetAdapter(cmd);
                adapter.Fill(data);
                data.TableName = "Asset Image";
                return data;
            }
            finally
            {
                conn.Close();
            }
        }

        public static DataTable GetAssetImageByID(string OBJID)
        {
            SqlConnection conn = GetConnection();
            StringBuilder query = new StringBuilder();

            query.Append(" SELECT                 ");
            query.Append(" RECID, OBJID,          ");
            query.Append(" PLNID, IMAGE           ");
            query.Append(" FROM asset.PLANT_IMAGE ");
            query.Append(" WHERE                  ");
            query.Append(" BEGDA <= GETDATE() AND ");
            query.Append(" ENDDA >= GETDATE() AND ");
            query.Append(" OBJID = @OBJID         ");

            SqlCommand cmd = GetCommand(conn, query.ToString());
            cmd.Parameters.Add(GetParameter("@OBJID", OBJID));

            try
            {
                conn.Open();
                DataTable data = new DataTable();
                SqlDataAdapter adapter = GetAdapter(cmd);
                adapter.Fill(data);
                data.TableName = "Asset Image";
                return data;
            }
            finally
            {
                conn.Close();
            }
        }

        public static DataTable GetAssetImageByAssetID(string PLNID)
        {
            SqlConnection conn = GetConnection();
            StringBuilder query = new StringBuilder();

            query.Append(" SELECT                 ");
            query.Append(" RECID, OBJID,          ");
            query.Append(" PLNID, IMAGE           ");
            query.Append(" FROM asset.PLANT_IMAGE ");
            query.Append(" WHERE                  ");
            query.Append(" BEGDA <= GETDATE() AND ");
            query.Append(" ENDDA >= GETDATE() AND ");
            query.Append(" PLNID = @PLNID         ");

            SqlCommand cmd = GetCommand(conn, query.ToString());
            cmd.Parameters.Add(GetParameter("@PLNID", PLNID));

            try
            {
                conn.Open();
                DataTable data = new DataTable();
                SqlDataAdapter adapter = GetAdapter(cmd);
                adapter.Fill(data);
                data.TableName = "Asset Image";
                return data;
            }
            finally
            {
                conn.Close();
            }
        }

        //QUERY DOCUMENT MASTER
        public static int InsertDocumentMaster(int OBJID, string DOCNM, string DESCR, string CHGUS)
        {
            SqlConnection conn = GetConnection();
            StringBuilder query = new StringBuilder();
            int _objid = OBJID == 0 ? GetDocumentMasterMaxObjectID() : OBJID;

            query.Append(" INSERT INTO asset.DOCUMENT_MASTER    ");
            query.Append(" (BEGDA, ENDDA, OBJID,                ");
            query.Append(" DOCNM, DESCR, CHGDT, CHGUS)           ");
            query.Append("  VALUES                              ");
            query.Append(" (GETDATE(), @ENDDA, @OBJID,          ");
            query.Append(" @DOCNM, @DESCR, GETDATE(), @CHGUS)    ");

            SqlCommand cmd = GetCommand(conn, query.ToString());
            cmd.Parameters.Add(GetParameter("@ENDDA", GetMaxDate()));
            cmd.Parameters.Add(GetParameter("@OBJID", _objid));
            cmd.Parameters.Add(GetParameter("@DOCNM", DOCNM));
            cmd.Parameters.Add(GetParameter("@DESCR", DESCR));
            cmd.Parameters.Add(GetParameter("@CHGUS", CHGUS));

            try
            {
                conn.Open();
                cmd.ExecuteNonQuery();
                return _objid;
            }
            finally
            {
                conn.Close();
            }
        }

        public static void UpdateDocumentMaster(int OBJID, string DOCNM, string DESCR, string CHGUS)
        {
            if (OBJID != 0)
            {
                DelimitDocumentMaster(OBJID.ToString(), CHGUS);
            }

            InsertDocumentMaster(OBJID, DOCNM, DESCR, CHGUS);
        }

        public static void DelimitDocumentMaster(string OBJID, string CHGUS)
        {
            SqlConnection conn = GetConnection();
            StringBuilder query = new StringBuilder();

            query.Append(" UPDATE asset.DOCUMENT_MASTER  ");
            query.Append(" SET ENDDA = GETDATE(),        ");
            query.Append(" CHGDT = GETDATE(),            ");
            query.Append(" CHGUS = @CHGUS                ");
            query.Append(" WHERE OBJID = @OBJID AND      ");
            query.Append(" BEGDA <= GETDATE() AND        ");
            query.Append(" ENDDA >= GETDATE()            ");

            SqlCommand cmd = GetCommand(conn, query.ToString());
            cmd.Parameters.Add(GetParameter("@CHGUS", CHGUS));
            cmd.Parameters.Add(GetParameter("@OBJID", OBJID));

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

        public static void DeleteDocumentMaster(string OBJID)
        {
            SqlConnection conn = GetConnection();
            StringBuilder query = new StringBuilder();

            query.Append(" DELETE FROM asset.DOCUMENT_MASTER ");
            query.Append(" WHERE OBJID = @OBJID AND          ");
            query.Append(" BEGDA <= GETDATE() AND            ");
            query.Append(" ENDDA >= GETDATE()                ");

            SqlCommand cmd = GetCommand(conn, query.ToString());
            cmd.Parameters.Add(GetParameter("@OBJID", OBJID));

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

        public static DataTable GetDocumentMasters()
        {
            SqlConnection conn = GetConnection();
            StringBuilder query = new StringBuilder();

            query.Append(" SELECT                     ");
            query.Append(" RECID, OBJID,              ");
            query.Append(" DOCNM, DESCR               ");
            query.Append(" FROM asset.DOCUMENT_MASTER ");
            query.Append(" WHERE                      ");
            query.Append(" BEGDA <= GETDATE() AND     ");
            query.Append(" ENDDA >= GETDATE()         ");
            query.Append(" ORDER BY DOCNM             ");

            SqlCommand cmd = GetCommand(conn, query.ToString());

            try
            {
                conn.Open();
                DataTable data = new DataTable();
                SqlDataAdapter adapter = GetAdapter(cmd);
                adapter.Fill(data);
                data.TableName = "Document Master";
                return data;
            }
            finally
            {
                conn.Close();
            }
        }

        public static DataTable GetDocumentMasterByID(string OBJID)
        {
            SqlConnection conn = GetConnection();
            StringBuilder query = new StringBuilder();

            query.Append(" SELECT                     ");
            query.Append(" RECID, OBJID,              ");
            query.Append(" DOCNM, DESCR               ");
            query.Append(" FROM asset.DOCUMENT_MASTER ");
            query.Append(" WHERE                      ");
            query.Append(" BEGDA <= GETDATE() AND     ");
            query.Append(" ENDDA >= GETDATE() AND     ");
            query.Append(" OBJID = @OBJID             ");

            SqlCommand cmd = GetCommand(conn, query.ToString());
            cmd.Parameters.Add(GetParameter("@OBJID", OBJID));

            try
            {
                conn.Open();
                DataTable data = new DataTable();
                SqlDataAdapter adapter = GetAdapter(cmd);
                adapter.Fill(data);
                data.TableName = "Document Master";
                return data;
            }
            finally
            {
                conn.Close();
            }
        }

        //QUERY ASSET MUTATION
        public static string InsertAssetTransfer(string PLNID, string REFNO, string APPRO, string TRSDT, string FRGCD, string FRGNM, string FPRNR, string FNAME, string FLCID, string FLCNM, string ORGCD, string ORGNM, string PERNR, string CNAME, string LOCID, string LOCNM, string CHGUS)
        {
            SqlConnection conn = GetConnection();
            StringBuilder query = new StringBuilder();

            query.Append(" INSERT INTO asset.PLANT_TRANSFER    ");
            query.Append(" (BEGDA, ENDDA, PLNID, TRSDT,        ");
            query.Append("  FRGCD, FRGNM, FPRNR, FNAME,        ");
            query.Append("  FLCID, FLCNM,                      ");
            query.Append("  ORGCD, ORGNM, PERNR, CNAME,        ");
            query.Append("  REFNO, APPRO,                      ");
            query.Append("  LOCID, LOCNM, CHGDT, CHGUS)        ");
            query.Append("  VALUES                             ");
            query.Append(" (GETDATE(), @ENDDA,                 ");
            query.Append("  @PLNID, @TRSDT,                    ");
            query.Append("  @FRGCD, @FRGNM, @FPRNR, @FNAME,    ");
            query.Append("  @FLCID, @FLCNM, @ORGCD, @ORGNM,    ");
            query.Append("  @PERNR, @CNAME, @REFNO, @APPRO,    ");
            query.Append("  @LOCID, @LOCNM,                    ");
            query.Append("  GETDATE(), @CHGUS)                 ");

            SqlCommand cmd = GetCommand(conn, query.ToString());
            cmd.Parameters.Add(GetParameter("@ENDDA", GetMaxDate()));
            cmd.Parameters.Add(GetParameter("@PLNID", PLNID));
            cmd.Parameters.Add(GetParameter("@TRSDT", TRSDT));
            cmd.Parameters.Add(GetParameter("@FRGCD", FRGCD));
            cmd.Parameters.Add(GetParameter("@FRGNM", FRGNM));
            cmd.Parameters.Add(GetParameter("@FPRNR", FPRNR));
            cmd.Parameters.Add(GetParameter("@FNAME", FNAME));
            cmd.Parameters.Add(GetParameter("@FLCID", FLCID));
            cmd.Parameters.Add(GetParameter("@FLCNM", FLCNM));
            cmd.Parameters.Add(GetParameter("@ORGCD", ORGCD));
            cmd.Parameters.Add(GetParameter("@ORGNM", ORGNM));
            cmd.Parameters.Add(GetParameter("@PERNR", PERNR));
            cmd.Parameters.Add(GetParameter("@CNAME", CNAME));
            cmd.Parameters.Add(GetParameter("@LOCID", LOCID));
            cmd.Parameters.Add(GetParameter("@LOCNM", LOCNM));
            cmd.Parameters.Add(GetParameter("@REFNO", REFNO));
            cmd.Parameters.Add(GetParameter("@APPRO", APPRO));
            cmd.Parameters.Add(GetParameter("@CHGUS", CHGUS));

            try
            {
                conn.Open();
                cmd.ExecuteNonQuery();
                return PLNID;
            }
            finally
            {
                conn.Close();
            }
        }

        public static void UpdateAssetTransfer(string PLNID, string REFNO, string APPRO, string TRSDT, string FRGCD, string FRGNM, string FPRNR, string FNAME, string FLCID, string FLCNM, string ORGCD, string ORGNM, string PERNR, string CNAME, string LOCID, string LOCNM, string CHGUS)
        {
            
            DelimitAssetTransfer(REFNO, CHGUS);
            InsertAssetTransfer(PLNID, REFNO, APPRO, TRSDT, FRGCD, FRGNM, FPRNR, FNAME, FLCID, FLCNM, ORGCD, ORGNM, PERNR, CNAME, LOCID, LOCNM, CHGUS);
        }

        public static void DelimitAssetTransfer(string REFNO, string CHGUS)
        {
            SqlConnection conn = GetConnection();
            StringBuilder query = new StringBuilder();

            query.Append(" UPDATE asset.PLANT_TRANSFER  ");
            query.Append(" SET ENDDA = GETDATE(),       ");
            query.Append(" CHGDT = GETDATE(),           ");
            query.Append(" CHGUS = @CHGUS               ");
            query.Append(" WHERE REFNO = @REFNO AND     ");
            query.Append(" BEGDA <= GETDATE() AND       ");
            query.Append(" ENDDA >= GETDATE()           ");

            SqlCommand cmd = GetCommand(conn, query.ToString());
            cmd.Parameters.Add(GetParameter("@CHGUS", CHGUS));
            cmd.Parameters.Add(GetParameter("@REFNO", REFNO));

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

        public static void DeleteAssetTransfer(string OBJID)
        {
            SqlConnection conn = GetConnection();
            StringBuilder query = new StringBuilder();

            query.Append(" DELETE FROM asset.PLANT_TRANSFER ");
            query.Append(" WHERE OBJID = @OBJID AND         ");
            query.Append(" BEGDA <= GETDATE() AND           ");
            query.Append(" ENDDA >= GETDATE()               ");

            SqlCommand cmd = GetCommand(conn, query.ToString());
            cmd.Parameters.Add(GetParameter("@OBJID", OBJID));

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

        public static DataTable GetAssetTransfers()
        {
            SqlConnection conn = GetConnection();
            StringBuilder query = new StringBuilder();

            query.Append(" SELECT                       ");
            query.Append(" RECID, OBJID,                ");
            query.Append(" PLNID, TRSDT,                ");
            query.Append(" ORGCD, ORGNM,                ");
            query.Append(" PERNR, CNAME,                ");
            query.Append(" LOCID, LOCNM                 ");
            query.Append(" FROM asset.PLANT_TRANSFER    ");
            query.Append(" WHERE                        ");
            query.Append(" BEGDA <= GETDATE() AND       ");
            query.Append(" ENDDA >= GETDATE()           ");
            query.Append(" ORDER BY STASK               ");

            SqlCommand cmd = GetCommand(conn, query.ToString());

            try
            {
                conn.Open();
                DataTable data = new DataTable();
                SqlDataAdapter adapter = GetAdapter(cmd);
                adapter.Fill(data);
                data.TableName = "Asset Mutation";
                return data;
            }
            finally
            {
                conn.Close();
            }
        }

        public static DataTable GetAssetTransferByID(string OBJID)
        {
            SqlConnection conn = GetConnection();
            StringBuilder query = new StringBuilder();

            query.Append(" SELECT                       ");
            query.Append(" RECID, OBJID,                ");
            query.Append(" PLNID, TRSDT,                ");
            query.Append(" ORGCD, ORGNM,                ");
            query.Append(" PERNR, CNAME,                ");
            query.Append(" LOCID, LOCNM                 ");
            query.Append(" FROM asset.PLANT_TRANSFER    ");
            query.Append(" WHERE                        ");
            query.Append(" BEGDA <= GETDATE() AND       ");
            query.Append(" ENDDA >= GETDATE() AND       ");
            query.Append(" OBJID = @OBJID               ");

            SqlCommand cmd = GetCommand(conn, query.ToString());
            cmd.Parameters.Add(GetParameter("@OBJID", OBJID));

            try
            {
                conn.Open();
                DataTable data = new DataTable();
                SqlDataAdapter adapter = GetAdapter(cmd);
                adapter.Fill(data);
                data.TableName = "Asset Mutation";
                return data;
            }
            finally
            {
                conn.Close();
            }
        }

        public static DataTable GetAssetTransferByPlantID(string PLNID)
        {
            SqlConnection conn = GetConnection();
            StringBuilder query = new StringBuilder();

            query.Append(" SELECT                       ");
            query.Append(" RECID, OBJID,                ");
            query.Append(" PLNID, TRSDT,                ");
            query.Append(" ORGCD, ORGNM,                ");
            query.Append(" PERNR, bios,                ");
            query.Append(" LOCID, LOCNM                 ");
            query.Append(" FROM asset.PLANT_TRANSFER    ");
            query.Append(" WHERE                        ");
            query.Append(" BEGDA <= GETDATE() AND       ");
            query.Append(" ENDDA >= GETDATE() AND       ");
            query.Append(" PLNID = @PLNID               ");

            SqlCommand cmd = GetCommand(conn, query.ToString());
            cmd.Parameters.Add(GetParameter("@PLNID", PLNID));

            try
            {
                conn.Open();
                DataTable data = new DataTable();
                SqlDataAdapter adapter = GetAdapter(cmd);
                adapter.Fill(data);
                data.TableName = "Asset Mutation";
                return data;
            }
            finally
            {
                conn.Close();
            }
        }

        public static DataTable GetAssetTransferByReferenceNumber(string REFNO)
        {
            SqlConnection conn = GetConnection();
            StringBuilder query = new StringBuilder();

            query.Append(" SELECT                       ");
            query.Append(" RECID, OBJID,                ");
            query.Append(" PLNID, TRSDT,                ");
            query.Append(" ORGCD, ORGNM,                ");
            query.Append(" PERNR, CNAME,                ");
            query.Append(" LOCID, LOCNM                 ");
            query.Append(" FROM asset.PLANT_TRANSFER    ");
            query.Append(" WHERE                        ");
            query.Append(" BEGDA <= GETDATE() AND       ");
            query.Append(" ENDDA >= GETDATE() AND       ");
            query.Append(" REFNO = @REFNO               ");

            SqlCommand cmd = GetCommand(conn, query.ToString());
            cmd.Parameters.Add(GetParameter("@REFNO", REFNO));

            try
            {
                conn.Open();
                DataTable data = new DataTable();
                SqlDataAdapter adapter = GetAdapter(cmd);
                adapter.Fill(data);
                data.TableName = "Asset Mutation";
                return data;
            }
            finally
            {
                conn.Close();
            }
        }

        //QUERY ASSET DISPOSAL
        public static string InsertAssetDisposal(string PLNID, string REFNO, string APPRO, string TRSDT, string WORTH, string STACD, string STATU, string DISTY, string DTYNM, string LTRNO, string LFILE, string CHGUS)
        {
            SqlConnection conn = GetConnection();
            StringBuilder query = new StringBuilder();

            query.Append(" INSERT INTO asset.PLANT_DISPOSAL   ");
            query.Append(" (BEGDA, ENDDA, PLNID,              ");
            query.Append("  TRSDT, STACD, STATU,              ");
            query.Append("  DISTY, DTYNM, LTRNO,              ");
            query.Append("  REFNO, APPRO, WORTH,              ");
            query.Append("  LFILE, CHGDT, CHGUS)              ");
            query.Append("  VALUES                            ");
            query.Append(" (GETDATE(), @ENDDA, @PLNID,        ");
            query.Append("  @TRSDT, @STACD, @STATU,           ");
            query.Append("  @DISTY, @DTYNM, @LTRNO,           ");
            query.Append("  @REFNO, @APPRO, @WORTH, @LFILE,   ");
            query.Append("  GETDATE(), @CHGUS)                ");

            SqlCommand cmd = GetCommand(conn, query.ToString());
            cmd.Parameters.Add(GetParameter("@ENDDA", GetMaxDate()));
            cmd.Parameters.Add(GetParameter("@PLNID", PLNID));
            cmd.Parameters.Add(GetParameter("@TRSDT", TRSDT));
            cmd.Parameters.Add(GetParameter("@STACD", STACD));
            cmd.Parameters.Add(GetParameter("@STATU", STATU));
            cmd.Parameters.Add(GetParameter("@DISTY", DISTY));
            cmd.Parameters.Add(GetParameter("@DTYNM", DTYNM));
            cmd.Parameters.Add(GetParameter("@LTRNO", LTRNO));
            cmd.Parameters.Add(GetParameter("@REFNO", REFNO));
            cmd.Parameters.Add(GetParameter("@APPRO", APPRO));
            cmd.Parameters.Add(GetParameter("@WORTH", WORTH));
            cmd.Parameters.Add(GetParameter("@LFILE", LFILE));
            cmd.Parameters.Add(GetParameter("@CHGUS", CHGUS));

            try
            {
                conn.Open();
                cmd.ExecuteNonQuery();
                return PLNID;
            }
            finally
            {
                conn.Close();
            }
        }

        public static void UpdateAssetDisposal(string PLNID, string REFNO, string APPRO, string TRSDT, string WORTH, string STACD, string STATU, string DISTY, string DTYNM, string LTRNO, string LFILE, string CHGUS)
        {
            DelimitAssetDisposal(REFNO, CHGUS);
            InsertAssetDisposal(PLNID, REFNO, APPRO, TRSDT, WORTH, STACD, STATU, DISTY, DTYNM, LTRNO, LFILE, CHGUS);
        }

        public static void DelimitAssetDisposal(string REFNO, string CHGUS)
        {
            SqlConnection conn = GetConnection();
            StringBuilder query = new StringBuilder();

            query.Append(" UPDATE asset.PLANT_DISPOSAL   ");
            query.Append(" SET ENDDA = GETDATE(),       ");
            query.Append(" CHGDT = GETDATE(),           ");
            query.Append(" CHGUS = @CHGUS               ");
            query.Append(" WHERE REFNO = @REFNO AND     ");
            query.Append(" BEGDA <= GETDATE() AND       ");
            query.Append(" ENDDA >= GETDATE()           ");

            SqlCommand cmd = GetCommand(conn, query.ToString());
            cmd.Parameters.Add(GetParameter("@CHGUS", CHGUS));
            cmd.Parameters.Add(GetParameter("@REFNO", REFNO));

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

        public static void DeleteAssetDisposal(string OBJID)
        {
            SqlConnection conn = GetConnection();
            StringBuilder query = new StringBuilder();

            query.Append(" DELETE FROM asset.PLANT_DISPOSAL  ");
            query.Append(" WHERE OBJID = @OBJID AND         ");
            query.Append(" BEGDA <= GETDATE() AND           ");
            query.Append(" ENDDA >= GETDATE()               ");

            SqlCommand cmd = GetCommand(conn, query.ToString());
            cmd.Parameters.Add(GetParameter("@OBJID", OBJID));

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

        public static DataTable GetAssetDisposals()
        {
            SqlConnection conn = GetConnection();
            StringBuilder query = new StringBuilder();

            query.Append(" SELECT                       ");
            query.Append(" RECID, OBJID, PLNID, TRSDT,  ");
            query.Append(" STACD, STATU, LTRNO, LFILE   ");
            query.Append(" FROM asset.PLANT_DISPOSAL    ");
            query.Append(" WHERE                        ");
            query.Append(" BEGDA <= GETDATE() AND       ");
            query.Append(" ENDDA >= GETDATE()           ");
            query.Append(" ORDER BY STASK               ");

            SqlCommand cmd = GetCommand(conn, query.ToString());

            try
            {
                conn.Open();
                DataTable data = new DataTable();
                SqlDataAdapter adapter = GetAdapter(cmd);
                adapter.Fill(data);
                data.TableName = "Asset Disposal";
                return data;
            }
            finally
            {
                conn.Close();
            }
        }

        public static DataTable GetAssetDisposalByID(string OBJID)
        {
            SqlConnection conn = GetConnection();
            StringBuilder query = new StringBuilder();

            query.Append(" SELECT                       ");
            query.Append(" RECID, OBJID, PLNID, TRSDT,  ");
            query.Append(" STACD, STATU, LTRNO, LFILE,  ");
            query.Append(" DISTY, DTYNM                 ");
            query.Append(" FROM asset.PLANT_DISPOSAL    ");
            query.Append(" WHERE                        ");
            query.Append(" BEGDA <= GETDATE() AND       ");
            query.Append(" ENDDA >= GETDATE() AND       ");
            query.Append(" OBJID = @OBJID               ");

            SqlCommand cmd = GetCommand(conn, query.ToString());
            cmd.Parameters.Add(GetParameter("@OBJID", OBJID));

            try
            {
                conn.Open();
                DataTable data = new DataTable();
                SqlDataAdapter adapter = GetAdapter(cmd);
                adapter.Fill(data);
                data.TableName = "Asset Disposal";
                return data;
            }
            finally
            {
                conn.Close();
            }
        }

        public static DataTable GetAssetDisposalByPlantID(string PLNID)
        {
            SqlConnection conn = GetConnection();
            StringBuilder query = new StringBuilder();

            query.Append(" SELECT                       ");
            query.Append(" RECID, OBJID, PLNID, TRSDT,  ");
            query.Append(" STACD, STATU, LTRNO, LFILE,  ");
            query.Append(" DISTY, DTYNM                 ");
            query.Append(" WORTH                        ");
            query.Append(" FROM asset.PLANT_DISPOSAL    ");
            query.Append(" WHERE                        ");
            query.Append(" BEGDA <= GETDATE() AND       ");
            query.Append(" ENDDA >= GETDATE() AND       ");
            query.Append(" PLNID = @PLNID               ");

            SqlCommand cmd = GetCommand(conn, query.ToString());
            cmd.Parameters.Add(GetParameter("@PLNID", PLNID));
            
            try
            {
                conn.Open();
                DataTable data = new DataTable();
                SqlDataAdapter adapter = GetAdapter(cmd);
                adapter.Fill(data);
                data.TableName = "Asset Disposal";
                return data;
            }
            finally
            {
                conn.Close();
            }
        }

        //Custom Queries
        public static DataTable GetExistingAssetOrganization()
        {
            SqlConnection conn = GetConnection();
            StringBuilder query = new StringBuilder();

            query.Append(" SELECT                             ");
            query.Append(" P.ORGCD, P.ORGNM                   ");
            query.Append(" FROM asset.PLANT_MAINTENANCE M JOIN");
            query.Append(" asset.PLANT_MASTER P ON            ");
            query.Append(" M.PLNID = P.OBJID AND              ");
            query.Append(" P.BEGDA <= GETDATE() AND           ");
            query.Append(" P.ENDDA >= GETDATE()               ");
            query.Append(" GROUP BY P.ORGCD, P.ORGNM          ");
            query.Append(" ORDER BY P.ORGNM                   ");

            SqlCommand cmd = GetCommand(conn, query.ToString());

            try
            {
                conn.Open();
                DataTable data = new DataTable();
                SqlDataAdapter adapter = GetAdapter(cmd);
                adapter.Fill(data);
                data.TableName = "Asset Disposal";
                return data;
            }
            finally
            {
                conn.Close();
            }
        }

        public static bool IsPlantCodeNumberExist(string PLNCD)
        {
            SqlConnection conn = GetConnection();
            StringBuilder query = new StringBuilder();

            query.Append(" SELECT COUNT(*) VALUE    ");
            query.Append(" FROM asset.PLANT_MASTER  ");
            query.Append(" WHERE PLNCD = @PLNCD     ");

            SqlCommand cmd = GetCommand(conn, query.ToString());
            cmd.Parameters.Add("@PLNCD", PLNCD);

            try
            {
                conn.Open();
                DataTable data = new DataTable();
                SqlDataAdapter adapter = GetAdapter(cmd);
                adapter.Fill(data);
                data.TableName = "Asset Number";
                return (Convert.ToInt16(data.Rows[0]["VALUE"]) == 0 ? false : true);
            }
            finally
            {
                conn.Close();
            }
        }

        public static bool IsAssetNumberExist(string ASTNO)
        {
            SqlConnection conn = GetConnection();
            StringBuilder query = new StringBuilder();

            query.Append(" SELECT COUNT(*) VALUE    ");
            query.Append(" FROM asset.PLANT_MASTER  ");
            query.Append(" WHERE ASTNO = @ASTNO     ");

            SqlCommand cmd = GetCommand(conn, query.ToString());
            cmd.Parameters.Add("@ASTNO", ASTNO);

            try
            {
                conn.Open();
                DataTable data = new DataTable();
                SqlDataAdapter adapter = GetAdapter(cmd);
                adapter.Fill(data);
                data.TableName = "Asset Number";
                return (Convert.ToInt16(data.Rows[0]["VALUE"]) == 0 ? false : true);
            }
            finally
            {
                conn.Close();
            }
        }

        public static bool IsInventarisNumberExist(string INVNO)
        {
            SqlConnection conn = GetConnection();
            StringBuilder query = new StringBuilder();

            query.Append(" SELECT COUNT(*) VALUE    ");
            query.Append(" FROM asset.PLANT_MASTER  ");
            query.Append(" WHERE INVNO = @INVNO     ");

            SqlCommand cmd = GetCommand(conn, query.ToString());
            cmd.Parameters.Add("@INVNO", INVNO);

            try
            {
                conn.Open();
                DataTable data = new DataTable();
                SqlDataAdapter adapter = GetAdapter(cmd);
                adapter.Fill(data);
                data.TableName = "Asset Number";
                return (Convert.ToInt16(data.Rows[0]["VALUE"]) == 0 ? false : true);
            }
            finally
            {
                conn.Close();
            }
        }

        public static bool IsPlantIDExist(string PLNCD)
        {
            SqlConnection conn = GetConnection();
            StringBuilder query = new StringBuilder();

            query.Append(" SELECT COUNT(*) VALUE    ");
            query.Append(" FROM asset.PLANT_MASTER  ");
            query.Append(" WHERE PLNCD = @PLNCD     ");

            SqlCommand cmd = GetCommand(conn, query.ToString());
            cmd.Parameters.Add("@PLNCD", PLNCD);

            try
            {
                conn.Open();
                DataTable data = new DataTable();
                SqlDataAdapter adapter = GetAdapter(cmd);
                adapter.Fill(data);
                data.TableName = "Asset Number";
                return (Convert.ToInt16(data.Rows[0]["VALUE"]) == 0 ? false : true);
            }
            finally
            {
                conn.Close();
            }
        }
    }

    public class AssetWorkflow : DataCatalog
    {
        public static int GetAssetDisposalMaxNumber()
        {
            SqlConnection conn = GetConnection();
            StringBuilder query = new StringBuilder();

            query.Append(" SELECT (COALESCE(COUNT([REFNO]),0) + 1) VALUE");
            query.Append(" FROM asset.PLANT_DISPOSAL                    ");
            query.Append(" WHERE                                        ");
            query.Append(" BEGDA <= GETDATE() AND                       ");
            query.Append(" ENDDA >= GETDATE()                           ");


            SqlCommand cmd = GetCommand(conn, query.ToString());

            try
            {
                conn.Open();
                SqlDataReader reader = GetDataReader(cmd);
                int data = 0;
                while (reader.Read())
                {
                    data = Convert.ToInt32(reader[0]);
                }
                return data;
            }
            finally
            {
                conn.Close();
            }
        }

        public static int GetAssetTransferMaxNumber()
        {
            SqlConnection conn = GetConnection();
            StringBuilder query = new StringBuilder();

            query.Append(" SELECT (COALESCE(COUNT([REFNO]),0) + 1) VALUE");
            query.Append(" FROM asset.PLANT_TRANSFER                    ");
            query.Append(" WHERE                                        ");
            query.Append(" BEGDA <= GETDATE() AND                       ");
            query.Append(" ENDDA >= GETDATE()                           ");


            SqlCommand cmd = GetCommand(conn, query.ToString());

            try
            {
                conn.Open();
                SqlDataReader reader = GetDataReader(cmd);
                int data = 0;
                while (reader.Read())
                {
                    data = Convert.ToInt32(reader[0]);
                }
                return data;
            }
            finally
            {
                conn.Close();
            }
        }
        //Just Generate it from another project

        public static void InsertWorkFlow(string DOCID, string SEQNO, string FLWTY, string PERNR, string POSCD, string COMMT, string FLWST, string CHGUS)
        {
            SqlConnection conn = GetConnection();
            StringBuilder query = new StringBuilder();

            query.Append(" INSERT INTO asset.WORKFLOW               ");
            query.Append(" ( BEGDA, DOCID, SEQNO, FLWTY,            ");
            query.Append("   PERNR, POSCD, COMMT, FLWST,            ");
            query.Append("   CHGDT, CHGUS )                         ");
            query.Append("   VALUES                                 ");
            query.Append(" ( GETDATE(), @DOCID, @SEQNO , @FLWTY,    ");
            query.Append("   @PERNR, @POSCD, @COMMT, @FLWST,        ");
            query.Append("   GETDATE() , @CHGUS)                    ");

            SqlCommand cmd = GetCommand(conn, query.ToString());
            cmd.Parameters.Add(GetParameter("@DOCID", DOCID));
            cmd.Parameters.Add(GetParameter("@SEQNO", SEQNO));
            cmd.Parameters.Add(GetParameter("@FLWTY", FLWTY));
            cmd.Parameters.Add(GetParameter("@PERNR", PERNR));
            cmd.Parameters.Add(GetParameter("@POSCD", POSCD));
            cmd.Parameters.Add(GetParameter("@COMMT", COMMT));
            cmd.Parameters.Add(GetParameter("@FLWST", FLWST));
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

        public static DataTable GetWorkflowAssetTransferByStatus(List<string> FLWST)
        {
            string _flwst = GetIncludeQueryInteger(FLWST);

            SqlConnection conn = GetConnection();
            StringBuilder query = new StringBuilder();

            query.Append(" SELECT                           ");
            query.Append(" WF.BEGDA, WF.DOCID, WF.SEQNO,    ");
            query.Append(" WF.FLWTY, WF.FLWST, WF.COMMT,    ");
            query.Append(" PM.PLNNM, PM.PLNCD,              ");
            query.Append(" PM.ASTNO, PM.INVNO,              ");
            query.Append(" PT.FRGNM, PT.ORGNM NRGNM,        ");
            query.Append(" PT.FLCNM, PT.LOCNM NLCNM,        ");
            query.Append(" PT.FPRNR, PT.PERNR, PT.PLNID,    ");
            query.Append(" PT.FNAME, PT.CNAME, PT.REFNO     ");
            query.Append(" FROM                             ");
            query.Append(" asset.WORKFLOW WF,               ");
            query.Append(" (asset.PLANT_TRANSFER PT JOIN    ");
            query.Append(" asset.PLANT_MASTER PM            ");
            query.Append(" ON PT.PLNID = PM.OBJID           ");
            query.Append(" AND PM.BEGDA <= GETDATE()        ");
            query.Append(" AND PM.ENDDA >= GETDATE())       ");
            query.Append(" WHERE                            ");
            query.Append(" WF.DOCID = PT.REFNO AND          ");
            query.Append(" WF.BEGDA = (SELECT MAX(DF.BEGDA) ");
            query.Append(" FROM asset.WORKFLOW DF           ");
            query.Append(" WHERE                            ");
            query.Append(" DF.DOCID = PT.REFNO              ");
            query.Append(" AND DF.FLWTY = '4'               ");
            query.Append(" AND PT.BEGDA <= GETDATE()        ");
            query.Append(" AND PT.ENDDA >= GETDATE())       ");
            query.Append(" AND WF.FLWST IN (" + _flwst + ") ");

            SqlCommand cmd = GetCommand(conn, query.ToString());

            try
            {
                conn.Open();
                DataTable data = new DataTable();
                SqlDataAdapter adapter = GetAdapter(cmd);
                adapter.Fill(data);
                data.TableName = "Transfer";

                return data;
            }
            finally
            {
                conn.Close();
            }
        }

        public static DataTable GetWorkflowAssetDisposalByStatus(List<string> FLWST)
        {
            string _flwst = GetIncludeQueryInteger(FLWST);

            SqlConnection conn = GetConnection();
            StringBuilder query = new StringBuilder();

            query.Append(" SELECT                           ");
            query.Append(" WF.BEGDA, WF.DOCID, WF.SEQNO,    ");
            query.Append(" WF.FLWTY, WF.FLWST, WF.COMMT,    ");
            query.Append(" PM.PLNNM, PM.PLNCD,              ");
            query.Append(" PM.ASTNO, PM.INVNO,              ");
            query.Append(" PM.ORGNM, PD.TRSDT, PD.LFILE,    ");
            query.Append(" PM.LOCNM, PD.STACD, PD.WORTH,    ");
            query.Append(" PM.HOLDR, PD.STATU, PD.PLNID,    ");
            query.Append(" PM.HOLNM, PD.LTRNO, PD.REFNO     ");
            query.Append(" FROM                             ");
            query.Append(" asset.WORKFLOW WF,               ");
            query.Append(" (asset.PLANT_DISPOSAL PD JOIN    ");
            query.Append(" asset.PLANT_MASTER PM            ");
            query.Append(" ON PD.PLNID = PM.OBJID           ");
            query.Append(" AND PM.BEGDA <= GETDATE()        ");
            query.Append(" AND PM.ENDDA >= GETDATE())       ");
            query.Append(" WHERE                            ");
            query.Append(" WF.DOCID = PD.REFNO AND          ");
            query.Append(" WF.BEGDA = (SELECT MAX(DF.BEGDA) ");
            query.Append(" FROM asset.WORKFLOW DF           ");
            query.Append(" WHERE                            ");
            query.Append(" DF.DOCID = PD.REFNO              ");
            query.Append(" AND DF.FLWTY = '5'               ");
            query.Append(" AND PD.BEGDA <= GETDATE()        ");
            query.Append(" AND PD.ENDDA >= GETDATE())       ");
            query.Append(" AND WF.FLWST IN (" + _flwst + ") ");

            SqlCommand cmd = GetCommand(conn, query.ToString());

            try
            {
                conn.Open();
                DataTable data = new DataTable();
                SqlDataAdapter adapter = GetAdapter(cmd);
                adapter.Fill(data);
                data.TableName = "Disposal";

                return data;
            }
            finally
            {
                conn.Close();
            }
        }
    }
}
