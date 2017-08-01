using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Configuration;
using System.Data;

namespace Biofarma.Data.DataAgent
{
    public class Database
    {
        //databasefactory on sql client data server,
        //you can add more data server to this factory such as oracle, odbc, firebird, ms access, and/or others.
        //this scheme is to perform best manual script with low resource on server as data entity engine

        public static SqlConnection GetConnection()
        {
            return new SqlConnection(ConfigurationManager.ConnectionStrings[ConfigurationManager.AppSettings["ConnectionBiofarma"]].ToString());
        }

        // add connection to local db
        public static SqlConnection GetConnectionLocalDB()
        {
            return new SqlConnection(ConfigurationManager.ConnectionStrings[ConfigurationManager.AppSettings["Localdb"]].ToString());
        }
        // end add connection to local db

        public static SqlConnection GetConnection(string connection)
        {
            return new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings[connection].ToString());
        }

        public static SqlDataAdapter GetAdapter(SqlCommand cmd)
        {
            return new SqlDataAdapter(cmd);
        }

        public static SqlCommand GetCommand(SqlConnection con, string sqlCommand)
        {
            return new SqlCommand(sqlCommand, (SqlConnection)con);
        }

        public static SqlCommand GetStoredProcedureCommand(SqlConnection conn, string storedProcedureName)
        {
            SqlCommand cmd = new SqlCommand();
            cmd.CommandText = storedProcedureName;
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = conn;
            return cmd;
        }

        public static void AddParameter(ref SqlCommand command, string parameterName, ParameterDirection direction, object parameterValue)
        {
            SqlParameter parmStatusName = new SqlParameter(parameterName, parameterValue);
            parmStatusName.Direction = direction;
            command.Parameters.Add(parmStatusName);
        }


        public static void AddParameter(ref SqlCommand command, string parameterName, SqlDbType dbType, int size, ParameterDirection direction, object parameterValue)
        {
            SqlParameter parmStatusName = new SqlParameter(parameterName, dbType, size);
            parmStatusName.Value = parameterValue;
            parmStatusName.Direction = direction;
            command.Parameters.Add(parmStatusName);
        }

        public static void AddParameter(ref SqlCommand command, string parameterName, SqlDbType dbType, ParameterDirection direction)
        {
            SqlParameter parmStatusName = new SqlParameter(parameterName, dbType);
            parmStatusName.Direction = direction;
            command.Parameters.Add(parmStatusName);
        }

        public static void AddParameter(ref SqlCommand command, string parameterName, SqlDbType dbType, int size, ParameterDirection direction)
        {
            SqlParameter parmStatusName = new SqlParameter(parameterName, dbType);
            parmStatusName.Size = size;
            parmStatusName.Direction = direction;
            command.Parameters.Add(parmStatusName);
        }

        public static String GetParameterValue(SqlCommand command, string parameterName)
        {
            return command.Parameters[parameterName].Value.ToString();
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
