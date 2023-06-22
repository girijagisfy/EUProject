using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Drawing;
using CF.Models;
using System.Collections.Specialized;

namespace CF
{


    public partial class Dashboard : System.Web.UI.Page
    {
        DbErrorLog db = new DbErrorLog();
        clsFilter objclsfilter = new clsFilter();

        string User = "";
        string VillageID = "";
        string CSOID = "";
        string WFGID = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserType"] != null)
            {
                User = Session["UserType"].ToString();
                if (User == "Admin" || User == "CSO" || User == "WFG")
                {
                    Page.UnobtrusiveValidationMode = UnobtrusiveValidationMode.None;
                    if (!IsPostBack)
                    {
                        this.txtyear.Text = DateTime.Now.Year.ToString();
                        if (User == "Admin")
                        {
                            getState();
                            getDistrict();
                            getBlock();
                            GetCSOs("", "", "", "");
                            GetVillages("", "", "", "", "");
                            GetWFGs("", "", "", "", "", "");
                        }
                        else if (User == "CSO")
                        {
                            string query = "select CSOID,CSOName,StateID,DistrictID,BlockID from tblCSO where CSOID=" + Session["ClientID"] + " order by CSOName";
                            DataSet ds = db.getResultset(query, "", "", "");

                            ddlCSO.DataSource = ds;
                            ddlCSO.DataTextField = "CSOName";
                            ddlCSO.DataValueField = "CSOID";
                            ddlCSO.DataBind();
                            getState();
                            if (ddlState.Items.FindByValue(ds.Tables[0].Rows[0]["StateID"].ToString()) != null)
                            {
                                ddlState.Items.FindByValue(ds.Tables[0].Rows[0]["StateID"].ToString()).Selected = true;
                            }
                            getDistrict();
                            if (ddlDistrict.Items.FindByValue(ds.Tables[0].Rows[0]["DistrictID"].ToString()) != null)
                            {
                                ddlDistrict.Items.FindByValue(ds.Tables[0].Rows[0]["DistrictID"].ToString()).Selected = true;
                            }
                            getBlock();
                            if (ddlBlock.Items.FindByValue(ds.Tables[0].Rows[0]["BlockID"].ToString()) != null)
                            {
                                ddlBlock.Items.FindByValue(ds.Tables[0].Rows[0]["BlockID"].ToString()).Selected = true;
                            }
                            if (ddlCSO.Items.FindByValue(Session["ClientID"].ToString()) != null)
                            {
                                ddlCSO.Items.FindByValue(Session["ClientID"].ToString()).Selected = true;
                            }
                            ddlState.Enabled = false;
                            ddlDistrict.Enabled = false;
                            ddlBlock.Enabled = false;
                            GetVillages("", "", "", "", Session["ClientID"].ToString());
                            GetWFGs("", "", "", "", Session["ClientID"].ToString(), "");
                        }
                        else if (User == "WFG")
                        {
                            string query = "select c.CSOID,a.VillageID,StateID,DistrictID,BlockID from tblWFGs a left outer join tblVillageInfo b on a.VillageID = b.Vid left outer join tblCSO c on b.CSOID = c.CSOID where WfgNo = " + Session["ClientID"];

                            DataSet ds = db.getResultset(query, "", "", "");
                            if (ds != null && ds.Tables[0].Rows.Count > 0)
                            {
                                VillageID = ds.Tables[0].Rows[0]["VillageID"].ToString();
                                CSOID = ds.Tables[0].Rows[0]["CSOID"].ToString();
                                WFGID = Session["ClientID"].ToString();
                                getState();
                                if (ddlState.Items.FindByValue(ds.Tables[0].Rows[0]["StateID"].ToString()) != null)
                                {
                                    ddlState.Items.FindByValue(ds.Tables[0].Rows[0]["StateID"].ToString()).Selected = true;
                                }
                                getDistrict();
                                if (ddlDistrict.Items.FindByValue(ds.Tables[0].Rows[0]["DistrictID"].ToString()) != null)
                                {
                                    ddlDistrict.Items.FindByValue(ds.Tables[0].Rows[0]["DistrictID"].ToString()).Selected = true;
                                }
                                getBlock();
                                if (ddlBlock.Items.FindByValue(ds.Tables[0].Rows[0]["BlockID"].ToString()) != null)
                                {
                                    ddlBlock.Items.FindByValue(ds.Tables[0].Rows[0]["BlockID"].ToString()).Selected = true;
                                }
                                GetCSOs(CSOID, "", "", "");
                                GetVillages(VillageID, "", "", "", CSOID);
                                GetWFGs(WFGID, "", "", "", CSOID, "");
                                if (ddlCSO.Items.FindByValue(CSOID) != null)
                                {
                                    ddlCSO.Items.FindByValue(CSOID).Selected = true;
                                }
                            }
                            ddlState.Enabled = false;
                            ddlDistrict.Enabled = false;
                            ddlBlock.Enabled = false;
                        }


                    }
                    string Type = Session["UserType"].ToString();
                    string ID = Session["ClientID"].ToString();
                    hfClientID.Value = ID;
                    hfUserType.Value = Type;
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

        public void getState()
        {
            try
            {
                DataTable dt = objclsfilter.bindState();
                ddlState.DataTextField = "StateName";
                ddlState.DataValueField = "StateId";
                ddlState.DataSource = dt;
                ddlState.DataBind();
                ddlState.Items.Insert(0, "All");
            }
            catch (Exception ex)
            {

            }
        }

        public void getDistrict()
        {
            try
            {
                string stateId = ddlState.SelectedItem.Value;
                DataTable dt = objclsfilter.bindDistrict(stateId);
                ddlDistrict.DataTextField = "District";
                ddlDistrict.DataValueField = "DistrictID";
                ddlDistrict.DataSource = dt;
                ddlDistrict.DataBind();
                ddlDistrict.Items.Insert(0, "All");
            }
            catch (Exception ex)
            {

            }
        }

        public void getBlock()
        {
            try
            {
                string districtId = ddlDistrict.SelectedItem.Value;
                DataTable ddt = objclsfilter.bindBlock(districtId);
                ddlBlock.DataTextField = "Block";
                ddlBlock.DataValueField = "BlockID";
                ddlBlock.DataSource = ddt;
                ddlBlock.DataBind();
                ddlBlock.Items.Insert(0, "All");
            }
            catch (Exception ex)
            {

            }
        }

        public void GetCSOs(string csoid, string StateID, string DistrictID, string BlockID)
        {
            string csocondition = "";
            string Condetion = string.Empty;
            if (csoid != "")
            {
                csocondition += " and csoid=" + csoid;
            }
            if (!string.IsNullOrEmpty(StateID))
            {
                Condetion = " and StateID=" + StateID;
            }
            if (!string.IsNullOrEmpty(DistrictID))
            {
                Condetion = " and DistrictID=" + DistrictID;
            }
            if (!string.IsNullOrEmpty(BlockID))
            {
                Condetion = " and BlockID=" + BlockID;
            }
            if (ddlBlock.SelectedValue != "All")
            {
                csocondition += " and BlockID=" + ddlBlock.SelectedValue;
            }
            string query = "select CSOID,CSOName from tblCSO where 1=1 " + csocondition + Condetion + " order by CSOName";
            DataSet ds = db.getResultset(query, "", "", "");
            if (ds != null && ds.Tables[0].Rows.Count > 0)
            {
                ddlCSO.DataSource = ds;
                ddlCSO.DataTextField = "CSOName";
                ddlCSO.DataValueField = "CSOID";
                ddlCSO.DataBind();
                if (csoid == "")
                {
                    ddlCSO.Items.Insert(0, "All");
                }
            }
            else
            {
                ddlCSO.Items.Clear();
                ddlvillage.Items.Clear();
                ddlWFG.Items.Clear();
            }
        }

        public void GetVillages(string villageid, string StateID, string DistrictID, string BlockID, string CSOID)
        {
            string villagecondition = "";
            if (villageid != "")
            {
                villagecondition = " And Vid= " + villageid;
            }
            string Condetion = string.Empty;
            if (!string.IsNullOrEmpty(StateID))
            {
                Condetion = " and c.StateID=" + StateID;
            }
            if (!string.IsNullOrEmpty(DistrictID))
            {
                Condetion = " and c.DistrictID=" + DistrictID;
            }
            if (!string.IsNullOrEmpty(BlockID))
            {
                Condetion = " and b.BlockID=" + BlockID;
            }
            if (!string.IsNullOrEmpty(CSOID))
            {
                Condetion = " and c.CSOID=" + CSOID;
            }
            string query = "select Vid,village,a.VillageID,b.VillageID from tblVillageInfo a left outer join tblVillages b on a.VillageID=b.VillageID left outer join tblCSO c on b.BlockID=c.BlockID where 1=1" + villagecondition + Condetion + "  order by trim(village) ";
            DataSet ds = db.getResultset(query, "", "", "");
            if (ds != null && ds.Tables[0].Rows.Count > 0)
            {
                ddlvillage.DataSource = ds;
                ddlvillage.DataTextField = "village";
                ddlvillage.DataValueField = "Vid";
                ddlvillage.DataBind();

                if (User != "WFG")
                {
                    ddlvillage.Items.Insert(0, "All");
                }
                if (User == "WFG")
                {
                    ddlvillage.Items.FindByValue(VillageID).Selected = true;
                }
            }
            else
            {
                ddlvillage.Items.Clear();
                ddlWFG.Items.Clear();
            }
        }

        public void GetWFGs(string wfgid, string StateID, string DistrictID, string BlockID, string CSOID, string villageID)
        {
            string andwfgid = "";
            string WFGCondetion = "";
            string VillageID = ddlvillage.SelectedValue;
            string csoid = ddlCSO.SelectedValue;
            string WFGID = "";
            if (wfgid != "")
            {
                andwfgid = " and wfgno=" + wfgid;
            }
            if (csoid != "All")
            {
                WFGCondetion += " and d.CSOID =" + ddlCSO.SelectedValue;
            }
            if (VillageID != "All")
            {
                WFGCondetion += " and a.VillageID = " + ddlvillage.SelectedValue;
            }
            string Condetion = string.Empty;
            if (!string.IsNullOrEmpty(StateID))
            {
                Condetion = " and d.StateID=" + StateID;
            }
            if (!string.IsNullOrEmpty(DistrictID))
            {
                Condetion = " and d.DistrictID=" + DistrictID;
            }
            if (!string.IsNullOrEmpty(BlockID))
            {
                Condetion = " and d.BlockID=" + BlockID;
            }
            if (!string.IsNullOrEmpty(villageID))
            {
                Condetion = " and b.Vid=" + villageID;
            }
            if (!string.IsNullOrEmpty(CSOID))
            {
                Condetion = " and d.CSOID=" + CSOID;
            }
            string query = "select WfgNo,WFGName from tblWFGs a left outer join tblVillageInfo b on a.VillageID = b.Vid left outer join tblVillages c on b.VillageID=c.VillageID left outer join tblCSO d on c.BlockID=d.BlockID where 1=1 " + WFGCondetion + WFGID + andwfgid + " order by WFGName";
            DataSet ds = db.getResultset(query, "", "", "");
            if (ds != null && ds.Tables[0].Rows.Count > 0)
            {
                ddlWFG.DataSource = ds;
                ddlWFG.DataTextField = "WFGName";
                ddlWFG.DataValueField = "WfgNo";
                ddlWFG.DataBind();
                ddlWFG.Items.Insert(0, "All");

                if (User == "WFG")
                {
                    ddlWFG.Items.FindByValue(wfgid).Selected = true;
                }
            }
            else
            {
                ddlWFG.Items.Clear();
            }
        }

        protected void ddlvillage_SelectedIndexChanged(object sender, EventArgs e)
        {
            ddlWFG.Items.Clear();
            if (ddlvillage.SelectedIndex > 0)
            {
                string StateID = string.Empty;
                if (ddlState.SelectedValue != "All")
                {
                    StateID = ddlState.SelectedValue;
                }
                string DistrictID = string.Empty;
                if (ddlDistrict.SelectedValue != "All")
                {
                    DistrictID = ddlDistrict.SelectedValue;
                }
                string BlockID = string.Empty;
                if (ddlBlock.SelectedValue != "All")
                {
                    BlockID = ddlBlock.SelectedValue;
                }
                string CSOID = string.Empty;
                if (ddlCSO.SelectedValue != "All")
                {
                    CSOID = ddlCSO.SelectedValue;
                }
                string VillageID = string.Empty;
                if (ddlvillage.SelectedValue != "All")
                {
                    VillageID = ddlvillage.SelectedValue;
                }
                GetWFGs("", StateID, DistrictID, BlockID, CSOID, VillageID);
            }
        }

        protected void ddlCSO_SelectedIndexChanged(object sender, EventArgs e)
        {
            ddlWFG.Items.Clear();
            ddlvillage.Items.Clear();
            if (ddlCSO.SelectedIndex > 0)
            {
                string StateID = string.Empty;
                if (ddlState.SelectedValue != "All")
                {
                    StateID = ddlState.SelectedValue;
                }
                string DistrictID = string.Empty;
                if (ddlDistrict.SelectedValue != "All")
                {
                    DistrictID = ddlDistrict.SelectedValue;
                }
                string BlockID = string.Empty;
                if (ddlBlock.SelectedValue != "All")
                {
                    BlockID = ddlBlock.SelectedValue;
                }
                string CSOID = string.Empty;
                if (ddlCSO.SelectedValue != "All")
                {
                    CSOID = ddlCSO.SelectedValue;
                }
                string VillageID = string.Empty;
                if (ddlvillage.SelectedValue != "All")
                {
                    VillageID = ddlvillage.SelectedValue;
                }
                GetVillages("", StateID, DistrictID, BlockID, CSOID);
                GetWFGs("", StateID, DistrictID, BlockID, CSOID, VillageID);
            }
        }

        [System.Web.Services.WebMethod]
        public static List<object> SocialCategory(string stateId, string districtId, string blockId, string CSOId, string VillageId, string WFGID)
        {
            DbErrorLog db = new DbErrorLog();
            string VillageCondetion = string.Empty;
            string stateCondition = string.Empty;
            string districtCondion = string.Empty;
            string blockCondition = string.Empty;
            string CSOCondetion = string.Empty;
            string WFGCondetion = string.Empty;
            if (stateId != "All")
            {
                stateCondition = " and c.StateId = " + stateId;
            }
            if (districtId != "All")
            {
                districtCondion = " and c.DistrictID = " + districtId;

            }
            if (blockId != "All")
            {
                blockCondition = " and c.BlockID = " + blockId;
            }
            if (CSOId != "All")
            {
                CSOCondetion = " and c.CSOID = " + CSOId;
            }
            if (VillageId != "All")
            {
                VillageCondetion = " and Vid = " + VillageId;
            }
            if (WFGID != "All")
            {
                WFGCondetion = " and WfgNo = " + WFGID;
            }
            string allContion = stateCondition + districtCondion + blockCondition + VillageCondetion + CSOCondetion + WFGCondetion;

            string strQUery = "SELECT Count([SocialCategoryID]) as Total,b.Socialcategory FROM [dbo].[tblWFs] a left outer join tblsocialcategory b on a.SocialCategoryID = b.Sid left outer join tblVillageInfo c on a.VillageID = c.Vid left outer join tblWFGs d on a.WFGID= d.WfgNo where 1=1 " + allContion + " group by[SocialCategoryID], b.SocialCategory order by b.SocialCategory";
            DataSet ds = db.getResultset(strQUery, "", "", "");
            DataTable dtSocialCategory = new DataTable();
            if (ds != null && ds.Tables[0].Rows.Count > 0)
            {
                dtSocialCategory = ds.Tables[0];
            }

            Random r = new Random();
            List<object> SocialCategory = new List<object>();

            if (dtSocialCategory.Rows.Count > 0)
            {
                for (int i = 0; i < dtSocialCategory.Rows.Count; i++)
                {
                    SocialCategory.Add(new object[]
                    {
                        dtSocialCategory.Rows[i]["Socialcategory"].ToString(),
                        Convert.ToInt32(dtSocialCategory.Rows[i]["Total"].ToString()),
                        String.Format("#{0:X6}", r.Next(0x1000000)),
                });
                }
            }
            else
            {
                SocialCategory.Add(new object[]
                    {
                        "Socialcategory",
                        0,
                        String.Format("#{0:X6}", r.Next(0x1000000)),
                });
            }

            return SocialCategory;
        }

        [System.Web.Services.WebMethod]
        public static string Age(string stateId, string districtId, string blockId, string CSOId, string VillageId, string WFGID)
        {
            DbErrorLog db = new DbErrorLog();
            string VillageCondetion = string.Empty;
            string stateCondition = string.Empty;
            string districtCondion = string.Empty;
            string blockCondition = string.Empty;
            string CSOCondetion = string.Empty;
            string WFGCondetion = string.Empty;
            if (stateId != "All")
            {
                stateCondition = " and c.StateId = " + stateId;
            }
            if (districtId != "All")
            {
                districtCondion = " and c.DistrictID = " + districtId;

            }
            if (blockId != "All")
            {
                blockCondition = " and c.BlockID = " + blockId;
            }
            if (CSOId != "All")
            {
                CSOCondetion = " and c.CSOID = " + CSOId;
            }
            if (VillageId != "All")
            {
                VillageCondetion = " and Vid = " + VillageId;
            }
            if (WFGID != "All")
            {
                WFGCondetion = " and WfgNo = " + WFGID;
            }
            string allContion = stateCondition + districtCondion + blockCondition + VillageCondetion + CSOCondetion + WFGCondetion;

            string Age = "";

            string strQUery = "SELECT SUM(CASE WHEN [Age] < 18 THEN 1 ELSE 0 END) AS [Under 18], SUM(CASE WHEN [Age] BETWEEN 18 AND 30 THEN 1 ELSE 0 END) AS[18 - 30],SUM(CASE WHEN [Age] BETWEEN 31 AND 40 THEN 1 ELSE 0 END) AS[31 - 40],SUM(CASE WHEN [Age] BETWEEN 41 AND 50 THEN 1 ELSE 0 END) AS[41 - 50],SUM(CASE WHEN [Age] BETWEEN 51 AND 60 THEN 1 ELSE 0 END) AS[51 - 60],SUM(CASE WHEN [Age] > 60 THEN 1 ELSE 0 END) AS[Above 60] FROM [CF].[dbo].[tblWFs] a left outer join tblVillageInfo c on a.VillageID = c.Vid left outer join tblWFGs d on a.WFGID = d.WfgNo where 1=1" + allContion;
            DataSet ds = db.getResultset(strQUery, "", "", "");
            DataTable dtAge = new DataTable();
            if (ds != null && ds.Tables[0].Rows.Count > 0)
            {
                dtAge = ds.Tables[0];
                for (int i = 0; i < dtAge.Columns.Count; i++)
                {
                    if (Age == "")
                    {
                        Age = dtAge.Rows[0][i].ToString();
                    }
                    else
                    {
                        Age += "," + dtAge.Rows[0][i].ToString();
                    }
                }
            }
            else
            {
                Age = "0,0,0,0,0,0";
            }

            return Age;
        }

        [System.Web.Services.WebMethod]
        public static List<object> EducationalQualification(string stateId, string districtId, string blockId, string CSOId, string VillageId, string WFGID)
        {

            DbErrorLog db = new DbErrorLog();

            string VillageCondetion = string.Empty;
            string stateCondition = string.Empty;
            string districtCondion = string.Empty;
            string blockCondition = string.Empty;
            string CSOCondetion = string.Empty;
            string WFGCondetion = string.Empty;
            if (stateId != "All")
            {
                stateCondition = " and c.StateId = " + stateId;
            }
            if (districtId != "All")
            {
                districtCondion = " and c.DistrictID = " + districtId;
            }
            if (blockId != "All")
            {
                blockCondition = " and c.BlockID = " + blockId;
            }
            if (CSOId != "All")
            {
                CSOCondetion = " and c.CSOID = " + CSOId;
            }
            if (VillageId != "All")
            {
                VillageCondetion = " and Vid = " + VillageId;
            }
            if (WFGID != "All")
            {
                WFGCondetion = " and WfgNo = " + WFGID;
            }
            string allContion = stateCondition + districtCondion + blockCondition + VillageCondetion + CSOCondetion + WFGCondetion;

            string strQUery = "SELECT sum(case when Qualification='Cannot read at all' then 1  else 0 end) as [Cannot read at all],sum(case when Qualification='Can read Name/signature' then 1  else 0 end) as [Can read Name/signature],sum(case when Qualification='Upto 5th' then 1  else 0 end) as [Upto 5th],sum(case when Qualification='Upto 8th' then 1  else 0 end) as [Upto 8th],sum(case when Qualification='Upto 10th' then 1  else 0 end) as [Upto 10th],sum(case when Qualification='Upto 12th' then 1  else 0 end) as [Upto 12th],sum(case when Qualification='BA' then 1  else 0 end) as [BA],sum(case when Qualification='MA' then 1  else 0 end) as [MA],sum(case when Qualification='Other' then 1  else 0 end) as Other FROM [dbo].[tblWFs] a left outer join tblVillageInfo c on a.VillageID = c.Vid left outer join tblWFGs d on a.WFGID = d.WfgNo where 1=1 " + allContion + "";
            DataSet ds = db.getResultset(strQUery, "", "", "");
            DataTable dtEQ = new DataTable();

            if (ds != null && ds.Tables[0].Rows.Count > 0)
            {
                dtEQ = ds.Tables[0];
            }
            Random r = new Random();
            List<object> Qualification = new List<object>();
            //Qualification.Add(new object[]
            //{
            //    "Qualification","Total"
            //});

            if (dtEQ.Rows.Count > 0)
            {
                Qualification.Add(new object[]
                {
                        "1-5th",
                        Convert.ToInt32(dtEQ.Rows[0]["1-5th"].ToString()),
                        String.Format("#{0:X6}", r.Next(0x1000000)),
                });
                Qualification.Add(new object[]
                   {
                        "6-8th",
                        Convert.ToInt32(dtEQ.Rows[0]["6-8th"].ToString()),
                        String.Format("#{0:X6}", r.Next(0x1000000)),
                   });
                Qualification.Add(new object[]
                   {
                        "9-10th",
                        Convert.ToInt32(dtEQ.Rows[0]["9-10th"].ToString()),
                        String.Format("#{0:X6}", r.Next(0x1000000)),
                   });
                Qualification.Add(new object[]
                   {
                        "11-12th",
                        Convert.ToInt32(dtEQ.Rows[0]["11-12th"].ToString()),
                        String.Format("#{0:X6}", r.Next(0x1000000)),
                   });
                Qualification.Add(new object[]
                   {
                        "Graduate",
                        Convert.ToInt32(dtEQ.Rows[0]["Graduate"].ToString()),
                        String.Format("#{0:X6}", r.Next(0x1000000)),
                   });
                Qualification.Add(new object[]
                   {
                        "Masters",
                        Convert.ToInt32(dtEQ.Rows[0]["Masters"].ToString()),
                        String.Format("#{0:X6}", r.Next(0x1000000)),
                   });
                Qualification.Add(new object[]
                   {
                        "Technical Education",
                        Convert.ToInt32(dtEQ.Rows[0]["Technical"].ToString()),
                        String.Format("#{0:X6}", r.Next(0x1000000)),
                   });
                Qualification.Add(new object[]
                   {
                        "Other",
                        Convert.ToInt32(dtEQ.Rows[0]["Other"].ToString()),
                        String.Format("#{0:X6}", r.Next(0x1000000)),
                   });
            }
            else
            {
                Qualification.Add(new object[]
                    {
                        "Qualification",
                        0,
                        String.Format("#{0:X6}", r.Next(0x1000000)),
                });
            }

            return Qualification;
        }

        [System.Web.Services.WebMethod]
        public static List<object> CBOCategory(string stateId, string districtId, string blockId, string CSOId, string VillageId, string WFGID)
        {
            DbErrorLog db = new DbErrorLog();
            string VillageCondetion = string.Empty;
            string stateCondition = string.Empty;
            string districtCondion = string.Empty;
            string blockCondition = string.Empty;
            string CSOCondetion = string.Empty;
            string WFGCondetion = string.Empty;
            if (stateId != "All")
            {
                stateCondition = " and c.StateId = " + stateId;
            }
            if (districtId != "All")
            {
                districtCondion = " and c.DistrictID = " + districtId;

            }
            if (blockId != "All")
            {
                blockCondition = " and c.BlockID = " + blockId;
            }
            if (CSOId != "All")
            {
                CSOCondetion = " and c.CSOID = " + CSOId;
            }
            if (VillageId != "All")
            {
                VillageCondetion = " and Vid = " + VillageId;
            }
            if (WFGID != "All")
            {
                WFGCondetion = " and WfgNo = " + WFGID;
            }
            string allContion = stateCondition + districtCondion + blockCondition + VillageCondetion + CSOCondetion + WFGCondetion;

            string strQUery = "select CBONature,count(*) as Total from tblWFs a left outer join tblVillageInfo c on a.VillageID = c.Vid left outer join tblWFGs d on a.WFGID = d.WfgNo left outer join tblCBONature e on a.CBONatureID = e.CBOID where 1=1  group by [CBONature] order by [CBONature]";
            DataSet ds = db.getResultset(strQUery, "", "", "");
            DataTable dtEQ = new DataTable();

            if (ds != null && ds.Tables[0].Rows.Count > 0)
            {
                dtEQ = ds.Tables[0];
            }

            List<object> Qualification = new List<object>();
            //Qualification.Add(new object[]
            //{
            //    "CBO Nature","Total"
            //});
            Random r = new Random();
            if (dtEQ.Rows.Count > 0)
            {
                for (int i = 0; i < dtEQ.Rows.Count; i++)
                {
                    Qualification.Add(new object[]
                    {
                        dtEQ.Rows[i]["CBONature"].ToString(),
                        Convert.ToInt32(dtEQ.Rows[i]["Total"].ToString()),
                        String.Format("#{0:X6}", r.Next(0x1000000)),
                    });
                }
            }
            else
            {
                Qualification.Add(new object[]
                   {
                        "CBONature",
                        0,
                        String.Format("#{0:X6}", r.Next(0x1000000)),
                   });
            }

            return Qualification;
        }

        [System.Web.Services.WebMethod]
        public static string RationCardholder(string stateId, string districtId, string blockId, string CSOId, string VillageId, string WFGID)
        {

            DbErrorLog db = new DbErrorLog();
            string VillageCondetion = string.Empty;
            string stateCondition = string.Empty;
            string districtCondion = string.Empty;
            string blockCondition = string.Empty;
            string CSOCondetion = string.Empty;
            string WFGCondetion = string.Empty;
            if (stateId != "All")
            {
                stateCondition = " and c.StateId = " + stateId;
            }
            if (districtId != "All")
            {
                districtCondion = " and c.DistrictID = " + districtId;

            }
            if (blockId != "All")
            {
                blockCondition = " and c.BlockID = " + blockId;
            }
            if (CSOId != "All")
            {
                CSOCondetion = " and c.CSOID = " + CSOId;
            }
            if (VillageId != "All")
            {
                VillageCondetion = " and Vid = " + VillageId;
            }
            if (WFGID != "All")
            {
                WFGCondetion = " and WfgNo = " + WFGID;
            }
            string allContion = stateCondition + districtCondion + blockCondition + VillageCondetion + CSOCondetion + WFGCondetion;

            string RationCardholder = string.Empty;

            string strQUery = "SELECT Count(isRationcard) as Total FROM [CF].[dbo].[tblWFs] a left outer join tblVillageInfo c on a.VillageID = c.Vid left outer join tblWFGs d on a.WFGID = d.WfgNo where 1=1 " + allContion + " group by [isRationcard] order by [isRationcard]";
            DataSet ds = db.getResultset(strQUery, "", "", "");
            DataTable dt = new DataTable();
            if (ds != null && ds.Tables[0].Rows.Count > 0)
            {

                dt = ds.Tables[0];
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    if (RationCardholder == "")
                    {
                        RationCardholder = dt.Rows[i][0].ToString();
                    }
                    else
                    {
                        RationCardholder += "," + dt.Rows[i][0].ToString();
                    }
                }
            }
            else
            {
                RationCardholder = "0,0";
            }


            return RationCardholder;
        }

        [System.Web.Services.WebMethod]
        public static List<object> Rationcardtype(string stateId, string districtId, string blockId, string CSOId, string VillageId, string WFGID)
        {

            DbErrorLog db = new DbErrorLog();
            string VillageCondetion = string.Empty;
            string stateCondition = string.Empty;
            string districtCondion = string.Empty;
            string blockCondition = string.Empty;
            string CSOCondetion = string.Empty;
            string WFGCondetion = string.Empty;
            if (stateId != "All")
            {
                stateCondition = " and c.StateId = " + stateId;
            }
            if (districtId != "All")
            {
                districtCondion = " and c.DistrictID = " + districtId;

            }
            if (blockId != "All")
            {
                blockCondition = " and c.BlockID = " + blockId;
            }
            if (CSOId != "All")
            {
                CSOCondetion = " and c.CSOID = " + CSOId;
            }
            if (VillageId != "All")
            {
                VillageCondetion = " and Vid = " + VillageId;
            }
            if (WFGID != "All")
            {
                WFGCondetion = " and WfgNo = " + WFGID;
            }
            string allContion = stateCondition + districtCondion + blockCondition + VillageCondetion + CSOCondetion + WFGCondetion;


            string strQUery = "SELECT RationType, Count(RationcardTypeID) as Total FROM [CF].[dbo].[tblWFs] a left outer join tblRationType b on a.RationcardTypeID = b.Rid left outer join tblVillageInfo c on a.VillageID = c.Vid left outer join tblWFGs d on a.WFGID = d.WfgNo where 1=1 and RationcardTypeID is not null " + allContion + "  group by RationType order by RationType";
            DataSet ds = db.getResultset(strQUery, "", "", "");
            DataTable dt = new DataTable();
            List<object> Rationcardtype = new List<object>();
            Random r = new Random();
            if (ds != null && ds.Tables[0].Rows.Count > 0)
            {
                dt = ds.Tables[0];

                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    Rationcardtype.Add(new object[]
                        {
                        dt.Rows[i]["RationType"].ToString(),
                        Convert.ToInt32(dt.Rows[i]["Total"].ToString()),
                        String.Format("#{0:X6}", r.Next(0x1000000)),
                        });
                }
            }
            else
            {
                Rationcardtype.Add(new object[]
                        {
                        "RationType",
                        0,
                        String.Format("#{0:X6}", r.Next(0x1000000)),
                  });
            }


            return Rationcardtype;
        }

