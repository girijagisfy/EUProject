using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

namespace CF
{
    public partial class AddCSOCapacity : System.Web.UI.Page
    {
        DbErrorLog db = new DbErrorLog();
        string User = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserType"] != null)
            {
                User = Convert.ToString(Session["UserType"]);
                if (User == "Admin" || User == "CSO")
                {
                    Page.UnobtrusiveValidationMode = UnobtrusiveValidationMode.None;

                    if (!IsPostBack)
                    {
                        if (User == "Admin")
                        {
                            LoadCSO();
                        }
                        if (User == "CSO")
                        {
                            LoadCSOData();
                        }

                        loadQuarter();
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

        public void loadQuarter()
        {
            ddlQuarter.Items.Insert(0, "Select");
            ddlQuarter.Items.Insert(1, "Quarter1");
            ddlQuarter.Items.Insert(2, "Quarter2");
            ddlQuarter.Items.Insert(3, "Quarter3");
            ddlQuarter.Items.Insert(4, "Quarter4");
        }

        public void LoadCSO()
        {
            string query = "select Csoid,Csoname from tblCso where Status=1 order by Csoname ";
            DataSet ds = db.getResultset(query, "", "", "");

            if (ds != null && ds.Tables[0].Rows.Count > 0)
            {
                ddlCSO.DataSource = ds;
                ddlCSO.DataValueField = "Csoid";
                ddlCSO.DataTextField = "Csoname";
                ddlCSO.DataBind();
                ddlCSO.Items.Insert(0, "Select");
            }
            else
            {
                ddlCSO.Items.Clear();
                ddlCSO.Items.Insert(0, "Select");
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
        public void LoadStates()
        {
            string selectVill = "Select StateId, StateName from tblStates order by StateName";
            DataSet dsV = db.getResultset(selectVill, "", "", "");
            if (dsV != null && dsV.Tables[0].Rows.Count > 0)
            {
                ddlstate.DataSource = dsV;
                ddlstate.DataTextField = "StateName";
                ddlstate.DataValueField = "StateId";
                ddlstate.DataBind();
                ddlstate.Items.Insert(0, "Select");
            }
            else
            {
                ddlstate.Items.Clear();
                ddlstate.Items.Insert(0, "Select");
            }
        }

        protected void LoadCSOData()
        {
            string query = "select * from tblCSO where CSOID = " + Session["ClientID"];
            DataSet ds = db.getResultset(query, "", "", "");
            if (ds != null && ds.Tables[0].Rows.Count > 0)
            {
                LoadCSO();
                if (ddlCSO.Items.FindByValue(Session["ClientID"].ToString()) != null)
                {
                    ddlCSO.Items.FindByValue(Session["ClientID"].ToString()).Selected = true;
                }
                ddlCSO.Enabled = false;
                LoadStates();
                if (ddlstate.Items.FindByValue(ds.Tables[0].Rows[0]["StateId"].ToString()) != null)
                {
                    ddlstate.Items.FindByValue(ds.Tables[0].Rows[0]["StateId"].ToString()).Selected = true;
                }
                ddlstate.Enabled = false;
                loadDist();
                if (ddlDistrict.Items.FindByValue(ds.Tables[0].Rows[0]["DistrictID"].ToString()) != null)
                {
                    ddlDistrict.Items.FindByValue(ds.Tables[0].Rows[0]["DistrictID"].ToString()).Selected = true;
                }
                ddlDistrict.Enabled = false;
                loadBlock();
                if (ddlBlock.Items.FindByValue(ds.Tables[0].Rows[0]["BlockID"].ToString()) != null)
                {
                    ddlBlock.Items.FindByValue(ds.Tables[0].Rows[0]["BlockID"].ToString()).Selected = true;
                }
                ddlBlock.Enabled = false;
            }
        }

        protected void ddlCSO_SelectedIndexChanged(object sender, EventArgs e)
        {

            txtYear.Text = string.Empty;
            ddlQuarter.Items.Clear();
            loadQuarter();

            if (ddlCSO.SelectedIndex > 0)
            {
                string selectCSO = "SELECT [District],c.DistrictID,[Block],b.BlockID,D.StateId,StateName FROM tblCSO A,tblBlocks B,tblDistricts C ,tblStates D  where B.[BlockID ] = A.BlockID and C.[DistrictID] = A.DistrictID and D.[StateId] = A.StateId and CSOID =" + ddlCSO.SelectedValue;
                DataSet csods = db.getResultset(selectCSO, "", "", "");
                if (csods != null && csods.Tables[0].Rows.Count > 0)
                {
                    LoadStates();
                    if (ddlstate.Items.FindByValue(csods.Tables[0].Rows[0]["StateId"].ToString()) != null)
                    {
                        ddlstate.Items.FindByValue(csods.Tables[0].Rows[0]["StateId"].ToString()).Selected = true;
                    }
                    loadDist();
                    if (ddlDistrict.Items.FindByValue(csods.Tables[0].Rows[0]["DistrictID"].ToString()) != null)
                    {
                        ddlDistrict.Items.FindByValue(csods.Tables[0].Rows[0]["DistrictID"].ToString()).Selected = true;
                    }
                    loadBlock();
                    if (ddlBlock.Items.FindByValue(csods.Tables[0].Rows[0]["BlockID"].ToString()) != null)
                    {
                        ddlBlock.Items.FindByValue(csods.Tables[0].Rows[0]["BlockID"].ToString()).Selected = true;
                    }
                }                
            }
            else
            {
                ddlstate.Items.Clear();
                ddlstate.Items.Insert(0, "Select");
                ddlDistrict.Items.Clear();
                ddlDistrict.Items.Insert(0, "Select");
                ddlBlock.Items.Clear();
                ddlBlock.Items.Insert(0, "Select");
            }

        }

        protected void btnsubmit_Click(object sender, EventArgs e)
        {
            string csoId = ddlCSO.SelectedValue;
            string stateId = ddlstate.SelectedValue;
            string districtId = ddlDistrict.SelectedValue;
            string block = ddlBlock.SelectedValue;
            string year = txtYear.Text;
            string quareter = ddlQuarter.SelectedValue;
            string ltvc = txtLTVC.Text;
            string spic = txtSPIC.Text;
            string frs = txtFRS.Text;
            string slq = txtSLQ.Text;
            string lqna = txtLQNA.Text;
            string pm = txtPM.Text;
            string fm = txtFM.Text;
            string teafs = txtTEAFS.Text;
            string teae = txtTEAE.Text;
            string tesap = txtTESAP.Text;
            string udpmls = txtUDPMLS.Text;
            string meidm = txtMEIDM.Text;
            string quarterScore = hfOverallScore.Value;
            string quarterStatus = hfoverallScoreStatus.Value;

            string insertQ = "INSERT INTO [dbo].[tblCsoCapacity]([CsoId],[StateId],[DistrictId],[BlockId],[Year],[Quarter],[LongTermVisioning],[StrategicPlanning],[FundRaisingSkills],[SeniorLeadership],[LeadershipQuality],[ProgramManagement],[FinancialManagement],[FPCFormation],[WomenEmpowerment],[SustainableAgriculture],[UsageofDigitalPMLS],[Monitoring_Evaluation],[QuarterScore],[QuarterlyStatus]) VALUES(" + csoId + "," + stateId + "," + districtId + "," + block + ",'" + year + "','" + quareter + "','" + ltvc + "','" + spic + "','" + frs + "','" + slq + "','" + lqna + "','" + pm + "','" + fm + "','" + teafs + "','" + teae + "','" + tesap + "','" + udpmls + "','" + meidm + "','" + quarterScore + "','" + quarterStatus + "')";
            if (db.UpdateQuery(insertQ, "", "", "") > 0)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "ShowAlert('CSO Capacity Building Added Successfully.','success')", true);
            }
            else
            {
                ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "ShowAlert('Something went wrong please try again.','warning')", true);
            }

        }

        protected void txtYear_TextChanged(object sender, EventArgs e)
        {
            string year = string.Empty;
            if (!string.IsNullOrEmpty(txtYear.Text))
            {
                string selectQ = "select Quarter from tblCsoCapacity where year='" + txtYear.Text + "' and CsoId=" + ddlCSO.SelectedValue;
                DataSet ds = db.getResultset(selectQ, "", "", "");
                if (ds != null && ds.Tables[0].Rows.Count > 0)
                {
                    for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                    {
                        ddlQuarter.Items.FindByValue(ds.Tables[0].Rows[i]["Quarter"].ToString()).Enabled = false;
                    }
                }
                else
                {
                    ddlQuarter.Items.Clear();
                    loadQuarter();
                }
            }
        }
    }
}