using System;
using System.Collections.Generic;
using System.Configuration;
using Excel = Microsoft.Office.Interop.Excel;
using System.IO;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ClosedXML.Excel;

namespace CF
{
    public partial class WFDataTrackingInfo : System.Web.UI.Page
    {
        DbErrorLog db = new DbErrorLog();
        string User = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserType"] != null)
            {
                User = Session["UserType"].ToString();
                if (User == "Admin" || User == "CSO" || User == "WFG")
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
            string Condetion = "";
            if (User == "CSO")
            {
                Condetion = " and c.Csoid=" + Session["ClientID"];

            }
            else if (User == "WFG")
            {
                Condetion = " and b.WFGID=" + Session["ClientID"];
            }
            string selectQ ="select WFDataID, WomenName, Village, CSOName, ContactNumber, Year from tblWFsYearData a left outer join tblWFs b on a.Wfno = b.WFno left outer join tblVillageInfo c on b.villageid = c.Vid left outer join tblVillages d on d.villageid = c.VillageID left outer join tblBlocks e on d.BlockID = e.BlockID left outer join tblDistricts f on f.DistrictID = e.DistrictID left outer join tblStates g on g.StateId = f.StateID left outer join tblWFGs h on b.WFGID = h.WfgNo left outer join tblcso k on c.CSOID = k.CSOID where 1 = 1 " + Condetion + " order by Village, WomenName, Year";
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

        protected void Gridview1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            Gridview1.PageIndex = e.NewPageIndex;
            GetDetails();
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

        protected void btnExcel_Click(object sender, EventArgs e)
        {
            ExportDataSetToExcel();
        }

        private void ExportDataSetToExcel()
        {
            string Condetion = "";
            if (User == "CSO")
            {
                Condetion = " and c.Csoid=" + Session["ClientID"];

            }
            else if (User == "WFG")
            {
                Condetion = " and b.WFGID=" + Session["ClientID"];
            }
            string query = "SELECT a.WfNo,k.StateName,District,Block,CSOName,WFGName,WomenName,HusbandName,MaritalStatus,Village,Age,DOB,Qualification,a.SocialCategory,SocialCategoryID,AadharNo,isBankAccount,NameofBank,AccountHolder,AccountNo,IFSC,TotalFamilyMembers,IsCBOMember,NameofCBO,CBONatureID,isRationcard,RationcardTypeID,IsToilet,ToiletFunction,ContactNumber,Branch,[BusinessDevelop] as [Op2.2WFG members business developed],[Percentage] as [Op1.3Percentage of trained],[ICTAccess] as [Op2.3WFGmembers accessICT],[OnFarm] as [Op2.3aOnFarm],[OffFarm] as [Op2.3bOffFarm],[SolelyParticipate] as [Op2.5WFGmember solely decisions],[JointlyParticipate] as [Op2.5WFGmember Jointly decisions],[Financialliteracy] as [Op2.1WFGmembers financial literacy],[Deciding] as [Op2.4WFGmember decisions],Religion,ReligionOther,IsDisable,DisabilityType,DisabilityOther,VocationalTraining,BaselineSurvey,ClimateStudy,GenderStudy,[AccessService] as [Oc1.3.WFGmembers with access to business],[ClimateFriendly] as [Oc1.4WFGmembers practising climate friendly agriculture],[MoreCultivating] as [Oc.1.5WFGmembers cultivating],[MajorSourceofFamily] as[Major Source of income of family],[SourceOfIrrigationOther] as [other],[BuffaloLivestock] as [Buffalo],[CowLivestock] as [Cow],[GoatLivestock] as[Goat],[PoultryLivestock] as [Paultry],[OwnLandSelfName] as [Family Land Ownership],[IsOwnershipinLand] as [area of land having ownership],[islandinthenameofwoman] as [Whether woman has ownership in land],[AreaofOwnershipLand] as [If Yes, area of land having ownership],[irrigatedLandinAcr] as [Total Irrigated land],[TotalNonIrrigatedLand] as [Total Non irrigated land],[SourceofIrrigation] as [Source of irrigation],[IsSharecrops] as [Whether a sharecropper],[SharecropsLand] as [IfYes,areaofland],[ShareHolder] as [Op3.1.WFGmembers shareholder],DemoPlot,WheatAcr,PaddyAcr,OtherCropsName,OilCropAcr,VegitablesAcr,NameofBenefitScheme,isUjjwalaGasConnection,OtherBenefitSchemeName,IsGovScheme,GovSchemeName,GovSchemeAmount,OtherInformation,isMNREGA,FamilyIncome,a.Status FROM tblWFs a left outer join tblWFGs b on a.WFGID = b.WfgNo  left outer join tblVillageInfo c on a.VillageID = c.Vid left outer join tblCSO d on c.CSOID = d.CSOID left outer join tblSocialCategory e on a.SocialCategoryID=e.Sid left outer join tblCBONature f on a.CBONatureID = f.CBOID left outer join tblRationType g on a.RationcardTypeID = g.Rid left outer join tblVillages h on c.VillageID=h.VillageID left outer join tblBlocks i on i.BlockID=h.BlockID left outer join tblDistricts j on i.DistrictID=j.DistrictID left outer join tblStates k on k.StateId=j.StateID where 1=1" + Condetion;
            DataSet ds = db.getResultset(query, "", "", "");
            DataTable dt = new DataTable();
            if (ds != null && ds.Tables[0].Rows.Count > 0)
            {
                dt = ds.Tables[0];
                // Response.Write("<script>alert('excel fired')</script>");
                Random rn = new Random();
                int Order = rn.Next(10000000, 99999999);
                string filepath = ConfigurationManager.ConnectionStrings["DownloadReport"].ConnectionString;
                try
                {
                    string filename = "WFIndicator" + DateTime.Now.ToString("dd-MM-yyyy") + "_" + DateTime.Now.ToString("hh-mm-ss") + ".xlsx";
                    string excelpath = filepath + filename;
                    System.IO.File.Copy(filepath + "WFIndicatorSample.xlsx", excelpath, true);
                    //Creae an Excel application instance
                    Excel.Application excelApp = new Excel.Application();
                    // Response.Write("<script>alert('excelapp created')</script>");

                    //Create an Excel workbook instance and open it from the predefined location
                    Excel.Workbook excelWorkBook = excelApp.Workbooks.Open(excelpath);
                    int lastRow = dt.Rows.Count;
                    //Response.Redirect("<script>alert('excelWorkBook')</script>");

                    Excel.Worksheet excelWorkSheet = (Microsoft.Office.Interop.Excel.Worksheet)excelWorkBook.Worksheets.get_Item("Sheet1");

                    //for (int i = 0; i < dt.Columns.Count; i++)
                    //{
                    //    excelWorkSheet.Cells[1, i + 1] = dt.Columns[i].ColumnName;
                    //}

                    for (int j = 1; j < dt.Rows.Count + 1; j++)
                    {
                        for (int k = 0; k < dt.Columns.Count; k++)
                        {
                            excelWorkSheet.Cells[j + 2, k + 1] = dt.Rows[j - 1].ItemArray[k].ToString();
                        }
                    }
                    excelWorkBook.Save();
                    excelWorkBook.Close();
                    excelApp.Quit();

                    DownloadXlsx(excelpath, filename);
                    //DownloadPDF(excelpath);
                }
                catch (Exception ex)
                {
                    ex.Message.ToString();
                    db.AppendToErrorLog(ex.Message.ToString(), ex.StackTrace.ToString(), "", "");
                }
            }
            else
            {
                ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "ShowAlert('No Records Found.','error')", true);
            }
        }