        [System.Web.Services.WebMethod]
        public static string MemberofanyCBO(string stateId, string districtId, string blockId, string CSOId, string VillageId, string WFGID)
        {

            DbErrorLog db = new DbErrorLog();
            string VillageCondetion = string.Empty;
            string stateCondition = string.Empty;
            string districtCondion = string.Empty;
            string blockCondition = string.Empty;
            string CSOCondetion = string.Empty;
            string WFGCondetion = string.Empty;
            if (stateId != "All")
            {
                stateCondition = " and c.StateId = " + stateId;
            }
            if (districtId != "All")
            {
                districtCondion = " and c.DistrictID = " + districtId;

            }
            if (blockId != "All")
            {
                blockCondition = " and c.BlockID = " + blockId;
            }
            if (CSOId != "All")
            {
                CSOCondetion = " and a.CSOID = " + CSOId;
            }
            if (VillageId != "All")
            {
                VillageCondetion = " and Vid = " + VillageId;
            }
            if (WFGID != "All")
            {
                WFGCondetion = " and WfgNo = " + WFGID;
            }
            string allContion = stateCondition + districtCondion + blockCondition + VillageCondetion + CSOCondetion + WFGCondetion;
            string MemberofanyCBO = "";

            string strQUery = "SELECT sum(case when [IsCBOMember]='Yes' then 1 else 0 end) as yes,sum(case when [IsCBOMember]='No' then 1 else 0 end) as no FROM [CF].[dbo].[tblWFs] a left outer join tblVillageInfo c on a.VillageID = c.Vid left outer join tblWFGs d on a.WFGID = d.WfgNo where 1=1" + allContion;
            DataSet ds = db.getResultset(strQUery, "", "", "");
            DataTable dt = new DataTable();
            if (ds != null && ds.Tables[0].Rows.Count > 0)
            {
                dt = ds.Tables[0];
                MemberofanyCBO = dt.Rows[0]["yes"].ToString() + "," + dt.Rows[0]["no"].ToString();
                //for (int i = 0; i < dt.Rows.Count; i++)
                //{
                //    if (MemberofanyCBO == "")
                //    {
                //        MemberofanyCBO = dt.Rows[i][0].ToString();
                //    }
                //    else
                //    {
                //        MemberofanyCBO += "," + dt.Rows[i][0].ToString();
                //    }
                //}
            }
            else
            {
                MemberofanyCBO = "0,0";
            }


            return MemberofanyCBO;
        }
        // year wise
        [System.Web.Services.WebMethod]
        public static string MajorSourceofincomeofthefamily(string stateId, string districtId, string blockId, string year, string CSOId, string VillageId, string WFGID)
        {

            DbErrorLog db = new DbErrorLog();
            string VillageCondetion = string.Empty;
            string stateCondition = string.Empty;
            string districtCondion = string.Empty;
            string blockCondition = string.Empty;
            string CSOCondetion = string.Empty;
            string WFGCondetion = string.Empty;
            if (stateId != "All")
            {
                stateCondition = " and c.StateId = " + stateId;
            }
            if (districtId != "All")
            {
                districtCondion = " and c.DistrictID = " + districtId;

            }
            if (blockId != "All")
            {
                blockCondition = " and c.BlockID = " + blockId;
            }
            if (CSOId != "All")
            {
                CSOCondetion = " and CSOID = " + CSOId;
            }
            if (VillageId != "All")
            {
                VillageCondetion = " and Vid = " + VillageId;
            }
            if (WFGID != "All")
            {
                WFGCondetion = " and WfgNo = " + WFGID;
            }
            string allContion = stateCondition + districtCondion + blockCondition + VillageCondetion + CSOCondetion + WFGCondetion;
            string MajorSourceofincomeofthefamily = "";

            string strQUery = "SELECT distinct sum(case when trim(b.MajorSourceofFamily) = 'Agriculture' then 1 else 0 end) as Agriculture ,sum(case when trim(b.MajorSourceofFamily) = 'Agriculture- labour' then 1 else 0 end) as [Agriculture- labour],sum(case when trim(b.MajorSourceofFamily) = 'Animal Husbandary' then 1 else 0 end) as [Animal Husbandary],sum(case when trim(b.MajorSourceofFamily) = 'Government Job' then 1 else 0 end) as [Government Job],sum(case when trim(b.MajorSourceofFamily) = 'Small business' then 1 else 0 end),0) as [Smallbusiness],sum(case when trim(b.MajorSourceofFamily) = 'Skilled work' then 1 else 0 end) as [Skilledwork],sum(case when trim(b.MajorSourceofFamily) = 'Other' then 1 else 0 end) as [Others]" ;
            DataSet ds = new DataSet();
            NameValueCollection nvc = new NameValueCollection();
            nvc.Clear();
            nvc.Add("@Operation", "MajorSourceofincomeofthefamily");
            nvc.Add("@whereConn", allContion);
            DataTable data = new clsConnection().fnExecuteProcedureSelectWithCondtion("[CF].[dbo].[spFilter]", nvc);
            nvc.Clear();
            DataTable dt = new DataTable();
            if (ds != null && data.Rows.Count > 0)
            {
                dt = ds.Tables[0];
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    MajorSourceofincomeofthefamily = dt.Rows[0]["Labour"].ToString() + "," + dt.Rows[0]["FORMING"].ToString() + "," + dt.Rows[0]["GovtJob"].ToString() + "," + dt.Rows[0]["Agriculture"].ToString() + "," + dt.Rows[0]["Others"].ToString();
                }
            }
            else
            {
                MajorSourceofincomeofthefamily = "0,0,0,0,0";
            }


