using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Biofarma.Framework.Entity
{
    public enum LoginGateway : byte
    {
        PortalCTI = 0, Local
    }

    public enum ConfigurationStatus : byte
    {
        No = 0, Yes
    }

    public enum SatuanWaktu : byte
    {
        Tahun, Bulan, Minggu, Hari, Jam, Menit, Detik, Milidetik
    }
}
