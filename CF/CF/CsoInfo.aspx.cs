using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ClosedXML.Excel;
using System.Data;
using CF;

namespace CF
{
    public partial class CsoInfo : System.Web.UI.Page
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
            string selectQ = "SELECT CsoId,Csoname,StateName,District,Block,RegisteredAddress,NameofContactPerson, addressofcontactPerson, a.Status FROM [dbo].tblCso a left outer join tblBlocks b on a.BlockID=b.BlockID left outer join tblDistricts c on a.DistrictID = c.DistrictID left outer join tblStates d on c.StateID=d.StateId where 1=1" + CSOCondetion + " order by CsoId";

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
                    string val = (string)this.Gridview1.DataKeys[rowIndex]["CsoId"].ToString();
                    Session["CsoId"] = val;
                    Response.Redirect("EditCso.aspx");
                }
                else if (e.CommandName == "Inactive")
                {
                    GridViewRow row = (GridViewRow)(((Control)e.CommandSource).NamingContainer);
                    int RowIndex = row.RowIndex;
                    string val = (string)this.Gridview1.DataKeys[RowIndex]["CsoId"].ToString();
                    string deleteQ = "update tblVillageInfo set Status = 0 where CSOID=" + val + "; update tblWFGs set Status=0 from tblWFGs a left outer join tblVillageInfo b on a.VillageID = b.Vid left outer join tblCSO c on b.CSOID=c.CSOID where c.CSOID = " + val + "; update tblWFs set Status=0 from tblWFs a left outer join tblWFGs b on a.WFGID=b.WfgNo left outer join tblVillageInfo c on b.VillageID = c.Vid left outer join tblCSO d on c.CSOID=d.CSOID where c.CSOID = " + val + "; update tblClients set Status=0 where UserType = 'CSO' and ClientID=" + val + ";update tblClients set Status=0 from tblClients a left outer join tblWFGs b on a.ClientID=b.WfgNo left outer join tblVillageInfo c on b.VillageID=c.Vid left outer join tblCSO d on c.CSOID=d.CSOID where a.UserType='WFG' and c.CSOID=" + val + ";update tblCSO set Status = 0 where CSOID = " + val + ";";
                    if (db.UpdateQuery(deleteQ, "", "", "") > 0)
                    {
                        ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "ShowAlert('You have Inactivated cso successfully.','success')", true);
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
                    string val = (string)this.Gridview1.DataKeys[RowIndex]["CsoId"].ToString();
                    string deleteQ = "update tblVillageInfo set Status = 1 where CSOID=" + val + "; update tblWFGs set Status=1 from tblWFGs a left outer join tblVillageInfo b on a.VillageID = b.Vid left outer join tblCSO c on b.CSOID=c.CSOID where c.CSOID = " + val + "; update tblWFs set Status=1 from tblWFs a left outer join tblWFGs b on a.WFGID=b.WfgNo left outer join tblVillageInfo c on b.VillageID = c.Vid left outer join tblCSO d on c.CSOID=d.CSOID where c.CSOID = " + val + "; update tblClients set Status=1 where UserType = 'CSO' and ClientID=" + val + ";update tblClients set Status=1 from tblClients a left outer join tblWFGs b on a.ClientID=b.WfgNo left outer join tblVillageInfo c on b.VillageID=c.Vid left outer join tblCSO d on c.CSOID=d.CSOID where a.UserType='WFG' and c.CSOID=" + val + ";update tblCSO set Status = 1 where CSOID = " + val + ";";
                    if (db.UpdateQuery(deleteQ, "", "", "") > 0)
                    {
                        ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "ShowAlert('You have Activated cso successfully.','success')", true);
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
            string val = (string)this.Gridview1.DataKeys[index]["CsoId"].ToString();

            string deleteQ = "update tblVillageInfo set Status = 0 where CSOID=" + val + "; update tblWFGs set Status=0 from tblWFGs a left outer join tblVillageInfo b on a.VillageID = b.Vid left outer join tblCSO c on b.CSOID=c.CSOID where c.CSOID = " + val + "; update tblWFs set Status=0 from tblWFs a left outer join tblWFGs b on a.WFGID=b.WfgNo left outer join tblVillageInfo c on b.VillageID = c.Vid left outer join tblCSO d on c.CSOID=d.CSOID where c.CSOID = " + val + "; update tblClients set Status=0 where UserType = 'CSO' and ClientID=1;update tblClients set Status=0 from tblClients a left outer join tblWFGs b on a.ClientID=b.WfgNo left outer join tblVillageInfo c on b.VillageID=c.Vid left outer join tblCSO d on c.CSOID=d.CSOID where a.UserType='WFG' and c.CSOID=" + val + ";update tblCSO set Status = 0 where CSOID = " + val + ";";
            if (db.UpdateQuery(deleteQ, "", "", "") > 0)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "ShowAlert('You have deleted CSO successfully.','success')", true);
            }
            else
            {
                ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "ShowAlert('Something went wrong / Delete Data Under this CSO.','warning')", true);
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

        protected void Gridview1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                string Status = Gridview1.DataKeys[e.Row.RowIndex].Values[1].ToString();

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
    }
}