            return MajorSourceofincomeofthefamily;
        }

        [System.Web.Services.WebMethod]
        public static string govtschemes(string stateId, string districtId, string blockId, string year, string CSOId, string VillageId, string WFGID)
        {

            DbErrorLog db = new DbErrorLog();
            string VillageCondetion = string.Empty;
            string stateCondition = string.Empty;
            string districtCondion = string.Empty;
            string blockCondition = string.Empty;
            string CSOCondetion = string.Empty;
            string WFGCondetion = string.Empty;
            if (stateId != "All")
            {
                stateCondition = " and c.StateId = " + stateId;
            }
            if (districtId != "All")
            {
                districtCondion = " and c.DistrictID = " + districtId;

            }
            if (blockId != "All")
            {
                blockCondition = " and c.BlockID = " + blockId;
            }
            if (CSOId != "All")
            {
                CSOCondetion = " and CSOID = " + CSOId;
            }
            if (VillageId != "All")
            {
                VillageCondetion = " and Vid = " + VillageId;
            }
            if (WFGID != "All")
            {
                WFGCondetion = " and WfgNo = " + WFGID;
            }
            string allContion = stateCondition + districtCondion + blockCondition + VillageCondetion + CSOCondetion + WFGCondetion;
            string govtschemes = "";

            string strQUery = "SELECT Count(IsBenefit) FROM [CF].[dbo].[tblWFs] a left outer join tblVillageInfo c on a.VillageID = c.Vid left outer join tblWFGs d on a.WFGID = d.WfgNo where 1=1  group by IsBenefit order by IsBenefit";
            DataSet ds = db.getResultset(strQUery, "", "", "");
            DataTable dt = new DataTable();
            if (ds != null && ds.Tables[0].Rows.Count > 0)
            {

                dt = ds.Tables[0];
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    if (govtschemes == "")
                    {
                        govtschemes = dt.Rows[i][0].ToString();
                    }
                    else
                    {
                        govtschemes += "," + dt.Rows[i][0].ToString();
                    }
                }
            }
            else
            {
                govtschemes = "0,0";
            }


