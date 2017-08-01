using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace AssetManagement.Entity
{
    public enum Info : byte
    {
        Info = 1, Warning, Danger
    }
    public enum AssetStatus : byte
    {
        NewArrival = 0, Good, NotGood, NoPhysic, NotProductive
    }

    public enum DeviationType : byte
    {
        PreventiveMaintenance = 1
    }
}