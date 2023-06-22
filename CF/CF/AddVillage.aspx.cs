using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

namespace CF
{
    public partial class AddVillage : System.Web.UI.Page
    {
        DbErrorLog db = new DbErrorLog();
        string User = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            User = Session["UserType"].ToString();
            if (Session["ClientID"] != null)
            {
                Page.UnobtrusiveValidationMode = UnobtrusiveValidationMode.None;
                if (!IsPostBack)
                {
                    loadCSO();

                    if (User == "CSO")
                    {
                        LoadCSOData();
                        loadVillage();
                    }
                }
            }
            else
            {
                Response.Redirect("~/Logout.aspx");
            }

        }

        protected void LoadCSOData()
        {
            string query = "select * from tblCSO where CSOID = " + Session["ClientID"];
            DataSet ds = db.getResultset(query, "", "", "");
            if (ds != null && ds.Tables[0].Rows.Count > 0)
            {
                LoadStates();
                if (ddlState.Items.FindByValue(ds.Tables[0].Rows[0]["StateId"].ToString()) != null)
                {
                    ddlState.Items.FindByValue(ds.Tables[0].Rows[0]["StateId"].ToString()).Selected = true;
                }
                ddlState.Enabled = false;
                loadCSO();
                if (ddlCso.Items.FindByValue(Session["ClientID"].ToString()) != null)
                {
                    ddlCso.Items.FindByValue(Session["ClientID"].ToString()).Selected = true;
                }
                ddlCso.Enabled = false;
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
            }
        }

        public void LoadStates()
        {
            string selectVill = "Select * from tblStates";
            DataSet dsV = db.getResultset(selectVill, "", "", "");
            if (dsV != null && dsV.Tables[0].Rows.Count > 0)
            {
                ddlState.DataSource = dsV;
                ddlState.DataTextField = "StateName";
                ddlState.DataValueField = "StateId";
                ddlState.DataBind();
                ddlState.Items.Insert(0, "Select");
            }
            else
            {
                ddlState.Items.Clear();
                ddlState.Items.Insert(0, "Select");
            }
        }

        public void loadCSO()
        {
            string selectCSO = "select [CSOID],[CSOName]from tblCSO";
            DataSet ds = db.getResultset(selectCSO, "", "", "");
            if (ds.Tables[0].Rows.Count > 0 && ds != null)
            {
                ddlCso.DataSource = ds.Tables[0];
                ddlCso.DataTextField = "CSOName";
                ddlCso.DataValueField = "CSOID";
                ddlCso.DataBind();
                ddlCso.Items.Insert(0, "Select");
            }
            else
            {
                ddlCso.Items.Clear();
                ddlCso.Items.Insert(0, "Select");
            }
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            string cso = ddlCso.SelectedValue;
            string RevenueVillageName = ddlVillage.SelectedValue;
            string District = ddlDistrict.SelectedValue;
            string block = ddlBlock.SelectedValue;
            string gramPanchayat = txtGramPamchayat.Text;
            string State = ddlState.SelectedValue;

            string InsertVillage = "INSERT INTO [dbo].[tblVillageInfo] ([VillageID],[GramPanchayatName],[BlockID],[DistrictID], [StateID],[CSOID]) VALUES(" + RevenueVillageName + ",'" + gramPanchayat + "'," + block + "," + District + "," + State + "," + cso + ")";
            if (db.UpdateQuery(InsertVillage, "", "", "") > 0)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "ShowAlert('You have submitted data successfully. Thank you.','success')", true);
            }
            else
            {
                ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "ShowAlert('Something went wrong please try again.','warning')", true);
            }
        }

        public void loadDist()
        {
            string selectDist = "Select District,DistrictID from tblDistricts";
            DataSet ds = db.getResultset(selectDist, "", "", "");
            if (ds != null && ds.Tables[0].Rows.Count > 0)
            {
                ddlDistrict.DataSource = ds;
                ddlDistrict.DataTextField = "District";
                ddlDistrict.DataValueField = "DistrictID";
                ddlDistrict.DataBind();
            }
        }

        public void loadVillage()
        {
            string selectVill = "Select Village,a.VillageID from tblVillages a left outer join tblVillageInfo b on a.VillageID = b.VillageID where b.VillageID is null and a.BlockID=" + ddlBlock.SelectedValue + " order by Village";
            DataSet dsV = db.getResultset(selectVill, "", "", "");
            if (dsV != null && dsV.Tables[0].Rows.Count > 0)
            {
                ddlVillage.DataSource = dsV;
                ddlVillage.DataTextField = "Village";
                ddlVillage.DataValueField = "VillageID";
                ddlVillage.DataBind();
                ddlVillage.Items.Insert(0, "Select");
            }
            else
            {
                ddlVillage.Items.Clear();
                ddlVillage.Items.Insert(0, "Select");
            }
        }

        public void loadBlock()
        {
            string selectDist = "Select Block,BlockID from tblBlocks";
            DataSet ds = db.getResultset(selectDist, "", "", "");
            if (ds != null && ds.Tables[0].Rows.Count > 0)
            {
                ddlBlock.DataSource = ds;
                ddlBlock.DataTextField = "Block";
                ddlBlock.DataValueField = "BlockID";
                ddlBlock.DataBind();
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
                    if (ddlDistrict.Items.FindByValue(ds.Tables[0].Rows[0]["DistrictID"].ToString()) != null)
                    {
                        ddlDistrict.Items.FindByValue(ds.Tables[0].Rows[0]["DistrictID"].ToString()).Selected = true;
                    }

                    loadBlock();
                    if (ddlBlock.Items.FindByValue(ds.Tables[0].Rows[0]["BlockID"].ToString()) != null)
                    {
                        ddlBlock.Items.FindByValue(ds.Tables[0].Rows[0]["BlockID"].ToString()).Selected = true;
                    }

                    loadVillage();
                }

            }
            else
            {
                ddlDistrict.Items.Clear();
                ddlBlock.Items.Clear();
            }
        }

        protected void ddlGrampanchayath_SelectedIndexChanged(object sender, EventArgs e)
        {
            loadVillage();
        }
    }
}