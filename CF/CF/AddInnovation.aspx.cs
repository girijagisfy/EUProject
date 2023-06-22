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
    public partial class AddInnovation : System.Web.UI.Page
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
            string Textarea = "";
            string Images = "";
            if (Textid.Text != "")
            {
                Textarea = Textid.Text;
            }

            if (Imageupload.FileName != "")
            {
                Images = Imageupload.FileName;
                Imageupload.SaveAs(MediaPath + Images);
            }


            //string Images = Path.GetFileName(Imageupload.PostedFile.FileName);
            //Imageupload.PostedFile.SaveAs(Server.MapPath("CFMedia1/" + Images));
            //string Vidoes = Path.GetFileName(VidoeUpload.PostedFile.FileName);
            //VidoeUpload.PostedFile.SaveAs(Server.MapPath("CFMedia1/" + Vidoes));
            // string imagePath = MediaPath + "" + Images;
            if (Textid.Text == "" && Imageupload.FileName == "")
            {

            }
            else
            {
                string InsertImage = "INSERT INTO [dbo].[tblInnovationImages] ([Textarea],[ImagePath]) VALUES('" + Textarea + "','" + Images + "')";
                if (db.UpdateQuery(InsertImage, "", "", "") > 0)
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "ShowAlert('Data submitted successufuly. ','success')", true);
                    Response.Redirect("InnovationInfo.aspx");
                }
                else
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "ShowAlert('Something went wrong please try again.','warning')", true);
                }
            }


        }
    }
}