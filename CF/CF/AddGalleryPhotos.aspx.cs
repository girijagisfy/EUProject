using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.IO;

namespace CF
{
    public partial class GalleryPhotos : System.Web.UI.Page
    {
        DbErrorLog db = new DbErrorLog();
        protected void Page_Load(object sender, EventArgs e)
        {
            Page.UnobtrusiveValidationMode = UnobtrusiveValidationMode.None;
            if (Session["UserType"] != null)
            {
                if (!IsPostBack)
                {
                   
                }
            }
            else
            {
                Response.Redirect("~/Logout.aspx");
            }

        }
        protected void btnSubmit_Click(object sender, EventArgs e)
        {

            string MediaPath = ConfigurationManager.ConnectionStrings["CFMedia"].ToString();
            string Videos = "";
            string Images = "";
            string Type = "";
            string fileExtention = System.IO.Path.GetExtension(Imageupload.FileName);
            string[] imageEtentions = { ".JPEG", ".JPG", ".PNG", ".TIFF", ".GIF" };
            string[] VideoEtentions = { ".WEBM", ".MKV", ".FLV", ".VOB", ".WMV", ".AVI", ".SVI", ".MP4" };

            if (Imageupload.FileName == "")
            {
                ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "ShowAlert('Select file','warning')", true);
            }
            else if (Imageupload.FileName != "")
            {
                fileExtention = fileExtention.ToUpperInvariant();
                if (!imageEtentions.Contains(fileExtention) && !VideoEtentions.Contains(fileExtention))
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "ShowAlert('Please select image or video','warning')", true);

                }
                else if (imageEtentions.Contains(fileExtention.ToUpper()))
                {
                    Images = Imageupload.FileName;
                    Imageupload.SaveAs(MediaPath + Images);
                    Type = "Image";
                }
                else
                {
                    Videos = Imageupload.FileName;
                    Imageupload.SaveAs(MediaPath + Videos);
                    Type = "Video";
                }
                string InsertImage = "INSERT INTO [dbo].[tblImages] ([ImagePath],[VideoPath],[Type]) VALUES('" + Images + "','" + Videos + "','" + Type + "')";
                if (db.UpdateQuery(InsertImage, "", "", "") > 0)
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "ShowAlert('Data submitted successufuly. ','success')", true);
                    Response.Redirect("GalleryInfo.aspx");
                }
                else
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "ShowAlert('Something went wrong please try again.','warning')", true);
                }
            }

        }

    }
}
