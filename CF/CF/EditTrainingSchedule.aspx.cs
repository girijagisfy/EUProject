using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CF
{
    public partial class EditTrainingSchedule : System.Web.UI.Page
    {
        DbErrorLog db = new DbErrorLog();
        protected void Page_Load(object sender, EventArgs e)
        {
            Page.UnobtrusiveValidationMode = UnobtrusiveValidationMode.None;
            if (Session["tno"].ToString() != "")
            {
                if (!IsPostBack)
                {
                    LoadData();
                }
            }
            else
            {
                Response.Redirect("~/TrainingScheduleInfo.aspx");
            }
        }

        public void LoadData()
        {
            string id = Session["tno"].ToString();
            string query = "SELECT tno,TrainingName,TrainingTask,StartDate,EndDate,NoofTrainings,Area,CSOName,WFGName FROM CF.dbo.tblTrainingSchedules where tno=" + id;
            DataSet ds = db.getResultset(query, "", "", "");

            if (ds.Tables[0].Rows.Count > 0)
            {
                DataTable dt = ds.Tables[0];
                LoadTrainings();
                LoadCSO();

                txtTask.Text = dt.Rows[0]["TrainingTask"].ToString();
                txtSDate.Text = dt.Rows[0]["StartDate"].ToString();
                txtArea.Text = dt.Rows[0]["Area"].ToString();
                txtEDate.Text = dt.Rows[0]["EndDate"].ToString();
                txtTrainings.Text = dt.Rows[0]["NoofTrainings"].ToString();
                ddlTrainingName.Items.FindByValue(dt.Rows[0]["TrainingName"].ToString()).Selected = true;
                ddlCSO.Items.FindByValue(dt.Rows[0]["CSOName"].ToString()).Selected = true;
                ddlWFG.Items.FindByValue(dt.Rows[0]["WFGName"].ToString()).Selected = true;
            }
        }

        public void LoadTrainings()
        {
            string query = "select TrainingName from tblTrainings";
            DataSet ds = db.getResultset(query, "", "", "");

            ddlTrainingName.DataSource = ds;
            ddlTrainingName.DataTextField = "TrainingName";
            ddlTrainingName.DataValueField = "TrainingName";
            ddlTrainingName.DataBind();
            ddlTrainingName.Items.Insert(0, "Select");
        }

        public void LoadCSO()
        {
            string query = "select NameofChief from tblCso";
            DataSet ds = db.getResultset(query, "", "", "");

            ddlCSO.DataSource = ds;
            ddlCSO.DataTextField = "NameofChief";
            ddlCSO.DataValueField = "NameofChief";
            ddlCSO.DataBind();
            ddlCSO.Items.Insert(0, "Select");
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            string query = "update tblTrainingSchedules set TrainingTask = '" + txtTask.Text + "', StartDate = '" + txtSDate.Text + "', EndDate = '" + txtEDate.Text + "', TrainingName = '" + ddlTrainingName.SelectedValue + "', Area = '" + txtArea.Text + "', NoofTrainings = '" + txtTrainings.Text + "', CSOName = '" + ddlCSO.SelectedValue + "',WFGName = '" + ddlWFG.SelectedValue + "' where tno = " + Session["tno"];

            if (db.UpdateQuery(query, "", "", "") > 0)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "ShowAlert(You have submitted data successfully. Thank you.','success')", true);
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
                string query = "select WFGName from tblWFGs where CSOName = '" + ddlCSO.SelectedValue + "'";
                DataSet ds = db.getResultset(query, "", "", "");

                ddlWFG.DataSource = ds;
                ddlWFG.DataTextField = "WFGName";
                ddlWFG.DataValueField = "WFGName";
                ddlWFG.DataBind();
                ddlWFG.Items.Insert(0, "Select");
            }
        }
    }
}