            return govtschemes;
        }

        [System.Web.Services.WebMethod]
        public static string Livestock(string stateId, string districtId, string blockId, string year, string CSOId, string VillageId, string WFGID)
        {

            DbErrorLog db = new DbErrorLog();
            string VillageCondetion = "";
            if (CSOId != "All")
            {
                if (VillageId != "All")
                {
                    if (WFGID != "All")
                    {
                        VillageCondetion = " and WfgNo = " + WFGID;
                    }
                    else
                    {
                        VillageCondetion = " and Vid = " + VillageId;
                    }
                }
                else
                {
                    VillageCondetion = " and CSOID = " + CSOId;
                }
            }
            string Livestock = "";

            string strQUery = "SELECT Count([isLivestock]) FROM [CF].[dbo].[tblWFs] a left outer join tblVillageInfo c on a.VillageID = c.Vid left outer join tblWFGs d on a.WFGID = d.WfgNo where 1=1  " + VillageCondetion + " group by [isLivestock] order by [isLivestock]";
            DataSet ds = db.getResultset(strQUery, "", "", "");
            DataTable dt = new DataTable();
            if (ds != null && ds.Tables[0].Rows.Count > 0)
            {
                dt = ds.Tables[0];
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    if (Livestock == "")
                    {
                        Livestock = dt.Rows[i][0].ToString();
                    }
                    else
                    {
                        Livestock += "," + dt.Rows[i][0].ToString();
                    }
                }
            }
            else
            {
                Livestock = "0,0";
            }


            return Livestock;
        }

        [System.Web.Services.WebMethod]
        public static string WomanMNREGAjobcard(string stateId, string districtId, string blockId, string year, string CSOId, string VillageId, string WFGID)
        {

            DbErrorLog db = new DbErrorLog();
            string VillageCondetion = "";
            if (CSOId != "All")
            {
                if (VillageId != "All")
                {
                    if (WFGID != "All")
                    {
                        VillageCondetion = " and WfgNo = " + WFGID;
                    }
                    else
                    {
                        VillageCondetion = " and Vid = " + VillageId;
                    }
                }
                else
                {
                    VillageCondetion = " and CSOID = " + CSOId;
                }
            }
            string WomanMNREGAjobcard = "";

            string strQUery = "SELECT Count([isMNREGA]) FROM [CF].[dbo].[tblWFs] a left outer join tblVillageInfo c on a.VillageID = c.Vid left outer join tblWFGs d on a.WFGID = d.WfgNo where 1=1 " + VillageCondetion + " group by [isMNREGA] order by [isMNREGA]";
            DataSet ds = db.getResultset(strQUery, "", "", "");
            DataTable dt = new DataTable();
            if (ds != null && ds.Tables[0].Rows.Count > 0)
            {

                dt = ds.Tables[0];
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    if (WomanMNREGAjobcard == "")
                    {
                        WomanMNREGAjobcard = dt.Rows[i][0].ToString();
                    }
                    else
                    {
                        WomanMNREGAjobcard += "," + dt.Rows[i][0].ToString();
                    }
                }
            }
            else
            {
                WomanMNREGAjobcard = "0,0";
            }


            return WomanMNREGAjobcard;
        }

        [System.Web.Services.WebMethod]
        public static string Womanownershipinland(string stateId, string districtId, string blockId, string year, string CSOId, string VillageId, string WFGID)
        {

            DbErrorLog db = new DbErrorLog();
            string VillageCondetion = "";
            if (CSOId != "All")
            {
                if (VillageId != "All")
                {
                    if (WFGID != "All")
                    {
                        VillageCondetion = " and WfgNo = " + WFGID;
                    }
                    else
                    {
                        VillageCondetion = " and Vid = " + VillageId;
                    }
                }
                else
                {
                    VillageCondetion = " and CSOID = " + CSOId;
                }
            }
            string Womanownershipinland = "";

            string strQUery = "SELECT Count([IsOwnershipinLand]) FROM [CF].[dbo].[tblWFs] a left outer join tblVillageInfo c on a.VillageID = c.Vid left outer join tblWFGs d on a.WFGID = d.WfgNo where 1=1 " + VillageCondetion + " group by [IsOwnershipinLand] order by [IsOwnershipinLand]";
            DataSet ds = db.getResultset(strQUery, "", "", "");
            DataTable dt = new DataTable();
            if (ds != null && ds.Tables[0].Rows.Count > 0)
            {

                dt = ds.Tables[0];
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    if (Womanownershipinland == "")
                    {
                        Womanownershipinland = dt.Rows[i][0].ToString();
                    }
                    else
                    {
                        Womanownershipinland += "," + dt.Rows[i][0].ToString();
                    }
                }
            }
            else
            {
                Womanownershipinland = "0,0";
            }


            return Womanownershipinland;
        }

        [System.Web.Services.WebMethod]
        public static string Sourceofirrigation(string stateId, string districtId, string blockId, string year, string CSOId, string VillageId, string WFGID)
        {

            DbErrorLog db = new DbErrorLog();
            string VillageCondetion = "";
            if (CSOId != "All")
            {
                if (VillageId != "All")
                {
                    if (WFGID != "All")
                    {
                        VillageCondetion = " and WfgNo = " + WFGID;
                    }
                    else
                    {
                        VillageCondetion = " and Vid = " + VillageId;
                    }
                }
                else
                {
                    VillageCondetion = " and CSOID = " + CSOId;
                }
            }
            string Sourceofirrigation = "";

            string strQUery = "SELECT ISNULL(sum(case when a.[SourceofIrrigation] = ''Borewell'' then 1 else 0 end), 0) as Borewell,ISNULL(sum(case when trim(a.[SourceofIrrigation]) = ''PumpSet'' then 1 else 0 end), 0) as Pumpset,ISNULL(sum(case when trim(a.[SourceofIrrigation]) = ''Canal'' then 1 else 0 end),0) as Canal,ISNULL(sum(case when trim(a.[SourceofIrrigation]) = ''Other'' then 1 else 0 end),0) as Others,ISNULL(sum(case when trim(a.[SourceofIrrigation]) = ''Tubewell'' then 1 else 0 end),0) as Tubewell ,ISNULL(sum(case when trim(a.[SourceofIrrigation]) = ''Electric Motor'' then 1 else 0 end),0) as ElectricMotor FROM [CF].[dbo].[tblWFs] a left outer join tblVillageInfo c on a.VillageID = c.Vid left outer join tblWFGs d on a.WFGID = d.WfgNo where 1=1 " + VillageCondetion;
            DataSet ds = db.getResultset(strQUery, "", "", "");
            DataTable dt = new DataTable();
            if (ds != null && ds.Tables[0].Rows.Count > 0)
            {

                dt = ds.Tables[0];
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    Sourceofirrigation = dt.Rows[0]["Borewell"].ToString() + "," + dt.Rows[0]["Pumpset"].ToString() + "," + dt.Rows[0]["Canal"].ToString() + "," + dt.Rows[0]["Others"].ToString() + "," + dt.Rows[0]["Tubewell"].ToString() + "," + dt.Rows[0]["ElectricMotor"].ToString();
                }
            }
            else
            {
                Sourceofirrigation = "0,0,0,0";
            }

            return Sourceofirrigation;
        }
        [System.Web.Services.WebMethod]
        public static List<object> TotalIrrigatedLand(string stateId, string districtId, string blockId, string year, string CSOId, string VillageId, string WFGID)
        {

            DbErrorLog db = new DbErrorLog();
            string VillageCondetion = "";
            if (CSOId != "All")
            {
                if (VillageId != "All")
                {
                    if (WFGID != "All")
                    {
                        VillageCondetion = " and WfgNo = " + WFGID;
                    }
                    else
                    {
                        VillageCondetion = " and Vid = " + VillageId;
                    }
                }
                else
                {
                    VillageCondetion = " and CSOID = " + CSOId;
                }
            }

            string strQUery = "IF EXISTS (select WFGID from tblwfs where 1=1 " + VillageCondetion + ")select sum(case when try_convert(float,TotalLandinHectors) <=1 and try_convert(float,TotalLandinHectors) > 0 then 1 else 0 end) as LandUpto1Hec, sum(case when try_convert(float,TotalLandinHectors) >1 and try_convert(float,TotalLandinHectors) <=2 then 1 else 1 end) as Land1to2Hec, sum(case when try_convert(float,TotalLandinHectors) > 2 and try_convert(float,TotalLandinHectors)<=4  then 1 else 0 end) as Land2to4Hec,sum(case when try_convert(float,TotalLandinHectors) >4 then 1 else 0 end) as LandMorethan4Hec,sum(case when try_convert(float,TotalLandinHectors) =0 then 1 else 0 end) as Landless from tblwfs where 1=1 " + VillageCondetion + " ELSE select 0 as LandUpto1Hec, 0 as Land1to2Hec, 0 as Land2to4Hec,0 as LandMorethan4Hec,0 as Landless";
            DataSet ds = db.getResultset(strQUery, "", "", "");
            DataTable dtEQ = new DataTable();
            Random r = new Random();
            List<object> TotalLandinHectors = new List<object>();
            if (ds != null && ds.Tables[0].Rows.Count > 0)
            {
                dtEQ = ds.Tables[0];
                if (dtEQ.Rows.Count > 0)
                {

                    TotalLandinHectors.Add(new object[]
                    {
                        "upto 1 Hec",

                        Convert.ToInt32(dtEQ.Rows[0]["LandUpto1Hec"].ToString()),
                        String.Format("#{0:X6}", r.Next(0x1000000)),
                    });
                    TotalLandinHectors.Add(new object[]
                    {
                      "1 to 2 Hec",


                        Convert.ToInt32(dtEQ.Rows[0]["Land1to2Hec"].ToString()),
                        String.Format("#{0:X6}", r.Next(0x1000000)),

                    });
                    TotalLandinHectors.Add(new object[]
                    {
                      "2 to 4 Hec",
                        Convert.ToInt32(dtEQ.Rows[0]["Land2to4Hec"].ToString()),
                        String.Format("#{0:X6}", r.Next(0x1000000)),
                    });
                    TotalLandinHectors.Add(new object[]
                    {
                           "More then 4 Hec",
                        Convert.ToInt32(dtEQ.Rows[0]["LandMorethan4Hec"].ToString()),
                        String.Format("#{0:X6}", r.Next(0x1000000)),
                    });
                    TotalLandinHectors.Add(new object[]
                    {
                        "land less",
                        Convert.ToInt32(dtEQ.Rows[0]["Landless"].ToString()),
                        String.Format("#{0:X6}", r.Next(0x1000000)),
                    });
                }
            }
            else
            {
                TotalLandinHectors.Add(new object[]
                    {
                        "upto 1 Hec",

                        0,
                        String.Format("#{0:X6}", r.Next(0x1000000)),
                    });
                TotalLandinHectors.Add(new object[]
                {
                      "1 to 2 Hec",0,
                        String.Format("#{0:X6}", r.Next(0x1000000)),

                });
                TotalLandinHectors.Add(new object[]
                {
                      "2 to 4 Hec",
                        0,
                        String.Format("#{0:X6}", r.Next(0x1000000)),
                });
                TotalLandinHectors.Add(new object[]
                {
                           "More then 4 Hec",
                        0,
                        String.Format("#{0:X6}", r.Next(0x1000000)),
                });
                TotalLandinHectors.Add(new object[]
                {
                        "land less",
                        0,
                        String.Format("#{0:X6}", r.Next(0x1000000)),
                });
            }

            return TotalLandinHectors;
        }

        protected void ddlState_SelectedIndexChanged(object sender, EventArgs e)
        {
            string stateId = ddlState.SelectedItem.Value;
            DataTable dt = objclsfilter.bindDistrict(stateId);
            if (dt != null && dt.Rows.Count > 0)
            {
                ddlDistrict.DataSource = dt;
                ddlDistrict.DataTextField = "District";
                ddlDistrict.DataValueField = "DistrictID";
                ddlDistrict.DataBind();
                ddlDistrict.Items.Insert(0, "All");


                string districtId = ddlDistrict.SelectedItem.Value;
                DataTable ddt = objclsfilter.bindBlock(districtId);
                if (ddt != null && ddt.Rows.Count > 0)
                {
                    ddlBlock.DataTextField = "Block";
                    ddlBlock.DataValueField = "BlockID";
                    ddlBlock.DataSource = ddt;
                    ddlBlock.DataBind();
                    ddlBlock.Items.Insert(0, "All");

                    string blockId = ddlBlock.SelectedItem.Value;
                    DataTable bdt = objclsfilter.bindCSO(blockId);
                    if (bdt != null && bdt.Rows.Count > 0)
                    {
                        ddlCSO.DataSource = bdt;
                        ddlCSO.DataTextField = "CSOName";
                        ddlCSO.DataValueField = "CSOID";
                        ddlCSO.DataBind();
                        ddlCSO.Items.Insert(0, "All");
                        if (bdt != null && bdt.Rows.Count > 0)
                        {
                            if (ddlState.SelectedIndex > 0)
                            {
                                string StateID = string.Empty;
                                if (ddlState.SelectedValue != "All")
                                {
                                    StateID = ddlState.SelectedValue;
                                }
                                string DistrictID = string.Empty;
                                if (ddlDistrict.SelectedValue != "All")
                                {
                                    DistrictID = ddlDistrict.SelectedValue;
                                }
                                string BlockID = string.Empty;
                                if (ddlBlock.SelectedValue != "All")
                                {
                                    BlockID = ddlBlock.SelectedValue;
                                }
                                string CSOID = string.Empty;
                                if (ddlCSO.SelectedValue != "All")
                                {
                                    CSOID = ddlCSO.SelectedValue;
                                }
                                string VillageID = string.Empty;
                                if (ddlvillage.SelectedValue != "All")
                                {
                                    VillageID = ddlvillage.SelectedValue;
                                }
                                GetCSOs("", StateID, DistrictID, BlockID);
                                GetVillages("", StateID, DistrictID, BlockID, CSOID);
                                GetWFGs("", StateID, DistrictID, BlockID, CSOID, VillageID);
                            }
                        }
                        else
                        {
                            ddlCSO.Items.Clear();
                            ddlvillage.Items.Clear();
                            ddlWFG.Items.Clear();
                        }
                    }
                    else
                    {
                        ddlBlock.Items.Clear();
                        ddlCSO.Items.Clear();
                        ddlvillage.Items.Clear();
                        ddlWFG.Items.Clear();
                    }
                }
                else
                {
                    ddlBlock.Items.Clear();
                    ddlCSO.Items.Clear();
                    ddlvillage.Items.Clear();
                    ddlWFG.Items.Clear();
                }
            }
            else
            {
                ddlDistrict.Items.Clear();
                ddlBlock.Items.Clear();
                ddlCSO.Items.Clear();
                ddlvillage.Items.Clear();
                ddlWFG.Items.Clear();
            }
        }

        protected void ddlDistrict_SelectedIndexChanged(object sender, EventArgs e)
        {
            string districtId = ddlDistrict.SelectedItem.Value;
            DataTable ddt = objclsfilter.bindBlock(districtId);
            if (ddt != null && ddt.Rows.Count > 0)
            {
                ddlBlock.DataTextField = "Block";
                ddlBlock.DataValueField = "BlockID";
                ddlBlock.DataSource = ddt;
                ddlBlock.DataBind();
                ddlBlock.Items.Insert(0, "All");

                string blockId = ddlBlock.SelectedItem.Value;
                DataTable bdt = objclsfilter.bindCSO(blockId);
                if (bdt != null && bdt.Rows.Count > 0)
                {
                    ddlCSO.DataSource = bdt;
                    ddlCSO.DataTextField = "CSOName";
                    ddlCSO.DataValueField = "CSOID";
                    ddlCSO.DataBind();
                    ddlCSO.Items.Insert(0, "All");
                    if (bdt != null && bdt.Rows.Count > 0)
                    {
                        if (ddlState.SelectedIndex > 0)
                        {
                            string StateID = string.Empty;
                            if (ddlState.SelectedValue != "All")
                            {
                                StateID = ddlState.SelectedValue;
                            }
                            string DistrictID = string.Empty;
                            if (ddlDistrict.SelectedValue != "All")
                            {
                                DistrictID = ddlDistrict.SelectedValue;
                            }
                            string BlockID = string.Empty;
                            if (ddlBlock.SelectedValue != "All")
                            {
                                BlockID = ddlBlock.SelectedValue;
                            }
                            string CSOID = string.Empty;
                            if (ddlCSO.SelectedValue != "All")
                            {
                                CSOID = ddlCSO.SelectedValue;
                            }
                            string VillageID = string.Empty;
                            if (ddlvillage.SelectedValue != "All")
                            {
                                VillageID = ddlvillage.SelectedValue;
                            }
                            GetCSOs("", StateID, DistrictID, BlockID);
                            GetVillages("", StateID, DistrictID, BlockID, CSOID);
                            GetWFGs("", StateID, DistrictID, BlockID, CSOID, VillageID);
                        }
                    }
                    else
                    {
                        ddlCSO.Items.Clear();
                        ddlvillage.Items.Clear();
                        ddlWFG.Items.Clear();
                    }
                }
                else
                {
                    ddlBlock.Items.Clear();
                    ddlCSO.Items.Clear();
                    ddlvillage.Items.Clear();
                    ddlWFG.Items.Clear();
                }
            }
            else
            {
                ddlBlock.Items.Clear();
                ddlCSO.Items.Clear();
                ddlvillage.Items.Clear();
                ddlWFG.Items.Clear();
            }
        }

        protected void ddlBlock_SelectedIndexChanged(object sender, EventArgs e)
        {
            string blockId = ddlBlock.SelectedItem.Value;
            DataTable dt = objclsfilter.bindCSO(blockId);

            ddlCSO.DataSource = dt;
            ddlCSO.DataTextField = "CSOName";
            ddlCSO.DataValueField = "CSOID";
            ddlCSO.DataBind();
            ddlCSO.Items.Insert(0, "All");

            if (dt != null && dt.Rows.Count > 0)
            {
                if (ddlState.SelectedIndex > 0)
                {
                    string StateID = string.Empty;
                    if (ddlState.SelectedValue != "All")
                    {
                        StateID = ddlState.SelectedValue;
                    }
                    string DistrictID = string.Empty;
                    if (ddlDistrict.SelectedValue != "All")
                    {
                        DistrictID = ddlDistrict.SelectedValue;
                    }
                    string BlockID = string.Empty;
                    if (ddlBlock.SelectedValue != "All")
                    {
                        BlockID = ddlBlock.SelectedValue;
                    }
                    string CSOID = string.Empty;
                    if (ddlCSO.SelectedValue != "All")
                    {
                        CSOID = ddlCSO.SelectedValue;
                    }
                    string VillageID = string.Empty;
                    if (ddlvillage.SelectedValue != "All")
                    {
                        VillageID = ddlvillage.SelectedValue;
                    }
                    GetCSOs("", StateID, DistrictID, BlockID);
                    GetVillages("", StateID, DistrictID, BlockID, CSOID);
                    GetWFGs("", StateID, DistrictID, BlockID, CSOID, VillageID);
                }
            }
            else
            {
                ddlCSO.Items.Clear();
                ddlvillage.Items.Clear();
                ddlWFG.Items.Clear();
            }
        }
    }
}