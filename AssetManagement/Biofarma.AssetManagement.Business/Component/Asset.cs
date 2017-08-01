using Biofarma.AssetManagement.Data.DataAccess;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using Biofarma.Framework.Security;
using Biofarma.Data.DataAccess;

namespace Biofarma.AssetManagement.Business.Component
{
    public class Asset
    {
        public enum Info : byte
        {
            Info = 1, Warning, Danger
        }
        public enum AssetStatus : byte
        {
            NewArrival = 0, Good, NotGood, NoPhysic, NotProductive
        }
        public enum DeviationType : byte
        {
            PreventiveMaintenance = 1
        }
        
        public static DataTable GetAssetFilter(string unit, string location, string group)
        {
            StringBuilder _table = new StringBuilder();
            DataTable dt = new DataTable("AssetData");
            DataTable table = AssetCatalog.GetAssetHeadersByFilter(unit, location, group);
            dt.Columns.Add(("#"));
            dt.Columns.Add(("Nama Aset"));
            dt.Columns.Add(("Kode Aset Akuntansi"));
            dt.Columns.Add(("No Inventaris"));
            dt.Columns.Add(("Id Alat"));
            dt.Columns.Add(("Masa Aset"));
            dt.Columns.Add(("Perolehan"));
            dt.Columns.Add(("Peruntukan"));
            dt.Columns.Add(("Lokasi"));
            dt.Columns.Add(("Unit"));
            dt.Columns.Add(("Action"));
            for (int i = 0; i < table.Rows.Count; i++)
            {
                string _action = GetAssetAction(table.Rows[i]["OBJID"].ToString());
                string _status = GetStatus(table.Rows[i]["STACD"].ToString());
                int _yearRange = Convert.ToInt32((Convert.ToDateTime(table.Rows[i]["EXPDT"]) - Convert.ToDateTime(table.Rows[i]["EFFDT"])).TotalDays / 365);
                object[] obj = new object[11];
                
                obj[0] = _status;
                obj[1] = table.Rows[i]["PLNNM"].ToString();
                obj[2] = table.Rows[i]["ASTNO"].ToString();
                obj[3] = table.Rows[i]["INVNO"].ToString();
                obj[4] = table.Rows[i]["PLNCD"].ToString();
                obj[5] = _yearRange.ToString();
                obj[6] = table.Rows[i]["HOWGT"].ToString();
                obj[7] = table.Rows[i]["ASTTO"].ToString();
                obj[8] = table.Rows[i]["LOCNM"].ToString();
                obj[9] = table.Rows[i]["ORGNM"].ToString();
                obj[10] = _action;
                dt.Rows.Add(obj);
            }

            return dt;
        }

        public static DataTable GetAssetByGroup(string group)
        {
            StringBuilder _table = new StringBuilder();
            DataTable dt = new DataTable("AssetData");
            DataTable table = AssetCatalog.GetAssetHeadersByMajor( group);
            dt.Columns.Add(("#"));
            dt.Columns.Add(("Nama Aset"));
            dt.Columns.Add(("Kode Aset Akuntansi"));
            dt.Columns.Add(("No Inventaris"));
            dt.Columns.Add(("Id Alat"));
            dt.Columns.Add(("Masa Aset"));
            dt.Columns.Add(("Perolehan"));
            dt.Columns.Add(("Peruntukan"));
            dt.Columns.Add(("Lokasi"));
            dt.Columns.Add(("Unit"));
            dt.Columns.Add(("Action"));
            for (int i = 0; i < table.Rows.Count; i++)
            {
                string _action = GetAssetAction(table.Rows[i]["OBJID"].ToString());
                string _status = GetStatus(table.Rows[i]["STACD"].ToString());
                int _yearRange = Convert.ToInt32((Convert.ToDateTime(table.Rows[i]["EXPDT"]) - Convert.ToDateTime(table.Rows[i]["EFFDT"])).TotalDays / 365);
                object[] obj = new object[11];

                obj[0] = _status;
                obj[1] = table.Rows[i]["PLNNM"].ToString();
                obj[2] = table.Rows[i]["ASTNO"].ToString();
                obj[3] = table.Rows[i]["INVNO"].ToString();
                obj[4] = table.Rows[i]["PLNCD"].ToString();
                obj[5] = _yearRange.ToString();
                obj[6] = table.Rows[i]["HOWGT"].ToString();
                obj[7] = table.Rows[i]["ASTTO"].ToString();
                obj[8] = table.Rows[i]["LOCNM"].ToString();
                obj[9] = table.Rows[i]["ORGNM"].ToString();
                obj[10] = _action;
                dt.Rows.Add(obj);
            }

            return dt;
        }

