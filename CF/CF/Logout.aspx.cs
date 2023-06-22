using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Principal;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using CF.Models;

namespace CF
{
    public partial class Logout : System.Web.UI.Page
    {
        
        protected void Page_Load(object sender, EventArgs e)
        {
            ClsLogout objlogout = new ClsLogout();
            objlogout.doLogout();


           
            Response.Redirect("Login.aspx");
        }

        public void doLogout()
        {
            Session["Hid"] = null;
            Session["HDid"] = null;
            Session["UserType"] = null;
            Session["ClientID"] = null;
            Session["Vid"] = null;
            Session["Anid"] = null;
            Session["BlockID"] = null;
            Session["CsoCapacityId"] = null;
            Session["NCid"] = null;
            Session["Disid"] = null;
            Session["DistrictID"] = null;
            Session["FLid"] = null;
            Session["Nid"] = null;
            Session["Skid"] = null;
            Session["StateId"] = null;
            Session["trno"] = null;
            Session["tno"] = null;
            Session["Cid"] = null;
            Session["VillageID"] = null;
            Session["WfNo"] = null;
            Session["WFDataID"] = null;
            Session["WfgNo"] = null;
            Session["FPCId"] = null;
            Session["FPCid"] = null;
            Session["UserID"] = null;
            Session["Disid"] = null;
            Session["FPCid"] = null;
            Session["FPCid"] = null;
            Session["FPCid"] = null;

            // First we clean the authentication ticket like always
            //required NameSpace: using System.Web.Security;
            FormsAuthentication.SignOut();

            // Second we clear the principal to ensure the user does not retain any authentication
            //required NameSpace: using System.Security.Principal;
          

          
            System.Web.HttpContext.Current.Session.RemoveAll();
            Session.Abandon();
            

        }

    }
}