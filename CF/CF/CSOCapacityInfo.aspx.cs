using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using CF;
using ClosedXML.Excel;
using System.IO;

namespace CF
{
    public partial class CSOCapacityInfo : System.Web.UI.Page
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
            else
            {
                Response.Redirect("~/Logout.aspx");
            }
        }

        protected void GetDetails()
        {
            string CSOCondetion = "";
            if (Convert.ToString(Session["UserType"]) == "CSO")
            {
                CSOCondetion = " and a.CSOID=" + Session["ClientID"];
            }
            string selectQ = "SELECT CsoCapacityId,Csoname,District,Block,Year,Quarter,QuarterlyStatus FROM [dbo].tblCso a, tblBlocks b,tblDistricts c, tblCsoCapacity d where a.BlockID=b.BlockID and a.DistrictID = c.DistrictID and a.CsoId=d.CsoId" + CSOCondetion + " order by Csoname,Year,Quarter";

            DataSet ds = db.getResultset(selectQ, "", "", "");
            DataTable dt = new DataTable();
            if (ds != null && ds.Tables[0].Rows.Count > 0)
            {
                dt = ds.Tables[0];
            }

            Gridview1.DataSource = dt;
            Gridview1.DataBind();

            ViewState["dirState"] = dt;
            ViewState["sortdr"] = "Asc";
        }

        protected void Gridview1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName != "Sort" && e.CommandName != "Page")
            {
                if (e.CommandName.Equals("btnEdit"))
                {
                    string strid = e.CommandName.ToString();
                    int rowIndex = int.Parse(e.CommandArgument.ToString());
                    string val = (string)this.Gridview1.DataKeys[rowIndex]["CsoCapacityId"].ToString();
                    Session["CsoCapacityId"] = val;
                    Response.Redirect("EditCsoCapacity.aspx");
                }
            }
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            GridViewRow gvRow = (GridViewRow)(sender as Control).Parent.Parent;
            int index = gvRow.RowIndex;
            string val = (string)this.Gridview1.DataKeys[index]["CsoCapacityId"].ToString();

            string deleteQ = "Delete from tblCsoCapacity where CsoCapacityId=" + val;
            if (db.UpdateQuery(deleteQ, "", "", "") > 0)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "ShowAlert('CSO Capacity Building Deleted Successfully.','success')", true);
            }
            else
            {
                ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "ShowAlert('Something went wrong please try again.','warning')", true);
            }
        }

        protected void Gridview1_Sorting(object sender, GridViewSortEventArgs e)
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
                Gridview1.DataSource = dtrslt;
                Gridview1.DataBind();
            }

            for (int i = 0; i < Gridview1.Columns.Count; i++)
            {
                string lbText = Gridview1.Columns[i].SortExpression;

                if (lbText == e.SortExpression)
                {
                    TableCell tableCell = Gridview1.HeaderRow.Cells[i];
                    Image img = new Image();
                    img.ImageUrl = (Convert.ToString(ViewState["sortdr"]) == "Asc") ? "~/Images/ArrowUp.gif" : "~/Images/ArrowDown.gif";
                    tableCell.Controls.Add(new LiteralControl("&nbsp;"));
                    tableCell.Controls.Add(img);
                }
            }
        }

        protected void Gridview1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            Gridview1.PageIndex = e.NewPageIndex;
            GetDetails();
        }

        protected void btnexcelExport_Click(object sender, EventArgs e)
        {
            string CSOCondetion = "";
            if (Convert.ToString(Session["UserType"]) == "CSO")
            {
                CSOCondetion = " and a.CSOID=" + Session["ClientID"];
            }

            string getQuery = "SELECT CsoCapacityId, Csoname, District, Block, Year, Quarter, LongTermVisioning, StrategicPlanning, FundRaisingSkills, SeniorLeadership, LeadershipQuality, ProgramManagement, FinancialManagement, FPCFormation, d.WomenEmpowerment, SustainableAgriculture, UsageofDigitalPMLS, Monitoring_Evaluation,  case when QuarterScore is null then 0 else QuarterScore end as QuarterScore, QuarterlyStatus FROM[dbo].tblCso a, tblBlocks b, tblDistricts c, tblCsoCapacity d where a.BlockID = b.BlockID and a.DistrictID = c.DistrictID and a.CsoId = d.CsoId" + CSOCondetion + " order by Csoname,Quarter,Year";
            DataSet ds = db.getResultset(getQuery, "", "", "");

            if (ds != null && ds.Tables[0].Rows.Count > 0)
            {

                using (XLWorkbook wb = new XLWorkbook())
                {
                    wb.Worksheets.Add(ds.Tables[0]);
                    using (MemoryStream stream = new MemoryStream())
                    {
                        wb.SaveAs(stream);
                        stream.Position = 0;
                        string myName = Server.UrlEncode("SOCapacityBuildingTracker" + DateTime.Now.ToShortDateString() + ".xlsx");

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
    }
    
}