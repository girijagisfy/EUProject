using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CF
{
    public partial class AnganwadiInfo : System.Web.UI.Page
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
            string query = "select Anid,NameofHamlet, NameofAnganwadicentres, EnrolmentinAnganwadiCentres, Anganwadiisfunctionalornot from tblAnganwadiDetails a left outer join tblHamletData b on a.HdId=b.HDid left outer join tblHamletInfo c on b.Hid=c.Hid where a.HdId=" + Session["HDid"];
            DataSet ds = db.getResultset(query, "", "", "");
            DataTable dt = new DataTable();
            if (ds != null && ds.Tables[0].Rows.Count > 0)
            {
                dt = ds.Tables[0];
            }

            gvAngan.DataSource = dt;
            gvAngan.DataBind();

            ViewState["dirState"] = dt;
            ViewState["sortdr"] = "Asc";

        }

        protected void gvAngan_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName.Equals("btnEdit"))
            {
                string strid = e.CommandName.ToString();
                int rowIndex = int.Parse(e.CommandArgument.ToString());
                string val = (string)this.gvAngan.DataKeys[rowIndex]["Anid"].ToString();
                Session["Anid"] = val;
                Response.Redirect("EditAnganwadi.aspx");
            }
        }

        protected void gvAngan_Sorting(object sender, GridViewSortEventArgs e)
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
                gvAngan.DataSource = dtrslt;
                gvAngan.DataBind();
            }

            for (int i = 0; i < gvAngan.Columns.Count; i++)
            {
                string lbText = gvAngan.Columns[i].SortExpression;

                if (lbText == e.SortExpression)
                {
                    TableCell tableCell = gvAngan.HeaderRow.Cells[i];
                    Image img = new Image();
                    img.ImageUrl = (Convert.ToString(ViewState["sortdr"]) == "Asc") ? "~/Images/ArrowUp.gif" : "~/Images/ArrowDown.gif";
                    tableCell.Controls.Add(new LiteralControl("&nbsp;"));
                    tableCell.Controls.Add(img);
                }
            }
        }

        protected void gvAngan_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvAngan.PageIndex = e.NewPageIndex;
            GetDetails();
        }

        protected void btnStatus_Click(object sender, EventArgs e)
        {
            GridViewRow gvRow = (GridViewRow)(sender as Control).Parent.Parent;
            int rowIndex = gvRow.RowIndex;
            string val = (string)this.gvAngan.DataKeys[rowIndex]["Anid"].ToString();
            string deleteQ = "delete from tblAnganwadiDetails where Anid=" + val;
            if (db.UpdateQuery(deleteQ, "", "", "") > 0)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "ShowAlert('You have deleted Anganwadi successfully.','success')", true);
            }
            else
            {
                ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "ShowAlert('Something went wrong please try again.','warning')", true);
            }
        }

        protected void btnReport_Click(object sender, EventArgs e)
        {

            string hamletid = Session["Hid"].ToString();

            ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "ShowLoader()", true);
            string query = "select NameofHamlet, NameofAnganwadicentres, EnrolmentinAnganwadiCentres, Anganwadiisfunctionalornot from tblAnganwadiDetails  a left outer join tblHamletInfo b on a.Hamletid=b.Hid where HamletID =" + hamletid;



            DataSet ds = db.getResultset(query, "", "", "");
            if (ds != null && ds.Tables[0].Rows.Count > 0)
            {
                ExportDataSetToExcel(ds);
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
                string filename = "Anganwadi" + DateTime.Now.ToString("dd-MM-yyyy") + "_" + DateTime.Now.ToString("hh-mm-ss") + ".xlsx";
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