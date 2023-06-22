using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.IO;
using ClosedXML.Excel;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


namespace CF
{
    public partial class CroppingInfo : System.Web.UI.Page
    {
        DbErrorLog db = new DbErrorLog();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Hid"] != null)
            {
                if (Session["HDid"] != null)
                {
                    if (!IsPostBack)
                    {
                        GetDetails();
                    }
                }
                else
                {
                    Response.Redirect("~/HamletDataInfo.aspx");
                }
            }
            else
            {
                Response.Redirect("~/VillageHamlet.aspx");
            }
        }

        public void GetDetails()
        {
            ;
            string query = "select NCid,NameofHamlet,PatternName,TotalAreainacr as TotalAreainacre,AverageProduction,AverageIncome from tblNaturalResouce_CroppingPattern a left outer join tblHamletData b on a.HdId=b.HDid left outer join tblHamletInfo c on b.Hid=c.Hid where a.HdId=" + Session["HDid"];
            DataSet ds = db.getResultset(query, "", "", "");
            DataTable dt = new DataTable();
            if (ds != null && ds.Tables[0].Rows.Count > 0)
            {
                dt = ds.Tables[0];
            }

            gvCropping.DataSource = dt;
            gvCropping.DataBind();

            ViewState["dirState"] = dt;
            ViewState["sortdr"] = "Asc";

        }

        protected void gvCropping_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName.Equals("btnEdit"))
            {
                string strid = e.CommandName.ToString();
                int rowIndex = int.Parse(e.CommandArgument.ToString());
                string val = (string)this.gvCropping.DataKeys[rowIndex]["NCid"].ToString();
                Session["NCid"] = val;
                Response.Redirect("Editcroppingpattern.aspx");
            }
        }

        protected void gvCropping_Sorting(object sender, GridViewSortEventArgs e)
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
                gvCropping.DataSource = dtrslt;
                gvCropping.DataBind();
            }

            for (int i = 0; i < gvCropping.Columns.Count; i++)
            {
                string lbText = gvCropping.Columns[i].SortExpression;

                if (lbText == e.SortExpression)
                {
                    TableCell tableCell = gvCropping.HeaderRow.Cells[i];
                    Image img = new Image();
                    img.ImageUrl = (Convert.ToString(ViewState["sortdr"]) == "Asc") ? "~/Images/ArrowUp.gif" : "~/Images/ArrowDown.gif";
                    tableCell.Controls.Add(new LiteralControl("&nbsp;"));
                    tableCell.Controls.Add(img);
                }
            }
        }

        protected void gvCropping_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvCropping.PageIndex = e.NewPageIndex;
            GetDetails();
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            GridViewRow gvRow = (GridViewRow)(sender as Control).Parent.Parent;
            int rowIndex = gvRow.RowIndex;
            string val = (string)this.gvCropping.DataKeys[rowIndex]["NCid"].ToString();
            string deleteQ = "delete from tblNaturalResouce_CroppingPattern where NCid=" + val;
            if (db.UpdateQuery(deleteQ, "", "", "") > 0)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "ShowAlert('You have deleted Cropping Pattern successfully.','success')", true);
            }
            else
            {
                ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "ShowAlert('Something went wrong please try again.','warning')", true);
            }
        }

        protected void btnReport_Click(object sender, EventArgs e)
        {
            string query = "select NameofHamlet,PatternName,TotalAreainacr,AverageProduction,AverageIncome from tblNaturalResouce_CroppingPattern a left outer join tblHamletData b on a.HdId=b.HDid left outer join tblHamletInfo c on b.Hid=c.Hid where a.HdId=" + Session["HDid"];

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
                        string myName = Server.UrlEncode("CroppingPattern_" + DateTime.Now.ToShortDateString() + ".xlsx");

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

        private void ExportDataSetToExcel(DataSet ds)
        {
            // Response.Write("<script>alert('excel fired')</script>");
            Random rn = new Random();
            int Order = rn.Next(10000000, 99999999);
            string filepath = ConfigurationManager.ConnectionStrings["ReportPath"].ConnectionString;
            try
            {
                string filename = "CroppingPattern" + DateTime.Now.ToString("dd-MM-yyyy") + "_" + DateTime.Now.ToString("hh-mm-ss") + ".xlsx";
                string excelpath = filepath + filename;
                System.IO.File.Copy(filepath + "WFReport.xlsx", excelpath, true);
                //Creae an Excel application instance
                Microsoft.Office.Interop.Excel.Application excelApp = new Microsoft.Office.Interop.Excel.Application();
                // Response.Write("<script>alert('excelapp created')</script>");

                //Create an Excel workbook instance and open it from the predefined location
                Microsoft.Office.Interop.Excel.Workbook excelWorkBook = excelApp.Workbooks.Open(excelpath);
                int lastRow = ds.Tables[0].Rows.Count;
                //Response.Redirect("<script>alert('excelWorkBook')</script>");

                foreach (DataTable table in ds.Tables)
                {
                    //Add a new worksheet to workbook with the Datatable name
                    //Excel.Worksheet excelWorkSheet = excelWorkBook.Sheets.Add();
                    //excelWorkSheet.Name = table.TableName;

                    Microsoft.Office.Interop.Excel.Worksheet excelWorkSheet = (Microsoft.Office.Interop.Excel.Worksheet)excelWorkBook.Worksheets.get_Item("Sheet1");

                    for (int i = 1; i < table.Columns.Count + 1; i++)
                    {
                        excelWorkSheet.Cells[1, i] = table.Columns[i - 1].ColumnName;
                    }

                    for (int j = 0; j < table.Rows.Count; j++)
                    {
                        for (int k = 0; k < table.Columns.Count; k++)
                        {
                            excelWorkSheet.Cells[j + 2, k + 1] = table.Rows[j].ItemArray[k].ToString();
                        }
                    }
                    // excelWorkSheet.Rows[lastRow].Style.Color = Color.LightBlue;
                }

                excelWorkBook.Save();
                excelWorkBook.Close();
                excelApp.Quit();
                // Response.Write("<script>alert('excel completed')</script>");
                DownloadXlsx(excelpath);
                //DownloadPDF(excelpath);
            }
            catch (Exception ex)
            {
                ex.Message.ToString();
                //AppendToErrorLog(ex.Message.ToString(), ex.StackTrace.ToString(), "", "");
            }
        }

        public void DownloadXlsx(string fileName)
        {
            string path = ConfigurationManager.ConnectionStrings["ReportPath"].ConnectionString;
            FileInfo file = new FileInfo(fileName);
            if (file.Exists)
            {
                Response.Clear();
                Response.ClearHeaders();
                Response.ClearContent();
                Response.AddHeader("content-disposition", "attachment; filename=" + Path.GetFileName(fileName));
                Response.AddHeader("Content-Type", "application/Excel");
                Response.ContentType = "application/vnd.xlsx";
                Response.AddHeader("Content-Length", file.Length.ToString());
                Response.WriteFile(file.FullName);
                Response.End();
                ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "HideLoader()", true);
            }
            else
            {
                Response.Write("This file does not exist.");
            }
        }
    }
}