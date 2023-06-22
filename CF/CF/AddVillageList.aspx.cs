using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

namespace CF
{
    public partial class AddVillageList : System.Web.UI.Page
    {
        DbErrorLog db = new DbErrorLog();
        protected void Page_Load(object sender, EventArgs e)
        {
            Page.UnobtrusiveValidationMode = UnobtrusiveValidationMode.None;
            if (!IsPostBack)
            {
                loadStates();
            }
        }

        protected void loadStates()
        {
            string query = "select StateId,StateName from tblStates";
            DataSet ds = db.getResultset(query, "", "", "");
            if (ds != null && ds.Tables[0].Rows.Count > 0)
            {
                ddlState.DataSource = ds;
                ddlState.DataValueField = "StateId";
                ddlState.DataTextField = "StateName";
                ddlState.DataBind();
                ddlState.Items.Insert(0, "Select");
            }
            else
            {
                ddlState.Items.Clear();
                ddlState.Items.Insert(0, "Select");
            }
        }

        protected void ddlDistrict_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlDistrict.SelectedIndex > 0)
            {
                string query = "select BlockID,Block from tblBlocks where DistrictID =" + ddlDistrict.SelectedValue;
                DataSet ds = db.getResultset(query, "", "", "");
                if (ds != null && ds.Tables[0].Rows.Count > 0)
                {
                    ddlBlock.DataSource = ds;
                    ddlBlock.DataValueField = "BlockID";
                    ddlBlock.DataTextField = "Block";
                    ddlBlock.DataBind();
                    ddlBlock.Items.Insert(0, "Select");
                }
                else
                {
                    ddlBlock.Items.Clear();
                    ddlBlock.Items.Insert(0, "Select");
                }
            }
            else
            {
                ddlBlock.Items.Clear();
                ddlBlock.Items.Insert(0, "Select");
            }
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            string query = "insert into tblVillages ( Village, BlockID) values('" + txtVillage.Text + "'," + ddlBlock.SelectedValue + ")";
            if (db.UpdateQuery(query, "", "", "") > 0)
            {

                ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "ShowAlert('Village Added Successfully. Thank you.','success')", true);

            }
            else
            {
                ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "ShowAlert('Something went wrong please try again.','warning')", true);
            }
        }

        protected void ddlState_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlState.SelectedIndex > 0)
            {
                string query = "select DistrictID,District from tblDistricts where StateID=" + ddlState.SelectedValue;
                DataSet ds = db.getResultset(query, "", "", "");
                if (ds != null && ds.Tables[0].Rows.Count > 0)
                {
                    ddlDistrict.DataSource = ds;
                    ddlDistrict.DataValueField = "DistrictID";
                    ddlDistrict.DataTextField = "District";
                    ddlDistrict.DataBind();
                    ddlDistrict.Items.Insert(0, "Select");
                }
                else
                {
                    ddlDistrict.Items.Clear();
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

       
    }
}