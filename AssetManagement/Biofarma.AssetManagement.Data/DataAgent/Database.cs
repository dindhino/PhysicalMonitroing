using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Configuration;

namespace Biofarma.AssetManagement.Data.DataAgent
{
    class Database
    {
        public static SqlConnection GetConnection()
        {
            return new SqlConnection(ConfigurationManager.ConnectionStrings[ConfigurationManager.AppSettings["ConnectionAssetManagement"]].ToString());
        }

        public static SqlDataAdapter GetAdapter(SqlCommand cmd)
        {
            return new SqlDataAdapter(cmd);
        }

        public static SqlCommand GetCommand(SqlConnection con, string sqlCommand)
        {
            return new SqlCommand(sqlCommand, (SqlConnection)con);
        }

        public static SqlDataReader GetDataReader(SqlCommand cmd)
        {
            return cmd.ExecuteReader();
        }

        public static SqlParameter GetParameter(string parameterName, object parameterValue)
        {
            return new SqlParameter(parameterName, parameterValue);
        }
    }
}
