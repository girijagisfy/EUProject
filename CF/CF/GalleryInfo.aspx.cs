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
    public partial class GalleryInfo : System.Web.UI.Page
    {


        DbErrorLog db = new DbErrorLog();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserType"] != null)
            {
                if (!IsPostBack)
                {
                    GetDetails();
                }
            }
            else
            {
                Response.Redirect("~/Logout.aspx");
            }
        }

        public void GetDetails()
        {
            // string MediaPath = ConfigurationManager.ConnectionStrings["CFMedia1"].ToString();
            string Getquery = "select * from tblImages where Type='Image' ";
            DataSet ds = db.getResultset(Getquery, "", "", "");

            DataTable dt = new DataTable();

            if (ds != null && ds.Tables[0].Rows.Count > 0)
            {
                string path = ConfigurationManager.ConnectionStrings["CFMedia1"].ConnectionString;
                for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                {
                    string Image = path + ds.Tables[0].Rows[i]["ImagePath"].ToString();
                    ds.Tables[0].Rows[i]["ImagePath"] = Image;
                    string videos = path + ds.Tables[0].Rows[i]["VideoPath"].ToString();
                    ds.Tables[0].Rows[i]["VideoPath"] = videos;
                }

                dt = ds.Tables[0];

                gallery.DataSource = dt;
                gallery.DataBind();

            }

            Getquery = "select * from tblImages where Type='Video' ";
            ds = db.getResultset(Getquery, "", "", "");

            dt = new DataTable();

            if (ds != null && ds.Tables[0].Rows.Count > 0)
            {
                string path = ConfigurationManager.ConnectionStrings["CFMedia1"].ConnectionString;
                for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                {
                    string Image = path + ds.Tables[0].Rows[i]["ImagePath"].ToString();
                    ds.Tables[0].Rows[i]["ImagePath"] = Image;
                    string videos = path + ds.Tables[0].Rows[i]["VideoPath"].ToString();
                    ds.Tables[0].Rows[i]["VideoPath"] = videos;
                }

                dt = ds.Tables[0];



                gvVideos.DataSource = dt;
                gvVideos.DataBind();
            }


        }

        protected void gallery_RowCommand(object sender, GridViewCommandEventArgs e)
        {

        }

        protected void gvVideos_RowCommand(object sender, GridViewCommandEventArgs e)
        {

        }

        protected void gallery_Sorting(object sender, GridViewSortEventArgs e)
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
                gallery.DataSource = dtrslt;
                gallery.DataBind();
            }

            for (int i = 0; i < gallery.Columns.Count; i++)
            {
                string lbText = gallery.Columns[i].SortExpression;

                if (lbText == e.SortExpression)
                {
                    TableCell tableCell = gallery.HeaderRow.Cells[i];
                    Image img = new Image();
                    img.ImageUrl = (Convert.ToString(ViewState["sortdr"]) == "Asc") ? "~/Images/ArrowUp.gif" : "~/Images/ArrowDown.gif";
                    tableCell.Controls.Add(new LiteralControl("&nbsp;"));
                    tableCell.Controls.Add(img);
                }
            }
        }

        protected void gallery_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gallery.PageIndex = e.NewPageIndex;
            GetDetails();
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            GridViewRow gvRow = (GridViewRow)(sender as Control).Parent.Parent;
            int rowIndex = gvRow.RowIndex;
            string val = (string)this.gallery.DataKeys[rowIndex]["ImageId"].ToString();
            string deleteQ = "delete from tblImages where ImageId=" + val;
            if (db.UpdateQuery(deleteQ, "", "", "") > 0)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "ShowAlert('You have deleted Images successfully.','success')", true);
            }
            else
            {
                ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "ShowAlert('Something went wrong please try again.','warning')", true);
            }
        }

        protected void btnDelete_Click1(object sender, EventArgs e)
        {
            GridViewRow gvRow = (GridViewRow)(sender as Control).Parent.Parent;
            int rowIndex = gvRow.RowIndex;
            string val = (string)this.gvVideos.DataKeys[rowIndex]["ImageId"].ToString();
            string deleteQ = "delete from tblImages where ImageId=" + val;
            if (db.UpdateQuery(deleteQ, "", "", "") > 0)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "ShowAlert('You have deleted Images successfully.','success')", true);
            }
            else
            {
                ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "ShowAlert('Something went wrong please try again.','warning')", true);
            }
        }
    }
}
