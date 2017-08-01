using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;

namespace Biofarma.AssetManagement.Business.Activity
{
    public class DataManager
    {
        public static DataTable GetData(DataTable data, int pageNumber, int numberOfEntry)
        {
            if (numberOfEntry > 0 && data.Rows.Count > 0) data = data.AsEnumerable().Skip((pageNumber - 1) * numberOfEntry).Take(numberOfEntry).CopyToDataTable();

            return data;
        }

        public static int GetTotalPage(int numberOfEntry, int totalRow)
        {
            return totalRow / numberOfEntry;
        }

        public static DataTable GetData(DataTable data, string searchKey)
        {
            return data;
        }
    }
}
