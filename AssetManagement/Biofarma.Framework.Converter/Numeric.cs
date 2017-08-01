using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Biofarma.Framework.Converter
{
    class Numeric
    {
        private static String[] huruf = { "", "Satu", "Dua", "Tiga", "Empat", "Lima", "Enam", "Tujuh", "Delapan", "Sembilan", "Sepuluh", "Sebelas" };
        public static String GetNumberToBeSpelled(int satuan)
        {
            return GetNumber(satuan) + " Rupiah.";
        }

        private static String GetNumber(int satuan)
        {
            String result = null;

            if (satuan < 12)
                result += huruf[satuan];
            else if (satuan == 0)
                result += "Nol";
            else if (satuan < 20)
                result += GetNumber(satuan - 10) + " Belas";
            else if (satuan < 100)
                result += GetNumber(satuan / 10) + " Puluh " + GetNumber(satuan % 10);
            else if (satuan < 200)
                result += "Seratus " + GetNumber(satuan - 100);
            else if (satuan < 1000)
                result += GetNumber(satuan / 100) + " Ratus " + GetNumber(satuan % 100);
            else if (satuan < 2000)
                result += "Seribu " + GetNumber(satuan - 1000);
            else if (satuan < 1000000)
                result += GetNumber(satuan / 1000) + " Ribu " + GetNumber(satuan % 1000);
            else if (satuan < 1000000000)
                result += GetNumber(satuan / 1000000) + " Juta " + GetNumber(satuan % 1000000);
            else if (satuan >= 1000000000)
                result = "Angka terlalu besar, harus kurang dari 1 milyar!";

            return result;
        }
    }
}
