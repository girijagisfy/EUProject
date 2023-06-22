using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using Excel = Microsoft.Office.Interop.Excel;
using ClosedXML.Excel;
using System.IO;
using System.Drawing;

namespace CF
{
    public partial class WFGInfo : System.Web.UI.Page
    {
        DbErrorLog db = new DbErrorLog();
        string User = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserType"] != null)
            {
                User = Session["UserType"].ToString();
                if (User == "Admin" || User == "CSO")
                {
                    Page.UnobtrusiveValidationMode = UnobtrusiveValidationMode.None;
                    if (!IsPostBack)
                    {
                        GetDetails();
                    }
                }
                if (User == "Admin")
                {
                    btnReport.Visible = false;
                }
            }
            else
            {
                Response.Redirect("~/Logout.aspx");
            }
        }

        public void GetDetails()
        {


            string status = "";
            if (ddlStatus.SelectedIndex == 1)
            {
                status = " and a.Status = 1";
            }
            else if (ddlStatus.SelectedIndex == 2)
            {
                status = " and a.Status = 0";
            }
            string CSOCondetion = "";
            if (Convert.ToString(Session["UserType"]) == "CSO")
            {
                btnFilter.Visible = false;
                CSOCondetion = " and b.CSOID=" + Session["ClientID"];
            }
            string query = "SELECT WfgNo, CSOName, e.Village, WFGName, WFGMembers, d.SocialCategory, Hamlet, PresidentName, PresidentContact, Remarks, a.Status FROM dbo.tblWFGs a left outer join tblVillageInfo c on a.VillageID = c.Vid left outer join tblVillages e on c.VillageID = e.VillageID left outer join tblCso b on b.CSOID = c.Csoid left outer join tblSocialCategory d on d.Sid = a.WFGTypeID  where 1=1" + status + CSOCondetion;
            DataSet ds = db.getResultset(query, "", "", "");
            DataTable dt = new DataTable();
            if (ds != null && ds.Tables[0].Rows.Count > 0)
            {
                dt = ds.Tables[0];
            }

            gvWFG.DataSource = dt;
            gvWFG.DataBind();

            ViewState["dirState"] = dt;
            ViewState["sortdr"] = "Asc";
        }

