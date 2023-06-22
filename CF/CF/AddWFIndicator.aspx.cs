using System;
using System.Collections.Generic;
using System.Configuration;
using Excel = Microsoft.Office.Interop.Excel;
using System.IO;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CF
{
    public partial class AddWFIndicator : System.Web.UI.Page
    {
        DbErrorLog db = new DbErrorLog();
        string User = "";
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
                        if (User == "Admin")
                        {
                            LoadCSO();
                        }
                        else if (User == "CSO")
                        {
                            LoadCSOData();
                            loadVillage();
                        }
                        else if (User == "WFG")
                        {
                            LoadWFGData();
                        }
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
        protected void LoadCSOData()
        {
            string query = "select[District],c.DistrictID,[Block],b.BlockID,D.StateId,StateName FROM tblCSO A,tblBlocks B,tblDistricts C ,tblStates D  where B.[BlockID] = A.BlockID and C.[DistrictID] = A.DistrictID and D.[StateId] = A.StateId and CSOID = " + Session["ClientID"];
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

        protected void LoadWFGData()
        {
            string query = "select e.StateId,e.DistrictID,e.BlockID,e.CSOID,Vid,WfgNo from tblwfgs a left outer join tblVillageInfo b on a.villageid=b.vid left outer join tblvillages c on b.villageid=c.villageid left outer join tblblocks d on c.BlockID=d.BlockID left outer join tblCSO e on d.BlockID=e.BlockID where WfgNo = " + Session["ClientID"];
            DataSet ds = db.getResultset(query, "", "", "");
            if (ds != null && ds.Tables[0].Rows.Count > 0)
            {
                LoadCSO();
                if (ddlCSO.Items.FindByValue(ds.Tables[0].Rows[0]["CSOID"].ToString()) != null)
                {
                    ddlCSO.Items.FindByValue(ds.Tables[0].Rows[0]["CSOID"].ToString()).Selected = true;
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
                loadVillage();
                if (ddlVillage.Items.FindByValue(ds.Tables[0].Rows[0]["Vid"].ToString()) != null)
                {
                    ddlVillage.Items.FindByValue(ds.Tables[0].Rows[0]["Vid"].ToString()).Selected = true;
                }
                ddlVillage.Enabled = false;
                LoadWFGs();
                if (ddlWFG.Items.FindByValue(ds.Tables[0].Rows[0]["WfgNo"].ToString()) != null)
                {
                    ddlWFG.Items.FindByValue(ds.Tables[0].Rows[0]["WfgNo"].ToString()).Selected = true;
                }
                ddlWFG.Enabled = false;
                loadWFs();
            }
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
        public void LoadStates()
        {
            string selectVill = "Select * from tblStates";
            DataSet dsV = db.getResultset(selectVill, "", "", "");
            if (dsV != null && dsV.Tables[0].Rows.Count > 0)
            {
                ddlstate.DataSource = dsV;
                ddlstate.DataTextField = "StateName";
                ddlstate.DataValueField = "StateId";
                ddlstate.DataBind();
                ddlstate.Items.Insert(0, "Select");
            }
            else{
                ddlstate.Items.Clear();
                ddlstate.Items.Insert(0, "Select");
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

        public void loadVillage()
        {
            string block = "";
            if (User == "Admin" || User == "WFG")
            {
                block = ddlBlock.SelectedValue;
            }
            else if (User == "CSO")
            {
                string distblock = "select DistrictID,BlockID from tblCSO where CSOID = " + ddlCSO.SelectedValue;
                DataSet distds = db.getResultset(distblock, "", "", "");
                if (distds != null && distds.Tables[0].Rows.Count > 0)
                {
                    DataTable distdt = distds.Tables[0];
                    block = distdt.Rows[0]["BlockID"].ToString();
                }
            }

            string selectVill = "Select Vid,Village from tblVillageInfo b left outer join tblVillages a on a.VillageID = b.VillageID where b.VillageID is not null and a.BlockID =" + block;
            DataSet dsV = db.getResultset(selectVill, "", "", "");
            if (dsV != null && dsV.Tables[0].Rows.Count > 0)
            {
                ddlVillage.DataSource = dsV;
                ddlVillage.DataTextField = "Village";
                ddlVillage.DataValueField = "Vid";
                ddlVillage.DataBind();
                ddlVillage.Items.Insert(0, "Select");
            }
        }

        public void LoadWFGs()
        {
            string query = "select WfgNo,WFGName from tblWFGs where VillageID = " + ddlVillage.SelectedValue + " order by WFGName";
            DataSet ds = db.getResultset(query, "", "", "");

            if (ds != null && ds.Tables[0].Rows.Count > 0)
            {
                ddlWFG.DataSource = ds;
                ddlWFG.DataValueField = "WfgNo";
                ddlWFG.DataTextField = "WFGName";
                ddlWFG.DataBind();
                ddlWFG.Items.Insert(0, "Select");
            }
            else
            {
                ddlWFG.Items.Clear();
                ddlWFG.Items.Insert(0, "Select");
            }
        }

        public void loadWFs()
        {
            string query = "select WFno,WomenName from tblWFs where WFGID = " + ddlWFG.SelectedValue + " order by WomenName";
            DataSet ds = db.getResultset(query, "", "", "");

            if (ds != null && ds.Tables[0].Rows.Count > 0)
            {
                ddlWF.DataSource = ds;
                ddlWF.DataValueField = "WFno";
                ddlWF.DataTextField = "WomenName";
                ddlWF.DataBind();
                ddlWF.Items.Insert(0, "Select");
            }
            else
            {
                ddlWF.Items.Clear();
                ddlWF.Items.Insert(0, "Select");
            }
        }

        protected void ddlstate_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlstate.SelectedIndex > 0)
            {
                string selectDist = "Select District,DistrictID from tblDistricts where StateId=" + ddlstate.SelectedValue + " order by District";
                DataSet ds = db.getResultset(selectDist, "", "", "");
                if (ds != null && ds.Tables[0].Rows.Count > 0)
                {
                    ddlDistrict.DataSource = ds;
                    ddlDistrict.DataTextField = "District";
                    ddlDistrict.DataValueField = "DistrictID";
                    ddlDistrict.DataBind();
                    ddlDistrict.Items.Insert(0, "Select");
                }
                else
                {
                    ddlDistrict.Items.Clear();
                    ddlDistrict.Items.Insert(0, "Select");
                }
            }
            else
            {
                ddlDistrict.Items.Clear();
                ddlDistrict.Items.Insert(0, "Select");

            }
        }

        protected void ddlDistrict_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlDistrict.SelectedIndex > 0)
            {
                string selectDist = "Select Block,BlockID from tblBlocks where DistrictID=" + ddlDistrict.SelectedValue + " order by Block";
                DataSet ds = db.getResultset(selectDist, "", "", "");
                if (ds != null && ds.Tables[0].Rows.Count > 0)
                {
                    ddlBlock.DataSource = ds;
                    ddlBlock.DataTextField = "Block";
                    ddlBlock.DataValueField = "BlockID";
                    ddlBlock.DataBind();
                    ddlBlock.Items.Insert(0, "Select");
                }
                else
                {
                    ddlBlock.Items.Clear();
                    ddlBlock.Items.Insert(0, "Select");
                }
            }
            else
            {
                ddlBlock.Items.Clear();
                ddlBlock.Items.Insert(0, "Select");

            }
        }

        protected void ddlBlock_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlBlock.SelectedIndex > 0)
            {
                string selectVill = "Select Vid,Village from tblVillageInfo b left outer join tblVillages a on a.VillageID = b.VillageID where b.VillageID is not null and a.BlockID =" + ddlBlock.SelectedValue + " order by Village";
                DataSet dsV = db.getResultset(selectVill, "", "", "");
                if (dsV != null && dsV.Tables[0].Rows.Count > 0)
                {
                    ddlVillage.DataSource = dsV;
                    ddlVillage.DataTextField = "Village";
                    ddlVillage.DataValueField = "Vid";
                    ddlVillage.DataBind();
                    ddlVillage.Items.Insert(0, "Select");
                }
                else
                {
                    ddlVillage.Items.Clear();
                    ddlVillage.Items.Insert(0, "Select");
                }
            }
            else
            {
                ddlVillage.Items.Clear();
                ddlVillage.Items.Insert(0, "Select");
            }
        }

        protected void ddlVillage_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlVillage.SelectedIndex > 0)
            {
                string query = "select WfgNo,WFGName from tblWFGs where VillageID = " + ddlVillage.SelectedValue + " order by WFGName";
                DataSet ds = db.getResultset(query, "", "", "");

                if (ds != null && ds.Tables[0].Rows.Count > 0)
                {
                    ddlWFG.DataSource = ds;
                    ddlWFG.DataValueField = "WfgNo";
                    ddlWFG.DataTextField = "WFGName";
                    ddlWFG.DataBind();
                    ddlWFG.Items.Insert(0, "Select");
                }
                else
                {
                    ddlWFG.Items.Clear();
                    ddlWFG.Items.Insert(0, "Select");
                }
            }
            else
            {
                ddlWFG.Items.Clear();
                ddlWFG.Items.Insert(0, "Select");
            }
        }

        protected void ddlWFG_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlWFG.SelectedIndex > 0)
            {
                string query = "select WFno,WomenName from tblWFs where WFGID = " + ddlWFG.SelectedValue + " order by WomenName";
                DataSet ds = db.getResultset(query, "", "", "");

                if (ds != null && ds.Tables[0].Rows.Count > 0)
                {
                    ddlWF.DataSource = ds;
                    ddlWF.DataValueField = "WFno";
                    ddlWF.DataTextField = "WomenName";
                    ddlWF.DataBind();
                    ddlWF.Items.Insert(0, "Select");
                }
                else
                {
                    ddlWF.Items.Clear();
                    ddlWF.Items.Insert(0, "Select");
                }
            }
            else
            {
                ddlWF.Items.Clear();
                ddlWF.Items.Insert(0, "Select");
            }
        }

        [System.Web.Services.WebMethod]
        public static string SocialCategory(string WFno)
        {
            DbErrorLog db = new DbErrorLog();
            string Data = "";
            string query = "select WFno, Year, Buisness, AccessService, ClimateFriendly, PracticeType, MoreCultivating, AgriUse, ProUse, Demonstrate, PercTrained, PreTraining, PostTraining, LoanObtain, ManageMoney, BuisnessDevelop, ICTAccess, OnFarm, OffFarm, CropChoice, Input, Deciding, Timing, DecidingTime, Harvesting, SaleLand, SoWomen, SoMaterial, SoAgro, SoSelling, SoExopenditure, JoWomen, JoMaterial, JoAgro, JoSelling, JoExpenditure, ShareHolder, FPCName, FPCShares from tblWFsYearData where WFno=" + WFno;
            DataSet ds = db.getResultset(query, "", "", "");
            if (ds != null && ds.Tables[0].Rows.Count > 0)
            {
                DataTable dt = ds.Tables[0];
                for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                {
                    DataRow dr = dt.Rows[i];
                    if (Data != "")
                    {
                        Data += "$" + dr["Year"] + ":" + dr["Buisness"] + ":" + dr["AccessService"] + ":" + dr["ClimateFriendly"] + ":" + dr["PracticeType"] + ":" + dr["MoreCultivating"] + ":" + dr["AgriUse"] + ":" + dr["ProUse"] + ":" + dr["Demonstrate"] + ":" + dr["PercTrained"] + ":" + dr["PreTraining"] + ":" + dr["PostTraining"] + ":" + dr["LoanObtain"] + ":" + dr["ManageMoney"] + ":" + dr["BuisnessDevelop"] + ":" + dr["ICTAccess"] + ":" + dr["OnFarm"] + ":" + dr["OffFarm"] + ":" + dr["CropChoice"] + ":" + dr["Input"] + ":" + dr["Deciding"] + ":" + dr["Timing"] + ":" + dr["DecidingTime"] + ":" + dr["Harvesting"] + ":" + dr["SaleLand"] + ":" + dr["SoWomen"] + ":" + dr["SoMaterial"] + ":" + dr["SoAgro"] + ":" + dr["SoSelling"] + ":" + dr["SoExopenditure"] + ":" + dr["JoWomen"] + ":" + dr["JoMaterial"] + ":" + dr["JoAgro"] + ":" + dr["JoSelling"] + ":" + dr["JoExpenditure"] + ":" + dr["ShareHolder"] + ":" + dr["FPCName"] + ":" + dr["FPCShares"];
                    }
                    else
                    {
                        Data = dr["Year"] + ":" + dr["Buisness"] + ":" + dr["AccessService"] + ":" + dr["ClimateFriendly"] + ":" + dr["PracticeType"] + ":" + dr["MoreCultivating"] + ":" + dr["AgriUse"] + ":" + dr["ProUse"] + ":" + dr["Demonstrate"] + ":" + dr["PercTrained"] + ":" + dr["PreTraining"] + ":" + dr["PostTraining"] + ":" + dr["LoanObtain"] + ":" + dr["ManageMoney"] + ":" + dr["BuisnessDevelop"] + ":" + dr["ICTAccess"] + ":" + dr["OnFarm"] + ":" + dr["OffFarm"] + ":" + dr["CropChoice"] + ":" + dr["Input"] + ":" + dr["Deciding"] + ":" + dr["Timing"] + ":" + dr["DecidingTime"] + ":" + dr["Harvesting"] + ":" + dr["SaleLand"] + ":" + dr["SoWomen"] + ":" + dr["SoMaterial"] + ":" + dr["SoAgro"] + ":" + dr["SoSelling"] + ":" + dr["SoExopenditure"] + ":" + dr["JoWomen"] + ":" + dr["JoMaterial"] + ":" + dr["JoAgro"] + ":" + dr["JoSelling"] + ":" + dr["JoExpenditure"] + ":" + dr["ShareHolder"] + ":" + dr["FPCName"] + ":" + dr["FPCShares"];
                    }
                }
            }
            return Data;
        }

        protected void btnsubmit_Click(object sender, EventArgs e)
        {
            string wfno = "";
            int count = 0;
            string[] data = hiddenDataArrayTable.Value.Split('$');
            string delete = "delete from tblWFsYearData where WFno=" + ddlWF.SelectedValue;
            if (db.UpdateQuery(delete, "", "", "") > 0)
            {
            }
            for (int i = 0; i < data.Length; i++)
            {
                string[] datavalues = data[i].Split(':');
                string tablequery = "INSERT INTO tblWFsYearData(WFno, Year, Buisness, AccessService, ClimateFriendly, PracticeType, MoreCultivating, AgriUse, ProUse, Demonstrate, PercTrained, PreTraining, PostTraining, LoanObtain, ManageMoney, BuisnessDevelop, ICTAccess, OnFarm, OffFarm, CropChoice, Input, Deciding, Timing, DecidingTime, Harvesting, SaleLand, SoWomen, SoMaterial, SoAgro, SoSelling, SoExopenditure, JoWomen, JoMaterial, JoAgro, JoSelling, JoExpenditure, ShareHolder, FPCName, FPCShares) VALUES(" + ddlWF.SelectedValue + ",'" + datavalues[0] + "','" + datavalues[1] + "','" + datavalues[2] + "','" + datavalues[3] + "','" + datavalues[4] + "','" + datavalues[5] + "','" + datavalues[6] + "','" + datavalues[7] + "','" + datavalues[8] + "','" + datavalues[9] + "','" + datavalues[10] + "','" + datavalues[11] + "','" + datavalues[12] + "','" + datavalues[13] + "','" + datavalues[14] + "','" + datavalues[15] + "','" + datavalues[16] + "','" + datavalues[17] + "','" + datavalues[18] + "','" + datavalues[19] + "','" + datavalues[20] + "','" + datavalues[21] + "','" + datavalues[22] + "','" + datavalues[23] + "','" + datavalues[24] + "','" + datavalues[25] + "','" + datavalues[26] + "','" + datavalues[27] + "','" + datavalues[28] + "','" + datavalues[29] + "','" + datavalues[30] + "','" + datavalues[31] + "','" + datavalues[32] + "','" + datavalues[33] + "','" + datavalues[34] + "','" + datavalues[35] + "','" + datavalues[36] + "','" + datavalues[37] + "')";
                if (db.UpdateQuery(tablequery, "", "", "") > 0)
                {
                    count++;
                }
            }
            if (count > 0)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "ShowAlert('Added Successfully.','success')", true);
            }
            else
            {
                ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "ShowAlert('Something Went Wrong Please Try Again.','error')", true);
            }

        }

        protected void ddlCSO_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlCSO.SelectedIndex > 0)
            {
                ddlWFG.Items.Clear();
                ddlWFG.Items.Insert(0, "Select");

                string selectCSO = "SELECT [District],c.DistrictID,[Block],b.BlockID,D.StateId,StateName FROM tblCSO A,tblBlocks B,tblDistricts C ,tblStates D  where B.[BlockID ] = A.BlockID and C.[DistrictID] = A.DistrictID and D.[StateId] = A.StateId and CSOID =" + ddlCSO.SelectedValue;
                DataSet csods = db.getResultset(selectCSO, "", "", "");
                if (csods != null && csods.Tables[0].Rows.Count > 0)
                {
                    LoadStates();
                    if (ddlstate.Items.FindByValue(csods.Tables[0].Rows[0]["StateId"].ToString()) != null)
                    {
                        ddlstate.Items.FindByValue(csods.Tables[0].Rows[0]["StateId"].ToString()).Selected = true;
                    }
                    ddlstate.Enabled = false;
                    loadDist();
                    if (ddlDistrict.Items.FindByValue(csods.Tables[0].Rows[0]["DistrictID"].ToString()) != null)
                    {
                        ddlDistrict.Items.FindByValue(csods.Tables[0].Rows[0]["DistrictID"].ToString()).Selected = true;
                    }
                    ddlDistrict.Enabled = false;
                    loadBlock();
                    if (ddlBlock.Items.FindByValue(csods.Tables[0].Rows[0]["BlockID"].ToString()) != null)
                    {
                        ddlBlock.Items.FindByValue(csods.Tables[0].Rows[0]["BlockID"].ToString()).Selected = true;
                    }
                    ddlBlock.Enabled = false;
                    loadVillage();
                }
            }
            else
            {
                ddlstate.Items.Clear();
                ddlstate.Items.Insert(0, "Select");
                ddlVillage.Items.Clear();
                ddlVillage.Items.Insert(0, "Select");
                ddlDistrict.Items.Clear();
                ddlDistrict.Items.Insert(0, "Select");
                ddlBlock.Items.Clear();
                ddlBlock.Items.Insert(0, "Select");
                ddlWFG.Items.Clear();
                ddlWFG.Items.Insert(0, "Select");
            }
        }
    }
}