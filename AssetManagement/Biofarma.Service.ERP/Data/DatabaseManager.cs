using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Text;

namespace Biofarma.Service.ERP.Data
{
    public class DatabaseManager
    {
        //databasefactory on sql client data server,
        //you can add more data server to this factory such as oracle, odbc, firebird, ms access, and/or others.
        //this scheme is to perform best manual script with low resource on server as data entity engine

        public static SqlConnection GetConnection()
        {
            return new SqlConnection(ConfigurationManager.ConnectionStrings[ConfigurationManager.AppSettings["ConnectionBiofarma"]].ToString());
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
