using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Configuration;

namespace CF
{
    public partial class WFGDocs : System.Web.UI.Page
    {
        DbErrorLog db = new DbErrorLog();
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
                GetDetails();
            }


        }

        public void GetDetails()
        {
            // string MediaPath = ConfigurationManager.ConnectionStrings["CFMedia1"].ToString();
            string Getquery = "select DicID, WFGName, DocumentName from tblMasterDocuments a left outer join tblWFGs b on a.ClientID=b.WfgNo where a.UserType = 'WFG'";
            DataSet ds = db.getResultset(Getquery, "", "", "");

            DataTable dt = new DataTable();

            if (ds != null && ds.Tables[0].Rows.Count > 0)
            {
                dt = ds.Tables[0];

                gvDocs.DataSource = dt;
                gvDocs.DataBind();

                ViewState["dirState"] = dt;
                ViewState["sortdr"] = "Asc";

            }
        }

        protected void gvDocs_RowCommand(object sender, GridViewCommandEventArgs e)
        {

        }

        protected void gvDocs_Sorting(object sender, GridViewSortEventArgs e)
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
                gvDocs.DataSource = dtrslt;
                gvDocs.DataBind();
            }

            for (int i = 0; i < gvDocs.Columns.Count; i++)
            {
                string lbText = gvDocs.Columns[i].SortExpression;

                if (lbText == e.SortExpression)
                {
                    TableCell tableCell = gvDocs.HeaderRow.Cells[i];
                    Image img = new Image();
                    img.ImageUrl = (Convert.ToString(ViewState["sortdr"]) == "Asc") ? "~/Images/ArrowUp.gif" : "~/Images/ArrowDown.gif";
                    tableCell.Controls.Add(new LiteralControl("&nbsp;"));
                    tableCell.Controls.Add(img);
                }
            }
        }

        protected void gvDocs_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvDocs.PageIndex = e.NewPageIndex;
            GetDetails();
        }

        protected void gvDocs_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            string path = ConfigurationManager.ConnectionStrings["CFMedia1"].ConnectionString;
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                HyperLink hl = (HyperLink)e.Row.FindControl("Link");
                if (hl != null)
                {
                    DataRowView drv = (DataRowView)e.Row.DataItem;
                    string keyword = drv["DocumentName"].ToString().Trim();
                    hl.Text = keyword;
                    hl.NavigateUrl = path + keyword;
                }
            }
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            GridViewRow gvRow = (GridViewRow)(sender as Control).Parent.Parent;
            int rowIndex = gvRow.RowIndex;
            string val = (string)this.gvDocs.DataKeys[rowIndex]["DicID"].ToString();
            string deleteQ = "delete from tblMasterDocuments where DicID=" + val;
            if (db.UpdateQuery(deleteQ, "", "", "") > 0)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "ShowAlert('You have deleted Document successfully.','success')", true);
            }
            else
            {
                ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "ShowAlert('Something went wrong please try again.','warning')", true);
            }
        }
    }
}