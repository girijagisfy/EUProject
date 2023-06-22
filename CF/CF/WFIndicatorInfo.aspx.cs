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

namespace CF
{
    public partial class WFIndicatorInfo : System.Web.UI.Page
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
            string selectQ = "select distinct a.WfNo, WomenName, Village, CSOName, ContactNumber from tblWFsYearData a left outer join tblWFs b on a.Wfno=b.WFno left outer join tblVillageInfo c on b.villageid=c.Vid left outer join tblVillages d on d.villageid=c.VillageID left outer join tblBlocks e on d.BlockID=e.BlockID left outer join tblDistricts f on f.DistrictID=e.DistrictID left outer join tblStates g on g.StateId=f.StateID left outer join tblWFGs h on b.WFGID=h.WfgNo left outer join tblcso k on c.CSOID = k.CSOID where 1=1 " + Condetion;

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
            string query = "select ROW_NUMBER() OVER(ORDER BY (SELECT 1)) AS SerialNum,d.Village, c.Vid, c.GramPanchayatName, a.WFno, WomenName, HusbandName, Religion, SocialCategory, DOB, Age, AadharNo, IsDisable,case when DisabilityType='Other' then DisabilityOther else DisabilityType end as Disability, Qualification, VocationalTraining, h.WFGName, TotalFamilyMembers, isRationcard, TypeofRationCard, IsCBOMember, NameofCBO, NatureofCBO, MajorSourceofFamily, NumberOfLiveStock, IsOwnershipinLand, AreaofOwnershipLand, islandinthenameofwoman, OwnLandSelfName, SourceofIrrigation, TotalNonIrrigatedLand,concat('Wheat Acr:',case when isWheat='Yes' then WheatAcr else '0' end ,', ','Paddy Acr:', case when IsPaddy='Yes' then PaddyAcr else '0' end ,', ','Vegitables Acr:', case when isVegitables = 'Yes' then VegitablesAcr else '0' end) as StapleCrops, IsSharecrops, SharecropsLand, DemoPlot, IsBenefit, NameofBenefitScheme, BenefitTotal, OtherInformation, isMNREGA, BaselineSurvey, ClimateStudy, GenderStudy, HasAttendedTraining, TrainingName, TrainingFollowUps, Year, Buisness, AccessService,  ClimateFriendly, PracticeType, MoreCultivating, AgriUse, ProUse, PercTrained, PreTraining, PostTraining, isBankAccount, LoanObtain, ManageMoney, BuisnessDevelop, ICTAccess, OnFarm, OffFarm, CropChoice, Input, Deciding, Timing, DecidingTime, Harvesting, SaleLand, SoWomen, SoMaterial, SoAgro, SoSelling, SoExopenditure, JoWomen, JoMaterial, JoAgro, JoSelling, JoExpenditure, ShareHolder, FPCShares, FPCName from tblWFsYearData a left outer join tblWFs b on a.Wfno=b.WFno left outer join tblVillageInfo c on b.villageid=c.Vid left outer join tblVillages d on d.villageid=c.VillageID left outer join tblBlocks e on d.BlockID=e.BlockID left outer join tblDistricts f on f.DistrictID=e.DistrictID left outer join tblStates g on g.StateId=f.StateID left outer join tblWFGs h on b.WFGID=h.WfgNo where 1=1 " + Condetion;
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
    }
}