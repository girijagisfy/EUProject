using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using CF;
using System.Data;
using System.Configuration;
using CF.Models;

namespace CF
{
    public partial class WFDocsAdd : System.Web.UI.Page
    {
        DbErrorLog db = new DbErrorLog();
        string User = "";
        Generator genobj = new Generator();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserType"] != null)
            {
                User = Session["UserType"].ToString();
                if (User == "Admin")
                {
                    Page.UnobtrusiveValidationMode = UnobtrusiveValidationMode.None;
                    if (!IsPostBack)
                    {
                        LoadCSO();
                    }
                }
                else
                {
                    Response.Redirect("~/Logout.aspx");
                }
            }
            else
            {
                Response.Redirect("~/Logout.aspx");
            }
        }
        protected void LoadCSO()
        {
            string query = "select CSOID, CSOName from tblCSO order by CSOName";
            DataSet ds = db.getResultset(query, "", "", "");

            if (ds != null && ds.Tables[0].Rows.Count > 0)
            {
                ddlCSO.DataSource = ds;
                ddlCSO.DataValueField = "CSOID";
                ddlCSO.DataTextField = "CSOName";
                ddlCSO.DataBind();
                ddlCSO.Items.Insert(0, "Select");
            }
            else
            {
                ddlCSO.Items.Clear();
                ddlCSO.Items.Insert(0, "Select");
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            string InputFileName = string.Empty;
            if (CsoDocs.HasFiles)
            {
                string ServerSavePath = ConfigurationManager.ConnectionStrings["CFMedia"].ConnectionString;
                InputFileName = genobj.Randomlongstring() + "_" + CsoDocs.FileName.Trim();
                CsoDocs.SaveAs(ServerSavePath + InputFileName);
            }

            string query = "insert into tblMasterDocuments(DocumentName, ClientID, UserType) values('" + InputFileName + "','" + ddlWF.SelectedValue + "','WF')";

            if (db.UpdateQuery(query, "", "", "") > 0)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "ShowAlert('You have submitted data successfully. Thank you.','success')", true);
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
                string query = "select Vid,Village from tblVillageInfo a left outer join tblVillages b on a.VillageID=b.VillageID where CSOID=" + ddlCSO.SelectedValue + " order by Village";
                DataSet ds = db.getResultset(query, "", "", "");

                if (ds != null && ds.Tables[0].Rows.Count > 0)
                {
                    ddlvillage.DataSource = ds;
                    ddlvillage.DataValueField = "Vid";
                    ddlvillage.DataTextField = "Village";
                    ddlvillage.DataBind();
                    ddlvillage.Items.Insert(0, "Select");

                    ddlwfg.Items.Clear();
                    ddlwfg.Items.Insert(0, "Select");
                    ddlWF.Items.Clear();
                    ddlWF.Items.Insert(0, "Select");
                }
            }
            else
            {
                ddlvillage.Items.Clear();
                ddlvillage.Items.Insert(0, "Select");

                ddlwfg.Items.Clear();
                ddlwfg.Items.Insert(0, "Select");
                ddlWF.Items.Clear();
                ddlWF.Items.Insert(0, "Select");
            }
        }

        protected void ddlvillage_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlvillage.SelectedIndex > 0)
            {
                string query = "select WfgNo, WFGName from tblWFGs where VillageID = " + ddlvillage.SelectedValue + " order by WFGName";
                DataSet ds = db.getResultset(query, "", "", "");

                if (ds != null && ds.Tables[0].Rows.Count > 0)
                {
                    ddlwfg.DataSource = ds;
                    ddlwfg.DataValueField = "WfgNo";
                    ddlwfg.DataTextField = "WFGName";
                    ddlwfg.DataBind();
                    ddlwfg.Items.Insert(0, "Select");

                    ddlWF.Items.Clear();
                    ddlWF.Items.Insert(0, "Select");

                }
            }
            else
            {
                ddlwfg.Items.Clear();
                ddlwfg.Items.Insert(0, "Select");
                ddlWF.Items.Clear();
                ddlWF.Items.Insert(0, "Select");

            }
        }

        protected void ddlwfg_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlwfg.SelectedIndex > 0)
            {
                string query = "select WFno,WomenName from tblWFs where WFGID = " + ddlwfg.SelectedValue + " order by WomenName";
                DataSet ds = db.getResultset(query, "", "", "");

                if (ds != null && ds.Tables[0].Rows.Count > 0)
                {
                    ddlWF.DataSource = ds;
                    ddlWF.DataValueField = "WFno";
                    ddlWF.DataTextField = "WomenName";
                    ddlWF.DataBind();
                    ddlWF.Items.Insert(0, "Select");

                }
            }
            else
            {
                ddlWF.Items.Clear();
                ddlWF.Items.Insert(0, "Select");

            }
        }
    }
}