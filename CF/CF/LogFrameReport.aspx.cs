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
    public partial class LogFrameReport : System.Web.UI.Page
    {
        DbErrorLog db = new DbErrorLog();
        string User = string.Empty;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserType"] != null)
            {
                User = Session["UserType"].ToString();
                if (User == "Admin")
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

            DataTable dt = new DataTable();
            dt.Columns.Add("Indicator");
            DataRow dr = dt.NewRow();
            //O.Obj Indicator 1
            string csoqr = "select count(*) as Count from tblCSO where Status=1";
            DataSet csods = db.getResultset(csoqr, "", "", "");
            if (csods != null && csods.Tables[0].Rows.Count > 0)
            {
                dr["Indicator"] = csods.Tables[0].Rows[0]["Count"].ToString();
            }
            else
            {
                dr["Indicator"] = "0";
            }
            dt.Rows.Add(dr);
            //fpc profits need to get.
            dr = dt.NewRow();
            string Yearcon = "FORMAT(try_CAST(Date AS datetime),'yyyy-MM') between '" + Year + "-04' and '" + (Convert.ToInt32(Year) + 1) + "-03'";
            string Query = "select Name,convert(decimal(10,2),Amount) as Amount,FORMAT(try_CAST(Date AS datetime),'yyyy-MM') as Date from (select TypeName as Name,TotalAmount as Amount,PurchaseOrderDate as Date from tblPurchaseOrder where Inc_Exp = 'Expenditure' union select TypeName as Name,Payments as Amount,HiringDate as Date from tblServiceHiring where Inc_Exp = 'Expenditure' union select PName as Name,PTotalPrice as Amount,PDate as Date from tblProcessing  union select FacilityTypeName as Name ,Amount as Amount,Date as Date from tblOtherFacilities a,tblFacilityTypes b  where a.FacilityTypeId = b.FacilityTypeID and Inc_Exp = 'Expenditure'  union select OParticular as Name,OTotalAmount as Amount,ODate as Date from tblOperational where Inc_Exp = 'Expenditure') as k where " + Yearcon + " group by Name,Amount,k.Date;";

            DataSet FPCds = db.getResultset(Query, "", "", "");
            DataTable Expenditure = new DataTable();
            Expenditure.Columns.Add("Name");
            Expenditure.Columns.Add("Amount");

            DataTable Income = new DataTable();
            Income.Columns.Add("Name");
            Income.Columns.Add("Amount");

            string TotalIncome = string.Empty;
            string TotalExpenditure = string.Empty;
            if (FPCds != null && FPCds.Tables[0].Rows.Count > 0)
            {
                foreach (DataRow row in FPCds.Tables[0].Rows)
                {
                    DataRow dtRow = Expenditure.NewRow();
                    dtRow["Name"] = row["Name"].ToString();
                    dtRow["Amount"] = row["Amount"].ToString();
                    Expenditure.Rows.Add(dtRow);
                }
                TotalExpenditure = FPCds.Tables[0].Compute("Sum([" + FPCds.Tables[0].Columns[1].ColumnName + "])", "").ToString();

            }
            String query2 = "select Name,convert(decimal(10,2),Amount) as Amount,FORMAT(try_CAST(Date AS datetime),'yyyy-MM') as Date from(select TypeName as Name,TotalAmount as Amount,InvoiceDate as Date from tblSalesOrders a,tblInvoice b where a.SalesOrderNumber=b.SalesOrderId and Inc_Exp='Income' union select TypeName as Name,payments as Amount,hiringdate as Date from tblServiceHiring where Inc_Exp = 'Income' union select FacilityTypeName as Name ,Amount as Amount,Date as Date from tblOtherFacilities a,tblFacilityTypes b  where a.FacilityTypeId = b.FacilityTypeID and Inc_Exp = 'Income') as k where " + Yearcon + " group by Name,Amount,k.Date";
            DataSet FPCds2 = db.getResultset(query2, "", "", "");
            if (FPCds2 != null && FPCds2.Tables[0].Rows.Count > 0)
            {
                foreach (DataRow row in FPCds2.Tables[0].Rows)
                {
                    DataRow dtRowI = Income.NewRow();
                    dtRowI["Name"] = row["Name"].ToString();
                    dtRowI["Amount"] = row["Amount"].ToString();
                    Income.Rows.Add(dtRowI);
                }
                TotalIncome = FPCds.Tables[0].Compute("Sum([" + FPCds.Tables[0].Columns[1].ColumnName + "])", "").ToString();
            }
            if (TotalIncome == "")
            {
                TotalIncome = "1";
            }
            if (TotalExpenditure == "")
            {
                TotalExpenditure = "0";
            }

            string Pf = ((Convert.ToDecimal(TotalIncome) - Convert.ToDecimal(TotalExpenditure)) * 100 / Convert.ToDecimal(TotalIncome)).ToString();
            dr["Indicator"] = Pf;
            dt.Rows.Add(dr);


            //Oc1.2, Oc1.2b, Oc1.3

            string indqr = "select sum(case when Business='Yes' then 1 else 0 end) as Count, Convert(Numeric(38, 2),(sum(case when Business='Yes' then 1 else 0 end)*100.0/count(*))) as total from tblWFsYearData where Year= '" + Year + "'";
            DataSet indds = db.getResultset(indqr, "", "", "");
            if (indds != null && indds.Tables[0].Rows.Count > 0)
            {
                dr = dt.NewRow();
                dr["Indicator"] = indds.Tables[0].Rows[0]["Count"].ToString();
                dt.Rows.Add(dr);
                dr = dt.NewRow();
                dr["Indicator"] = indds.Tables[0].Rows[0]["Count"].ToString();
                dt.Rows.Add(dr);
                dr = dt.NewRow();
                dr["Indicator"] = indds.Tables[0].Rows[0]["total"].ToString();
                dt.Rows.Add(dr);
            }
            else
            {
                dr = dt.NewRow();
                dr["Indicator"] = "0";
                dt.Rows.Add(dr);
                dr = dt.NewRow();
                dr["Indicator"] = "0";
                dt.Rows.Add(dr);
                dr = dt.NewRow();
                dr["Indicator"] = "0";
                dt.Rows.Add(dr);
            }

            //Oc 1.4
            string ocqr = "select Convert(Numeric(38, 2),(sum(case when ClimateFriendly='Yes' then 1 else 0 end)*100.0/count(*))) as ClimateFriendly, Convert(Numeric(38, 2),(sum(case when UseofOrganicManure='Yes' then 1 else 0 end)*100.0/count(*))) as UseofOrganicManure,Convert(Numeric(38, 2),(sum(case when Useofwaterconservation='Yes' then 1 else 0 end)*100.0/count(*))) as Useofwaterconservation,Convert(Numeric(38, 2),(sum(case when UseofMultiCropping='Yes' then 1 else 0 end)*100.0/count(*))) as UseofMultiCropping, Convert(Numeric(38, 2),(sum(case when MoreCultivating='Yes' then 1 else 0 end)*100.0/count(*))) as MoreCultivating, Convert(Numeric(38, 2),(sum(case when IsGovScheme='Yes' then 1 else 0 end)*100.0/count(*))) as IsGovScheme, Convert(Numeric(38, 2),(sum(case when islandinthenameofwoman='Yes' then 1 else 0 end)*100.0/count(*))) as islandinthenameofwoman, Convert(Numeric(38, 2),(sum(case when AgriUse='Yes' then 1 else 0 end)*100.0/count(*))) as AgriUse from tblWFsYearData where Year = '" + Year + "' group by Year";
            DataSet ocds = db.getResultset(ocqr, "", "", "");
            if (ocds != null && ocds.Tables[0].Rows.Count > 0)
            {
                dr = dt.NewRow();
                dr["Indicator"] = ocds.Tables[0].Rows[0]["ClimateFriendly"].ToString();
                dt.Rows.Add(dr);
                dr = dt.NewRow();
                dr["Indicator"] = ocds.Tables[0].Rows[0]["UseofOrganicManure"].ToString();
                dt.Rows.Add(dr);
                dr = dt.NewRow();
                dr["Indicator"] = ocds.Tables[0].Rows[0]["Useofwaterconservation"].ToString();
                dt.Rows.Add(dr);
                dr = dt.NewRow();
                dr["Indicator"] = ocds.Tables[0].Rows[0]["UseofMultiCropping"].ToString();
                dt.Rows.Add(dr);
                dr = dt.NewRow();
                dr["Indicator"] = ocds.Tables[0].Rows[0]["MoreCultivating"].ToString();
                dt.Rows.Add(dr);
                dr = dt.NewRow();
                dr["Indicator"] = ocds.Tables[0].Rows[0]["IsGovScheme"].ToString();
                dt.Rows.Add(dr);
                dr = dt.NewRow();
                dr["Indicator"] = ocds.Tables[0].Rows[0]["islandinthenameofwoman"].ToString();
                dt.Rows.Add(dr);
                dr = dt.NewRow();
                dr["Indicator"] = ocds.Tables[0].Rows[0]["AgriUse"].ToString();
                dt.Rows.Add(dr);
            }
            else
            {
                dr = dt.NewRow();
                dr["Indicator"] = "0";
                dt.Rows.Add(dr);
                dr = dt.NewRow();
                dr["Indicator"] = "0";
                dt.Rows.Add(dr);
                dr = dt.NewRow();
                dr["Indicator"] = "0";
                dt.Rows.Add(dr);
                dr = dt.NewRow();
                dr["Indicator"] = "0";
                dt.Rows.Add(dr);
                dr = dt.NewRow();
                dr["Indicator"] = "0";
                dt.Rows.Add(dr);
                dr = dt.NewRow();
                dr["Indicator"] = "0";
                dt.Rows.Add(dr);
                dr = dt.NewRow();
                dr["Indicator"] = "0";
                dt.Rows.Add(dr);
                dr = dt.NewRow();
                dr["Indicator"] = "0";
                dt.Rows.Add(dr);
            }

            //Op1.1
            dr = dt.NewRow();
            string csocap = "select count(distinct csoid) as count from tblCsoCapacity where Year='" + Year + "'";
            DataSet capds = db.getResultset(csocap, "", "", "");
            if (capds != null && capds.Tables[0].Rows.Count > 0)
            {
                dr["Indicator"] = capds.Tables[0].Rows[0]["count"].ToString();
            }
            else
            {
                dr["Indicator"] = "0";
            }
            dt.Rows.Add(dr);

            //Op1.2
            dr = dt.NewRow();
            string csotea = "select Convert(Numeric(38, 2),(sum(case when FPCFormation!='0' or WomenEmpowerment!='0' or SustainableAgriculture!='0' then 1 else 0 end)*100.0/count(*))) as count from tblCsoCapacity where Year='" + Year + "'";
            DataSet teads = db.getResultset(csotea, "", "", "");
            if (teads != null && teads.Tables[0].Rows.Count > 0)
            {
                dr["Indicator"] = teads.Tables[0].Rows[0]["count"].ToString();
            }
            else
            {
                dr["Indicator"] = "0";
            }
            dt.Rows.Add(dr);

            //Op1.3, Op2.1, Op2.2, Op2.3, Op2.3a, Op2.3b, Op2.4, Op 2.5, Op 2.5, Op3.1
            string wfgtrain = "select Convert(Numeric(38, 2),ISNULL(sum(TRY_CONVERT(float,PercTrained)),0)*100.0/count(*)) as PercentTrain, Convert(Numeric(38, 2),sum(case when Financialliteracy='Yes' then 1 else 0 end)*100.0/count(*)) as Finance, Convert(Numeric(38, 2),sum(case when Business='Yes' then 1 else 0 end)*100.0/count(*)) as Business, Convert(Numeric(38, 2),sum(case when ICTAccess='Yes' then 1 else 0 end)*100.0/count(*)) as ICTAccess, Convert(Numeric(38, 2),sum(case when OnFarm='Yes' then 1 else 0 end)*100.0/count(*)) as OnFarm, Convert(Numeric(38, 2),sum(case when OffFarm='Yes' then 1 else 0 end)*100.0/count(*)) as OffFarm, Convert(Numeric(38, 2),sum(case when CropChoice='Yes' or Input='Yes' or Timing='Yes' or SaleLand='Yes' then 1 else 0 end)*100.0/count(*)) as Productive, Convert(Numeric(38, 2),sum(case when SoWomen='Yes' or SoMaterial='Yes' or SoSelling='Yes' or SoExpenditure='Yes'  or SoAgro='Yes' then 1 else 0 end)*100.0/count(*)) as soley, Convert(Numeric(38, 2),sum(case when JoWomen='Yes' or JoMaterial='Yes' or JoMaterial='Yes' or JoExpenditure='Yes'  or JoAgro='Yes' then 1 else 0 end)*100.0/count(*)) as jointly, Convert(Numeric(38, 2),sum(case when ShareHolder='Yes' then 1 else 0 end)*100.0/count(*)) as ShareHolder from tblWFsYearData where Year='" + Year + "'";
            DataSet wfgtrds = db.getResultset(wfgtrain, "", "", "");
            if (wfgtrds != null && wfgtrds.Tables[0].Rows.Count > 0)
            {
                dr = dt.NewRow();
                dr["Indicator"] = wfgtrds.Tables[0].Rows[0]["PercentTrain"].ToString();
                dt.Rows.Add(dr);
                dr = dt.NewRow();
                dr["Indicator"] = wfgtrds.Tables[0].Rows[0]["Finance"].ToString();
                dt.Rows.Add(dr);
                dr = dt.NewRow();
                dr["Indicator"] = wfgtrds.Tables[0].Rows[0]["Business"].ToString();
                dt.Rows.Add(dr);
                dr = dt.NewRow();
                dr["Indicator"] = wfgtrds.Tables[0].Rows[0]["ICTAccess"].ToString();
                dt.Rows.Add(dr);
                dr = dt.NewRow();
                dr["Indicator"] = wfgtrds.Tables[0].Rows[0]["OnFarm"].ToString();
                dt.Rows.Add(dr);
                dr = dt.NewRow();
                dr["Indicator"] = wfgtrds.Tables[0].Rows[0]["OffFarm"].ToString();
                dt.Rows.Add(dr);
                dr = dt.NewRow();
                dr["Indicator"] = wfgtrds.Tables[0].Rows[0]["Productive"].ToString();
                dt.Rows.Add(dr);
                dr = dt.NewRow();
                dr["Indicator"] = wfgtrds.Tables[0].Rows[0]["soley"].ToString();
                dt.Rows.Add(dr);
                dr = dt.NewRow();
                dr["Indicator"] = wfgtrds.Tables[0].Rows[0]["jointly"].ToString();
                dt.Rows.Add(dr);
                dr = dt.NewRow();
                dr["Indicator"] = wfgtrds.Tables[0].Rows[0]["ShareHolder"].ToString();
                dt.Rows.Add(dr);
            }
            else
            {
                dr = dt.NewRow();
                dr["Indicator"] = "0";
                dt.Rows.Add(dr);
                dr = dt.NewRow();
                dr["Indicator"] = "0";
                dt.Rows.Add(dr);
                dr = dt.NewRow();
                dr["Indicator"] = "0";
                dt.Rows.Add(dr);
                dr = dt.NewRow();
                dr["Indicator"] = "0";
                dt.Rows.Add(dr);
                dr = dt.NewRow();
                dr["Indicator"] = "0";
                dt.Rows.Add(dr);
                dr = dt.NewRow();
                dr["Indicator"] = "0";
                dt.Rows.Add(dr);
                dr = dt.NewRow();
                dr["Indicator"] = "0";
                dt.Rows.Add(dr);
                dr = dt.NewRow();
                dr["Indicator"] = "0";
                dt.Rows.Add(dr);
                dr = dt.NewRow();
                dr["Indicator"] = "0";
                dt.Rows.Add(dr);
                dr = dt.NewRow();
                dr["Indicator"] = "0";
                dt.Rows.Add(dr);
            }

            //Op3.2
            dr = dt.NewRow();
            string finance = "select count(*) as count from tblFPCRegistration where YEAR(CONVERT(Date, FPCRegistrationdate, 103))='" + Year + "'";
            DataSet finds = db.getResultset(finance, "", "", "");
            if (finds != null && finds.Tables[0].Rows.Count > 0)
            {
                dr["Indicator"] = finds.Tables[0].Rows[0]["count"].ToString();
            }
            else
            {
                dr["Indicator"] = "0";
            }
            dt.Rows.Add(dr);

            dr = dt.NewRow();
            dr["Indicator"] = "1";
            dt.Rows.Add(dr);
            dr = dt.NewRow();
            dr["Indicator"] = "1";
            dt.Rows.Add(dr);
            dr = dt.NewRow();
            dr["Indicator"] = "1";
            dt.Rows.Add(dr);


            // Response.Write("<script>alert('excel fired')</script>");
            Random rn = new Random();
            int Order = rn.Next(10000000, 99999999);
            string filepath = ConfigurationManager.ConnectionStrings["DownloadReport"].ConnectionString;
            try
            {
                string filename = "LogFrameIndicator" + DateTime.Now.ToString("dd-MM-yyyy") + "_" + DateTime.Now.ToString("hh-mm-ss") + ".xlsx";
                string excelpath = filepath + filename;
                System.IO.File.Copy(filepath + "LogFrameIndicator.xlsx", excelpath, true);
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


                excelWorkSheet.Cells[2, 8] = "Current value* " + Year;
                excelWorkSheet.Cells[2, 9] = "Y3 " + Year;
                excelWorkSheet.Cells[2, 10] = "Y1 " + (Convert.ToInt32(Year) - 2);
                excelWorkSheet.Cells[2, 11] = "Y2 " + (Convert.ToInt32(Year) -1 );
                excelWorkSheet.Cells[2, 12] = "Y4 " + (Convert.ToInt32(Year) + 1);
                for (int j = 1; j < dt.Rows.Count + 1; j++)
                {
                    excelWorkSheet.Cells[j + 2, 8] = dt.Rows[j - 1]["Indicator"].ToString();
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