using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CF
{
    public partial class EditDistrict : System.Web.UI.Page
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
                    if (Session["DistrictID"] != null)
                    {
                        User = Session["UserType"].ToString();
                        if (!IsPostBack)
                        {
                            GetStates();
                            GetDetails();
                        }
                    }
                    else
                    {
                        Response.Redirect("~/DistrictsInfo.aspx");
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

        public void GetDetails()
        {
            string query = "select District,StateID from tblDistricts where DistrictID=" + Session["DistrictID"];
            DataSet ds = db.getResultset(query, "", "", "");
            if (ds != null && ds.Tables[0].Rows.Count > 0)
            {
                if (ddlState.Items.FindByValue(ds.Tables[0].Rows[0]["StateID"].ToString()) != null)
                {
                    ddlState.Items.FindByValue(ds.Tables[0].Rows[0]["StateID"].ToString()).Selected = true;
                }
                txtDistrict.Text = ds.Tables[0].Rows[0]["District"].ToString();
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            string State = ddlState.SelectedValue;
            string District = txtDistrict.Text;

            string query = "update tblDistricts set District='" + District + "',StateID=" + State + " where DistrictID=" + Session["DistrictID"];
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