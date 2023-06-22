using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Threading;

namespace CF
{
    public partial class Gallery : System.Web.UI.Page
    {
        DbErrorLog db = new DbErrorLog();
        protected void Page_Load(object sender, EventArgs e)
        {
            Page.UnobtrusiveValidationMode = UnobtrusiveValidationMode.None;
            if (!IsPostBack)
            {
                loadimages();
            }
        }
        string[] IMAGE;
        string[] VIDEO;
        public static string showImagelist = string.Empty;
        public static string showVideoList = string.Empty;
        private string LoadDocList()
        {

            try
            {
                showImagelist = string.Empty;

                int image1 = 0;

                for (int i = 0; i < IMAGE.Length; i++)
                {
                    if (image1 == 3)
                    {
                        showImagelist += "</div><div class='row'>";
                        image1 = 0;
                    }

                    showImagelist += " <div class='col-lg-4 col-md-4 col-sm-4'><div class='form-group'><img src = '" + IMAGE[i] + "' style='width:100%'></div></div>";
                    image1++;

                }

                return showImagelist;

            }
            catch (Exception ex)
            {
                return null;
            }
        }

        private string LoadVidoes()
        {

            try
            {
                showVideoList = string.Empty;

                int Vidoes1 = 0;

                for (int i = 0; i <= VIDEO.Length; i++)
                {
                    if (Vidoes1 == 3)
                    {
                        showVideoList += "</div><div class='row'>";
                        Vidoes1 = 0;
                    }

                    showVideoList += "<div class='col-lg-4 col-md-4 col-sm-4'><div class='form-group'><Video width ='350' src = '" + VIDEO[i] + "' controls></Video></div></div>";
                    Vidoes1++;
                }

                return showVideoList;

            }
            catch
            {
                return null;
            }
        }
        public void loadimages()
        {
            string MediaPath = ConfigurationManager.ConnectionStrings["CFMedia1"].ToString();
            string selectDist = "select * from tblImages";
            DataSet ds = db.getResultset(selectDist, "", "", "");

            if (ds != null && ds.Tables[0].Rows.Count > 0)
            {
                IMAGE = new string[ds.Tables[0].Rows.Count];
                VIDEO = new string[ds.Tables[0].Rows.Count];
                for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                {

                    IMAGE[i] = MediaPath + ds.Tables[0].Rows[i]["ImagePath"].ToString();
                    VIDEO[i] = MediaPath + ds.Tables[0].Rows[i]["VideoPath"].ToString();

                    //string k = MediaPath + ds.Tables[0].Rows[i]["ImagePath"].ToString();
                    //string k1 = MediaPath + ds.Tables[0].Rows[i]["VidoePath"].ToString();
                    ////Image.ImageUrl = k;
                    ////video.Src = k1;



                }


            }
            LoadDocList();
            LoadVidoes();
        }
    }
}