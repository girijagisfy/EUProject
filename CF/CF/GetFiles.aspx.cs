using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CF
{
    public partial class GetFiles : System.Web.UI.Page
    {
        DbErrorLog db = new DbErrorLog();
        protected void Page_Load(object sender, EventArgs e)
        {
            string FileName = string.Empty;

            if (Request.QueryString["FileName"] != null)
            {
                if (Request.QueryString["FileName"].ToString().Trim().Length > 0)
                {
                    FileName = Request.QueryString["FileName"].ToString().Trim();
                    if (FileName == "PDF")
                    {
                        DownloadXlsx(FileName);
                    }
                    else
                    {
                        DownloadXlsx(FileName);
                    }

                }
            }
        }
        public void DownloadXlsx(string fileName)
        {
            try
            {
                string path = ConfigurationManager.ConnectionStrings["DownloadReport"].ConnectionString;
                string dpa = path + fileName;

                string extension = Path.GetExtension(dpa).Replace(".", "");
                string contype = string.Empty;
                if (extension == "txt")
                {
                    contype = "text/plain";
                }
                else if (extension == "htm" || extension == "html")
                {
                    contype = "text/HTML";
                }
                else if (extension == "doc" || extension == "rtf" || extension == "docx")
                {
                    contype = "Application/msword";
                }
                else if (extension == "xls" || extension == "xlsx")
                {
                    contype = "Application/x-msexcel";
                }
                //.jpg, .jpeg Response.ContentType = "image/jpeg";
                else if (extension == "jpg" || extension == "jpeg")
                {
                    contype = "image/jpeg";
                }
                else if (extension == "gif")
                {
                    contype = "image/GIF";
                }
                else if (extension == "pdf")
                {
                    contype = "application/pdf";
                }
                Response.Clear();
                Response.ClearHeaders();
                Response.ContentType = contype;


                Response.AppendHeader("Content-Disposition", "attachment; filename=" + Path.GetFileName(dpa));

                Response.WriteFile(dpa);
                Response.Flush();

                Response.End();
            }
            catch (Exception ex)
            {
                ex.Message.ToString();
                db.AppendToErrorLog(ex.Message.ToString(), ex.StackTrace.ToString(), "", "");
            }
        }


    }
}