using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Biofarma.AssetManagement.Business.Entity
{
    public enum WorkflowUser : byte
    {
        UnitUser, AssetManagementOperator, AssetManagementApprover
    }

    public enum WorkflowStatus : int
    {
        Request = 1, InProcess, Decline, Approve
    }

    public enum WorkflowType : byte
    {
        FixRegister = 1, NonFixRegister, LeasingRegister, 
        Transfer = 4, Disposal, Capitalization, 
    }

    public enum ApprovalStatus : byte
    {
        Unapproved = 0, Approved, Declined, InProcess
    }
}
