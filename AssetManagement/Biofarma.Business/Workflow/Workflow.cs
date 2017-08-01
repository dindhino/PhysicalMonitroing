using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using Biofarma.Data.DataAccess;

namespace Biofarma.Business.Workflow
{
    public class Workflow
    {
        public static DataTable GetPemeriksa(string POSID, string PSTYP, int SEQNO)
        {
            object[] value = GetDocumentReviewer(PSTYP);

            DataTable data = OrganizationCatalog.GetChiefByPositionAndPSType(POSID, value[SEQNO].ToString());
            return data;
        }

        public static object[] GetDocumentReviewer(string PSTYP)
        {
            switch (PSTYP)
            {
                case "":
                    {
                        return new object[] { "'07','08','09'", "'04','05','06'", "'01','02','03'" };
                    }
                case "21":
                    {
                        return new object[] { "'07','08','09'", "'04','05','06'", "'01','02','03'" };
                    }
                case "20":
                    {
                        return new object[] { "'07','08','09'", "'04','05','06'", "'01','02','03'" };
                    }
                case "19":
                    {
                        return new object[] { "'07','08','09'", "'04','05','06'", "'01','02','03'" };
                    }
                case "18":
                    {
                        return new object[] { "''", "'04','05','06'", "'01','02','03'" };
                    }
                case "17":
                    {
                        return new object[] { "''", "'04','05','06'", "'01','02','03'" };
                    }
                case "16":
                    {
                        return new object[] { "''", "'04','05','06'", "'01','02','03'" };
                    }
                case "15":
                    {
                        return new object[] { "''", "''", "'01','02','03'" };
                    }
                case "14":
                    {
                        return new object[] { "''", "''", "'01','02','03'" };
                    }
                case "13":
                    {
                        return new object[] { "''", "''", "'01','02','03'" };
                    }
                case "12":
                    {
                        return new object[] { "''", "''", "00" };
                    }
                case "11":
                    {
                        return new object[] { "''", "''", "00" };
                    }
                case "10":
                    {
                        return new object[] { "''", "''", "00" };
                    }
                case "09":
                    {
                        return new object[] { "''", "'04','05','06'", "'01','02','03'" };
                    }
                case "08":
                    {
                        return new object[] { "''", "'04','05','06'", "'01','02','03'" };
                    }
                case "07":
                    {
                        return new object[] { "''", "'04','05','06'", "'01','02','03'" };
                    }
                case "06":
                    {
                        return new object[] { "''", "''", "'01','02','03'" };
                    }
                case "05":
                    {
                        return new object[] { "''", "''", "'01','02','03'" };
                    }
                case "04":
                    {
                        return new object[] { "''", "''", "'01','02','03'" };
                    }
                case "03":
                    {
                        return new object[] { "''", "''", "'00'" };
                    }
                case "02":
                    {
                        return new object[] { "''", "''", "'00'" };
                    }
                case "01":
                    {
                        return new object[] { "''", "''", "'00'" };
                    }
                case "00":
                    {
                        return new object[] { "''", "'00'", "'00'" };
                    }
                default:
                    {
                        return new object[] { "''", "''", "''" };
                    }
            }
        }
    }
}
