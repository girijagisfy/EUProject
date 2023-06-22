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
    public partial class DistrictsInfo : System.Web.UI.Page
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
                        loadDistricts();
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
        public void loadDistricts()
        {
            string query = "SELECT Distinct StateId, StateName from tblStates order by  StateName asc";
            DataSet ds = db.getResultset(query, "", "", "");

            searchStates.DataSource = ds;
            searchStates.DataTextField = "StateName";
            searchStates.DataValueField = "StateId";
            searchStates.DataBind();
            searchStates.Items.Insert(0, "All");
        }
        protected void GetDetails()
        {
            string queryFilter = "";
            if (searchStates.SelectedIndex > 0)
            {
                queryFilter = " where a.StateID=" + searchStates.SelectedValue + "";
            }
            string selectQ = "select DistrictID,District,StateName from tblDistricts a left outer join tblStates b on a.StateID=b.StateId" + queryFilter + "";

            DataSet ds = db.getResultset(selectQ, "", "", "");
            DataTable dt = new DataTable();
            if (ds != null && ds.Tables[0].Rows.Count > 0)
            {
                dt = ds.Tables[0];
            }

            gvDistrict.DataSource = dt;
            gvDistrict.DataBind();

            ViewState["dirState"] = dt;
            ViewState["sortdr"] = "Asc";

        }

        protected void gvDistrict_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName.Equals("btnEdit"))
            {
                string strid = e.CommandName.ToString();
                int rowIndex = int.Parse(e.CommandArgument.ToString());
                string val = (string)this.gvDistrict.DataKeys[rowIndex]["DistrictID"].ToString();
                Session["DistrictID"] = val;
                Response.Redirect("EditDistrict.aspx");
            }
        }

        protected void gvDistrict_Sorting(object sender, GridViewSortEventArgs e)
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
                gvDistrict.DataSource = dtrslt;
                gvDistrict.DataBind();
            }

            for (int i = 0; i < gvDistrict.Columns.Count; i++)
            {
                string lbText = gvDistrict.Columns[i].SortExpression;

                if (lbText == e.SortExpression)
                {
                    TableCell tableCell = gvDistrict.HeaderRow.Cells[i];
                    Image img = new Image();
                    img.ImageUrl = (Convert.ToString(ViewState["sortdr"]) == "Asc") ? "~/Images/ArrowUp.gif" : "~/Images/ArrowDown.gif";
                    tableCell.Controls.Add(new LiteralControl("&nbsp;"));
                    tableCell.Controls.Add(img);
                }
            }
        }

        protected void gvDistrict_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvDistrict.PageIndex = e.NewPageIndex;
            GetDetails();
        }

        protected void searchStatess_SelectedIndexChanged(object sender, EventArgs e)
        {
            GetDetails();
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            GridViewRow gvRow = (GridViewRow)(sender as Control).Parent.Parent;
            int rowIndex = gvRow.RowIndex;
            string val = (string)this.gvDistrict.DataKeys[rowIndex]["DistrictID"].ToString();
            string deleteQ = "delete from tblDistricts where DistrictID=" + val;
            if (db.UpdateQuery(deleteQ, "", "", "") > 0)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "ShowAlert('You have deleted District successfully.','success')", true);
            }
            else
            {
                ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "ShowAlert('Something went wrong / Delete data under this District.','warning')", true);
            }
        }
    }
}