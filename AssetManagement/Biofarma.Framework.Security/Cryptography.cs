using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Security.Cryptography;
using System.Text;

namespace Biofarma.Framework.Security
{
    public class Cryptography
    {
        //to parse encrypted data, such as session, query string, xml, and/or others.
        //symetic or asymetric encryption, based on 64 bit complexity.
        //need a token private key or public key to perform best data security, but hug of complexity.
        //make sure you are using bes way to perform this way, only when you need to protect the data.

        public static string Encrypt(string toEncrypt, bool useHashing)
        {
            byte[] keyArray;
            byte[] toEncryptArray = UTF8Encoding.UTF8.GetBytes(toEncrypt);

            System.Configuration.AppSettingsReader settingsReader = new AppSettingsReader();

            string key = (string)ConfigurationManager.AppSettings["SecurityKey"];

            if (useHashing)
            {
                MD5CryptoServiceProvider hashmd5 = new MD5CryptoServiceProvider();
                keyArray = hashmd5.ComputeHash(UTF8Encoding.UTF8.GetBytes(key));
                hashmd5.Clear();
            }
            else keyArray = UTF8Encoding.UTF8.GetBytes(key);

            TripleDESCryptoServiceProvider tdes = new TripleDESCryptoServiceProvider();

            tdes.Key = keyArray;
            tdes.Mode = CipherMode.ECB;
            tdes.Padding = PaddingMode.PKCS7;

            ICryptoTransform cTransform = tdes.CreateEncryptor();
            byte[] resultArray = cTransform.TransformFinalBlock(toEncryptArray, 0, toEncryptArray.Length);

            tdes.Clear();
            return Convert.ToBase64String(resultArray, 0, resultArray.Length).Replace(@"\", @"\\");
        }

        public static string Decrypt(string cipherString, bool useHashing)
        {
            byte[] keyArray;
            byte[] toEncryptArray = Convert.FromBase64String(cipherString.Replace(@" ", @"+"));

            System.Configuration.AppSettingsReader settingsReader = new AppSettingsReader();

            string key = (string)ConfigurationManager.AppSettings["SecurityKey"];

            if (useHashing)
            {
                MD5CryptoServiceProvider hashmd5 = new MD5CryptoServiceProvider();
                keyArray = hashmd5.ComputeHash(UTF8Encoding.UTF8.GetBytes(key));

                hashmd5.Clear();
            }
            else
            {
                keyArray = UTF8Encoding.UTF8.GetBytes(key);
            }

            TripleDESCryptoServiceProvider tdes = new TripleDESCryptoServiceProvider();
            tdes.Key = keyArray;
            tdes.Mode = CipherMode.ECB;
            tdes.Padding = PaddingMode.PKCS7;

            ICryptoTransform cTransform = tdes.CreateDecryptor();
            byte[] resultArray = cTransform.TransformFinalBlock(toEncryptArray, 0, toEncryptArray.Length);
            tdes.Clear();
            return UTF8Encoding.UTF8.GetString(resultArray);
        }

        public static string EncryptLong(string toEncrypt, bool useHashing)
        {
            byte[] keyArray;
            byte[] toEncryptArray = UTF8Encoding.UTF8.GetBytes(toEncrypt);

            System.Configuration.AppSettingsReader settingsReader = new AppSettingsReader();

            string key = (string)ConfigurationManager.AppSettings["LongSecurityKey"];

            if (useHashing)
            {
                MD5CryptoServiceProvider hashmd5 = new MD5CryptoServiceProvider();
                keyArray = hashmd5.ComputeHash(UTF8Encoding.UTF8.GetBytes(key));
                hashmd5.Clear();
            }
            else keyArray = UTF8Encoding.UTF8.GetBytes(key);

            TripleDESCryptoServiceProvider tdes = new TripleDESCryptoServiceProvider();

            tdes.Key = keyArray;
            tdes.Mode = CipherMode.ECB;
            tdes.Padding = PaddingMode.PKCS7;

            ICryptoTransform cTransform = tdes.CreateEncryptor();
            byte[] resultArray = cTransform.TransformFinalBlock(toEncryptArray, 0, toEncryptArray.Length);

            tdes.Clear();
            return Convert.ToBase64String(resultArray, 0, resultArray.Length).Replace(@"\", @"\\");
        }

        public static string DecryptLong(string cipherString, bool useHashing)
        {
            byte[] keyArray;

            byte[] toEncryptArray = Convert.FromBase64String(cipherString.Replace(@" ", @"+"));

            System.Configuration.AppSettingsReader settingsReader = new AppSettingsReader();

            string key = (string)ConfigurationManager.AppSettings["LongSecurityKey"];

            if (useHashing)
            {
                MD5CryptoServiceProvider hashmd5 = new MD5CryptoServiceProvider();
                keyArray = hashmd5.ComputeHash(UTF8Encoding.UTF8.GetBytes(key));

                hashmd5.Clear();
            }
            else
            {
                keyArray = UTF8Encoding.UTF8.GetBytes(key);
            }

            TripleDESCryptoServiceProvider tdes = new TripleDESCryptoServiceProvider();
            tdes.Key = keyArray;
            tdes.Mode = CipherMode.ECB;
            tdes.Padding = PaddingMode.PKCS7;

            ICryptoTransform cTransform = tdes.CreateDecryptor();
            byte[] resultArray = cTransform.TransformFinalBlock(toEncryptArray, 0, toEncryptArray.Length);
            tdes.Clear();
            return UTF8Encoding.UTF8.GetString(resultArray);
        }

        public static string Encrypt(string toEncrypt, bool useHashing, string publicKey)
        {
            byte[] keyArray;
            byte[] toEncryptArray = UTF8Encoding.UTF8.GetBytes(toEncrypt);

            System.Configuration.AppSettingsReader settingsReader = new AppSettingsReader();

            if (useHashing)
            {
                MD5CryptoServiceProvider hashmd5 = new MD5CryptoServiceProvider();
                keyArray = hashmd5.ComputeHash(UTF8Encoding.UTF8.GetBytes(publicKey));
                hashmd5.Clear();
            }
            else keyArray = UTF8Encoding.UTF8.GetBytes(publicKey);

            TripleDESCryptoServiceProvider tdes = new TripleDESCryptoServiceProvider();

            tdes.Key = keyArray;
            tdes.Mode = CipherMode.ECB;
            tdes.Padding = PaddingMode.PKCS7;

            ICryptoTransform cTransform = tdes.CreateEncryptor();
            byte[] resultArray = cTransform.TransformFinalBlock(toEncryptArray, 0, toEncryptArray.Length);

            tdes.Clear();
            return Convert.ToBase64String(resultArray, 0, resultArray.Length).Replace(@"\", @"\\");
        }

        public static string Decrypt(string cipherString, bool useHashing, string publicKey)
        {
            byte[] keyArray;

            byte[] toEncryptArray = Convert.FromBase64String(cipherString.Replace(@" ", @"+"));

            System.Configuration.AppSettingsReader settingsReader = new AppSettingsReader();

            if (useHashing)
            {
                MD5CryptoServiceProvider hashmd5 = new MD5CryptoServiceProvider();
                keyArray = hashmd5.ComputeHash(UTF8Encoding.UTF8.GetBytes(publicKey));

                hashmd5.Clear();
            }
            else
            {
                keyArray = UTF8Encoding.UTF8.GetBytes(publicKey);
            }

            TripleDESCryptoServiceProvider tdes = new TripleDESCryptoServiceProvider();
            tdes.Key = keyArray;
            tdes.Mode = CipherMode.ECB;
            tdes.Padding = PaddingMode.PKCS7;

            ICryptoTransform cTransform = tdes.CreateDecryptor();
            byte[] resultArray = cTransform.TransformFinalBlock(toEncryptArray, 0, toEncryptArray.Length);
            tdes.Clear();
            return UTF8Encoding.UTF8.GetString(resultArray);
        }

        private string RSAEncrypt(string value)
        {
            byte[] plaintext = Encoding.Unicode.GetBytes(value);

            CspParameters cspParams = new CspParameters();
            cspParams.KeyContainerName = (string)ConfigurationManager.AppSettings["SecurityKey"];
            using (RSACryptoServiceProvider RSA = new RSACryptoServiceProvider(2048, cspParams))
            {
                byte[] encryptedData = RSA.Encrypt(plaintext, false);
                return Convert.ToBase64String(encryptedData);
            }
        }

        private string RSADecrypt(string value)
        {
            byte[] encryptedData = Convert.FromBase64String(value);

            CspParameters cspParams = new CspParameters();
            cspParams.KeyContainerName = (string)ConfigurationManager.AppSettings["SecurityKey"];
            using (RSACryptoServiceProvider RSA = new RSACryptoServiceProvider(2048, cspParams))
            {
                byte[] decryptedData = RSA.Decrypt(encryptedData, false);
                return Encoding.Unicode.GetString(decryptedData);
            }
        }
    }
}
