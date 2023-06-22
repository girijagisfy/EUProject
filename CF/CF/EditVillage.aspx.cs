using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CF
{
    public partial class EditVillage : System.Web.UI.Page
    {
        DbErrorLog db = new DbErrorLog();
        protected void Page_Load(object sender, EventArgs e)
        {
            Page.UnobtrusiveValidationMode = UnobtrusiveValidationMode.None;
            if (Session["ClientID"] != null)
            {
                if (!IsPostBack)
                {

                    loadCSO();
                    loaddata();
                    if (Session["UserType"].ToString() == "CSO")
                    {
                        ddlCso.Enabled = false;
                    }
                }
            }
            else
            {
                Response.Redirect("~/Logout.aspx");
            }
        }

        public void loadCSO()
        {
            string selectCSO = "select [CSOID],[CSOName]from tblCSO order by CSOName";
            DataSet ds = db.getResultset(selectCSO, "", "", "");
            if (ds.Tables[0].Rows.Count > 0 && ds != null)
            {
                ddlCso.DataSource = ds.Tables[0];
                ddlCso.DataTextField = "CSOName";
                ddlCso.DataValueField = "CSOID";
                ddlCso.DataBind();
                ddlCso.Items.Insert(0, "Select");
            }
        }

        public void LoadStates()
        {
            string selectVill = "select Stateid,StateName from tblStates order by StateName";
            DataSet dsV = db.getResultset(selectVill, "", "", "");
            if (dsV != null && dsV.Tables[0].Rows.Count > 0)
            {
                ddlState.DataSource = dsV;
                ddlState.DataTextField = "StateName";
                ddlState.DataValueField = "Stateid";
                ddlState.DataBind();
                ddlState.Items.Insert(0, "Select");
            }
        }

        public void loaddata()
        {
            string vidCondetion = Session["Vid"].ToString();
            string selectCSO = "SELECT [Vid],VillageID,[GramPanchayatName],a.[BlockID],a.StateId,a.[DistrictID],a.[CSOID] FROM [dbo].[tblVillageInfo] a left outer join tblCSO b on a.csoid=b.csoid where [Vid]=" + vidCondetion;
            DataSet ds = db.getResultset(selectCSO, "", "", "");
            if (ds.Tables[0].Rows.Count > 0 && ds != null)
            {
                if (ddlCso.Items.FindByValue(ds.Tables[0].Rows[0]["CSOID"].ToString()) != null)
                {
                    ddlCso.Items.FindByValue(ds.Tables[0].Rows[0]["CSOID"].ToString()).Selected = true;
                }
                LoadStates();
                if (ddlState.Items.FindByValue(ds.Tables[0].Rows[0]["StateId"].ToString()) != null)
                {
                    ddlState.Items.FindByValue(ds.Tables[0].Rows[0]["StateId"].ToString()).Selected = true;
                }
                loadDist();
                if (ddlDistrict.Items.FindByValue(ds.Tables[0].Rows[0]["DistrictID"].ToString()) != null)
                {
                    ddlDistrict.Items.FindByValue(ds.Tables[0].Rows[0]["DistrictID"].ToString()).Selected = true;
                }

                loadBlock();
                if (ddlBlock.Items.FindByValue(ds.Tables[0].Rows[0]["BlockID"].ToString()) != null)
                {
                    ddlBlock.Items.FindByValue(ds.Tables[0].Rows[0]["BlockID"].ToString()).Selected = true;
                }

                txtGramPamchayat.Text = ds.Tables[0].Rows[0]["GramPanchayatName"].ToString();

                ViewState["VillageID"] = ds.Tables[0].Rows[0]["VillageID"].ToString();
                loadVillage(ViewState["VillageID"].ToString());
                if (ddlVillage.Items.FindByValue(ds.Tables[0].Rows[0]["VillageID"].ToString()) != null)
                {
                    ddlVillage.Items.FindByValue(ds.Tables[0].Rows[0]["VillageID"].ToString()).Selected = true;
                }
            }
        }

        public void loadDist()
        {
            string selectDist = "Select District,DistrictID from tblDistricts order by District";
            DataSet ds = db.getResultset(selectDist, "", "", "");
            if (ds != null && ds.Tables[0].Rows.Count > 0)
            {
                ddlDistrict.DataSource = ds;
                ddlDistrict.DataTextField = "District";
                ddlDistrict.DataValueField = "DistrictID";
                ddlDistrict.DataBind();
            }
        }

        public void loadVillage(string villageid)
        {
            if (villageid == "")
            {
                villageid = "0";
            }
            string selectVill = "Select Village,a.VillageID,b.VillageID from tblVillages a left outer join tblVillageInfo b on a.VillageID = b.VillageID where (b.VillageID is null or b.VillageID = " + villageid + ") and a.BlockID =" + ddlBlock.SelectedValue + " order by Village";
            DataSet dsV = db.getResultset(selectVill, "", "", "");
            if (dsV != null && dsV.Tables[0].Rows.Count > 0)
            {
                ddlVillage.DataSource = dsV;
                ddlVillage.DataTextField = "Village";
                ddlVillage.DataValueField = "VillageID";
                ddlVillage.DataBind();
                ddlVillage.Items.Insert(0, "Select");
            }
        }


        public void loadBlock()
        {
            string selectDist = "Select Block,BlockID from tblBlocks order by Block";
            DataSet ds = db.getResultset(selectDist, "", "", "");
            if (ds != null && ds.Tables[0].Rows.Count > 0)
            {
                ddlBlock.DataSource = ds;
                ddlBlock.DataTextField = "Block";
                ddlBlock.DataValueField = "BlockID";
                ddlBlock.DataBind();
            }
        }
        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            string val = Session["Vid"].ToString();
            string RevenueVillageName = ddlVillage.SelectedValue;
            string GramPanchayatName = txtGramPamchayat.Text;
            string Block = ddlBlock.SelectedValue;
            string District = ddlDistrict.SelectedValue;
            string State = ddlState.SelectedValue;
            string insertQ = "UPDATE tblVillageInfo set [VillageID] = " + RevenueVillageName + ", [GramPanchayatName]= '" + GramPanchayatName + "',[BlockID]= " + Block + ",[DistrictID]= " + District + ", StateID= " + State + " where [Vid] = " + val;

            if (db.UpdateQuery(insertQ, "", "", "") > 0)
            {

                ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "ShowAlert('You have updated data successfully. Thank you.','success')", true);

            }
            else
            {
                ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "ShowAlert('Something went wrong please try again.','warning')", true);
            }
        }
        protected void ddlCso_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlCso.SelectedIndex > 0)
            {
                string cso = ddlCso.SelectedValue;
                string selectCSO = "select DistrictID,BlockID,StateId FROM tblCSO where [CSOID]=" + cso;
                DataSet ds = db.getResultset(selectCSO, "", "", "");
                if (ds != null && ds.Tables[0].Rows.Count > 0)
                {
                    LoadStates();
                    if (ddlState.Items.FindByValue(ds.Tables[0].Rows[0]["StateId"].ToString()) != null)
                    {
                        ddlState.Items.FindByValue(ds.Tables[0].Rows[0]["StateId"].ToString()).Selected = true;
                    }
                    loadDist();
                    ddlDistrict.Items.FindByValue(ds.Tables[0].Rows[0]["DistrictID"].ToString()).Selected = true;

                    loadBlock();
                    ddlBlock.Items.FindByValue(ds.Tables[0].Rows[0]["BlockID"].ToString()).Selected = true;

                    loadVillage(ViewState["VillageID"].ToString());
                }

            }
            else
            {
                ddlDistrict.Items.Clear();
                ddlBlock.Items.Clear();
            }
        }
    }
}