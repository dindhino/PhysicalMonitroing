using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using Biofarma.Service.ERP.AssetERP;
using Biofarma.Service.ERP.Data;

namespace Biofarma.Service.ERP
{
    public class AssetERPCatalog : AssetAccess
    {
        private static DataTable CreateTable()
        {
            DataTable _data = new DataTable();
            _data.TableName = "Asset";
            _data.Columns.Add("", typeof(string));
            _data.Columns.Add("", typeof(string));
            _data.Columns.Add("", typeof(string));
            _data.Columns.Add("", typeof(string));
            _data.Columns.Add("", typeof(string));
            _data.Columns.Add("", typeof(string));
            _data.Columns.Add("", typeof(string));
            _data.Columns.Add("", typeof(string));
            _data.Columns.Add("", typeof(string));

            return _data;
        }

        //Need to Edit
        public static DataTable GetERPAssets(DateTime begda, DateTime endda, string userName)
        {
            DataTable _data = CreateTable();
            SCC_WSAssetObj[] _asset = GetAssets(begda, endda);

            for (int i = 0; i < _asset.Length; i++)
            {
                RepositoryERP.InsertAsset(_asset[i].AcquisitionDate.ToString(), _asset[i].AssetGroupID, _asset[i].AssetGroupName, _asset[i].AssetID, _asset[i].AssetName, _asset[i].Condition, _asset[i].CostCenter, _asset[i].MajorType, _asset[i].MajorTypeName, _asset[i].NetBookValue.ToString(), _asset[i].NomorInventaris, _asset[i].TanggalPerolehan.ToString(), userName);
            }

            return _data;
        }

        //Need to Edit
        public static DataTable GetERPAssetsByAssetCode(string assetCode, DateTime begda, DateTime endda)
        {
            DataTable _data = CreateTable();
            SCC_WSAssetObj[] _asset = GetAssetDetailByAssetCode(assetCode, begda, endda);

            for (int i = 0; i < _asset.Length; i++)
            {
                //Insert
            }

            return _data;
        }

        //Need to Edit
        public static DataTable GetERPAssetDetailByInventarisCode(string inventarisCode, DateTime begda, DateTime endda)
        {
            DataTable _data = CreateTable();
            SCC_WSAssetObj[] _asset = GetAssetDetailbyInventarisCode(inventarisCode, begda, endda);

            for (int i = 0; i < _asset.Length; i++)
            {
                //Insert
            }

            return _data;
        }

        //Need to Edit
        public static DataTable GetERPAssetDetail(string assetGroup, string assetSubGroup, string costCenter, DateTime begda, DateTime endda)
        {
            DataTable _data = CreateTable();
            SCC_WSAssetObj[] _asset = GetAssetDetail(assetGroup, assetSubGroup, costCenter, begda, endda);

            for (int i = 0; i < _asset.Length; i++)
            {
                //Insert
            }

            return _data;
        }

        //Done
        //public static void TransferAssets(string assetCode, string costCenter, DateTime transferDate, string notes)
        //{
        //    TransferAsset(assetCode, costCenter, transferDate, notes);
        //}
    }
}
