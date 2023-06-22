using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

namespace CF
{
    public partial class EditVillageList : System.Web.UI.Page
    {
        DbErrorLog db = new DbErrorLog();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["VillageID"] != null)
            {
                Page.UnobtrusiveValidationMode = UnobtrusiveValidationMode.None;
                if (!IsPostBack)
                {
                    LoadData();
                }
            }
        }

        protected void LoadData()
        {
            string query = "select VillageID,Village,a.BlockID, b.DistrictID,c.StateID from tblVillages a left outer join tblBlocks b on a.BlockID = b.BlockID left outer join tblDistricts c on b.DistrictID=c.DistrictID where VillageID=" + Session["VillageID"];
            DataSet ds = db.getResultset(query, "", "", "");
            if (ds != null && ds.Tables[0].Rows.Count > 0)
            {
                loadStates();
                if (ddlState.Items.FindByValue(ds.Tables[0].Rows[0]["StateID"].ToString()) != null)
                {
                    ddlState.Items.FindByValue(ds.Tables[0].Rows[0]["StateID"].ToString()).Selected = true;
                }
                LoadDistricts();
                if (ddlDistrict.Items.FindByValue(ds.Tables[0].Rows[0]["DistrictID"].ToString()) != null)
                {
                    ddlDistrict.Items.FindByValue(ds.Tables[0].Rows[0]["DistrictID"].ToString()).Selected = true;
                }
                LoadBlocks();
                if (ddlBlock.Items.FindByValue(ds.Tables[0].Rows[0]["BlockID"].ToString()) != null)
                {
                    ddlBlock.Items.FindByValue(ds.Tables[0].Rows[0]["BlockID"].ToString()).Selected = true;
                }
                txtVillage.Text = ds.Tables[0].Rows[0]["Village"].ToString();
            }
        }

        protected void loadStates()
        {
            string query = "select StateId,StateName from tblStates order by StateName";
            DataSet ds = db.getResultset(query, "", "", "");
            if (ds != null && ds.Tables[0].Rows.Count > 0)
            {
                ddlState.DataSource = ds;
                ddlState.DataValueField = "StateId";
                ddlState.DataTextField = "StateName";
                ddlState.DataBind();
                ddlState.Items.Insert(0, "Select");
            }
        }

        protected void LoadDistricts()
        {
            if (ddlState.SelectedIndex > 0)
            {
                string query = "select DistrictID,District from tblDistricts where StateID=" + ddlState.SelectedValue + " order by District";
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

        protected void LoadBlocks()
        {
            if (ddlDistrict.SelectedIndex > 0)
            {
                string query = "select BlockID,Block from tblBlocks where DistrictID =" + ddlDistrict.SelectedValue + " order by Block";
                DataSet ds = db.getResultset(query, "", "", "");
                if (ds != null && ds.Tables[0].Rows.Count > 0)
                {
                    ddlBlock.DataSource = ds;
                    ddlBlock.DataValueField = "BlockID";
                    ddlBlock.DataTextField = "Block";
                    ddlBlock.DataBind();
                    ddlBlock.Items.Insert(0, "Select");
                }
            }
        }

        protected void ddlDistrict_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlDistrict.SelectedIndex > 0)
            {
                string query = "select BlockID,Block from tblBlocks where DistrictID =" + ddlDistrict.SelectedValue + " order by Block";
                DataSet ds = db.getResultset(query, "", "", "");
                if (ds != null && ds.Tables[0].Rows.Count > 0)
                {
                    ddlBlock.DataSource = ds;
                    ddlBlock.DataValueField = "BlockID";
                    ddlBlock.DataTextField = "Block";
                    ddlBlock.DataBind();
                    ddlBlock.Items.Insert(0, "Select");
                }
            }
            else
            {
                ddlBlock.Items.Clear();
                ddlBlock.Items.Insert(0, "Select");
            }
        }

        protected void ddlState_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlState.SelectedIndex > 0)
            {
                string query = "select DistrictID,District from tblDistricts where StateID=" + ddlState.SelectedValue + " order by District";
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
            else
            {
                ddlDistrict.Items.Clear();
                ddlDistrict.Items.Insert(0, "Select");
                ddlBlock.Items.Clear();
                ddlBlock.Items.Insert(0, "Select");
            }
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            string query = "update tblVillages set Village='" + txtVillage.Text + "', BlockID=" + ddlBlock.SelectedValue + " where VillageID=" + Session["VillageID"];
            if (db.UpdateQuery(query, "", "", "") > 0)
            {

                ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "ShowAlert('Village Updated Successfully. Thank you.','success')", true);

            }
            else
            {
                ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "ShowAlert('Something went wrong please try again.','warning')", true);
            }
        }
    }
}