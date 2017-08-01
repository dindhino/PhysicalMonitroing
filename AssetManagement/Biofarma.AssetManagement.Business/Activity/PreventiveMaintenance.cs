using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using Biofarma.AssetManagement.Data.DataAccess;
using Biofarma.Framework.Converter;

namespace Biofarma.AssetManagement.Business.Activity
{
    public class PreventiveMaintenance
    {
        public static DataTable GetAssetMaintenancePlan(string objid, DateTime initDate, DateTime endDate)
        {
            DataTable _tableReference = AssetCatalog.GetPlantMaintenanceByPlantID(objid);
            DataTable _tableResult = CreateTableMaintenancePlan();

            for (int i = 0; i < _tableReference.Rows.Count; i++)
            {
                DateTime _currentDate = Convert.ToDateTime(_tableReference.Rows[i]["LASTM"].ToString());
                double _duration = (endDate - _currentDate).Days;

                while (_duration > 0)
                {
                    _currentDate = CalculatePeriode(_currentDate, Convert.ToInt32(_tableReference.Rows[i]["PERIO"]), _tableReference.Rows[i]["PUNIT"].ToString());

                    if ((_currentDate - initDate).Days >= 0 && (endDate - _currentDate).Days >= 0)
                    {
                        string _periode = _tableReference.Rows[i]["PERIO"].ToString() == "0" ? _tableReference.Rows[i]["PUNIT"].ToString() : (_tableReference.Rows[i]["PERIO"].ToString() + " " + _tableReference.Rows[i]["PUNIT"].ToString());

                        _tableResult.Rows.Add(new object[] { _tableReference.Rows[i]["PLNCD"].ToString(), _tableReference.Rows[i]["PLNNM"].ToString(), _tableReference.Rows[i]["TASk"].ToString(), _tableReference.Rows[i]["STASK"].ToString(), _periode, DateTimeFormat.GetDateStandardFormat(_currentDate.ToString()), string.Empty });
                    }
                    
                    _duration = (endDate - _currentDate).Days;
                }
            }

            return _tableResult;
        }

        public static DataTable GetAssetMaintenanceHistory(string objid, DateTime initDate, DateTime endDate, bool isNeedPeriode)
        {
            DataTable _tableReference = AssetCatalog.GetPlantMaintenanceHistorybyPlantID(objid);
            DataTable _tableResult = CreateTableMaintenanceHistory();

            for (int i = 0; i < _tableReference.Rows.Count; i++)
            {
                DateTime _currentDate = Convert.ToDateTime(_tableReference.Rows[i]["LASTM"].ToString());
                string _periode = _tableReference.Rows[i]["PERIO"].ToString() == "0" ? _tableReference.Rows[i]["PUNIT"].ToString() : (_tableReference.Rows[i]["PERIO"].ToString() + " " + _tableReference.Rows[i]["PUNIT"].ToString());

                if (isNeedPeriode)
                {
                    if ((_currentDate - initDate).Days >= 0 && (endDate - _currentDate).Days >= 0)
                    {
                        _tableResult.Rows.Add(new object[] { _tableReference.Rows[i]["PLNCD"].ToString(), _tableReference.Rows[i]["PLNNM"].ToString(), _tableReference.Rows[i]["TASk"].ToString(), _tableReference.Rows[i]["STASK"].ToString(), _periode, DateTimeFormat.GetDateStandardFormat(_tableReference.Rows[i]["PLANM"].ToString()), DateTimeFormat.GetDateStandardFormat(_tableReference.Rows[i]["LASTM"].ToString()) });
                    }
                }
                else
                {
                    _tableResult.Rows.Add(new object[] { _tableReference.Rows[i]["PLNCD"].ToString(), _tableReference.Rows[i]["PLNNM"].ToString(), _tableReference.Rows[i]["TASk"].ToString(), _tableReference.Rows[i]["STASK"].ToString(), _periode, DateTimeFormat.GetDateStandardFormat(_tableReference.Rows[i]["PLANM"].ToString()), DateTimeFormat.GetDateStandardFormat(_tableReference.Rows[i]["LASTM"].ToString()) });
                }

            }

            return _tableResult;
        }

