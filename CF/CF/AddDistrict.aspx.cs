using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CF
{
    public partial class AddDistrict : System.Web.UI.Page
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
                    if (!IsPostBack)
                    {
                        GetStates();
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
            else
            {
                ddlState.Items.Clear();
                ddlState.Items.Insert(0, "Select");
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            string State = ddlState.SelectedValue;
            string District = txtDistrict.Text;

            string query = "insert into tblDistricts(District,StateID) values('" + District + "'," + State + ")";
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