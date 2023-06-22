using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CF
{
    public partial class ConductedTrainingsInfo : System.Web.UI.Page
    {
        DbErrorLog db = new DbErrorLog();
        protected void Page_Load(object sender, EventArgs e)
        {
            Page.UnobtrusiveValidationMode = UnobtrusiveValidationMode.None;
            if (!IsPostBack)
            {
                GetDetails();
            }
        }

        public void GetDetails()
        {
            string query = "select  trno, TrainingTask, StartDate, EndDate, TrainingName, Budget, NoofTrainings, NoofWomenFarmer from tblTrainings";
            DataSet ds = db.getResultset(query, "", "", "");
            DataTable dt = ds.Tables[0];

            gvProject.DataSource = dt;
            gvProject.DataBind();
        }

        protected void gvProject_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "btnEdit")
            {
                string strid = e.CommandArgument.ToString();
                int rowIndex = int.Parse(e.CommandArgument.ToString());
                string val = (string)this.gvProject.DataKeys[rowIndex]["trno"].ToString();
                Session["trno"] = val;
                Response.Redirect("~/EditTrainings.aspx");
            }
            if (e.CommandName == "btnDelete")
            {
                string strid = e.CommandArgument.ToString();
                int rowIndex = int.Parse(e.CommandArgument.ToString());
                string val = (string)this.gvProject.DataKeys[rowIndex]["trno"].ToString();

                string deleteQ = "delete from tblTrainings where trno=" + val;
                if (db.UpdateQuery(deleteQ, "", "", "") > 0)
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "ShowAlert('You have deleted successfully.','success')", true);
                }
                else
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "ShowAlert('Something went wrong please try again.','warning')", true);
                }
            }
        }

        protected void gvProject_Sorting(object sender, GridViewSortEventArgs e)
        {
            DataTable dtrslt = (DataTable)ViewState["dirState"];

            //DataTable dtrslt = ds.Tables[0];

            if (dtrslt.Rows.Count > 0)
            {

                if (Convert.ToString(ViewState["sortdr"]) == "Asc")
                {
                    dtrslt.DefaultView.Sort = e.SortExpression + " Desc";
                    ViewState["sortdr"] = "Desc";
                }
                else
                {
                    dtrslt.DefaultView.Sort = e.SortExpression + " Asc";
                    ViewState["sortdr"] = "Asc";
                }
                gvProject.DataSource = dtrslt;
                gvProject.DataBind();
            }

            for (int i = 0; i < gvProject.Columns.Count; i++)
            {
                string lbText = gvProject.Columns[i].SortExpression;

                if (lbText == e.SortExpression)
                {
                    TableCell tableCell = gvProject.HeaderRow.Cells[i];
                    Image img = new Image();
                    img.ImageUrl = (Convert.ToString(ViewState["sortdr"]) == "Asc") ? "~/Images/ArrowUp.gif" : "~/Images/ArrowDown.gif";
                    tableCell.Controls.Add(new LiteralControl("&nbsp;"));
                    tableCell.Controls.Add(img);
                }
            }
        }
    }
}