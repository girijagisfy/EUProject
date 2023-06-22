using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

namespace CF
{
    public partial class VillagesList : System.Web.UI.Page
    {
        DbErrorLog db = new DbErrorLog();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                loadStates();
                loadDistricts();
                LoadBlocks();
                GetDetails();
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

        protected void GetDetails()
        {
            string queryFilter = "";
            if (ddlState.SelectedIndex > 0)
            {
                queryFilter += " and c.StateID=" + ddlState.SelectedValue;
            }
            if (ddlDistrict.SelectedIndex > 0)
            {
                queryFilter += " and c.DistrictID=" + ddlDistrict.SelectedValue;
            }
            if (ddlBlock.SelectedIndex > 0)
            {
                queryFilter = " and b.BlockID=" + ddlBlock.SelectedValue;
            }

            string selectQ = "select VillageID, Village, Block, District, StateName from tblVillages a left outer join tblBlocks b on a.BlockID=b.BlockID left outer join tblDistricts c on b.DistrictID=c.DistrictID left outer join tblStates d on c.StateID=d.StateId where 1=1 " + queryFilter + " order by StateName, District, Block, Village";

            DataSet ds = db.getResultset(selectQ, "", "", "");
            DataTable dt = new DataTable();
            if (ds != null && ds.Tables[0].Rows.Count > 0)
            {
                dt = ds.Tables[0];

            }

            gvVillages.DataSource = dt;
            gvVillages.DataBind();

            ViewState["dirState"] = dt;
            ViewState["sortdr"] = "Asc";

        }

        protected void gvVillages_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName.Equals("btnEdit"))
            {
                string strid = e.CommandName.ToString();
                int rowIndex = int.Parse(e.CommandArgument.ToString());
                string val = (string)this.gvVillages.DataKeys[rowIndex]["VillageID"].ToString();
                Session["VillageID"] = val;
                Response.Redirect("EditVillageList.aspx");
            }
        }

        protected void gvVillages_Sorting(object sender, GridViewSortEventArgs e)
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
                gvVillages.DataSource = dtrslt;
                gvVillages.DataBind();
            }

            for (int i = 0; i < gvVillages.Columns.Count; i++)
            {
                string lbText = gvVillages.Columns[i].SortExpression;

                if (lbText == e.SortExpression)
                {
                    TableCell tableCell = gvVillages.HeaderRow.Cells[i];
                    Image img = new Image();
                    img.ImageUrl = (Convert.ToString(ViewState["sortdr"]) == "Asc") ? "~/Images/ArrowUp.gif" : "~/Images/ArrowDown.gif";
                    tableCell.Controls.Add(new LiteralControl("&nbsp;"));
                    tableCell.Controls.Add(img);
                }
            }
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

        protected void LoadBlocks()
        {
            string DistCond = string.Empty;
            if (ddlState.SelectedIndex > 0)
            {
                DistCond += " and b.StateID=" + ddlState.SelectedValue;
            }
            if (ddlDistrict.SelectedIndex > 0)
            {
                DistCond += " and b.DistrictID=" + ddlDistrict.SelectedValue;
            }
            string query = "select BlockID, Block from tblBlocks a left outer join tblDistricts b on a.DistrictID=b.DistrictID where 1=1 " + DistCond + " order by Block";
            DataSet ds = db.getResultset(query, "", "", "");
            if (ds != null && ds.Tables[0].Rows.Count > 0)
            {
                ddlBlock.DataSource = ds;
                ddlBlock.DataTextField = "Block";
                ddlBlock.DataValueField = "BlockID";
                ddlBlock.DataBind();
                ddlBlock.Items.Insert(0, "All");
            }
            else
            {
                ddlBlock.Items.Clear();
            }
        }

        protected void gvVillages_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvVillages.PageIndex = e.NewPageIndex;
            GetDetails();
        }

        protected void searchVillage_SelectedIndexChanged(object sender, EventArgs e)
        {
            GetDetails();
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            GridViewRow gvRow = (GridViewRow)(sender as Control).Parent.Parent;
            int rowIndex = gvRow.RowIndex;
            string val = (string)this.gvVillages.DataKeys[rowIndex]["VillageID"].ToString();
            string deleteQ = "delete from tblVillages where VillageID = " + val;
            if (db.UpdateQuery(deleteQ, "", "", "") > 0)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "ShowAlert('You have deleted Village successfully.','success')", true);
            }
            else
            {
                ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "ShowAlert('Something went wrong / Delete Data Under this Village.','warning')", true);
            }
        }

        protected void ddlBlock_SelectedIndexChanged(object sender, EventArgs e)
        {
            GetDetails();
        }

        protected void ddlDistrict_SelectedIndexChanged(object sender, EventArgs e)
        {
            LoadBlocks();
            GetDetails();
        }

        protected void ddlState_SelectedIndexChanged(object sender, EventArgs e)
        {
            loadDistricts();
            LoadBlocks();
            GetDetails();
        }
    }
}