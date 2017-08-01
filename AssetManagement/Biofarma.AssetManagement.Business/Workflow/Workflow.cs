using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Biofarma.AssetManagement.Business.Entity;
using Biofarma.Framework.Security;

namespace Biofarma.AssetManagement.Business.Workflow
{
    public class Workflow
    {
        //Deployment Completed on 11 MAR 2016 at 11.50 p.m.
        public static string GetWorkflowAction(string FLWTY, string SEQNO, string FLWST, string REFNO, string PLNID)
        {
            StringBuilder element = new StringBuilder();
            switch (Convert.ToInt16(SEQNO))
            {
                case (int)WorkflowUser.AssetManagementOperator:
                {
                    if (Convert.ToInt16(FLWST) == (int)WorkflowStatus.Request)
                    {
                        if (Convert.ToInt16(FLWTY) == (int)WorkflowType.Transfer)
                        {
                            element.Append(string.Empty);
                        }
                        else if (Convert.ToInt16(FLWTY) == (int)WorkflowType.Disposal)
                        {
                            element.Append(string.Empty);
                        }
                    }

                    break;
                }

                case (int)WorkflowUser.AssetManagementApprover:
                {
                    if (Convert.ToInt16(FLWST) == (int)WorkflowStatus.Request)
                    {
                        if (Convert.ToInt16(FLWTY) == (int)WorkflowType.Transfer)
                        {
                            element.Append("<a class='btn btn-orange popovers' style='color:white;margin-bottom:5px;'  href='AssetTransferApproval.aspx?act=1&REFNO=" + Cryptography.Encrypt(REFNO, true) + "&PLNID=" + Cryptography.Encrypt(PLNID, true) + "&FLWTY=" + Cryptography.Encrypt(FLWTY, true) + "&FLWST=" + Cryptography.Encrypt(FLWST, true) + "'><i class='fa fa-file-o'></i></a> "); 
                        }
                        else if (Convert.ToInt16(FLWTY) == (int)WorkflowType.Disposal)
                        {
                            element.Append("<a class='btn btn-orange popovers' style='color:white;margin-bottom:5px;'  href='AssetDisposalApproval.aspx?act=1&REFNO=" + Cryptography.Encrypt(REFNO, true) + "&PLNID=" + Cryptography.Encrypt(PLNID, true) + "&FLWTY=" + Cryptography.Encrypt(FLWTY, true) + "&FLWST=" + Cryptography.Encrypt(FLWST, true) + "'><i class='fa fa-file-o'></i></a> ");
                        }
                    }

                    break;
                }

                default :
                {
                    element.Append(string.Empty);
                    break;
                }
            }

            return element.ToString();
        }

        public static string GetWorkflowStatusSymbol(string FLWST)
        {
            StringBuilder element = new StringBuilder();

            switch (Convert.ToInt16(FLWST))
            {
                case (int)WorkflowStatus.Request:
                    {
                        return "<span class='label label-grey popovers' style='color:white' data-content='Workflow status : Requested' data-placement='left' data-trigger='hover'><i class='fa fa-bookmark'></i></span>";
                    }

                case (int)WorkflowStatus.InProcess:
                    {
                        return "<span class='label label-orange popovers' style='color:white' data-content='Workflow status : In Process' data-placement='left' data-trigger='hover'><i class='fa fa-bookmark'></i></span>";
                    }

                case (int)WorkflowStatus.Decline:
                    {
                        return "<span class='label label-red popovers' style='color:white' data-content='Workflow status : Declined' data-placement='left' data-trigger='hover'><i class='fa fa-bookmark'></i></span>";
                    }

                case (int)WorkflowStatus.Approve:
                    {
                        return "<span class='label label-green popovers' style='color:white' data-content='Workflow status : Approved' data-placement='left' data-trigger='hover'><i class='fa fa-bookmark'></i></span>";
                    }

                default:
                    {
                        return string.Empty;
                    }
            }
        }

        private static string GetWorkflowStatus(string FLWST)
        {
            StringBuilder element = new StringBuilder();

            switch (Convert.ToInt16(FLWST))
            {
                case (int)WorkflowStatus.Request:
                    {
                        return " Requested";
                    }

                case (int)WorkflowStatus.InProcess:
                    {
                        return " In Process";
                    }

                case (int)WorkflowStatus.Decline:
                    {
                        return " Declined";
                    }

                case (int)WorkflowStatus.Approve:
                    {
                        return " Approved";
                    }

                default:
                    {
                        return string.Empty;
                    }
            }
        }

        public static string GetWorkflowStatus(string FLWTY, string FLWST)
        {
            StringBuilder element = new StringBuilder();

            switch (Convert.ToInt16(FLWTY))
            {
                case (int)WorkflowType.Transfer:
                    {
                        return WorkflowType.Transfer.ToString() + GetWorkflowStatus(FLWST);
                    }

                case (int)WorkflowType.Disposal:
                    {
                        return WorkflowType.Disposal.ToString() + GetWorkflowStatus(FLWST);
                    }

                default:
                    {
                        return string.Empty;
                    }
            }
        }

        public static List<string> GetDataServiceGroup(int ServiceStatus)
        {
            List<string> group = new List<string>();

            switch (ServiceStatus)
            {
                case (int)WorkflowStatus.InProcess:
                    {
                        group.Add(((int)WorkflowStatus.Request).ToString());
                        group.Add(((int)WorkflowStatus.InProcess).ToString());
                        return group;
                    }

                case (int)WorkflowStatus.Approve:
                    {
                        group.Add(((int)WorkflowStatus.Approve).ToString());
                        group.Add(((int)WorkflowStatus.Decline).ToString());
                        return group;
                    }

                default:
                    {
                        return null;
                    }
            }
        }
    }
}