        public void DownloadXlsx(string excelpath, string fileName)
        {
            try
            {
                string path = ConfigurationManager.ConnectionStrings["DownloadReport"].ConnectionString;
                FileInfo file = new FileInfo(excelpath);
                if (file.Exists)
                {
                    Response.Clear();
                    Response.ClearHeaders();
                    Response.ClearContent();
                    Response.AddHeader("content-disposition", "attachment; filename=" + Path.GetFileName(excelpath));
                    Response.AddHeader("Content-Type", "application/Excel");
                    Response.ContentType = "application/vnd.xlsx";
                    Response.AddHeader("Content-Length", file.Length.ToString());
                    Response.WriteFile(file.FullName);
                    Response.End();
                }
                else
                {
                    Response.Write("This file does not exist.");
                }
            }
            catch (Exception ex)
            {
                ex.Message.ToString();
                db.AppendToErrorLog(ex.Message.ToString(), ex.StackTrace.ToString(), "", "");
            }
        }

        protected void Gridview1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "btnEdit")
            {
                string strid = e.CommandArgument.ToString();
                int rowIndex = int.Parse(e.CommandArgument.ToString());
                string val = (string)this.Gridview1.DataKeys[rowIndex]["WFDataID"].ToString();
                Session["WFDataID"] = val;
                Response.Redirect("~/EditWFDataTracking.aspx");
            }
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            GridViewRow gvRow = (GridViewRow)(sender as Control).Parent.Parent;
            int index = gvRow.RowIndex;
            string val = (string)this.Gridview1.DataKeys[index]["WFDataID"].ToString();

