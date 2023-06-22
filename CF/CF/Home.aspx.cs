using CF;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace UMS
{
    public partial class Home : System.Web.UI.Page
    {
        DbErrorLog db = new DbErrorLog();
        protected void Page_Load(object sender, EventArgs e)
        {
            Page.UnobtrusiveValidationMode = UnobtrusiveValidationMode.None;
            if (!IsPostBack)
            { 
                //Getdata();
            }

        }

        //public void Getdata()
        //{
        //    try
        //    {
        //        string query = "select *from [tblImages]";

        //        DataSet ds = db.getResultset(query, "", "", "");
        //        if (ds != null && ds.Tables[0].Rows.Count > 0)
        //        {
                   
        //        }

        //    }
        //    catch (Exception e)
        //    { }
        //    //lbmsg.Text = "Username and Password Sent Successfully";
        //    //lbmsg.ForeColor = System.Drawing.Color.ForestGreen;
        //}

    }
}