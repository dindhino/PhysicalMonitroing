using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;

namespace Biofarma.Framework.Security
{
    public class Filtering
    {
        public static string FilterValidSqlQuery(string data)
        {
            return Regex.Replace(data, "'", "''");
        }

        public static string RemoveSingleQuote(string data)
        {
            return Regex.Replace(data, "'", string.Empty);
        }

        public static string RemoveSpecialCharacter(string data)
        {
            return Regex.Replace(data, "[^0-9a-zA-Z]+", string.Empty);
        }

        public static string RemoveWhiteSpace(string data)
        {
            return Regex.Replace(data, "\\s+", " ");
        }

        public static string FilterValidCharacter(string data)
        {
            return Regex.Replace(data, "&#x", "");
        }


    }
}