        public static DataTable GetAssetMaintenanceFilter(string unit, string location, string group)
        {
            StringBuilder _table = new StringBuilder();
            DataTable dt = new DataTable("AssetData");
            DataTable table = AssetCatalog.GetAssetHeadersByFilter(unit, location, group);
            dt.Columns.Add(("#"));
            dt.Columns.Add(("Nama Aset"));
            dt.Columns.Add(("Kode Aset Akuntansi"));
            dt.Columns.Add(("No Inventaris"));
            dt.Columns.Add(("Id Alat"));
            dt.Columns.Add(("Masa Aset"));
            dt.Columns.Add(("Perolehan"));
            dt.Columns.Add(("Peruntukan"));
            dt.Columns.Add(("Lokasi"));
            dt.Columns.Add(("Unit"));
            dt.Columns.Add(("Action"));
            for (int i = 0; i < table.Rows.Count; i++)
            {
                string _action = GetAssetMaintenanceAction(table.Rows[i]["OBJID"].ToString());
                string _status = GetStatus(table.Rows[i]["STACD"].ToString());
                int _yearRange = Convert.ToInt32((Convert.ToDateTime(table.Rows[i]["EXPDT"]) - Convert.ToDateTime(table.Rows[i]["EFFDT"])).TotalDays / 365);
                object[] obj = new object[11];

                obj[0] = _status;
                obj[1] = table.Rows[i]["PLNNM"].ToString();
                obj[2] = table.Rows[i]["ASTNO"].ToString();
                obj[3] = table.Rows[i]["INVNO"].ToString();
                obj[4] = table.Rows[i]["PLNCD"].ToString();
                obj[5] = _yearRange.ToString();
                obj[6] = table.Rows[i]["HOWGT"].ToString();
                obj[7] = table.Rows[i]["ASTTO"].ToString();
                obj[8] = table.Rows[i]["LOCNM"].ToString();
                obj[9] = table.Rows[i]["ORGNM"].ToString();
                obj[10] = _action;
                dt.Rows.Add(obj);
            }

            return dt;
        }

        public static DataTable GetAssetMaintenanceByGroup(string group)
        {
            StringBuilder _table = new StringBuilder();
            DataTable dt = new DataTable("AssetData");
            DataTable table = AssetCatalog.GetAssetHeadersByMajor(group);
            dt.Columns.Add(("#"));
            dt.Columns.Add(("Nama Aset"));
            dt.Columns.Add(("Kode Aset Akuntansi"));
            dt.Columns.Add(("No Inventaris"));
            dt.Columns.Add(("Id Alat"));
            dt.Columns.Add(("Masa Aset"));
            dt.Columns.Add(("Perolehan"));
            dt.Columns.Add(("Peruntukan"));
            dt.Columns.Add(("Lokasi"));
            dt.Columns.Add(("Unit"));
            dt.Columns.Add(("Action"));
            for (int i = 0; i < table.Rows.Count; i++)
            {
                string _action = GetAssetMaintenanceAction(table.Rows[i]["OBJID"].ToString());
                string _status = GetStatus(table.Rows[i]["STACD"].ToString());
                int _yearRange = Convert.ToInt32((Convert.ToDateTime(table.Rows[i]["EXPDT"]) - Convert.ToDateTime(table.Rows[i]["EFFDT"])).TotalDays / 365);
                object[] obj = new object[11];

                obj[0] = _status;
                obj[1] = table.Rows[i]["PLNNM"].ToString();
                obj[2] = table.Rows[i]["ASTNO"].ToString();
                obj[3] = table.Rows[i]["INVNO"].ToString();
                obj[4] = table.Rows[i]["PLNCD"].ToString();
                obj[5] = _yearRange.ToString();
                obj[6] = table.Rows[i]["HOWGT"].ToString();
                obj[7] = table.Rows[i]["ASTTO"].ToString();
                obj[8] = table.Rows[i]["LOCNM"].ToString();
                obj[9] = table.Rows[i]["ORGNM"].ToString();
                obj[10] = _action;
                dt.Rows.Add(obj);
            }

            return dt;
        }

