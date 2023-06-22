using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using CF;

namespace CF
{
    public partial class StatesInfo : System.Web.UI.Page
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
                    if (!IsPostBack)
                    {
                        loadStates();
                        GetDetails();
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
        public void loadStates()
        {
            string query = "SELECT Distinct StateName from tblStates order by StateName asc";
            DataSet ds = db.getResultset(query, "", "", "");

            searchStates.DataSource = ds;
            searchStates.DataTextField = "StateName";
            searchStates.DataValueField = "StateName";
            searchStates.DataBind();
            searchStates.Items.Insert(0, "All");
        }
        protected void GetDetails()
        {
            string queryFilter = "";
            if (searchStates.SelectedIndex > 0)
            {
                queryFilter = " where StateName='" + searchStates.SelectedValue + "'";
            }
            string CSOCondetion = "";
            if (Convert.ToString(Session["UserType"]) == "CSO")
            {
                CSOCondetion = " and a.CSOID=" + Session["ClientID"];
            }
            string selectQ = "SELECT StateId,StateName from tblStates " + queryFilter + " order by StateName";

            DataSet ds = db.getResultset(selectQ, "", "", "");
            DataTable dt = new DataTable();
            if (ds != null && ds.Tables[0].Rows.Count > 0)
            {
                dt = ds.Tables[0];

                gvStates.DataSource = dt;
                gvStates.DataBind();

                ViewState["dirState"] = dt;
                ViewState["sortdr"] = "Asc";
            }
        }

        protected void gvStates_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName.Equals("btnEdit"))
            {
                string strid = e.CommandName.ToString();
                int rowIndex = int.Parse(e.CommandArgument.ToString());
                string val = (string)this.gvStates.DataKeys[rowIndex]["StateId"].ToString();
                Session["StateId"] = val;
                Response.Redirect("EditState.aspx");
            }
        }

        protected void gvStates_Sorting(object sender, GridViewSortEventArgs e)
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
                gvStates.DataSource = dtrslt;
                gvStates.DataBind();
            }

            for (int i = 0; i < gvStates.Columns.Count; i++)
            {
                string lbText = gvStates.Columns[i].SortExpression;

                if (lbText == e.SortExpression)
                {
                    TableCell tableCell = gvStates.HeaderRow.Cells[i];
                    Image img = new Image();
                    img.ImageUrl = (Convert.ToString(ViewState["sortdr"]) == "Asc") ? "~/Images/ArrowUp.gif" : "~/Images/ArrowDown.gif";
                    tableCell.Controls.Add(new LiteralControl("&nbsp;"));
                    tableCell.Controls.Add(img);
                }
            }
        }

        protected void gvStates_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvStates.PageIndex = e.NewPageIndex;
            GetDetails();
        }

        protected void searchStates_SelectedIndexChanged(object sender, EventArgs e)
        {
            GetDetails();
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            GridViewRow gvRow = (GridViewRow)(sender as Control).Parent.Parent;
            int rowIndex = gvRow.RowIndex;
            string val = (string)this.gvStates.DataKeys[rowIndex]["StateId"].ToString();
            string deleteQ = "delete from tblStates where StateId=" + val;
            if (db.UpdateQuery(deleteQ, "", "", "") > 0)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "ShowAlert('You have deleted State successfully.','success')", true);
            }
            else
            {
                ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "ShowAlert('Something went wrong / Delete Data Under this State.','warning')", true);
            }
        }
    }
}