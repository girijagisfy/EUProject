using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Data;
using System.Web.UI.WebControls;

namespace CF
{
    public partial class EditState : System.Web.UI.Page
    {
        DbErrorLog db = new DbErrorLog();
        string User = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserType"] != null)
            {
                User = Session["UserType"].ToString();
                if (User == "Admin")
                {
                    
                    if (Session["StateId"] != null)
                    {
                        Page.UnobtrusiveValidationMode = UnobtrusiveValidationMode.None;
                        if (!IsPostBack)
                        {
                            GetData();
                        }
                    }
                    else
                    {
                        Response.Redirect("~/StatesInfo.aspx");
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

        public void GetData()
        {
            string query = "select StateID,StateName from tblStates where StateID=" + Session["StateId"];
            DataSet ds = db.getResultset(query, "", "", "");
            if (ds != null && ds.Tables[0].Rows.Count > 0)
            {
                txtState.Text = ds.Tables[0].Rows[0]["StateName"].ToString();
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            string State = txtState.Text;

            string query = "Update tblStates set StateName='" + State + "' where StateID=" + Session["StateId"];

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