        protected static string GetAssetAction(string OBJID)
        {
            StringBuilder element = new StringBuilder();

            //Preview Detail
            element.Append("<a class='btn btn-xs btn-yellow popovers' style='color:white;margin-bottom:5px;' href='AssetForm.aspx?actio=1&objid=" + Cryptography.Encrypt(OBJID, true) + "' data-content='Silakan klik untuk melakukan preview dan update data Aset' data-placement='left' data-trigger='hover'><i class='fa fa-edit'></i></a> ");
            element.Append("<a class='btn btn-xs btn-blue popovers' style='color:white;margin-bottom:5px;' href='AssetMaintenanceForm.aspx?actio=1&objid=" + Cryptography.Encrypt(OBJID, true) + "' data-content='Silakan klik untuk melakukan preview dan register data pemeliharaan aset' data-placement='left' data-trigger='hover'><i class='fa fa-gear'></i></a> ");
            element.Append("<a class='btn btn-xs btn-green popovers' style='color:white;margin-bottom:5px;' href='AssetDocumentForm.aspx?actio=1&objid=" + Cryptography.Encrypt(OBJID, true) + "' data-content='Silakan klik untuk melakukan preview dan register dokumen aset' data-placement='left' data-trigger='hover'><i class='fa fa-book'></i></a> ");
            element.Append("<a class='btn btn-xs btn-danger popovers' style='color:white;margin-bottom:5px;' href='Asset.aspx?actio=2&objid=" + Cryptography.Encrypt(OBJID, true) + "' data-content='Silakan klik untuk menghapus data. Apakah Anda yakin?' data-placement='left' data-trigger='hover'><i class='fa fa-trash-o'></i></a> ");
            return element.ToString();
        }

        protected static string GetAssetMaintenanceAction(string OBJID)
        {
            StringBuilder element = new StringBuilder();

            //Preview Detail
            element.Append("<a class='btn btn-blue popovers' style='color:white;margin-bottom:5px;' href='AssetMaintenanceUpdate.aspx?actio=1&objid=" + Cryptography.Encrypt(OBJID, true) + "' data-content='Silakan klik untuk melakukan register data pemeliharaan aset' data-placement='left' data-trigger='hover'><i class='fa fa-gear'></i></a> ");
            element.Append("<a class='btn btn-orange popovers' style='color:white;margin-bottom:5px;' href='AssetMaintenancePlan.aspx?actio=1&objid=" + Cryptography.Encrypt(OBJID, true) + "' data-content='Silakan klik untuk melihat rencana pemeliharaan aset' data-placement='left' data-trigger='hover'><i class='fa fa-calendar'></i></a> ");
            element.Append("<a class='btn btn-purple popovers' style='color:white;margin-bottom:5px;' href='AssetMaintenanceHistory.aspx?actio=1&objid=" + Cryptography.Encrypt(OBJID, true) + "' data-content='Silakan klik untuk melihat history pemeliharaan aset' data-placement='left' data-trigger='hover'><i class='fa fa-history'></i></a> ");

            return element.ToString();
        }

        protected static string GetStatus(string STACD)
        {
            StringBuilder element = new StringBuilder();

            //Preview Detail
            if (STACD == ((int)AssetStatus.NewArrival).ToString())
                element.Append("<span class='text-default popovers' data-content='Data baru dari ERP' data-placement='left' data-trigger='hover'><i class='fa fa-asterisk'></i></span> ");
            else if (STACD == ((int)AssetStatus.Good).ToString())
                element.Append("<span class='text-success popovers' data-content='Registered : Aset dalam kondisi baik' data-placement='left' data-trigger='hover'><i class='fa fa-bookmark'></i></span> ");
            else if (STACD == ((int)AssetStatus.NotGood).ToString())
                element.Append("<span class='text-danger popovers' data-content='Registered : Aset dalam kondisi rusak' data-placement='left' data-trigger='hover'><i class='fa fa-bookmark'></i></span> ");
            else if (STACD == ((int)AssetStatus.NoPhysic).ToString())
                element.Append("<span class='text-warning popovers' data-content='Registered : Fisik aset tidak ada' data-placement='left' data-trigger='hover'><i class='fa fa-bookmark'></i></span> ");
            else
                element.Append("<span class='text-green popovers' data-content='Registered : Aset tidak produktif' data-placement='left' data-trigger='hover'><i class='fa fa-bookmark'></i></span> ");

            return element.ToString();
        }
    }
}
