using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Biofarma.Framework.Converter
{
    public class DateTimeFormat
    {
        public static string ReverseDateVersionSQL(string date)
        {
            date = date.Split(' ')[0];
            return date.Split('-')[2] + "-" + date.Split('-')[1] + "-" + date.Split('-')[0];
        }

        public static string ReverseDateVersionASP(string date)
        {
            date = date.Split(' ')[0];
            return date.Split('/')[1] + "-" + date.Split('/')[0] + "-" + date.Split('/')[2];
        }

        public static string ReverseDateTimeVersionSQL(string datetime)
        {
            string date = datetime.Split(' ')[0];
            string time = datetime.Split(' ')[1];
            return date.Split('-')[2] + "-" + date.Split('-')[1] + "-" + date.Split('-')[0] + " " + time;
        }

        public static string GetDateTimeNow()
        {
            return GetDateFormat(DateTime.Today.ToString()) + " Pukul " + DateTime.Now.ToString("HH:mm:ss");
        }
        public static String GetMonthRomawiFormat(string date)
        {
            return NumToEnum<RomanMonth>(Convert.ToInt16(GetMonth(date))).ToString();
        }

        public static String GetTime(string date)
        {
            return (Convert.ToDateTime(date).TimeOfDay.ToString());
        }

        public static String GetDay(string date)
        {
            return (Convert.ToDateTime(date).Day.ToString());
        }

        public static String GetMonth(string date)
        {
            return (Convert.ToDateTime(date).Month.ToString());
        }

        public static String GetYear(string date)
        {
            return (Convert.ToDateTime(date).Year.ToString());
        }

        public static String GetMonthFromEnum(string month)
        {
            switch (month.ToLower())
            {
                case "januari":
                    {
                        return "01";
                    }
                case "februari":
                    {
                        return "02";
                    }
                case "maret":
                    {
                        return "03";
                    }
                case "april":
                    {
                        return "04";
                    }
                case "mei":
                    {
                        return "05";
                    }
                case "juni":
                    {
                        return "06";
                    }
                case "juli":
                    {
                        return "07";
                    }
                case "agustus":
                    {
                        return "08";
                    }
                case "september":
                    {
                        return "09";
                    }
                case "oktober":
                    {
                        return "10";
                    }
                case "november":
                    {
                        return "11";
                    }
                case "desember":
                    {
                        return "12";
                    }
                default: { return "01"; }
            }
        }

        private static T1 NumToEnum<T1>(int number)
        {
            return (T1)Enum.ToObject(typeof(T1), number);
        }

        public static String GetDateFormatToNumber(string date)
        {
            return GetMonthFromEnum(date.Split(' ')[1].ToLower()) + "/" + date.Split(' ')[0] + "/" + date.Split(' ')[2];
        }

        public static String GetDateFormat(string date)
        {
            return GetDay(date) + " " + NumToEnum<Month>(Convert.ToInt16(GetMonth(date))) + " " + GetYear(date);
        }

        public static String GetDateStandardFormat(string date)
        {
            return (GetDay(date).Length == 1 ? "0" + GetDay(date) : GetDay(date)) + " " + (NumToEnum<Month>(Convert.ToInt16(GetMonth(date)))).ToString().Substring(0, 3) + " " + GetYear(date);
        }

        public static String GetDateTimeFormat(string date)
        {
            return GetDay(date) + " " + NumToEnum<Month>(Convert.ToInt16(GetMonth(date))) + " " + GetYear(date) + " Pukul " + GetTime(date);
        }
    }
}
