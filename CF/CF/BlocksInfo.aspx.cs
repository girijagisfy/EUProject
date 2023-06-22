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
    public partial class BlocksInfo : System.Web.UI.Page
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
        protected void loadStates()
        {
            string query = "select StateId, StateName from tblstates order by StateName";
            DataSet ds = db.getResultset(query, "", "", "");
            ddlState.DataSource = ds;
            ddlState.DataTextField = "StateName";
            ddlState.DataValueField = "StateId";
            ddlState.DataBind();
            ddlState.Items.Insert(0, "All");
        }

        protected void loadDistricts()
        {
            string DistCond = string.Empty;
            if (ddlState.SelectedIndex > 0)
            {
                DistCond = " and StateID=" + ddlState.SelectedValue;
            }
            string query = "select DistrictID,District from tblDistricts where 1=1 " + DistCond + " order by District";
            DataSet ds = db.getResultset(query, "", "", "");
            if (ds != null && ds.Tables[0].Rows.Count > 0)
            {
                ddlDistrict.DataSource = ds;
                ddlDistrict.DataTextField = "District";
                ddlDistrict.DataValueField = "DistrictID";
                ddlDistrict.DataBind();
                ddlDistrict.Items.Insert(0, "All");
            }
            else
            {
                ddlDistrict.Items.Clear();
            }
        }
        protected void GetDetails()
        {
            string StateCond = string.Empty;
            if (ddlState.SelectedIndex > 0)
            {
                StateCond = " where c.StateId=" + ddlState.SelectedValue;
            }
            string DistCond = string.Empty;
            if (ddlDistrict.SelectedIndex > 0)
            {
                DistCond = " where b.DistrictID=" + ddlDistrict.SelectedValue;
            }

            string selectQ = "select BlockID,StateName,District,Block from tblBlocks a left outer join tblDistricts b on a.DistrictID=b.DistrictID left outer join tblStates c on b.StateID=c.StateId" + StateCond + DistCond + " order by StateName,District,Block";

            DataSet ds = db.getResultset(selectQ, "", "", "");
            DataTable dt = new DataTable();
            if (ds != null && ds.Tables[0].Rows.Count > 0)
            {
                dt = ds.Tables[0];
            }

            gvBlock.DataSource = dt;
            gvBlock.DataBind();

            ViewState["dirState"] = dt;
            ViewState["sortdr"] = "Asc";
        }

        protected void gvBlock_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName.Equals("btnEdit"))
            {
                string strid = e.CommandName.ToString();
                int rowIndex = int.Parse(e.CommandArgument.ToString());
                string val = (string)this.gvBlock.DataKeys[rowIndex]["BlockID"].ToString();
                Session["BlockID"] = val;
                Response.Redirect("EditBlock.aspx");
            }
        }

        protected void gvBlock_Sorting(object sender, GridViewSortEventArgs e)
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
                gvBlock.DataSource = dtrslt;
                gvBlock.DataBind();
            }

            for (int i = 0; i < gvBlock.Columns.Count; i++)
            {
                string lbText = gvBlock.Columns[i].SortExpression;

                if (lbText == e.SortExpression)
                {
                    TableCell tableCell = gvBlock.HeaderRow.Cells[i];
                    Image img = new Image();
                    img.ImageUrl = (Convert.ToString(ViewState["sortdr"]) == "Asc") ? "~/Images/ArrowUp.gif" : "~/Images/ArrowDown.gif";
                    tableCell.Controls.Add(new LiteralControl("&nbsp;"));
                    tableCell.Controls.Add(img);
                }
            }
        }

        protected void gvBlock_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvBlock.PageIndex = e.NewPageIndex;
            GetDetails();
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            GridViewRow gvRow = (GridViewRow)(sender as Control).Parent.Parent;
            int rowIndex = gvRow.RowIndex;
            string val = (string)this.gvBlock.DataKeys[rowIndex]["BlockID"].ToString();
            string deleteQ = "delete from tblBlocks where BlockID=" + val;
            if (db.UpdateQuery(deleteQ, "", "", "") > 0)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "ShowAlert('You have deleted Block successfully.','success')", true);
            }
            else
            {
                ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "ShowAlert('Something went wrong / Delete data under this Block.','warning')", true);
            }
        }

        protected void ddlDistrict_SelectedIndexChanged(object sender, EventArgs e)
        {
            GetDetails();
        }

        protected void ddlState_SelectedIndexChanged(object sender, EventArgs e)
        {
            loadDistricts();
            GetDetails();
        }
    }
}