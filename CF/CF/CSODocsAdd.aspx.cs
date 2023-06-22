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
    public partial class CSODocsAdd : System.Web.UI.Page
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
        //public void LoadStates()
        //{
        //    string query = "select StateId,StateName from tblStates order by StateName";
        //    DataSet ds = db.getResultset(query, "", "", "");

        //    if (ds != null && ds.Tables[0].Rows.Count > 0)
        //    {
        //        ddlStates.DataSource = ds;
        //        ddlStates.DataValueField = "StateId";
        //        ddlStates.DataTextField = "StateName";
        //        ddlStates.DataBind();
        //        ddlStates.Items.Insert(0, "Select");
        //    }
        //}

        //protected void ddlStates_SelectedIndexChanged(object sender, EventArgs e)
        //{
        //    if (ddlStates.SelectedIndex > 0)
        //    {
        //        string query = "select DistrictID,District from tblDistricts  where StateID = " + ddlStates.SelectedValue + " order by District";
        //        DataSet ds = db.getResultset(query, "", "", "");

        //        if (ds != null && ds.Tables[0].Rows.Count > 0)
        //        {
        //            ddlDisrtict.DataSource = ds;
        //            ddlDisrtict.DataValueField = "DistrictID";
        //            ddlDisrtict.DataTextField = "District";
        //            ddlDisrtict.DataBind();
        //            ddlDisrtict.Items.Insert(0, "Select");
        //        }
        //        else
        //        {
        //            ddlDisrtict.Items.Clear();
        //            ddlDisrtict.Items.Insert(0, "Select");

        //            ddlBlocks.Items.Clear();
        //            ddlBlocks.Items.Insert(0, "Select");
        //        }
        //    }
        //    else
        //    {
        //        ddlDisrtict.Items.Clear();
        //        ddlDisrtict.Items.Insert(0, "Select");
        //    }
        //}

        //protected void ddlDisrtict_SelectedIndexChanged(object sender, EventArgs e)
        //{
        //    if (ddlDisrtict.SelectedIndex > 0)
        //    {
        //        string query = "select BlockID,Block from tblBlocks  where DistrictID = " + ddlDisrtict.SelectedValue + " order by Block";
        //        DataSet ds = db.getResultset(query, "", "", "");

        //        if (ds != null && ds.Tables[0].Rows.Count > 0)
        //        {
        //            ddlBlocks.DataSource = ds;
        //            ddlBlocks.DataValueField = "BlockID";
        //            ddlBlocks.DataTextField = "Block";
        //            ddlBlocks.DataBind();
        //            ddlBlocks.Items.Insert(0, "Select");
        //        }
        //    }
        //    else
        //    {
        //        ddlBlocks.Items.Clear();
        //        ddlBlocks.Items.Insert(0, "Select");
        //    }
        //}

        //protected void ddlBlocks_SelectedIndexChanged(object sender, EventArgs e)
        //{
        //    if (ddlBlocks.SelectedIndex > 0)
        //    {
        //        string query = "select CSOID, CSOName from tblCSO where BlockID = " + ddlBlocks.SelectedValue + " order by CSOName";
        //        DataSet ds = db.getResultset(query, "", "", "");

        //        if (ds != null && ds.Tables[0].Rows.Count > 0)
        //        {
        //            ddlCSO.DataSource = ds;
        //            ddlCSO.DataValueField = "CSOID";
        //            ddlCSO.DataTextField = "CSOName";
        //            ddlCSO.DataBind();
        //            ddlCSO.Items.Insert(0, "Select");
        //        }
        //    }
        //    else
        //    {
        //        ddlCSO.Items.Clear();
        //        ddlCSO.Items.Insert(0, "Select");
        //    }
        //}

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            string InputFileName = string.Empty;
            if (CsoDocs.HasFiles)
            {
                string ServerSavePath = ConfigurationManager.ConnectionStrings["CFMedia"].ConnectionString;
                InputFileName = genobj.Randomlongstring() + "_" + CsoDocs.FileName.Trim();
                CsoDocs.SaveAs(ServerSavePath + InputFileName);
            }

            string query = "insert into tblMasterDocuments(DocumentName, ClientID, UserType) values('" + InputFileName + "','" + ddlCSO.SelectedValue + "','CSO')";

            if (db.UpdateQuery(query, "", "", "") > 0)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "ShowAlert('You have submitted data successfully. Thank you.','success')", true);
            }
            else
            {
                ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "ShowAlert('Something went wrong please try again.','warning')", true);
            }
        }
    }
}