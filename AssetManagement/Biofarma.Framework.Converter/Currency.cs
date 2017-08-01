using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Biofarma.Framework.Converter
{
    public class Currency
    {
        public static String SetNominalToRupiahFormat(string cvalue)
        {
            string result = null;
            int counter = 0;
            bool flag = false;
            bool negatif = false;

            if (cvalue.Contains('-'))
            {
                cvalue = cvalue.Remove(0, 1);
                negatif = true;
            }

            foreach (char c in cvalue)
            {
                if (flag == false)
                {
                    if (counter < cvalue.Length % 3)
                    {
                        result += c;
                        counter++;
                    }
                    else
                    {
                        if (cvalue.Length % 3 != 0)
                        {
                            result += ".";
                        }
                        flag = true;
                        result += c;
                        counter = 1;
                    }
                }
                else
                {
                    if (counter < 3)
                    {
                        result += c;
                        counter++;
                    }
                    else
                    {

                        result += ".";
                        result += c;
                        counter = 1;
                    }
                }
            }

            if (negatif) return ("Rp -" + result + ",00");
            else return ("Rp " + result + ",00");

        }
    }
}
