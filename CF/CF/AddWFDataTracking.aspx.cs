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
    public partial class AddWFDataTracking : System.Web.UI.Page
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
                        }
                        else if (User == "CSO")
                        {
                            LoadCSOData();
                        }
                        else if (User == "WFG")
                        {
                            LoadWFGData();
                        }
                        LoadFPC();
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

        protected void LoadFPC()
        {
            string query = "select FPCid,FPCName from tblFPCRegistration";
            DataSet ds = db.getResultset(query, "", "", "");
            if (ds != null && ds.Tables[0].Rows.Count > 0)
            {
                ddlFPCName.DataSource = ds;
                ddlFPCName.DataValueField = "FPCid";
                ddlFPCName.DataTextField = "FPCName";
                ddlFPCName.DataBind();
                ddlFPCName.Items.Insert(0, "Select");
            }
            else
            {
                ddlFPCName.Items.Clear();
                ddlFPCName.Items.Insert(0, "Select");
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
            else
            {
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
            string selectVill = "Select Vid,Village from tblVillageInfo b left outer join tblVillages a on a.VillageID = b.VillageID where b.VillageID is not null and a.BlockID =" + ddlBlock.SelectedValue;
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

        protected void btnsubmit_Click(object sender, EventArgs e)
        {
            string wfno = ddlWF.SelectedValue;
            string Year = txtYear.Text;
            string MajorSource = ddlMajorSource.SelectedValue;
            string OtehrSource = string.Empty;
            if (MajorSource == "Other")
            {
                OtehrSource = txtOtherSource.Text;
            }
            string SourceIncome = txtIncome.Text;
            string TotalIncome = txtTotalIncome.Text;
            string MNREGA = rblMNREGA.SelectedValue;
            string MNREGADays = string.Empty;
            if (MNREGA == "Yes")
            {
                MNREGADays = txtMNREGADays.Text;
            }
            string isLabour = rblLabourer.SelectedValue;
            string LabourNature = string.Empty;
            if (isLabour == "Yes")
            {
                LabourNature = txtNatureofWork.Text;
            }
            string isBenfits = rblBenifits.SelectedValue;
            string BenfitName = string.Empty;
            string OtherBenfit = string.Empty;
            string BenfitAmount = string.Empty;
            if (isBenfits == "Yes")
            {
                BenfitName = ddlBenfitName.SelectedValue;
                if (BenfitName == "Other")
                {
                    OtherBenfit = txtOtherBenfit.Text;
                }
                BenfitAmount = txtBenfitAmount.Text;
            }
            string isLivestock = rblLivestock.SelectedValue;
            string NoofLiveStock = string.Empty;
            string Cow = string.Empty;
            string Buffalo = string.Empty;
            string Goat = string.Empty;
            string Poultry = string.Empty;
            string Milk = string.Empty;
            string OtherLivestock = string.Empty;
            if (isLivestock == "Yes")
            {
                NoofLiveStock = txtLivestock.Text;
                Cow = txtCow.Text;
                Buffalo = txtBuffalo.Text;
                Goat = txtGoat.Text;
                Poultry = txtPoultry.Text;
                Milk = txtMilk.Text;
                OtherLivestock = txtOther.Text;
            }
            string isOwnlandSelfName = rblownlandSelfName.Text;
            string OwnlandSelfName = string.Empty;
            if (isOwnlandSelfName == "Yes")
            {
                OwnlandSelfName = txtownlandSelfName.Text;
            }
            string OtherOwnland = txtOwnLand.Text;
            string RentalLand = txtRentalLand.Text;
            string TotalLand = hfLandinHectore.Value;
            string isIrrigationLand = rblIrrigatedLand.SelectedValue;
            string IrrigationLand = string.Empty;
            string IrrigationSource = string.Empty;
            string OtherIrrigationSource = string.Empty;
            if (isIrrigationLand == "Yes")
            {
                IrrigationLand = txtTotlairrigationland.Text;
                IrrigationSource = ddlIrrigation.SelectedValue;
                if (IrrigationSource == "Yes")
                {
                    OtherIrrigationSource = txtIrrigationSpecify.Text;
                }
            }
            string NonIrrigationLand = txtNonirrigated.Text;
            string isOwnershipinland = rblOwnerShipinland.SelectedValue;
            string OwnershipLand = string.Empty;
            if (isOwnershipinland == "Yes")
            {
                OwnershipLand = txtLandHaving.Text;
            }
            string DemoPlot = rblDemoPlot.SelectedValue;
            string isGovScheme = rblGovScheme.SelectedValue;
            string SchemeName = string.Empty;
            string SchemeAmount = string.Empty;
            if (isGovScheme == "Yes")
            {
                SchemeName = txtGovScheme.Text;
                SchemeAmount = txtGovAmt.Text;
            }
            string isPaddy = rblPaddy.SelectedValue;
            string Paddy = string.Empty;
            string PaddyAvg = string.Empty;
            if (isPaddy == "Yes")
            {
                Paddy = txtPaddy.Text;
                PaddyAvg = txtPaddyAvg.Text;
            }
            string IsWheat = rblWheat.SelectedValue;
            string Wheat = string.Empty;
            string WheatAvg = string.Empty;
            if (IsWheat == "Yes")
            {
                Wheat = txtWheat.Text;
                WheatAvg = txtWheatAvg.Text;
            }
            string isPulse = rblPulseCrops.SelectedValue;
            string Pulse = string.Empty;
            string PulseAvg = string.Empty;
            string PulseType = string.Empty;
            if (isPulse == "Yes")
            {
                Pulse = txtPulseCrop.Text;
                PulseAvg = txtPulseCropAvg.Text;
                PulseType = ddlPulseType.SelectedValue;
            }
            string isOil = rblOilCrop.SelectedValue;
            string Oil = string.Empty;
            string OilAvg = string.Empty;
            string OilType = string.Empty;
            if (isOil == "Yes")
            {
                Oil = txtOilCrop.Text;
                OilAvg = txtOilCropAvg.Text;
                OilType = ddlOilType.SelectedValue;
            }
            string isVegitables = rblVegitables.SelectedValue;
            string Vegitables = string.Empty;
            string VegitablesAvg = string.Empty;
            string VegitablesType = string.Empty;
            if (isVegitables == "Yes")
            {
                Vegitables = txtVegitables.Text;
                VegitablesAvg = txtVegitablesAvg.Text;
                VegitablesType = ddlVegitableType.SelectedValue;
            }

            string isOthercrops = rblOtherCrops.SelectedValue;
            string Othercrops = string.Empty;
            string OthercropAvg = string.Empty;
            string OthercropAcr = string.Empty;
            if (isOthercrops == "Yes")
            {
                Othercrops = txtOtherCrop.Text;
                OthercropAcr = txtOtherCropAcr.Text;
                OthercropAvg = txtOtherCropAvg.Text;
            }
            string isShareCropper = rblsharecropper.SelectedValue;
            string ShareCropLand = string.Empty;
            if (isShareCropper == "Yes")
            {
                ShareCropLand = txtAreaofland.Text;
            }
            string isBusinessService = rblBuisness.SelectedValue;
            string BusinessServiceName = string.Empty;
            string BusinessServicceeOther = string.Empty;
            if (isBusinessService == "yes")
            {
                BusinessServiceName = ddlAccessService.SelectedValue;
                if (BusinessServiceName == "Other")
                {
                    BusinessServicceeOther = txtAccessService.Text;
                }
            }
            string ClimateAgriculture = rblClimateFriendly.SelectedValue;
            string OtherPractivce = string.Empty;
            string NUOM = string.Empty;
            string NUMIF = string.Empty;
            string NUMC = string.Empty;
            string NOTF = string.Empty;
            string NDSBSR = string.Empty;
            string NSRI = string.Empty;
            string NCR = string.Empty;
            string NUSV = string.Empty;
            string NMC = string.Empty;
            if (ClimateAgriculture == "Yes")
            {
                NUOM = rblNUOM.SelectedValue;
                NUMIF = rblNUMIF.SelectedValue;
                NUMC = rblNUMC.SelectedValue;
                NOTF = rblNOTF.SelectedValue;
                NDSBSR = rblNDSBSR.SelectedValue;
                NSRI = rblNSRI.SelectedValue;
                NCR = rblNCR.SelectedValue;
                NUSV = rblNUSV.SelectedValue;
                NMC = rblNMC.SelectedValue;
                OtherPractivce = txtOtherPracticeType.Text;
            }
            string isTrainingAttended = rblAttendedTrainings.SelectedValue;
            string TrainingName = string.Empty;
            string OtherTrainingName = string.Empty;
            string NoofFallowUps = string.Empty;
            if (isTrainingAttended == "Yes")
            {
                TrainingName = ddlTraining.SelectedValue;
                NoofFallowUps = txtTrainingNo.Text;
                if (TrainingName == "Other")
                {
                    OtherTrainingName = txtTrainingSpecify.Text;
                }
            }
            string MoreCultivating = rblMoreCultivating.SelectedValue;
            string CultivatingCrop = string.Empty;
            if (MoreCultivating == "Yes")
            {
                CultivatingCrop = txtCultivatingCrop.Text;
            }
            string AgriUse = txtAgriUse.Text;
            string ProUse = txtProUse.Text;
            string DIKS = rblDIKS.SelectedValue;
            string PrecTrained = txtPrecTrained.Text;
            string PreTrainig = txtPreTrainig.Text;
            string PostTraining = txtPostTraining.Text;
            string KnowLoanObtain = rblKOLFI.SelectedValue;
            string Financialliteracy = rblFinance.SelectedValue;
            string ManageMoney = rblManageMoney.SelectedValue;
            string BuisnessDevelop = rblBuisnessDevelop.SelectedValue;
            string TypeofBusiness = string.Empty;
            if (BuisnessDevelop == "Yes")
            {
                TypeofBusiness = txtBusinessPlanType.Text;
            }
            string ICTAccess = rblICTAccess.SelectedValue;
            string CropChoice = rblCropChoice.SelectedValue;
            string Input = rblInput.SelectedValue;
            string Deciding = rblDeciding.SelectedValue;
            string Timimg = rblTimimg.SelectedValue;
            string DecidingTime = rblDecidingTime.SelectedValue;
            string Harvesting = rblHarvesting.SelectedValue;
            string SaleLand = rblSaleLand.SelectedValue;
            string SoWomen = rblSoWomen.SelectedValue;
            string SoMaterial = rblSoMaterial.SelectedValue;
            string SoAgro = rblSoAgro.SelectedValue;
            string SoSelling = rblSoSelling.SelectedValue;
            string SoExpenditure = rblSoExpenditure.SelectedValue;
            string JoWomen = rblJoWomen.SelectedValue;
            string JoMaterial = rblJoMaterial.SelectedValue;
            string JoAgro = rblJoAgro.SelectedValue;
            string JoSelling = rblJoSelling.SelectedValue;
            string JoExpenditure = rblJoExpenditure.SelectedValue;
            string OnFarm = rblOnFarm.SelectedValue;
            string OffFarm = rblOffFarm.SelectedValue;
            string ShareHolder = rblShareHolder.SelectedValue;
            string FPCID = "NULL";
            string FPCName = string.Empty;
            string NoofShares = string.Empty;
            if (ShareHolder == "Yes")
            {
                FPCID = ddlFPCName.SelectedValue;
                FPCName = ddlFPCName.SelectedItem.Text;
                NoofShares = txtFPCShares.Text;
            }

            string tablequery = "INSERT INTO tblWFsYearData(WFno, Year, Business, AccessService, AccessServiceOther, ClimateFriendly, UseofOrganicManure, Useofwaterconservation, UseofMultiCropping,  OTillageFarming, DirectSeededRiceBSR, SysytemofRootIntensification, CarbonReduction, UseofSeedsVariety, Mixedcropping, PracticeType, MoreCultivating, CultivatingCrop, AgriUse, ProUse, Demonstrate, PercTrained, PreTraining, PostTraining, LoanObtain, ManageMoney, BusinessDevelop, ICTAccess, OnFarm, OffFarm, CropChoice, Input, Deciding, Timing, DecidingTime, Harvesting, SaleLand, SoWomen, SoMaterial, SoAgro, SoSelling, SoExpenditure, JoWomen, JoMaterial, JoAgro, JoSelling, JoExpenditure, ShareHolder, FPCName, FPCID, FPCShares, MajorSourceofFamily, OtherMajorSource, MajorSourceIncome, isMNREGA, MNREGADays, IsWomenLaboure, NatureofWork, IsBenefit, NameofBenefitScheme, OtherBenefitSchemeName, BenefitIncome, isLivestock, NumberOfLiveStock, CowLivestock, BuffaloLivestock, GoatLivestock, PoultryLivestock, MilkLivestock, OtherLivestock, islandinthenameofwoman, OwnLandSelfName, OwnLand, RentalLand, TotalLandinHectors, IsIrrigatedLand, irrigatedLandinAcr, SourceofIrrigation, SourceOfIrrigationOther, NonIrrigated, IsOwnershipinLand, AreaofOwnershipLand, DemoPlot, IsGovScheme, GovSchemeName, GovSchemeAmount, IsPaddy, PaddyAcr, PaddyAvg, isWheat, WheatAcr, WheatAvg, isPulseCrop, PulseCropAcr ,PulseCropAvg,PulseCropType, IsOilCrop, OilCropAcr, OilCropAvg, OilCropType, isVegitables, VegitablesAcr, VegitablesAvg, VegitableCropType,  IsOtherCrop, OtherCropsName, OtherCropAcr, OtherCropAvg,  IsSharecrops, SharecropsLand, HasAttendedTraining, TrainingName, TrainingOther, TrainingFollowUps, Financialliteracy, TotalAnualIncome) VALUES(" + ddlWF.SelectedValue + ",'" + Year + "','" + isBusinessService + "','" + BusinessServiceName + "','" + BusinessServicceeOther + "','" + ClimateAgriculture + "','" + NUOM + "','" + NUMIF + "','" + NUMC + "','" + NOTF + "','" + NDSBSR + "','" + NSRI + "','" + NCR + "','" + NUSV + "','" + NMC + "','" + OtherPractivce + "','" + MoreCultivating + "','" + CultivatingCrop + "','" + AgriUse + "','" + ProUse + "','" + DIKS + "','" + PrecTrained + "','" + PreTrainig + "','" + PostTraining + "','" + KnowLoanObtain + "','" + ManageMoney + "','" + BuisnessDevelop + "','" + ICTAccess + "','" + OnFarm + "','" + OffFarm + "','" + CropChoice + "','" + Input + "','" + Deciding + "','" + Timimg + "','" + DecidingTime + "','" + Harvesting + "','" + SaleLand + "','" + SoWomen + "','" + SoMaterial + "','" + SoAgro + "','" + SoSelling + "','" + SoExpenditure + "','" + JoWomen + "','" + JoMaterial + "','" + JoAgro + "','" + JoSelling + "','" + JoExpenditure + "','" + ShareHolder + "','" + FPCName + "'," + FPCID + ",'" + NoofShares + "','" + MajorSource + "','" + OtehrSource + "','" + SourceIncome + "','" + MNREGA + "','" + MNREGADays + "','" + isLabour + "','" + LabourNature + "','" + isBenfits + "','" + BenfitName + "','" + OtherBenfit + "','" + BenfitAmount + "','" + isLivestock + "','" + NoofLiveStock + "','" + Cow + "','" + Buffalo + "','" + Goat + "','" + Poultry + "','" + Milk + "','" + OtherLivestock + "','" + isOwnlandSelfName + "','" + OwnlandSelfName + "','" + OtherOwnland + "','" + RentalLand + "','" + TotalLand + "','" + isIrrigationLand + "','" + IrrigationLand + "','" + IrrigationSource + "','" + OtherIrrigationSource + "','" + NonIrrigationLand + "','" + isOwnershipinland + "','" + OwnershipLand + "','" + DemoPlot + "','" + isGovScheme + "','" + SchemeName + "','" + SchemeAmount + "','" + isPaddy + "','" + Paddy + "','" + PaddyAvg + "','" + IsWheat + "','" + Wheat + "','" + WheatAvg + "','" + isPulse + "','" + Pulse + "','" + PulseAvg + "','" + PulseType + "','" + isOil + "','" + Oil + "','" + OilAvg + "','" + OilType + "','" + isVegitables + "','" + Vegitables + "','" + VegitablesAvg + "','" + VegitablesType + "','" + isOthercrops + "','" + Othercrops + "','" + OthercropAcr + "','" + OthercropAvg + "','" + isShareCropper + "','" + ShareCropLand + "','" + isTrainingAttended + "','" + TrainingName + "','" + OtherTrainingName + "','" + NoofFallowUps + "','" + Financialliteracy + "','" + TotalIncome + "')";
            if (db.UpdateQuery(tablequery, "", "", "") > 0)
            {
                if (rblShareHolder.SelectedValue == "Yes")
                {
                    string query1 = "select * from tblWFs where WFno = " + ddlWF.SelectedValue + "";
                    DataSet ds1 = db.getResultset(query1, "", "", "");

                    if (ds1 != null && ds1.Tables[0].Rows.Count > 0)
                    {
                        string fpcinsert = "insert into tblFPCMembers(State, District, Block, Village, FPCName, NoofSharesheldinFPC, MemberName, FatherorHusbandName, Age, Category, EducationalQualification, ContactNo, AadhaarNo, DateofJoiningFPC) values('" + ddlstate.SelectedValue + "','" + ddlDistrict.SelectedValue + "','" + ddlBlock.SelectedValue + "', '" + ddlVillage.SelectedValue + "','" + ddlFPCName.SelectedValue + "','" + txtFPCShares.Text + "','" + ddlWF.SelectedItem.Text + "','" + ds1.Tables[0].Rows[0]["HusbandName"] + "','" + ds1.Tables[0].Rows[0]["Age"] + "','" + ds1.Tables[0].Rows[0]["SocialCategory"] + "','" + ds1.Tables[0].Rows[0]["Qualification"] + "','" + ds1.Tables[0].Rows[0]["ContactNumber"] + "','" + ds1.Tables[0].Rows[0]["AdharNo"] + "','" + DateTime.Now + "')";
                        db.UpdateQuery(fpcinsert, "", "", "");
                        ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "ShowAlert('Added Details Successfully.','success')", true);
                    }
                }
                ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "ShowAlert('Added Details Successfully.','success')", true);
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

        protected void txtYear_TextChanged(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(txtYear.Text) && ddlWF.SelectedIndex > 0)
            {
                string query = "select * from tblWFsYearData where Year='" + txtYear.Text + "' and Wfno=" + ddlWF.SelectedValue;
                DataSet ds = db.getResultset(query, "", "", "");
                if (ds != null && ds.Tables[0].Rows.Count > 0)
                {
                    txtYear.Text = "";
                    ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "ShowAlert('Selected Year has already existed in the data.','error')", true);
                }
            }
        }

        //protected void rblWantFPC_SelectedIndexChanged(object sender, EventArgs e)
        //{
        //    string str = rblWantFPC.SelectedValue;
        //    if (str == "Yes")
        //    {
        //        string query = "select FPCName from tblFPCRegistration";
        //        DataSet ds = db.getResultset(query, "", "", "");

        //        if (ds != null && ds.Tables[0].Rows.Count > 0)
        //        {
        //            ddlFPCName.DataSource = ds;
        //            ddlFPCName.DataValueField = "FPCName";
        //            ddlFPCName.DataTextField = "FPCName";
        //            ddlFPCName.DataBind();
        //            ddlFPCName.Items.Insert(0, "Select");
        //        }
        //    }
        //    else
        //    {

        //    }

        //}
    }
}






