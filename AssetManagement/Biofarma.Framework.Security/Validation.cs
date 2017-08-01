using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web.UI.WebControls;
using System.IO;

namespace Biofarma.Framework.Security
{
    public class Validation
    {
        public static bool IsValidDocumentPDF(FileUpload file)
        {
            if (Path.GetExtension(file.FileName).ToLower() == ".pdf")
            {
                return true;
            }
            else
            {
                return false;
            }
        }

        public static bool IsValidImageFile(FileUpload file)
        {
            if (Path.GetExtension(file.FileName).ToLower() == ".jpg")
            {
                return true;
            }
            else if (Path.GetExtension(file.FileName).ToLower() == ".jpeg")
            {
                return true;
            }
            else if (Path.GetExtension(file.FileName).ToLower() == ".png")
            {
                return true;
            }
            else
            {
                return false;
            }
        }

        public static bool IsValidSoundFile(FileUpload file)
        {
            if (Path.GetExtension(file.FileName).ToLower() == ".mp3")
            {
                return true;
            }
            else if (Path.GetExtension(file.FileName).ToLower() == ".wav")
            {
                return true;
            }
            else if (Path.GetExtension(file.FileName).ToLower() == ".aac")
            {
                return true;
            }
            else if (Path.GetExtension(file.FileName).ToLower() == ".m4p")
            {
                return true;
            }
            else if (Path.GetExtension(file.FileName).ToLower() == ".wma")
            {
                return true;
            }
            else
            {
                return false;
            }
        }

        public static bool IsValidVideoFile(FileUpload file)
        {
            if (Path.GetExtension(file.FileName).ToLower() == ".mp4")
            {
                return true;
            }
            else if (Path.GetExtension(file.FileName).ToLower() == ".wmv")
            {
                return true;
            }
            else if (Path.GetExtension(file.FileName).ToLower() == ".vlcs")
            {
                return true;
            }
            else
            {
                return false;
            }
        }

        public static bool IsValidDocumentFile(FileUpload file)
        {
            if (Path.GetExtension(file.FileName).ToLower() == ".doc")
            {
                return true;
            }
            else if (Path.GetExtension(file.FileName).ToLower() == ".docx")
            {
                return true;
            }
            else if (Path.GetExtension(file.FileName).ToLower() == ".pdf")
            {
                return true;
            }
            else
            {
                return false;
            }
        }

        public static bool IsValidExcelFile(FileUpload file)
        {
            if (Path.GetExtension(file.FileName).ToLower() == ".xls")
            {
                return true;
            }
            else if (Path.GetExtension(file.FileName).ToLower() == ".xlsx")
            {
                return true;
            }
            else if (Path.GetExtension(file.FileName).ToLower() == ".csv")
            {
                return true;
            }
            else
            {
                return false;
            }
        }

        public static bool IsValidPresentationFile(FileUpload file)
        {
            if (Path.GetExtension(file.FileName).ToLower() == ".ppt")
            {
                return true;
            }
            else if (Path.GetExtension(file.FileName).ToLower() == ".pptx")
            {
                return true;
            }
            else
            {
                return false;
            }
        }

        public static bool IsNullInput(string data)
        {
            if (data.Trim().Length == 0)
            {
                return true;
            }
            else
            {
                return false;
            }
        }

        public static bool IsSmallerThan(int smallvalue, int bigvalue)
        {
            if (smallvalue < bigvalue)
            {
                return true;
            }
            else
            {
                return false;
            }
        }

        public static bool IsSmallerThan(decimal smallvalue, decimal bigvalue)
        {
            if (smallvalue < bigvalue)
            {
                return true;
            }
            else
            {
                return false;
            }
        }

        public static bool IsPositiveValue(int value)
        {
            if (value >= 0)
            {
                return true;
            }
            else
            {
                return false;
            }
        }

        public static bool IsPositiveValue(decimal value)
        {
            if (value >= 0)
            {
                return true;
            }
            else
            {
                return false;
            }
        }

        public static bool IsZeroValue(int value)
        {
            if (value == 0)
            {
                return true;
            }
            else
            {
                return false;
            }
        }

        public static bool IsZeroValue(decimal value)
        {
            if (value == 0)
            {
                return true;
            }
            else
            {
                return false;
            }
        }

        public static bool IsZeroModResult(int value, int divider)
        {
            if (value % divider == 0)
            {
                return true;
            }
            else
            {
                return false;
            }
        }

        public static bool IsValidCharacter(string data)
        {
            bool isValid = true;
            for (int i = 0; i < data.Length; i++)
            {
                if (((int)data[i] < 'A' || (int)data[i] > 'Z') && ((int)data[i] < 'a' || (int)data[i] > 'z'))
                {
                    isValid = false;
                    break;
                }
            }

            return isValid;
        }

        public static bool IsValidInteger(string data)
        {
            bool isValid = true;
            for (int i = 0; i < data.Length; i++)
            {
                if ((int)data[i] < '0' || (int)data[i] > '9')
                {
                    isValid = false;
                    break;
                }
            }

            return isValid;
        }

        public static bool IsValidDecimal(string data)
        {
            bool isValid = false;
            int counter = 0;
            for (int i = 0; i < data.Length; i++)
            {
                if ((int)data[i] == '.' && i == 0)
                {
                    isValid = false;
                    break;
                }
                else if ((int)data[i] == '.')
                {
                    counter++;
                    if (counter == 1)
                    {
                        isValid = true;
                    }
                    else
                    {
                        isValid = false;
                        break;
                    }
                }
                else if ((int)data[i] < '0' || (int)data[i] > '9')
                {
                    isValid = false;
                    break;
                }
            }

            return isValid;
        }

        public static bool IsValidPasswordCombination(string data)
        {
            bool isSymbol = false, isAlphabet = false, isNumber = false, isLength = false;

            if (data.Length >= 8)
            {
                isLength = true;

                for (int i = 0; i < data.Length; i++)
                {
                    if (((int)data[i] < 'A' || (int)data[i] > 'Z') && ((int)data[i] < 'a' || (int)data[i] > 'z') && ((int)data[i] < '0' || (int)data[i] > '9'))
                    {
                        isSymbol = true;
                    }
                    if (((int)data[i] >= 'A' || (int)data[i] <= 'Z') || ((int)data[i] >= 'a' || (int)data[i] <= 'z'))
                    {
                        isAlphabet = true;
                    }
                    if (((int)data[i] >= '0' || (int)data[i] <= '9'))
                    {
                        isNumber = true;
                    }
                }
            }

            if (isAlphabet && isNumber && isSymbol && isLength) return true;
            else return false;
        }
    }
}
