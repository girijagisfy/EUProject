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
using System.Threading;

namespace CF
{
    public partial class CSOCapacityReport : System.Web.UI.Page
    {
        DbErrorLog db = new DbErrorLog();
        string User = string.Empty;
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

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            string Year = txtYear.Text;
            string CSOCondetion = "";
            if (Convert.ToString(Session["UserType"]) == "CSO")
            {
                CSOCondetion = " and b.CSOID=" + Session["ClientID"];
            }
            string getQuery = "select CSOName, QuarteerName, LongTermVisioning, StrategicPlanning, FundRaisingSkills, SeniorLeadership, LeadershipQuality, ProgramManagement, FinancialManagement, FPCFormation, c.WomenEmpowerment, SustainableAgriculture, UsageofDigitalPMLS, Monitoring_Evaluation, QuarterlyStatus, case when QuarterScore is null then 0 else QuarterScore end as QuarterScore from tblCSO b left outer join tblCsoCapacity c on b.CsoId=c.CSOID left outer join tblCSOQuarters a on c.Quarter=a.QuarteerName where Year=" + Year + "" + CSOCondetion + " order by b.CsoId,Quarter,Year";
            DataSet ds = db.getResultset(getQuery, "", "", "");
            DataTable dt = new DataTable();
            if (ds != null && ds.Tables[0].Rows.Count > 0)
            {
                dt = ds.Tables[0];
            }

            // Response.Write("<script>alert('excel fired')</script>");
            Random rn = new Random();
            int Order = rn.Next(10000000, 99999999);
            string filepath = ConfigurationManager.ConnectionStrings["DownloadReport"].ConnectionString;
            try
            {
                string filename = "CSOCapacityBuildingTracker" + DateTime.Now.ToString("dd-MM-yyyy") + "_" + DateTime.Now.ToString("hh-mm-ss") + ".xlsx";
                string excelpath = filepath + filename;
                System.IO.File.Copy(filepath + "CSOCapacityBuildingTracker.xlsx", excelpath, true);
                //Creae an Excel application instance
                Excel.Application excelApp = new Excel.Application();
                // Response.Write("<script>alert('excelapp created')</script>");

                //Create an Excel workbook instance and open it from the predefined location
                Excel.Workbook excelWorkBook = excelApp.Workbooks.Open(excelpath);
                int lastRow = dt.Rows.Count;
                //Response.Redirect("<script>alert('excelWorkBook')</script>");

                Excel.Worksheet excelWorkSheet = (Microsoft.Office.Interop.Excel.Worksheet)excelWorkBook.Worksheets.get_Item("CSO Capacity");

                //for (int i = 0; i < dt.Columns.Count; i++)
                //{
                //    excelWorkSheet.Cells[1, i + 1] = dt.Columns[i].ColumnName;
                //}

                int count = 0;
                int YearStatus = 0;
                excelWorkSheet.Cells[5, 2] = "QuarteerName" + Year;
                for (int j = 6; j < dt.Rows.Count + 6; j++)
                {
                    for (int k = 1; k <= dt.Columns.Count - 1; k++)
                    {
                        YearStatus += Convert.ToInt32(dt.Rows[j - 6]["QuarterScore"].ToString());
                        if (count > 3)
                        {
                            count = 0;
                        }
                        if (count == 0 && k == 1)
                        {
                            excelWorkSheet.Cells[j, 1] = dt.Rows[j - 6].ItemArray[0].ToString();
                            excelWorkSheet.Range[excelWorkSheet.Cells[j, 1], excelWorkSheet.Cells[j + 3, 1]].Merge();
                            excelWorkSheet.Range[excelWorkSheet.Cells[j, 16], excelWorkSheet.Cells[j + 3, 16]].Merge();
                            excelWorkSheet.Cells[j, 1].Borders.LineStyle = Microsoft.Office.Interop.Excel.XlLineStyle.xlContinuous;
                            excelWorkSheet.Cells[j, 1].Borders.Weight = Microsoft.Office.Interop.Excel.XlBorderWeight.xlThin;
                            excelWorkSheet.Cells[j, 1].HorizontalAlignment = Microsoft.Office.Interop.Excel.XlHAlign.xlHAlignLeft;
                            excelWorkSheet.Cells[j, 16].Borders.LineStyle = Microsoft.Office.Interop.Excel.XlLineStyle.xlContinuous;
                            excelWorkSheet.Cells[j, 16].Borders.Weight = Microsoft.Office.Interop.Excel.XlBorderWeight.xlThin;
                            excelWorkSheet.Cells[j, 16].HorizontalAlignment = Microsoft.Office.Interop.Excel.XlHAlign.xlHAlignLeft;
                        }
                        else if (count == 4 && k == 15)
                        {
                            //excelWorkSheet.Range[excelWorkSheet.Cells[j, k], excelWorkSheet.Cells[j - 3, k]].Merge();
                            if (YearStatus == 0)
                            {
                                excelWorkSheet.Cells[j - 3, 16] = "No changes";
                            }
                            else if (YearStatus > 0 || YearStatus <= 80)
                            {
                                excelWorkSheet.Cells[j - 3, 16] = "Developmental";
                            }
                            else if (YearStatus > 80 || YearStatus <= 160)
                            {
                                excelWorkSheet.Cells[j - 3, 16] = "Transitional";
                            }
                            else if (YearStatus > 160)
                            {
                                excelWorkSheet.Cells[j - 3, 16] = "Transformational";
                            }
                            YearStatus = 0;
                        }
                        else if (k > 1)
                        {
                            excelWorkSheet.Cells[j, k] = dt.Rows[j - 6].ItemArray[k - 1].ToString();
                            excelWorkSheet.Cells[j, k].Borders.LineStyle = Microsoft.Office.Interop.Excel.XlLineStyle.xlContinuous;
                            excelWorkSheet.Cells[j, k].Borders.Weight = Microsoft.Office.Interop.Excel.XlBorderWeight.xlThin;
                            excelWorkSheet.Cells[j, k].HorizontalAlignment = Microsoft.Office.Interop.Excel.XlHAlign.xlHAlignLeft;
                        }
                        if (k == 15)
                        {
                            count++;
                        }
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