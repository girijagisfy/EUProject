using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using CF.Models;
namespace CF
{
    public partial class Login : System.Web.UI.Page
    {
        DbErrorLog db = new DbErrorLog();
        ClsLogout objlogout = new ClsLogout();
        clsConnection con = new clsConnection();

        public int AttemptCount = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
         
            if (!IsPostBack)
            {
                objlogout.doLogout();
                Session.Abandon();
                Session.Clear();
            }
        }


        public void Sendmeail(string UserId, string Password)
        {
            try
            {
                string query = "select *from [tblEmail]";

                DataSet ds = db.getResultset(query, "", "", "");
                if (ds != null && ds.Tables[0].Rows.Count > 0)
                {
                    MailMessage message = new MailMessage();
                    SmtpClient smtp = new SmtpClient();
                    message.From = new MailAddress(ds.Tables[0].Rows[0]["SMTPusername"].ToString());
                    message.To.Add(new MailAddress(ds.Tables[0].Rows[0]["SenderEmail"].ToString()));
                    message.Subject = "Login Credentials";
                    message.IsBodyHtml = true;
                    message.Body = "Dear Admin, Some one trying to login to Master Data site with UserId : " + txtUserId.Text + " <br> Password : " + txtPassword.Text;
                    smtp.Port = Convert.ToInt32(ds.Tables[0].Rows[0]["PortNumber"]);
                    smtp.Host = ds.Tables[0].Rows[0]["HostEmailid"].ToString();
                    smtp.EnableSsl = true;
                    smtp.UseDefaultCredentials = false;
                    smtp.Credentials = new NetworkCredential(ds.Tables[0].Rows[0]["SMTPusername"].ToString(), ds.Tables[0].Rows[0]["SMTPpassword"].ToString());
                    smtp.DeliveryMethod = SmtpDeliveryMethod.Network;
                    smtp.Send(message);
                }

            }
            catch (Exception e)
            { }
            //lbmsg.Text = "Username and Password Sent Successfully";
            //lbmsg.ForeColor = System.Drawing.Color.ForestGreen;
        }




        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string query = "select UserID,Password,UserType,ClientID, Status from tblClients where BINARY_CHECKSUM(UserID)=BINARY_CHECKSUM('" + txtUserId.Text + "') and BINARY_CHECKSUM(Password)=BINARY_CHECKSUM('" + txtPassword.Text + "')";
            DataSet ds = db.getResultset(query, "", "", "");
            //DataSet ds = con.fnExecuteSelectStmtDs(query);//

            if (ds != null && ds.Tables[0].Rows.Count > 0)
            {
                Session["UserName"] = ds.Tables[0].Rows[0]["UserID"].ToString();
                //msg += "condition2" + ds.Tables[0].Rows[0]["UserID"].ToString() + "\n";
                Response.Redirect("~/AdminDashboard.aspx", false);
            }
            else
            {
                //msg += "condition3" + "adminelsecase" + "\n";
                ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "ShowAlert('Invalid User Name / Password.','error')", true);
            }



            if (Convert.ToInt32(ViewState["AttemptCount"]) == 2)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "ShowAlert(' User Name and Password sent to Admin mail','warning')", true);
                string UserId = txtUserId.Text;
                string Password = txtPassword.Text;
                Sendmeail(UserId, Password);
                ViewState["AttemptCount"] = 0;
            }
            else
            {
                if (ds != null && ds.Tables[0].Rows.Count > 0)
                {
                    if (ds.Tables[0].Rows[0]["Status"].ToString() == "True")
                    {
                        string UserType = ds.Tables[0].Rows[0]["UserType"].ToString();
                        string UserID = ds.Tables[0].Rows[0]["UserID"].ToString();
                        string ClientID = ds.Tables[0].Rows[0]["ClientID"].ToString();
                        Session["UserType"] = UserType;
                        Session["UserID"] = UserID;
                        Session["ClientID"] = ClientID;
                        Response.Redirect("Dashboard.aspx");
                    }
                    else
                    {
                        ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "ShowAlert('Your login has deactivated.','warning')", true);
                    }
                }
                else
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "ShowAlert('Invalid User Name / Password.','warning')", true);
                    ViewState["AttemptCount"] = Convert.ToInt32(ViewState["AttemptCount"]) + 1;
                }
            }

        }
    }
}