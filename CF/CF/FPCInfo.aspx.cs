using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using ClosedXML.Excel;
using System.IO;

namespace CF
{
    public partial class FPCInfo : System.Web.UI.Page
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

        public void GetDetails()
        {
            string query = "select FPCId,CSOName,FPCName,FPCContactNumber,FPCAddress,Status from tblFPCRegistration";
            DataSet ds = db.getResultset(query, "", "", "");
            DataTable dt = new DataTable();

            if (ds != null && ds.Tables[0].Rows.Count > 0)
            {
                dt = ds.Tables[0];
            }

            gvFPC.DataSource = dt;
            gvFPC.DataBind();

            ViewState["dirState"] = dt;
            ViewState["sortdr"] = "Asc";

        }

        protected void gvFPC_Sorting(object sender, GridViewSortEventArgs e)
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
                gvFPC.DataSource = dtrslt;
                gvFPC.DataBind();
            }

            for (int i = 0; i < gvFPC.Columns.Count; i++)
            {
                string lbText = gvFPC.Columns[i].SortExpression;

                if (lbText == e.SortExpression)
                {
                    TableCell tableCell = gvFPC.HeaderRow.Cells[i];
                    Image img = new Image();
                    img.ImageUrl = (Convert.ToString(ViewState["sortdr"]) == "Asc") ? "~/Images/ArrowUp.gif" : "~/Images/ArrowDown.gif";
                    tableCell.Controls.Add(new LiteralControl("&nbsp;"));
                    tableCell.Controls.Add(img);
                }
            }
        }

        protected void gvFPC_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName != "Sort" && e.CommandName != "Page")
            {
                if (e.CommandName == "btnEdit")
                {
                    string strid = e.CommandArgument.ToString();
                    int rowIndex = int.Parse(e.CommandArgument.ToString());
                    string val = (string)this.gvFPC.DataKeys[rowIndex]["FPCId"].ToString();
                    Session["FPCId"] = val;
                    Response.Redirect("~/FPCRegistrationEdit.aspx");
                }
                else if (e.CommandName == "Inactive")
                {
                    GridViewRow row = (GridViewRow)(((Control)e.CommandSource).NamingContainer);
                    int RowIndex = row.RowIndex;
                    string val = (string)this.gvFPC.DataKeys[RowIndex]["FPCId"].ToString();
                    string deleteQ = "update tblFPCRegistration set Status = 0 where FPCId= " + val;
                    if (db.UpdateQuery(deleteQ, "", "", "") > 0)
                    {
                        ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "ShowAlert('You have deactivated successfully.','success')", true);
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
                    string val = (string)this.gvFPC.DataKeys[RowIndex]["FPCId"].ToString();
                    string deleteQ = "update tblFPCRegistration set Status = 1 where FPCId= " + val;
                    if (db.UpdateQuery(deleteQ, "", "", "") > 0)
                    {
                        ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "ShowAlert('You have activated successfully.','success')", true);
                    }
                    else
                    {
                        ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "ShowAlert('Something went wrong please try again.','warning')", true);
                    }
                }
            }
        }

        protected void gvFPC_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvFPC.PageIndex = e.NewPageIndex;
            GetDetails();
        }

        protected void gvFPC_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                string Status = gvFPC.DataKeys[e.Row.RowIndex].Values[1].ToString();

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

        protected void btnCropReport_Click(object sender, EventArgs e)
        {
            string SelectQ = "select StateName, c.District, d.Block, CSOName, FPCAddress, FPCContactNumber, FPCEmail, FPCWebsite, TotalMembers, MaleMembers, FemaleMembers,TransGenderMembers, SFMFMembers, STMembers, SCMembers, OBCMembers,GeneralMembers, NoofVillagesCovered, NoofBlocksCovered, NoofDistrictsCovered, NoofSharesMobilizedbyFPC,SharedMoneyMobilizedbyFPC, SFACEquitySupportAvailed, EquityGrantFundMobilizedbyFPC, FPCRegistrationdate, LegalActunderWhichFPC, CINNo, SupportTakenfromotherAgency, SupportAmt, FPCBankAccountNo, AccountType,a.BankName, BankBranch, IFSCCode, FPCBusinessAddress, TAN, TANNumber, TANDate, TANExpiry, PAN, PANNumber, PANDate, PANExpiry, GST, GSTNumber, GSTDate, GSTExpiry, ServiceTax, ServiceTaxNumber, ServiceTaxDate, ServiceTaxExpiry, BusinesslicenseTaken, EmployeeAppointed, DirectorsAppointed, UserName, Password, FpcLogo, OtherLegalAct,a.UploadFile,a.UploadFileName from tblFPCRegistration a left outer join tblStates b on a.StateID=b.StateId left outer join tblDistricts c on a.DistrictID=c.DistrictID left outer join tblBlocks d on a.BlockID=d.BlockID left outer join tblFPCMembers e on e.FPCId=a.FPCid left outer join tblBODMembers f on f.FPCId=a.FPCid left outer join tblFpcRegistrationTeamMembers g on a.FPCid=g.FPCId left outer join tblFpcRegistrationBusinessTaken h on a.fpcid=h.FPCId left outer join tblFPCRegAboutus i on a.fpcid=i.fpcid group by e.FPCId,StateName, c.District, d.Block, CSOName, FPCAddress, FPCContactNumber, FPCEmail, FPCWebsite, TotalMembers, MaleMembers, FemaleMembers,TransGenderMembers, SFMFMembers, STMembers, SCMembers, OBCMembers,GeneralMembers, NoofVillagesCovered, NoofBlocksCovered, NoofDistrictsCovered, NoofSharesMobilizedbyFPC,SharedMoneyMobilizedbyFPC, SFACEquitySupportAvailed, EquityGrantFundMobilizedbyFPC, FPCRegistrationdate, LegalActunderWhichFPC, CINNo, SupportTakenfromotherAgency, SupportAmt, FPCBankAccountNo, AccountType,a.BankName, BankBranch, IFSCCode, FPCBusinessAddress, TAN, TANNumber, TANDate, TANExpiry, PAN, PANNumber, PANDate, PANExpiry, GST, GSTNumber, GSTDate, GSTExpiry, ServiceTax, ServiceTaxNumber, ServiceTaxDate, ServiceTaxExpiry, BusinesslicenseTaken, EmployeeAppointed, DirectorsAppointed, UserName, Password, FpcLogo, OtherLegalAct,a.UploadFile,a.UploadFileName";
            DataSet ds = db.getResultset(SelectQ, "", "", "");
            if (ds != null && ds.Tables[0].Rows.Count > 0)
            {
                using (XLWorkbook wb = new XLWorkbook())
                {
                    wb.Worksheets.Add(ds.Tables[0]);

                    using (MemoryStream stream = new MemoryStream())
                    {
                        var ws = wb.AddWorksheet("sheet1");
                        ws.Columns().AdjustToContents();
                        wb.SaveAs(stream);
                        stream.Position = 0;
                        string myName = Server.UrlEncode("FPC_Info_" + DateTime.Now.ToShortDateString() + ".xlsx");

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