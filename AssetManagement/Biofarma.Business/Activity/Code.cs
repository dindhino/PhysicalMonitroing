using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Drawing;
using BarcodeLib;
using System.IO;
using System.Net;
using ThoughtWorks.QRCode.Codec;
using Biofarma.Framework.Entity;

namespace Biofarma.Business.Activity
{
    public class Code
    {
        public static string CreateSequenceCode(string initCode, string categoryCode, int categoryLength, string sequenceCode, int sequenceLength)
        {
            string _cat = Normalization.FilterNumberOfDigit(categoryCode, categoryLength);
            string _seq = Normalization.FilterNumberOfDigit(sequenceCode, sequenceLength);
            return (initCode + _cat + _seq);
        }
        public static string CreateCode(int codeLength)
        {
            string allChar = "0,1,2,3,4,5,6,7,8,9,A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z";
            string[] allCharArray = allChar.Split(',');
            string randomCode = "";
            int temp = -1;

            Random rand = new Random();
            for (int i = 0; i < codeLength; i++)
            {
                if (temp != -1)
                {
                    rand = new Random(i * temp * ((int)DateTime.Now.Ticks));
                }

                int t = rand.Next(36);

                if (temp != -1 && temp == t)
                {
                    return CreateCode(codeLength);
                }

                temp = t;

                randomCode += allCharArray[t];
            }

            return randomCode;
        }

        public static Image CreateBarCode(string codeText, int width, int height)
        {
            Barcode barcode = new Barcode()
            {
                IncludeLabel = false, //Can Be True to View
                Alignment = AlignmentPositions.CENTER,
                Width = width,
                Height = height,
                RotateFlipType = RotateFlipType.RotateNoneFlipNone,
                BackColor = Color.Transparent,
                ForeColor = Color.Black,
            };

            Image image = barcode.Encode(TYPE.CODE128B, codeText);

            return image;
        }

        public static Image CreateQrCode(string codeText, int scale, int version)
        {

            QRCodeEncoder qrcode = new QRCodeEncoder();

            qrcode.QRCodeEncodeMode = QRCodeEncoder.ENCODE_MODE.ALPHA_NUMERIC;
            qrcode.QRCodeScale = scale;
            qrcode.QRCodeVersion = version;
            qrcode.QRCodeErrorCorrect = QRCodeEncoder.ERROR_CORRECTION.M;
            Image image = qrcode.Encode(codeText);

            return image;
        }

        public static Image CreateQrCode(string codeText, int length)
        {
            var url = string.Format("http://chart.apis.google.com/chart?cht=qr&chs={1}x{2}&chl={0}", codeText, length, length);
            WebResponse response = default(WebResponse);
            Stream remoteStream = default(Stream);
            StreamReader readStream = default(StreamReader);
            WebRequest request = WebRequest.Create(url);
            response = request.GetResponse();
            remoteStream = response.GetResponseStream();
            readStream = new StreamReader(remoteStream);
            Image image = Image.FromStream(remoteStream);

            response.Close();
            remoteStream.Close();
            readStream.Close();

            return image;
        }
    }
}
