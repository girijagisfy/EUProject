using ClosedXML.Excel;
using System;
using System.Configuration;
using System.Data;
using System.IO;
using System.Web.UI;

namespace CF
{
    public partial class WFDataReport : System.Web.UI.Page
    {
        DbErrorLog db = new DbErrorLog();
        string User = string.Empty;
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
                            LoadStates();
                        }
                        else if (User == "CSO")
                        {
                            LoadCSOData();
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
                loadVillage();
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
                ddlstate.Items.Insert(0, "All");
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
                ddlDistrict.Items.Insert(0, "All");
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
                ddlBlock.Items.Insert(0, "All");
            }
        }

        public void loadVillage()
        {
            string blockcond = string.Empty;
            if (ddlBlock.SelectedIndex > 0)
            {
                blockcond = "and a.BlockID =" + ddlBlock.SelectedValue;
            }
            string selectVill = "Select Vid,Village from tblVillageInfo b left outer join tblVillages a on a.VillageID = b.VillageID where b.VillageID is not null " + blockcond;
            DataSet dsV = db.getResultset(selectVill, "", "", "");
            if (dsV != null && dsV.Tables[0].Rows.Count > 0)
            {
                ddlVillage.DataSource = dsV;
                ddlVillage.DataTextField = "Village";
                ddlVillage.DataValueField = "Vid";
                ddlVillage.DataBind();
                ddlVillage.Items.Insert(0, "All");
            }
        }

        public void LoadWFGs()
        {
            string vilalgecond = string.Empty;
            if (ddlVillage.SelectedIndex > 0)
            {
                vilalgecond = " and a.VillageID = " + ddlVillage.SelectedValue + "";
            }
            else if (ddlBlock.SelectedIndex > 0)
            {
                vilalgecond += " and b.BlockId=" + ddlBlock.SelectedValue;
            }
            string query = "select WfgNo,WFGName from tblWFGs a left outer join tblVillageInfo b on a.VillageID = b.Vid where 1=1 " + vilalgecond + " order by WFGName";
            DataSet ds = db.getResultset(query, "", "", "");

            if (ds != null && ds.Tables[0].Rows.Count > 0)
            {
                ddlWFG.DataSource = ds;
                ddlWFG.DataValueField = "WfgNo";
                ddlWFG.DataTextField = "WFGName";
                ddlWFG.DataBind();
                ddlWFG.Items.Insert(0, "All");
            }
            else
            {
                ddlWFG.Items.Clear();
                ddlWFG.Items.Insert(0, "All");
            }
        }

        public void loadWFs()
        {
            string vilalgecond = string.Empty;
            if (ddlWFG.SelectedIndex > 0)
            {
                vilalgecond = " and a.WFGID = " + ddlWFG.SelectedValue + "";
            }
            else if (ddlVillage.SelectedIndex > 0)
            {
                vilalgecond = " and a.VillageID = " + ddlVillage.SelectedValue + "";
            }
            else if (ddlBlock.SelectedIndex > 0)
            {
                vilalgecond += " and c.BlockId=" + ddlBlock.SelectedValue;
            }
            string query = "select WFno,WomenName from tblWFs a left outer join tblWFGs b on a.WFGID=b.WFGno left outer join tblVillageInfo c on b.VillageID = c.Vid where 1=1 " + vilalgecond + " order by WomenName";
            DataSet ds = db.getResultset(query, "", "", "");

            if (ds != null && ds.Tables[0].Rows.Count > 0)
            {
                ddlWF.DataSource = ds;
                ddlWF.DataValueField = "WFno";
                ddlWF.DataTextField = "WomenName";
                ddlWF.DataBind();
                ddlWF.Items.Insert(0, "All");
            }
            else
            {
                ddlWF.Items.Clear();
                ddlWF.Items.Insert(0, "All");
            }
        }

        protected void ddlCSO_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlCSO.SelectedIndex > 0)
            {
                ddlWFG.Items.Clear();
                ddlWFG.Items.Insert(0, "All");

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
                    LoadWFGs();
                    loadWFs();
                }
            }
            else
            {
                ddlstate.Items.Clear();
                ddlstate.Items.Insert(0, "All");
                ddlVillage.Items.Clear();
                ddlVillage.Items.Insert(0, "All");
                ddlDistrict.Items.Clear();
                ddlDistrict.Items.Insert(0, "All");
                ddlBlock.Items.Clear();
                ddlBlock.Items.Insert(0, "All");
                ddlVillage.Items.Clear();
                ddlVillage.Items.Insert(0, "All");
                ddlWFG.Items.Clear();
                ddlWFG.Items.Insert(0, "All");
                ddlWF.Items.Clear();
                ddlWF.Items.Insert(0, "All");
                ddlstate.Enabled = true;
                ddlDistrict.Enabled = true;
                ddlBlock.Enabled = true;
                loadVillage();
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
                ddlBlock.Items.Clear();
                ddlBlock.Items.Insert(0, "All");
                ddlVillage.Items.Clear();
                ddlVillage.Items.Insert(0, "All");
                ddlWFG.Items.Clear();
                ddlWFG.Items.Insert(0, "All");
                ddlWF.Items.Clear();
                ddlWF.Items.Insert(0, "All");

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
                loadWFs();
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
                    ddlWF.Items.Insert(0, "All");
                }
                else
                {
                    ddlWF.Items.Clear();
                    ddlWF.Items.Insert(0, "All");
                }
            }
            else
            {
                ddlWF.Items.Clear();
                ddlWF.Items.Insert(0, "All");
            }
        }

        protected void btnExcel_Click(object sender, EventArgs e)
        {
            string Condetion = "";
            //if (User == "CSO")
            //{
            //    Condetion = " and c.Csoid=" + Session["ClientID"];
            //}
            //else if (User == "WFG")
            //{
            //    Condetion = " and b.WFGID=" + Session["ClientID"];
            //}
            string CSOCindetion = string.Empty;
            string StateCondetion = string.Empty;
            string DistrictCondetion = string.Empty;
            string BlockCondetion = string.Empty;
            if (ddlCSO.SelectedIndex > 0 && ddlCSO.SelectedValue != "All")
            {
                Condetion += " and c.CSOID=" + ddlCSO.SelectedValue;
            }
            else
            {
                if (ddlstate.SelectedIndex > 0 && ddlstate.SelectedValue != "All")
                {
                    Condetion += " and c.StateID=" + ddlstate.SelectedValue;
                }
                if (ddlDistrict.SelectedIndex > 0 && ddlDistrict.SelectedValue != "All")
                {
                    Condetion += " and c.DistrictID=" + ddlDistrict.SelectedValue;
                }
                if (ddlBlock.SelectedIndex > 0 && ddlBlock.SelectedValue != "All")
                {
                    Condetion += " and c.BlockID=" + ddlBlock.SelectedValue;
                }
            }
            if (ddlVillage.SelectedIndex > 0 && ddlVillage.SelectedValue != "All")
            {
                Condetion += " and Vid=" + ddlVillage.SelectedValue;
            }
            if (ddlWFG.SelectedIndex > 0 && ddlWFG.SelectedValue != "All")
            {
                Condetion += " and f.WfgNo=" + ddlWFG.SelectedValue;
            }
            if (!string.IsNullOrEmpty(txtYear.Text))
            {
                Condetion += " and Year='" + txtYear.Text + "'";
            }
            string query = "select ROW_NUMBER() OVER(ORDER BY (SELECT 1)) AS SerialNum,d.Village, c.Vid, c.GramPanchayatName, a.WFno, WomenName, HusbandName, Religion, SocialCategory, DOB, Age, AadharNo, IsDisable as Disability,case when DisabilityType='Other' then DisabilityOther else DisabilityType end as DisabilityType, Qualification, VocationalTraining, h.WFGName, TotalFamilyMembers, isRationcard, TypeofRationCard, IsCBOMember, NameofCBO, NatureofCBO, Year, case when a.MajorSourceofFamily='Other' then a.OtherMajorSource else a.MajorSourceofFamily end as MajorSourceofFamily, a.TotalAnualIncome as [Family income], a.NumberOfLiveStock, a.IsOwnershipinLand, a.AreaofOwnershipLand, a.islandinthenameofwoman, a.OwnLandSelfName, case when a.SourceofIrrigation='Other' then a.SourceOfIrrigationOther else a.SourceofIrrigation end SourceofIrrigation, a.NonIrrigated,concat('Wheat Acr:',case when a.isWheat='Yes' then a.WheatAcr else '0' end ,', ','Paddy Acr:', case when a.IsPaddy='Yes' then a.PaddyAcr else '0' end ,', ','Vegitables Acr:', case when a.isVegitables = 'Yes' then a.VegitablesAcr else '0' end) as StapleCrops, a.IsSharecrops, a.SharecropsLand, a.DemoPlot, case when a.IsBenefit='Yes' then case when a.NameofBenefitScheme='Other' then a.OtherBenefitSchemeName else a.NameofBenefitScheme end else '' end NameofBenefitScheme, a.IsGovScheme, a.GovSchemeName, a.GovSchemeAmount, OtherInformation, a.isMNREGA, BaselineSurvey, ClimateStudy, GenderStudy, a.HasAttendedTraining, case when a.TrainingName='Other' then a.TrainingOther else a.TrainingName end TrainingName, a.TrainingFollowUps, a.Business, a.AccessService,  a.ClimateFriendly, concat('Use of organic manure:', a.UseofOrganicManure,', Use of water conservation.-Micro irrigantion facilites:', a.Useofwaterconservation,', Use of multi-cropping:', a.UseofMultiCropping,', O tillage farming:', a.OTillageFarming,', Direct seeded rice-BSR:', a.DirectSeededRiceBSR,', Sysytem of Root Intensification:', a.SysytemofRootIntensification, ', Carbon Reduction:', a.CarbonReduction,', Use of Seeds Variety:', a.UseofSeedsVariety,', Mixed cropping:', a.Mixedcropping,', Other:', a.PracticeType) PracticeType, a.MoreCultivating, a.CultivatingCrop, a.AgriUse, a.ProUse, PercTrained, a.PreTraining, a.PostTraining, isBankAccount, a.LoanObtain, a.ManageMoney, a.BusinessDevelop, a.ICTAccess, a.OnFarm, a.OffFarm, concat('Choice of crops:',CropChoice,', Inputs-Material investment in agriculture:', Input,', Deciding crop cycle', a.Deciding,', Timing of cropping:', Timing,', Deciding crop sowing time:', DecidingTime, ', Crop harvesting', Harvesting, ', Sale/transfer of land:', SaleLand) as ProductiveResources,concat('Women self-development:', SoWomen,', Material/investment in agriculture:', SoMaterial,', Selling agro-produce:', SoAgro,', Selling/transferring land:' , SoSelling,', Expenditure planning of income:', SoExpenditure) as solely, concat('Women self-development:', JoWomen,', Material/investment in agriculture:', JoMaterial,', Selling agro-produce:', JoAgro,', Selling/transferring land:' , JoSelling,', Expenditure planning of income:', JoExpenditure) as jointly, a.ShareHolder, a.FPCName from tblWFsYearData a left outer join tblWFs b on a.Wfno=b.WFno left outer join tblVillageInfo c on b.villageid=c.Vid left outer join tblVillages d on d.villageid=c.VillageID left outer join tblBlocks e on d.BlockID=e.BlockID left outer join tblDistricts f on f.DistrictID=e.DistrictID left outer join tblStates g on g.StateId=f.StateID left outer join tblWFGs h on b.WFGID=h.WfgNo where 1=1 " + Condetion;
            DataSet ds = db.getResultset(query, "", "", "");
            DataTable dt = new DataTable();
            if (ds != null && ds.Tables[0].Rows.Count > 0)
            {
                using (XLWorkbook wb = new XLWorkbook())
                {
                    wb.Worksheets.Add(ds.Tables[0]);
                    using (MemoryStream stream = new MemoryStream())
                    {
                        wb.SaveAs(stream);
                        stream.Position = 0;
                        string myName = Server.UrlEncode("WFG_Data_Tracking_Sheet_" + DateTime.Now.ToShortDateString() + ".xlsx");

                        Response.Clear();
                        Response.Buffer = true;
                        Response.AddHeader("content-disposition", "attachment; filename=" + myName);
                        Response.ContentType = "application/vnd.ms-excel";
                        Response.BinaryWrite(stream.ToArray());
                        Response.End();
                    }
                }
            }
            else
            {
                ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "ShowAlert('Something went wrong / No Records Found','error')", true);
            }
        }

        public void DownloadXlsx(string excelpath, string fileName)
        {
            try
            {
                string path = ConfigurationManager.ConnectionStrings["DownloadReport"].ConnectionString;
                FileInfo file = new FileInfo(excelpath);
                if (file.Exists)
                {
                    Response.Clear();
                    Response.ClearHeaders();
                    Response.ClearContent();
                    Response.AddHeader("content-disposition", "attachment; filename=" + Path.GetFileName(excelpath));
                    Response.AddHeader("Content-Type", "application/Excel");
                    Response.ContentType = "application/vnd.xlsx";
                    Response.AddHeader("Content-Length", file.Length.ToString());
                    Response.WriteFile(file.FullName);
                    Response.End();
                }
                else
                {
                    Response.Write("This file does not exist.");
                }
            }
            catch (Exception ex)
            {
                ex.Message.ToString();
                db.AppendToErrorLog(ex.Message.ToString(), ex.StackTrace.ToString(), "", "");
            }
        }
    }
}