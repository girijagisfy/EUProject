using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CF
{
    public partial class EditUser : System.Web.UI.Page
    {
        DbErrorLog db = new DbErrorLog();
        string id = "";
        string User = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserType"] != null)
            {
                User = Session["UserType"].ToString();
                if (User == "Admin" || User == "CSO")
                {
                    Page.UnobtrusiveValidationMode = UnobtrusiveValidationMode.None;
                    if (Session["Cid"] != null)
                    {
                        id = Session["Cid"].ToString();
                        if (!IsPostBack)
                        {
                            LoadTypes();
                            LoadData();
                        }
                    }
                    else
                    {
                        Response.Redirect("~/UsersInfo.aspx");
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

        public void LoadTypes()
        {
            if (User == "Admin")
            {
                ddlType.Items.Insert(0, "Select");
                ddlType.Items.Insert(1, "Admin");
                ddlType.Items.Insert(2, "CSO");
                ddlType.Items.Insert(3, "WFG");
            }
            else if (User == "CSO")
            {
                ddlType.Items.Insert(0, "Select");
                ddlType.Items.Insert(1, "CSO");
                ddlType.Items.Insert(2, "WFG");
            }
        }

        public void LoadUsers()
        {
            string type = ddlType.SelectedValue;
            string query = "";
            if (type == "Admin")
            {
                query = "select ClientID as ID, Name from tblClients";
            }
            if (type == "CSO")
            {
                query = "select CSOID as ID,CSOName as Name from tblCSO order by CSOName";
            }
            else if (type == "WFG")
            {
                query = "select WfgNo as ID,WFGName as Name from tblWFGs order by WFGName";
            }
            else if (type == "WF")
            {
                query = "select WfNo as ID,WFName as Name from tblWFs order by WFName";
            }

            DataSet ds = db.getResultset(query, "", "", "");
            if (ds != null && ds.Tables[0].Rows.Count > 0)
            {
                ddlName.DataSource = ds;
                ddlName.DataTextField = "Name";
                ddlName.DataValueField = "ID";
                ddlName.DataBind();
                ddlName.Items.Insert(0, "Select");
            }
        }

        public void LoadData()
        {
            string query = "select Cid,Name,ClientID,UserID,Password,UserType from tblClients where Cid=" + Session["Cid"];
            DataSet ds = db.getResultset(query, "", "", "");
            if (ds != null && ds.Tables[0].Rows.Count > 0)
            {
                if (ddlType.Items.FindByValue(ds.Tables[0].Rows[0]["UserType"].ToString()) != null)
                {
                    ddlType.Items.FindByValue(ds.Tables[0].Rows[0]["UserType"].ToString()).Selected = true;
                }
                LoadUsers();
                if (ddlName.Items.FindByValue(ds.Tables[0].Rows[0]["ClientID"].ToString()) != null)
                {
                    ddlName.Items.FindByValue(ds.Tables[0].Rows[0]["ClientID"].ToString()).Selected = true;
                }
                txtUserID.Text = ds.Tables[0].Rows[0]["UserID"].ToString();
                txtPassword.Text = ds.Tables[0].Rows[0]["Password"].ToString();
                txtConformPassword.Text = ds.Tables[0].Rows[0]["Password"].ToString();
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            string query = "update tblClients set Name='" + ddlName.SelectedItem.Text + "',ClientID=" + ddlName.SelectedValue + ",UserID='" + txtUserID.Text + "',Password='" + txtPassword.Text + "',UserType='" + ddlType.SelectedValue + "' where Cid=" + id;

            if (db.UpdateQuery(query, "", "", "") > 0)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "ShowAlert('Data Updated successfully. Thank you.','success')", true);
            }
            else
            {
                ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "ShowAlert('Something went wrong please try again.','warning')", true);
            }
        }

        protected void txtUserID_TextChanged(object sender, EventArgs e)
        {
            string query = "select UserId from tblClients where UserId ='" + txtUserID.Text + "'";
            DataSet ds = db.getResultset(query, "", "", "");
            if (ds != null && ds.Tables[0].Rows.Count > 0)
            {
                lblUserStatus.Text = "User Name Taken";
                lblUserStatus.CssClass = "text-danger";
            }
            else
            {
                lblUserStatus.Text = "User Available";
                lblUserStatus.CssClass = "text-success";
            }
        }

        protected void ddlType_SelectedIndexChanged(object sender, EventArgs e)
        {
            string type = ddlType.SelectedValue;
            string query = "";
            if (type == "CSO")
            {
                query = "select CSOID as ID,CSOName as Name from tblCSO order by CSOName";
            }
            else if (type == "WFG")
            {
                query = "select WfgNo as ID,WFGName as Name from tblWFGs order by WFGName";
            }
            else if (type == "WF")
            {
                query = "select WfNo as ID,WFName as Name from tblWFs order by WFName";
            }

            DataSet ds = db.getResultset(query, "", "", "");
            if (ds != null && ds.Tables[0].Rows.Count > 0)
            {
                ddlName.DataSource = ds;
                ddlName.DataTextField = "ID";
                ddlName.DataValueField = "Name";
                ddlName.DataBind();
                ddlName.Items.Insert(0, "Select");
            }
        }
    }
}