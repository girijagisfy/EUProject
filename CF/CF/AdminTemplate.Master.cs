using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CF
{
    public partial class AdminTemplate : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string User = "";
            if (Session["UserType"] != null)
            {
                User = Session["UserType"].ToString();
                if (User == "Admin")
                {

                }
                else if (User == "CSO")
                {
                    liCSO.Visible = liFPC.Visible = liStates.Visible = liDistricts.Visible = liBlocks.Visible = liEmail.Visible = liVillageList.Visible = liDocs.Visible = liLogFrame.Visible = false;
                }
                else if (User == "WFG")
                {
                    liCSO.Visible = liVillages.Visible = liUsers.Visible = liWFG.Visible = liWFAssign.Visible = liFPC.Visible = liStates.Visible = liDistricts.Visible = liBlocks.Visible = liEmail.Visible = liVillageList.Visible = liDocs.Visible = liCSOCapacity.Visible  = liLogFrame.Visible = liVillageReport.Visible = false;
                }
            }
            else
            {
                Response.Redirect("~/Logout.aspx");
            }
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Logout.aspx");
        }
    }
}