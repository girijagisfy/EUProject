using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

namespace CF
{
    public partial class VerfyEmail : System.Web.UI.Page
    {
        DbErrorLog db = new DbErrorLog();
        public int Emailid { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {
            Page.UnobtrusiveValidationMode = UnobtrusiveValidationMode.None;
            if (!IsPostBack)
            {
                GetDetails();
            }
        }

        public void GetDetails()
        {
            string query = "select* from tblEmail";
            DataSet ds = db.getResultset(query, "", "", "");
            if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
            {
                ViewState["EmailId"] = Convert.ToInt32(ds.Tables[0].Rows[0]["Emailid"]);
                txtemail.Text = ds.Tables[0].Rows[0]["HostEmailid"].ToString();
                txtUserName.Text = ds.Tables[0].Rows[0]["SMTPusername"].ToString();
                txtPassword.Text = ds.Tables[0].Rows[0]["SMTPpassword"].ToString();
                txtportname.Text = ds.Tables[0].Rows[0]["PortName"].ToString();
                txtPortNumber.Text = ds.Tables[0].Rows[0]["PortNumber"].ToString();
                txtSEnderemail.Text = ds.Tables[0].Rows[0]["SenderEmail"].ToString();
                btnSubmit.Text = "Update";
            }

        }
        private void ClearControls()
        {
            txtemail.Text = string.Empty;
            txtUserName.Text = string.Empty;
            txtPassword.Text = string.Empty;
            txtportname.Text = string.Empty;
            txtPortNumber.Text = string.Empty;
            txtSEnderemail.Text = string.Empty;
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {

            string HostEmailid = txtemail.Text;
            string SMTPusername = txtUserName.Text;
            string SMTPpassword = txtPassword.Text;
            string PortName = txtportname.Text;
            string PortNumber = txtPortNumber.Text;
            string SenderEmail = txtSEnderemail.Text;
            string InsertEmail = "";
            int EmailId = 0;
            if (ViewState["EmailId"] != null)
            {
                EmailId = Convert.ToInt32(ViewState["EmailId"]);
            }
            if (btnSubmit.Text == "save")
            {
                InsertEmail = "INSERT INTO [dbo].[tblEmail] ([HostEmailid],[SMTPusername],[SMTPpassword],[PortName],[PortNumber],[SenderEmail]) VALUES('" + HostEmailid + "','" + SMTPusername + "','" + SMTPpassword + "','" + PortName + "','" + PortNumber + "','" + SenderEmail + "')";
                btnSubmit.Text = "Update";
            }
            else
            {
                InsertEmail = "update [tblEmail] set [HostEmailid]='" + HostEmailid + "',[SMTPusername]='" + SMTPusername + "',[SMTPpassword]='" + SMTPpassword + "',[PortName]='" + PortName + "',[PortNumber]='" + PortNumber + "',[SenderEmail]='" + SenderEmail + "' where Emailid=" + EmailId;

            }
            if (db.UpdateQuery(InsertEmail, "", "", "") > 0)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "ShowAlert('You have submitted data successfully. Thank you.','success')", true);

            }
            else
            {
                ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "ShowAlert('Something went wrong please try again.','warning')", true);
            }

        }
    }
}