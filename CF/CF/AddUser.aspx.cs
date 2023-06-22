using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CF
{
    public partial class AddUser : System.Web.UI.Page
    {
        DbErrorLog db = new DbErrorLog();
        string User = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserType"] != null)
            {
                User = Session["UserType"].ToString();
                if (User == "Admin" || User == "CSO")
                {
                    Page.UnobtrusiveValidationMode = UnobtrusiveValidationMode.None;
                    if (!IsPostBack)
                    {
                        LoadTypes();
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
                ddlType.Items.Insert(1, "CSO");
                ddlType.Items.Insert(2, "WFG");
            }
            else if (User == "CSO")
            {
                ddlType.Items.Insert(0, "Select");
                ddlType.Items.Insert(1, "WFG");
            }
        }

        protected void ddlType_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlType.SelectedIndex > 0)
            {
                string type = ddlType.SelectedValue;
                string query = "";
                if (type == "CSO")
                {
                    query = "Select CSOID as ID,CSOName as Name from tblCSO a left outer join tblClients b on a.csoid=b.clientid where a.UserType='CSO' and b.ClientID is null order by CSOName";
                }
                else if (type == "WFG")
                {
                    if (User == "Admin")
                    {
                        query = "select WfgNo as ID,WFGName as Name from tblWFGs a left outer join tblClients b on a.WfgNo=b.clientid where a.UserType='WFG' and b.ClientID is null order by WFGName";
                    }
                    else
                    {
                        query = "select WfgNo as ID,WFGName as Name from tblWFGs  a left outer join tblVillageInfo b on a.VillageID=b.Vid left outer join tblClients c on a.WfgNo=c.clientid where a.UserType='WFG' and c.ClientID is null and b.CSOID = " + Session["ClientID"] + " order by WFGName";
                    }

                }
                //else if (type == "WF")
                //{
                //    query = "select WfNo as ID,WFName as Name from tblWFs order by WFName";
                //}

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
            else
            {
                ddlName.Items.Clear();
                ddlName.Items.Insert(0, "Select");
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

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            string find = "select * from tblClients where ClientID = " + ddlName.SelectedValue + " and UserType = '" + ddlType.SelectedValue + "'";
            DataSet ds = db.getResultset(find, "", "", "");
            if (ds != null && ds.Tables[0].Rows.Count > 0)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "ShowExist('User already Exists.','warning')", true);
            }
            else
            {
                string query = "Insert into tblClients(Name,ClientID,UserID,Password,UserType) values('" + ddlName.SelectedItem.Text + "'," + ddlName.SelectedValue + ",'" + txtUserID.Text + "','" + txtPassword.Text + "','" + ddlType.SelectedValue + "')";

                if (db.UpdateQuery(query, "", "", "") > 0)
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "ShowAlert('Login Created successfully. Thank you.','success')", true);
                }
                else
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "ShowAlert('Something went wrong please try again.','warning')", true);
                }
            }
        }
    }
}