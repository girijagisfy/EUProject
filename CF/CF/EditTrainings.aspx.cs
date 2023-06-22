using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CF
{
    public partial class EditTrainings : System.Web.UI.Page
    {
        DbErrorLog db = new DbErrorLog();
        protected void Page_Load(object sender, EventArgs e)
        {
            Page.UnobtrusiveValidationMode = UnobtrusiveValidationMode.None;
            if (Session["trno"].ToString() != "")
            {
                if (!IsPostBack)
                {
                    FillDetails();
                }
            }
            else
            {
                Response.Redirect("~/ConductedTrainingsInfo.aspx");
            }
        }

        public void FillDetails()
        {
            string id = Session["trno"].ToString();
            string query = "select trno, TrainingTask, StartDate, EndDate, TrainingName, Budget, NoofTrainings, NoofWomenFarmer from tblTrainings where trno=" + id;
            DataSet ds = db.getResultset(query, "", "", "");

            if (ds.Tables[0].Rows.Count > 0)
            {
                DataTable dt = ds.Tables[0];

                txtName.Text = dt.Rows[0]["TrainingName"].ToString();
                txtTask.Text = dt.Rows[0]["TrainingTask"].ToString();
                txtSDate.Text = dt.Rows[0]["StartDate"].ToString();
                txtBudget.Text = dt.Rows[0]["Budget"].ToString();
                txtEDate.Text = dt.Rows[0]["EndDate"].ToString();
                txtNoofTrainings.Text = dt.Rows[0]["NoofTrainings"].ToString();
                txtWFarmer.Text = dt.Rows[0]["NoofWomenFarmer"].ToString();
            }
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            string id = Session["trno"].ToString();
            string query = "update tblTrainings set TrainingTask = '" + txtTask.Text + "', StartDate = '" + txtSDate.Text + "', EndDate = '" + txtEDate.Text + "', TrainingName = '" + txtName.Text + "', Budget = '" + txtBudget.Text + "', NoofTrainings = '" + txtNoofTrainings.Text + "', NoofWomenFarmer = '" + txtWFarmer.Text + "',NoOfAttended = " + txtNoofAttended.Text + ",NoOfNotAttended = " + txtNoofNotAttended.Text + " where trno = " + id;

            if (db.UpdateQuery(query, "", "", "") > 0)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "ShowAlert('Data updated successfully. Thank you.','success')", true);
            }
            else
            {
                ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "ShowAlert('Something went wrong please try again.','warning')", true);
            }
        }
    }
}