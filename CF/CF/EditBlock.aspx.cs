using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CF
{
    public partial class EditBlock : System.Web.UI.Page
    {
        DbErrorLog db = new DbErrorLog();
        string User = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            Page.UnobtrusiveValidationMode = UnobtrusiveValidationMode.None;
            if (Session["UserType"] != null)
            {
                User = Session["UserType"].ToString();
                if (User == "Admin")
                {
                    if (Session["BlockID"] != null)
                    {
                        if (!IsPostBack)
                        {
                            GetStates();
                            GetDetails();
                        }
                    }
                    else
                    {
                        Response.Redirect("~/BlocksInfo.aspx");
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

        public void GetStates()
        {
            string query = "select Stateid,StateName from tblStates order by StateName";
            DataSet ds = db.getResultset(query, "", "", "");
            if (ds != null && ds.Tables[0].Rows.Count > 0)
            {
                ddlState.DataSource = ds;
                ddlState.DataValueField = "Stateid";
                ddlState.DataTextField = "StateName";
                ddlState.DataBind();
                ddlState.Items.Insert(0, "Select");
            }
        }

        public void GetDistricts()
        {
            string query = "select DistrictID,District from tblDistricts where StateID = " + ddlState.SelectedValue + " order by District";
            DataSet ds = db.getResultset(query, "", "", "");
            if (ds != null && ds.Tables[0].Rows.Count > 0)
            {
                ddlDistrict.DataSource = ds;
                ddlDistrict.DataValueField = "DistrictID";
                ddlDistrict.DataTextField = "District";
                ddlDistrict.DataBind();
                ddlDistrict.Items.Insert(0, "Select");
            }
        }

        public void GetDetails()
        {
            string query = "select BlockID,Block,a.DistrictID,StateID from tblBlocks a left outer join tblDistricts b on a.DistrictID = b.DistrictID where BlockID=" + Session["BlockID"];
            DataSet ds = db.getResultset(query, "", "", "");

            if (ds != null && ds.Tables[0].Rows.Count > 0)
            {
                if (ddlState.Items.FindByValue(ds.Tables[0].Rows[0]["StateID"].ToString()) != null)
                {
                    ddlState.Items.FindByValue(ds.Tables[0].Rows[0]["StateID"].ToString()).Selected = true;
                }

                GetDistricts();
                if (ddlDistrict.Items.FindByValue(ds.Tables[0].Rows[0]["DistrictID"].ToString()) != null)
                {
                    ddlDistrict.Items.FindByValue(ds.Tables[0].Rows[0]["DistrictID"].ToString()).Selected = true;
                }

                txtBlock.Text = ds.Tables[0].Rows[0]["Block"].ToString();
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            string State = ddlState.SelectedValue;
            string District = ddlDistrict.SelectedValue;
            string Block = txtBlock.Text;

            string query = "update tblBlocks set Block='" + Block + "',DistrictID=" + District + " where BlockID= " + Session["BlockID"];
            if (db.UpdateQuery(query, "", "", "") > 0)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "ShowAlert('You have submitted data successfully. Thank you.','success')", true);
            }
            else
            {
                ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "ShowAlert('Something went wrong please try again.','warning')", true);
            }
        }

        protected void ddlState_SelectedIndexChanged(object sender, EventArgs e)
        {
            string query = "select DistrictID,District from tblDistricts where StateId=" + ddlState.SelectedValue + " order by District";
            DataSet ds = db.getResultset(query, "", "", "");
            if (ds != null && ds.Tables[0].Rows.Count > 0)
            {
                ddlDistrict.DataSource = ds;
                ddlDistrict.DataValueField = "DistrictID";
                ddlDistrict.DataTextField = "District";
                ddlDistrict.DataBind();
                ddlDistrict.Items.Insert(0, "Select");
            }
        }
    }
}