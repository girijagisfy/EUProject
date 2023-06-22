using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CF
{
    public partial class WFAssignPage : System.Web.UI.Page
    {
        DbErrorLog db = new DbErrorLog();
        string User = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserType"] != null)
            {
                User = Session["UserType"].ToString();
                if (User == "Admin" || User == "CSO")
                {
                    Page.UnobtrusiveValidationMode = UnobtrusiveValidationMode.None;
                    if (!IsPostBack)
                    {

                        LoadCSOs();
                    }
                }
                else
                {
                    Response.Redirect("Logout.aspx");
                }
            }
            else
            {
                Response.Redirect("Logout.aspx");
            }
        }

        public void LoadCSOs()
        {
            string CSOCond = string.Empty;
            if (User == "CSO")
            {
                CSOCond = " and Csoid=" + Session["ClientID"];
            }
            string query = "select Csoid,Csoname from tblCso where Status=1 " + CSOCond + " order by Csoname ";
            DataSet ds = db.getResultset(query, "", "", "");

            if (ds != null && ds.Tables[0].Rows.Count > 0)
            {
                ddlCSO.DataSource = ds;
                ddlCSO.DataValueField = "Csoid";
                ddlCSO.DataTextField = "Csoname";
                ddlCSO.DataBind();
                ddlCSO.Items.Insert(0, "Select");
            }
        }

        protected void ddlVillage_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlVillage.SelectedIndex > 0)
            {
                string query = "select WfgNo,WFGName from tblWFGs where Status=1 and VillageID = " + ddlVillage.SelectedValue + " order by WFGName";
                DataSet ds = db.getResultset(query, "", "", "");

                if (ds != null && ds.Tables[0].Rows.Count > 0)
                {
                    ddlWFGs.DataSource = ds;
                    ddlWFGs.DataValueField = "WfgNo";
                    ddlWFGs.DataTextField = "WFGName";
                    ddlWFGs.DataBind();
                    ddlWFGs.Items.Insert(0, "Select");
                }

                string WFquery = "select WFno,concat(WomenName,'-',HusbandName) as WomenName from tblWFs where Status=1 and WFGID is null and VillageID = " + ddlVillage.SelectedValue + " order by WomenName";
                DataSet wfds = db.getResultset(WFquery, "", "", "");

                if (wfds != null && wfds.Tables[0].Rows.Count > 0)
                {
                    ddlWFs.DataSource = wfds;
                    ddlWFs.DataValueField = "WFno";
                    ddlWFs.DataTextField = "WomenName";
                    ddlWFs.DataBind();
                }

            }
            else
            {
                ddlWFs.Items.Clear();
                ddlWFGs.Items.Clear();
                ddlWFGs.Items.Insert(0, "Select");
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            string WFG = ddlWFGs.SelectedValue;
            string WFs = "";
            foreach (ListItem li in ddlWFs.Items)
            {
                if (li.Selected)
                {
                    if (WFs == "")
                    {
                        WFs += li.Value;
                    }
                    else
                    {
                        WFs += "," + li.Value;
                    }
                }
            }
            WFs = WFs.Remove(WFs.Length - 1, 1);
            string query = "update tblWFs set WFGID = " + WFG + " where WFno in (" + WFs + ")";

            if (db.UpdateQuery(query, "", "", "") > 0)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "ShowAlert('Women Profiles Transferred successfully. Thank you.','success')", true);
            }
            else
            {
                ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "ShowAlert('Something went wrong please try again.','warning')", true);
            }
        }

        protected void ddlCSO_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlCSO.SelectedIndex > 0)
            {
                string query = "select Vid,village from tblVillageInfo a left outer join tblVillages b on a.VillageID = b.VillageID where Status=1 and CSOID = " + ddlCSO.SelectedValue + " order by village ";
                DataSet ds = db.getResultset(query, "", "", "");

                if (ds != null && ds.Tables[0].Rows.Count > 0)
                {
                    ddlVillage.DataSource = ds;
                    ddlVillage.DataValueField = "Vid";
                    ddlVillage.DataTextField = "village";
                    ddlVillage.DataBind();
                    ddlVillage.Items.Insert(0, "Select");
                }
            }
            else
            {
                ddlVillage.Items.Clear();
                ddlVillage.Items.Insert(0, "Select");
                ddlWFs.Items.Clear();
                ddlWFGs.Items.Clear();
                ddlWFGs.Items.Insert(0, "Select");
            }
        }
    }
}