        public static DataTable GetAssetMaintenancePlanUnit(string ORGCD, DateTime initDate, DateTime endDate)
        {
            DataTable _tableReference = AssetCatalog.GetPlantMaintenanceByOrganizationCode(ORGCD);
            DataTable _tableResult = CreateTableMaintenancePlan();

            for (int i = 0; i < _tableReference.Rows.Count; i++)
            {
                DateTime _currentDate = Convert.ToDateTime(_tableReference.Rows[i]["LASTM"].ToString());
                double _duration = (endDate - _currentDate).Days;

                while (_duration > 0)
                {
                    _currentDate = CalculatePeriode(_currentDate, Convert.ToInt32(_tableReference.Rows[i]["PERIO"]), _tableReference.Rows[i]["PUNIT"].ToString());

                    if ((_currentDate - initDate).Days >= 0 && (endDate - _currentDate).Days >= 0)
                    {
                        string _periode = _tableReference.Rows[i]["PERIO"].ToString() == "0" ? _tableReference.Rows[i]["PUNIT"].ToString() : (_tableReference.Rows[i]["PERIO"].ToString() + " " + _tableReference.Rows[i]["PUNIT"].ToString());

                        _tableResult.Rows.Add(new object[] { _tableReference.Rows[i]["PLNCD"].ToString(), _tableReference.Rows[i]["PLNNM"].ToString(), _tableReference.Rows[i]["TASk"].ToString(), _tableReference.Rows[i]["STASK"].ToString(), _periode, DateTimeFormat.GetDateStandardFormat(_currentDate.ToString()), string.Empty });
                    }

                    _duration = (endDate - _currentDate).Days;
                }
            }

            return _tableResult;
        }

        public static DataTable GetAssetMaintenanceHistoryUnit(string ORGCD, DateTime initDate, DateTime endDate, bool isNeedPeriode)
        {
            DataTable _tableReference = AssetCatalog.GetPlantMaintenanceHistoryByOrganizationCode(ORGCD);
            DataTable _tableResult = CreateTableMaintenanceHistory();

            for (int i = 0; i < _tableReference.Rows.Count; i++)
            {
                DateTime _currentDate = Convert.ToDateTime(_tableReference.Rows[i]["LASTM"].ToString());
                string _periode = _tableReference.Rows[i]["PERIO"].ToString() == "0" ? _tableReference.Rows[i]["PUNIT"].ToString() : (_tableReference.Rows[i]["PERIO"].ToString() + " " + _tableReference.Rows[i]["PUNIT"].ToString());

                if (isNeedPeriode)
                {
                    if ((_currentDate - initDate).Days >= 0 && (endDate - _currentDate).Days >= 0)
                    {
                        _tableResult.Rows.Add(new object[] { _tableReference.Rows[i]["PLNCD"].ToString(), _tableReference.Rows[i]["PLNNM"].ToString(), _tableReference.Rows[i]["TASk"].ToString(), _tableReference.Rows[i]["STASK"].ToString(), _periode, DateTimeFormat.GetDateStandardFormat(_tableReference.Rows[i]["PLANM"].ToString()), DateTimeFormat.GetDateStandardFormat(_tableReference.Rows[i]["LASTM"].ToString()) });
                    }
                }
                else
                {
                    _tableResult.Rows.Add(new object[] { _tableReference.Rows[i]["PLNCD"].ToString(), _tableReference.Rows[i]["PLNNM"].ToString(), _tableReference.Rows[i]["TASk"].ToString(), _tableReference.Rows[i]["STASK"].ToString(), _periode, DateTimeFormat.GetDateStandardFormat(_tableReference.Rows[i]["PLANM"].ToString()), DateTimeFormat.GetDateStandardFormat(_tableReference.Rows[i]["LASTM"].ToString()) });
                }

            }

            return _tableResult;
        }

        private static DataTable CreateTableMaintenancePlan()
        {
            DataTable _table = new DataTable();
            _table.TableName = "MaintenancePlant";
            _table.Columns.Add("PLNCD", typeof(string));
            _table.Columns.Add("PLNNM", typeof(string));
            _table.Columns.Add("TASK", typeof(string));
            _table.Columns.Add("STASK", typeof(string));
            _table.Columns.Add("PRIOD", typeof(string));
            _table.Columns.Add("PLAN", typeof(string));
            _table.Columns.Add("REAL", typeof(string));

            return _table;
        }

        private static DataTable CreateTableMaintenanceHistory()
        {
            DataTable _table = new DataTable();
            _table.TableName = "MaintenancePlant";
            _table.Columns.Add("PLNCD", typeof(string));
            _table.Columns.Add("PLNNM", typeof(string));
            _table.Columns.Add("TASK", typeof(string));
            _table.Columns.Add("STASK", typeof(string));
            _table.Columns.Add("PRIOD", typeof(string));
            _table.Columns.Add("PLAN", typeof(string));
            _table.Columns.Add("REAL", typeof(string));

            return _table;
        }

        protected static DateTime CalculatePeriode(DateTime date, int periodeValue, string periodeUnit)
        {
            if (periodeUnit.ToLower() == "tahun")
            {
                return date.AddYears(periodeValue);
            }
            else if (periodeUnit.ToLower() == "bulan")
            {
                return date.AddMonths(periodeValue);
            }
            else if (periodeUnit.ToLower() == "minggu")
            {
                return date.AddDays(7 * periodeValue);
            }
            else if (periodeUnit.ToLower() == "hari")
            {
                return date.AddDays(periodeValue);
            }
            else
            {
                return DateTime.MaxValue;
            }
        }
    }
}