        protected void gvWFG_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvWFG.PageIndex = e.NewPageIndex;
            GetDetails();
        }

        protected void gvWFG_Sorting(object sender, GridViewSortEventArgs e)
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
                gvWFG.DataSource = dtrslt;
                gvWFG.DataBind();
            }

            for (int i = 0; i < gvWFG.Columns.Count; i++)
            {
                string lbText = gvWFG.Columns[i].SortExpression;

                if (lbText == e.SortExpression)
                {
                    TableCell tableCell = gvWFG.HeaderRow.Cells[i];
                    System.Web.UI.WebControls.Image img = new System.Web.UI.WebControls.Image();
                    img.ImageUrl = (Convert.ToString(ViewState["sortdr"]) == "Asc") ? "~/Images/ArrowUp.gif" : "~/Images/ArrowDown.gif";
                    tableCell.Controls.Add(new LiteralControl("&nbsp;"));
                    tableCell.Controls.Add(img);
                }
            }
        }

        protected void gvWFG_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName != "Sort" && e.CommandName != "Page")
            {
                if (e.CommandName == "btnEdit")
                {
                    string strid = e.CommandArgument.ToString();
                    int rowIndex = int.Parse(e.CommandArgument.ToString());
                    string val = (string)this.gvWFG.DataKeys[rowIndex]["WfgNo"].ToString();
                    Session["WfgNo"] = val;
                    Response.Redirect("~/EditWFG.aspx");
                }
                else if (e.CommandName == "Inactive")
                {
                    GridViewRow row = (GridViewRow)(((Control)e.CommandSource).NamingContainer);
                    int RowIndex = row.RowIndex;
                    string val = (string)this.gvWFG.DataKeys[RowIndex]["WfgNo"].ToString();
                    string deleteQ = "update tblClients set Status=0 where UserType='WFG' and ClientID = " + val + ";update tblWFGs set Status=0 where WfgNo= " + val + "; update tblWFs set Status=0 where WFGID = " + val + ";";
                    if (db.UpdateQuery(deleteQ, "", "", "") > 0)
                    {
                        ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "ShowAlert('You have Deactivated successfully.','success')", true);
                    }
                    else
                    {
                        ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "ShowAlert('Something went wrong please try again.','warning')", true);
                    }
                }
                else if (e.CommandName == "Active")
                {
                    GridViewRow row = (GridViewRow)(((Control)e.CommandSource).NamingContainer);
                    int RowIndex = row.RowIndex;
                    string val = (string)this.gvWFG.DataKeys[RowIndex]["WfgNo"].ToString();
                    string deleteQ = "update tblClients set Status=1 where UserType='WFG' and ClientID = " + val + ";update  tblWFGs set Status=1 where WfgNo= " + val + "; update tblWFs set Status=1 where WFGID = " + val + ";";
                    if (db.UpdateQuery(deleteQ, "", "", "") > 0)
                    {
                        ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "ShowAlert('You have Activated successfully.','success')", true);
                    }
                    else
                    {
                        ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "ShowAlert('Something went wrong please try again.','warning')", true);
                    }
                }
            }
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            GridViewRow gvRow = (GridViewRow)(sender as Control).Parent.Parent;
            int index = gvRow.RowIndex;
            string val = (string)this.gvWFG.DataKeys[index]["WfgNo"].ToString();

            string deleteQ = "Delete from tblWFGs  where WfgNo= " + val + "; ";
            if (db.UpdateQuery(deleteQ, "", "", "") > 0)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "ShowAlert('You have deleted successfully.','success')", true);
            }
            else
            {
                ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "ShowAlert('Something went wrong / Delete Data Under this group.','warning')", true);
            }
        }

        protected void btnReport_Click(object sender, EventArgs e)
        {
            string status = "";
            if (ddlStatus.SelectedIndex == 1)
            {
                status = " and a.Status = 1";
            }
            else if (ddlStatus.SelectedIndex == 2)
            {
                status = " and a.Status = 0";
            }
            string CSOCondetion = "";
            if (Convert.ToString(Session["UserType"]) == "CSO")
            {

                CSOCondetion = " and b.CSOID=" + Session["ClientID"];
            }
            ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "ShowLoader()", true);
            string query = "SELECT WfgNo,StateName,District,Block, CSOName, Village, WFGName, WFGMembers, e.SocialCategory, Hamlet, BankName, AccountHolderName, BankAccountNumber, BankIFSCcode, PresidentName, PresidentContact, Remarks, a.Status FROM dbo.tblWFGs a left outer join tblVillageInfo b on a.VillageID = b.Vid left outer join tblVillages c on b.VillageID=c.VillageID left outer join tblCso d on d.CSOID = b.Csoid left outer join tblSocialCategory e on e.Sid = a.WFGTypeID left outer join tblDistricts f on f.DistrictID=d.DistrictID left outer join tblBlocks g on g.BlockID=d.BlockID left outer join tblStates h on h.StateId=f.StateID where 1=1" + status + CSOCondetion;

            DataSet ds = db.getResultset(query, "", "", "");
            if (ds != null && ds.Tables[0].Rows.Count > 0)
            {
                using (XLWorkbook wb = new XLWorkbook())
                {
                    wb.Worksheets.Add(ds.Tables[0]);
                    using (MemoryStream stream = new MemoryStream())
                    {
                        wb.SaveAs(stream);
                        stream.Position = 0;
                        string myName = Server.UrlEncode("WFGReport_" + DateTime.Now.ToShortDateString() + ".xlsx");

                        Response.Clear();
                        Response.Buffer = true;
                        Response.AddHeader("content-disposition", "attachment; filename=" + myName);
                        Response.ContentType = "application/vnd.ms-excel";
                        Response.BinaryWrite(stream.ToArray());
                        Response.End();
                    }
                }
            }
            else
            {
                ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "ShowAlert('No Records Found.','error','')", true);
            }
        }

        protected void gvWFG_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                string Status = gvWFG.DataKeys[e.Row.RowIndex].Values[1].ToString();

                if (Status == "True")
                {
                    Button btnSave = (Button)e.Row.FindControl("btnStatus");
                    btnSave.Text = "Inactive";
                    btnSave.CommandName = "Inactive";
                    btnSave.CssClass = "btn btn-danger";
                }
                else
                {
                    Button btnSave = (Button)e.Row.FindControl("btnStatus");
                    btnSave.Text = "Active";
                    btnSave.CommandName = "Active";
                    btnSave.CssClass = "btn btn-warning";
                }
            }
        }

        protected void ddlStatus_SelectedIndexChanged(object sender, EventArgs e)
        {
            GetDetails();
        }

        protected void Gridview1_RowCreated(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                if (Convert.ToString(Session["UserType"]) == "CSO")
                {
                    e.Row.Cells[6].CssClass = "hiddencol";
                }
            }
            else if (e.Row.RowType == DataControlRowType.Header)
            {
                if (Convert.ToString(Session["UserType"]) == "CSO")
                {
                    e.Row.Cells[6].CssClass = "hiddencol";
                }
            }
        }
    }
}