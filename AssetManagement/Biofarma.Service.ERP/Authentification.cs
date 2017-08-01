using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Configuration;
using System.Web.Configuration;
using Biofarma.Service.ERP.AssetERP;

namespace Biofarma.Service.ERP
{
    public class AuthentificationERP
    {
        protected static string GetUsername()
        {
            return WebConfigurationManager.AppSettings["ERP_username"];
        }

        protected static string GetPassword()
        {
            return WebConfigurationManager.AppSettings["ERP_password"];
        }
    }

    public class AssetAccess : AuthentificationERP
    {
        protected static SCC_WSAssetServiceClient GetClientService()
        {
            SCC_WSAssetServiceClient _client = new SCC_WSAssetServiceClient();
            _client.ClientCredentials.UserName.UserName = GetUsername();
            _client.ClientCredentials.UserName.Password = GetPassword();

            return _client;
        }

        private static CallContext GetCallContext()
        {
            return new CallContext();
        }

        public static SCC_WSAssetObj[] GetAssets(DateTime begda, DateTime endda)
        {
            SCC_WSAssetServiceClient _client = GetClientService();

            return _client.getAllAsset(GetCallContext(), begda, endda);
        }

        public static SCC_WSAssetObj[] GetAssetDetailByAssetCode(string assetCode, DateTime begda, DateTime endda)
        {
            SCC_WSAssetServiceClient _client = GetClientService();

            return _client.getAssetDetailByAssetCode(GetCallContext(), assetCode, begda, endda);
        }

        public static SCC_WSAssetObj[] GetAssetDetailbyInventarisCode(string inventarisCode, DateTime begda, DateTime endda)
        {
            SCC_WSAssetServiceClient _client = GetClientService();

            return _client.getAssetDetailByNoInventaris(GetCallContext(), inventarisCode, begda, endda);
        }

        public static SCC_WSAssetObj[] GetAssetDetail(string assetGroup, string assetSubGroup, string costCenter, DateTime begda, DateTime endda)
        {
            SCC_WSAssetServiceClient _client = GetClientService();

            return _client.getAssetDetail(GetCallContext(), assetGroup, assetSubGroup, costCenter, begda, endda);
        }

        //public static void TransferAsset(string assetCode, string costCenter, DateTime transferDate, string notes)
        //{
        //    SCC_WSAssetServiceClient _client = GetClientService();  
        //    _client.TranferAsset(GetCallContext(), assetCode, costCenter, transferDate, notes);
        //}
    }
}