            string deleteQ = "delete from tblWFsYearData where WFDataID=" + val;
            if (db.UpdateQuery(deleteQ, "", "", "") > 0)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "ShowAlert('You have deleted successfully.','success')", true);
            }
            else
            {
                ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "ShowAlert('Something went wrong please try again.','warning')", true);
            }
        }

        protected void Gridview1_RowCreated(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                if (Convert.ToString(Session["UserType"]) == "CSO" || Convert.ToString(Session["UserType"]) == "WFG")
                {
                    e.Row.Cells[6].CssClass = "hiddencol";
                }
            }
            else if (e.Row.RowType == DataControlRowType.Header)
            {
                if (Convert.ToString(Session["UserType"]) == "CSO" || Convert.ToString(Session["UserType"]) == "WFG")
                {
                    e.Row.Cells[6].CssClass = "hiddencol";
                }
            }
        }

        protected void btnexcelExport_Click(object sender, EventArgs e)
        {
            string Condetion = "";
            if (User == "CSO")
            {
                Condetion = " and c.Csoid=" + Session["ClientID"];

            }
            else if (User == "WFG")
            {
                Condetion = " and b.WFGID=" + Session["ClientID"];
            }
            ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "ShowLoader()", true);
            string query = "SELECT a.WfNo,k.StateName,District,Block,CSOName,WFGName,WomenName,HusbandName,MaritalStatus,Village,Age,DOB,Qualification,a.SocialCategory,SocialCategoryID,AadharNo,isBankAccount,NameofBank,AccountHolder,AccountNo,IFSC,TotalFamilyMembers,IsCBOMember,NameofCBO,CBONatureID,isRationcard,RationcardTypeID,IsToilet,ToiletFunction,ContactNumber,Branch,[BusinessDevelop] as [Op2.2WFG members business developed],[Percentage] as [Op1.3Percentage of trained],[ICTAccess] as [Op2.3WFGmembers accessICT],[OnFarm] as [Op2.3aOnFarm],[OffFarm] as [Op2.3bOffFarm],[SolelyParticipate] as [Op2.5WFGmember solely decisions],[JointlyParticipate] as [Op2.5WFGmember Jointly decisions],[Financialliteracy] as [Op2.1WFGmembers financial literacy],[Deciding] as [Op2.4WFGmember decisions],Religion,ReligionOther,IsDisable,DisabilityType,DisabilityOther,VocationalTraining,BaselineSurvey,ClimateStudy,GenderStudy,[AccessService] as [Oc1.3.WFGmembers with access to business],[ClimateFriendly] as [Oc1.4WFGmembers practising climate friendly agriculture],[MoreCultivating] as [Oc.1.5WFGmembers cultivating],[MajorSourceofFamily] as[Major Source of income of family],[SourceOfIrrigationOther] as [other],[BuffaloLivestock] as [Buffalo],[CowLivestock] as [Cow],[GoatLivestock] as[Goat],[PoultryLivestock] as [Paultry],[OwnLandSelfName] as [Family Land Ownership],[IsOwnershipinLand] as [area of land having ownership],[islandinthenameofwoman] as [Whether woman has ownership in land],[AreaofOwnershipLand] as [If Yes, area of land having ownership],[irrigatedLandinAcr] as [Total Irrigated land],[TotalNonIrrigatedLand] as [Total Non irrigated land],[SourceofIrrigation] as [Source of irrigation],[IsSharecrops] as [Whether a sharecropper],[SharecropsLand] as [IfYes,areaofland],[ShareHolder] as [Op3.1.WFGmembers shareholder],DemoPlot,WheatAcr,PaddyAcr,OtherCropsName,OilCropAcr,VegitablesAcr,NameofBenefitScheme,isUjjwalaGasConnection,OtherBenefitSchemeName,IsGovScheme,GovSchemeName,GovSchemeAmount,OtherInformation,isMNREGA,FamilyIncome,a.Status FROM tblWFs a left outer join tblWFGs b on a.WFGID = b.WfgNo  left outer join tblVillageInfo c on a.VillageID = c.Vid left outer join tblCSO d on c.CSOID = d.CSOID left outer join tblSocialCategory e on a.SocialCategoryID=e.Sid left outer join tblCBONature f on a.CBONatureID = f.CBOID left outer join tblRationType g on a.RationcardTypeID = g.Rid left outer join tblVillages h on c.VillageID=h.VillageID left outer join tblBlocks i on i.BlockID=h.BlockID left outer join tblDistricts j on i.DistrictID=j.DistrictID left outer join tblStates k on k.StateId=j.StateID where 1=1" + Condetion ;
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
                        string myName = Server.UrlEncode("WFReport_" + DateTime.Now.ToShortDateString() + ".xlsx");

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