using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Security.Principal;
using System.Web.Security;
using System.Web.UI;

namespace CF.Models
{
    public class ClsLogout
    {
        public void doLogout()
        {
            System.Web.HttpContext.Current.Session["Hid"] = null;
            System.Web.HttpContext.Current.Session["HDid"] = null;
            System.Web.HttpContext.Current.Session["UserType"] = null;
            System.Web.HttpContext.Current.Session["ClientID"] = null;
            System.Web.HttpContext.Current.Session["Vid"] = null;
            System.Web.HttpContext.Current.Session["Anid"] = null;
            System.Web.HttpContext.Current.Session["BlockID"] = null;
            System.Web.HttpContext.Current.Session["CsoCapacityId"] = null;
            System.Web.HttpContext.Current.Session["NCid"] = null;
            System.Web.HttpContext.Current.Session["Disid"] = null;
            System.Web.HttpContext.Current.Session["DistrictID"] = null;
            System.Web.HttpContext.Current.Session["FLid"] = null;
            System.Web.HttpContext.Current.Session["Nid"] = null;
            System.Web.HttpContext.Current.Session["Skid"] = null;
            System.Web.HttpContext.Current.Session["StateId"] = null;
            System.Web.HttpContext.Current.Session["trno"] = null;
            System.Web.HttpContext.Current.Session["tno"] = null;
            System.Web.HttpContext.Current.Session["Cid"] = null;
            System.Web.HttpContext.Current.Session["VillageID"] = null;
            System.Web.HttpContext.Current.Session["WfNo"] = null;
            System.Web.HttpContext.Current.Session["WFDataID"] = null;
            System.Web.HttpContext.Current.Session["WfgNo"] = null;
            System.Web.HttpContext.Current.Session["FPCId"] = null;
            System.Web.HttpContext.Current.Session["FPCid"] = null;
            System.Web.HttpContext.Current.Session["UserID"] = null;
            System.Web.HttpContext.Current.Session["Disid"] = null;
            System.Web.HttpContext.Current.Session["FPCid"] = null;
            System.Web.HttpContext.Current.Session["FPCid"] = null;
            System.Web.HttpContext.Current.Session["FPCid"] = null;

            // First we clean the authentication ticket like always
            //required NameSpace: using System.Web.Security;
            FormsAuthentication.SignOut();

            // Second we clear the principal to ensure the user does not retain any authentication
            //required NameSpace: using System.Security.Principal;


            System.Web.HttpContext.Current.Session.Clear();
            System.Web.HttpContext.Current.Session.Abandon();
            System.Web.HttpContext.Current.Session.RemoveAll();


        }
    }
}