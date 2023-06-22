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
    public partial class EditWFDataTracking : System.Web.UI.Page
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
                    if (Session["WFDataID"] != null)
                    {
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
                            LoadData();
                            LoadFPC();
                        }
                    }
                    else
                    {
                        Response.Redirect("~/WFDataTrackingInfo.aspx");
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

        protected void LoadData()
        {
            string GetQuery = "select a.WFno, c.CSOID, c.StateId, c.DistrictID, c.BlockID,c.GramPanchayatName, b.VillageID, WFGID, Year, a.Business, a.AccessService, a.AccessServiceOther, a.ClimateFriendly, a.UseofOrganicManure, a.Useofwaterconservation, a.UseofMultiCropping,  a.OTillageFarming,a. DirectSeededRiceBSR, SysytemofRootIntensification, CarbonReduction, UseofSeedsVariety, Mixedcropping, a.PracticeType, a.MoreCultivating, a.CultivatingCrop, a.AgriUse, a.ProUse, a.Demonstrate, a.PercTrained, a.PreTraining, a.PostTraining, a.LoanObtain, a.ManageMoney, a.BusinessDevelop, a.TypeofBusiness, a.ICTAccess, a.OnFarm, a.OffFarm, a.CropChoice, a.Input, a.Deciding, a.Timing, a.DecidingTime, a.Harvesting, a.SaleLand, a.SoWomen, a.SoMaterial, a.SoAgro, a.SoSelling, a.SoExpenditure, a.JoWomen, a.JoMaterial, a.JoAgro, a.JoSelling, a.JoExpenditure, a.ShareHolder, a.FPCName, a.FPCID, a.FPCShares, a.MajorSourceofFamily, a.OtherMajorSource, a.MajorSourceIncome, a.isMNREGA, a.MNREGADays, a.IsWomenLaboure, a.NatureofWork, a.IsBenefit, a.NameofBenefitScheme, a.OtherBenefitSchemeName, a.BenefitIncome, a.isLivestock, a.NumberOfLiveStock, a.CowLivestock, a.BuffaloLivestock, a.GoatLivestock, a.PoultryLivestock, a.MilkLivestock, a.OtherLivestock, a.islandinthenameofwoman, a.OwnLandSelfName, a.OwnLand, a.RentalLand, a.TotalLandinHectors, a.IsIrrigatedLand, a.irrigatedLandinAcr, a.SourceofIrrigation, a.SourceOfIrrigationOther, a.NonIrrigated, a.IsOwnershipinLand, a.AreaofOwnershipLand, a.DemoPlot, a.IsGovScheme, a.GovSchemeName, a.GovSchemeAmount, a.IsPaddy, a.PaddyAcr, a.PaddyAvg, a.isWheat, a.WheatAcr, a.WheatAvg, a.isPulseCrop, a.PulseCropAcr, a.PulseCropAvg, a.PulseCropType, a.IsOilCrop, a.OilCropAcr, a.OilCropAvg, a.OilCropType, a.isVegitables, a.VegitablesAcr, a.VegitablesAvg, a.VegitableCropType, a.IsOtherCrop, a.OtherCropsName, a.OtherCropAcr, a.OtherCropAvg, a.IsSharecrops, a.SharecropsLand, a.HasAttendedTraining, a.TrainingName, a.TrainingOther, a.TrainingFollowUps, a.Financialliteracy, a.TotalAnualIncome from tblWFsYearData a left outer join tblWFs b on a.Wfno=b.WFno left outer join tblVillageInfo c on b.VillageID = c.Vid left outer join tblCSO d on c.CSOID = d.CSOID left outer join tblWFGs e on b.WFGID = e.WfgNo where WFDataID=" + Session["WFDataID"];
            DataSet ds = db.getResultset(GetQuery, "", "", "");
            if (ds != null && ds.Tables[0].Rows.Count > 0)
            {
                DataTable dt = ds.Tables[0];
                DataRow dr = dt.Rows[0];
                LoadCSO();
                if (ddlCSO.Items.FindByValue(dr["CSOID"].ToString()) != null)
                {
                    ddlCSO.ClearSelection();
                    ddlCSO.Items.FindByValue(dr["CSOID"].ToString()).Selected = true;
                }
                LoadStates();
                if (ddlstate.Items.FindByValue(dr["StateId"].ToString()) != null)
                {
                    ddlstate.Items.FindByValue(dr["StateId"].ToString()).Selected = true;
                }
                ddlstate.Enabled = false;
                loadDist();
                if (ddlDistrict.Items.FindByValue(dr["DistrictID"].ToString()) != null)
                {
                    ddlDistrict.Items.FindByValue(dr["DistrictID"].ToString()).Selected = true;
                }
                ddlDistrict.Enabled = false;
                loadBlock();
                if (ddlBlock.Items.FindByValue(dr["BlockID"].ToString()) != null)
                {
                    ddlBlock.Items.FindByValue(dr["BlockID"].ToString()).Selected = true;
                }
                ddlBlock.Enabled = false;
                loadVillage();
                if (ddlVillage.Items.FindByValue(dr["VillageID"].ToString()) != null)
                {
                    ddlVillage.Items.FindByValue(dr["VillageID"].ToString()).Selected = true;
                }
                LoadWFGs();
                if (ddlWFG.Items.FindByValue(dr["WFGID"].ToString()) != null)
                {
                    ddlWFG.Items.FindByValue(dr["WFGID"].ToString()).Selected = true;
                }
                loadWFs();
                if (ddlWF.Items.FindByValue(dr["WFno"].ToString()) != null)
                {
                    ddlWF.Items.FindByValue(dr["WFno"].ToString()).Selected = true;
                }
                txtYear.Text = dr["Year"].ToString();
                if (ddlMajorSource.Items.FindByValue(dr["MajorSourceofFamily"].ToString()) != null)
                {
                    ddlMajorSource.Items.FindByValue(dr["MajorSourceofFamily"].ToString()).Selected = true;
                }
                if (ddlMajorSource.SelectedValue == "Other")
                {
                    txtOtherSource.Text = dr["OtherMajorSource"].ToString();
                }
                txtIncome.Text = dr["MajorSourceIncome"].ToString();
                if (rblMNREGA.Items.FindByValue(dr["isMNREGA"].ToString()) != null)
                {
                    rblMNREGA.Items.FindByValue(dr["isMNREGA"].ToString()).Selected = true;
                }
                if (rblMNREGA.SelectedValue == "Yes")
                {
                    txtMNREGADays.Text = dr["MNREGADays"].ToString();
                }
                if (rblLabourer.Items.FindByValue(dr["IsWomenLaboure"].ToString()) != null)
                {
                    rblLabourer.Items.FindByValue(dr["IsWomenLaboure"].ToString()).Selected = true;
                }
                if (rblLabourer.SelectedValue == "Yes")
                {
                    txtNatureofWork.Text = dr["IsBenefit"].ToString();
                }
                if (rblBenifits.Items.FindByValue(dr["IsBenefit"].ToString()) != null)
                {
                    rblBenifits.Items.FindByValue(dr["IsBenefit"].ToString()).Selected = true;
                }
                if (rblBenifits.SelectedValue == "Yes")
                {
                    if (ddlBenfitName.Items.FindByValue(dr["NameofBenefitScheme"].ToString()) != null)
                    {
                        ddlBenfitName.Items.FindByValue(dr["NameofBenefitScheme"].ToString()).Selected = true;
                    }
                    if (ddlBenfitName.SelectedValue == "Other")
                    {
                        txtOtherBenfit.Text = dr["OtherBenefitSchemeName"].ToString();
                    }
                    txtBenfitAmount.Text = dr["BenefitIncome"].ToString();
                }
                if (rblLivestock.Items.FindByValue(dr["isLivestock"].ToString()) != null)
                {
                    rblLivestock.Items.FindByValue(dr["isLivestock"].ToString()).Selected = true;
                }
                if (rblLivestock.SelectedValue == "Yes")
                {
                    txtLivestock.Text = dr["NumberOfLiveStock"].ToString();
                    txtCow.Text = dr["CowLivestock"].ToString();
                    txtBuffalo.Text = dr["BuffaloLivestock"].ToString();
                    txtGoat.Text = dr["GoatLivestock"].ToString();
                    txtPoultry.Text = dr["PoultryLivestock"].ToString();
                    txtMilk.Text = dr["MilkLivestock"].ToString();
                    txtOther.Text = dr["OtherLivestock"].ToString();
                }
                if (rblownlandSelfName.Items.FindByValue(dr["islandinthenameofwoman"].ToString()) != null)
                {
                    rblownlandSelfName.Items.FindByValue(dr["islandinthenameofwoman"].ToString()).Selected = true;
                }
                if (rblownlandSelfName.SelectedValue == "Yes")
                {
                    txtownlandSelfName.Text = dr["OwnLandSelfName"].ToString();
                }
                txtTotalIncome.Text = dr["TotalAnualIncome"].ToString();
                txtOwnLand.Text = dr["OwnLand"].ToString();
                txtRentalLand.Text = dr["RentalLand"].ToString();
                hfLandinHectore.Value = dr["TotalLandinHectors"].ToString();
                txtLandinHectore.Text = dr["TotalLandinHectors"].ToString();
                if (rblIrrigatedLand.Items.FindByValue(dr["IsIrrigatedLand"].ToString()) != null)
                {
                    rblIrrigatedLand.Items.FindByValue(dr["IsIrrigatedLand"].ToString()).Selected = true;
                }
                if (rblIrrigatedLand.SelectedValue == "Yes")
                {
                    txtTotlairrigationland.Text = dr["irrigatedLandinAcr"].ToString();
                    if (ddlIrrigation.Items.FindByValue(dr["SourceofIrrigation"].ToString()) != null)
                    {
                        ddlIrrigation.Items.FindByValue(dr["SourceofIrrigation"].ToString()).Selected = true;
                    }
                    if (ddlIrrigation.SelectedValue == "Yes")
                    {
                        txtIrrigationSpecify.Text = dr["SourceOfIrrigationOther"].ToString();
                    }
                }
                txtNonirrigated.Text = dr["NonIrrigated"].ToString();
                if (rblOwnerShipinland.Items.FindByValue(dr["IsOwnershipinLand"].ToString()) != null)
                {
                    rblOwnerShipinland.Items.FindByValue(dr["IsOwnershipinLand"].ToString()).Selected = true;
                }
                if (rblOwnerShipinland.SelectedValue == "Yes")
                {
                    txtLandHaving.Text = dr["AreaofOwnershipLand"].ToString();
                }
                if (rblDemoPlot.Items.FindByValue(dr["DemoPlot"].ToString()) != null)
                {
                    rblDemoPlot.Items.FindByValue(dr["DemoPlot"].ToString()).Selected = true;
                }
                if (rblGovScheme.Items.FindByValue(dr["IsGovScheme"].ToString()) != null)
                {
                    rblGovScheme.Items.FindByValue(dr["IsGovScheme"].ToString()).Selected = true;
                }
                if (rblGovScheme.SelectedValue == "Yes")
                {
                    txtGovScheme.Text = dr["GovSchemeName"].ToString();
                    txtGovAmt.Text = dr["GovSchemeAmount"].ToString();
                }
                if (rblPaddy.Items.FindByValue(dr["IsPaddy"].ToString()) != null)
                {
                    rblGovScheme.Items.FindByValue(dr["IsPaddy"].ToString()).Selected = true;
                }
                if (rblPaddy.SelectedValue == "Yes")
                {
                    txtPaddy.Text = dr["Paddy"].ToString();
                    txtPaddyAvg.Text = dr["PaddyAvg"].ToString();
                }
                if (rblWheat.Items.FindByValue(dr["isWheat"].ToString()) != null)
                {
                    rblWheat.Items.FindByValue(dr["isWheat"].ToString()).Selected = true;
                }
                if (rblWheat.SelectedValue == "Yes")
                {
                    txtWheat.Text = dr["WheatAcr"].ToString();
                    txtWheatAvg.Text = dr["WheatAvg"].ToString();
                }
                if (rblPulseCrops.Items.FindByValue(dr["isPulseCrop"].ToString()) != null)
                {
                    rblPulseCrops.Items.FindByValue(dr["isPulseCrop"].ToString()).Selected = true;
                }
                if (rblPulseCrops.SelectedValue == "Yes")
                {
                    txtPulseCrop.Text = dr["PulseCropAcr"].ToString();
                    txtPulseCropAvg.Text = dr["PulseCropAvg"].ToString();
                    if (ddlPulseType.Items.FindByValue(dr["PulseCropType"].ToString()) != null)
                    {
                        ddlPulseType.Items.FindByValue(dr["PulseCropType"].ToString()).Selected = true;
                    }
                }
                if (rblOilCrop.Items.FindByValue(dr["IsOilCrop"].ToString()) != null)
                {
                    rblOilCrop.Items.FindByValue(dr["IsOilCrop"].ToString()).Selected = true;
                }
                if (rblOilCrop.SelectedValue == "Yes")
                {
                    txtOilCrop.Text = dr["OilCropAcr"].ToString();
                    txtOilCropAvg.Text = dr["OilCropAvg"].ToString();
                    if (ddlOilType.Items.FindByValue(dr["OilCropType"].ToString()) != null)
                    {
                        ddlOilType.Items.FindByValue(dr["OilCropType"].ToString()).Selected = true;
                    }
                }
                if (rblVegitables.Items.FindByValue(dr["isVegitables"].ToString()) != null)
                {
                    rblVegitables.Items.FindByValue(dr["isVegitables"].ToString()).Selected = true;
                }
                if (rblVegitables.SelectedValue == "Yes")
                {
                    txtVegitables.Text = dr["VegitablesAcr"].ToString();
                    txtVegitablesAvg.Text = dr["VegitablesAvg"].ToString();
                    if (ddlVegitableType.Items.FindByValue(dr["VegitableCropType"].ToString()) != null)
                    {
                        ddlVegitableType.Items.FindByValue(dr["VegitableCropType"].ToString()).Selected = true;
                    }
                }
                if (rblOtherCrops.Items.FindByValue(dr["IsOtherCrop"].ToString()) != null)
                {
                    rblOtherCrops.Items.FindByValue(dr["IsOtherCrop"].ToString()).Selected = true;
                }
                if (rblOtherCrops.SelectedValue == "Yes")
                {
                    txtOtherCrop.Text = dr["OtherCropsName"].ToString();
                    txtOtherCropAcr.Text = dr["OtherCropAcr"].ToString();
                    txtOtherCropAvg.Text = dr["OtherCropAvg"].ToString();
                }
                if (rblsharecropper.Items.FindByValue(dr["IsSharecrops"].ToString()) != null)
                {
                    rblsharecropper.Items.FindByValue(dr["IsSharecrops"].ToString()).Selected = true;
                }
                if (rblsharecropper.SelectedValue == "Yes")
                {
                    txtAreaofland.Text = dr["SharecropsLand"].ToString();
                }
                if (rblBuisness.Items.FindByValue(dr["Business"].ToString()) != null)
                {
                    rblBuisness.Items.FindByValue(dr["Business"].ToString()).Selected = true;
                }
                if (rblBuisness.SelectedValue == "Yes")
                {
                    if (ddlAccessService.Items.FindByValue(dr["AccessService"].ToString()) != null)
                    {
                        ddlAccessService.Items.FindByValue(dr["AccessService"].ToString()).Selected = true;
                    }
                    if (ddlAccessService.SelectedValue == "Other")
                    {
                        txtAccessService.Text = dr["AccessServiceOther"].ToString();
                    }
                }
                if (rblClimateFriendly.Items.FindByValue(dr["ClimateFriendly"].ToString()) != null)
                {
                    rblClimateFriendly.Items.FindByValue(dr["ClimateFriendly"].ToString()).Selected = true;
                }
                if (rblClimateFriendly.SelectedValue == "Yes")
                {
                    if (rblNUOM.Items.FindByValue(dr["UseofOrganicManure"].ToString()) != null)
                    {
                        rblNUOM.Items.FindByValue(dr["UseofOrganicManure"].ToString()).Selected = true;
                    }
                    if (rblNUMIF.Items.FindByValue(dr["Useofwaterconservation"].ToString()) != null)
                    {
                        rblNUMIF.Items.FindByValue(dr["Useofwaterconservation"].ToString()).Selected = true;
                    }
                    if (rblNUMC.Items.FindByValue(dr["UseofMultiCropping"].ToString()) != null)
                    {
                        rblNUMC.Items.FindByValue(dr["UseofMultiCropping"].ToString()).Selected = true;
                    }
                    if (rblNOTF.Items.FindByValue(dr["OTillageFarming"].ToString()) != null)
                    {
                        rblNOTF.Items.FindByValue(dr["OTillageFarming"].ToString()).Selected = true;
                    }
                    if (rblNDSBSR.Items.FindByValue(dr["DirectSeededRiceBSR"].ToString()) != null)
                    {
                        rblNDSBSR.Items.FindByValue(dr["DirectSeededRiceBSR"].ToString()).Selected = true;
                    }
                    if (rblNSRI.Items.FindByValue(dr["SysytemofRootIntensification"].ToString()) != null)
                    {
                        rblNSRI.Items.FindByValue(dr["SysytemofRootIntensification"].ToString()).Selected = true;
                    }
                    if (rblNCR.Items.FindByValue(dr["CarbonReduction"].ToString()) != null)
                    {
                        rblNCR.Items.FindByValue(dr["CarbonReduction"].ToString()).Selected = true;
                    }
                    if (rblNUSV.Items.FindByValue(dr["UseofSeedsVariety"].ToString()) != null)
                    {
                        rblNUSV.Items.FindByValue(dr["UseofSeedsVariety"].ToString()).Selected = true;
                    }
                    if (rblNMC.Items.FindByValue(dr["Mixedcropping"].ToString()) != null)
                    {
                        rblNMC.Items.FindByValue(dr["Mixedcropping"].ToString()).Selected = true;
                    }
                    txtOtherPracticeType.Text = dr["PracticeType"].ToString();
                }
                if (rblAttendedTrainings.Items.FindByValue(dr["HasAttendedTraining"].ToString()) != null)
                {
                    rblAttendedTrainings.Items.FindByValue(dr["HasAttendedTraining"].ToString()).Selected = true;
                }
                if (rblAttendedTrainings.SelectedValue == "Yes")
                {
                    if (ddlTraining.Items.FindByValue(dr["TrainingName"].ToString()) != null)
                    {
                        ddlTraining.Items.FindByValue(dr["TrainingName"].ToString()).Selected = true;
                    }
                    txtTrainingNo.Text = dr["TrainingFollowUps"].ToString();
                    if (ddlTraining.SelectedValue == "Other")
                    {
                        txtTrainingSpecify.Text = dr["TrainingOther"].ToString();
                    }
                }
                if (rblMoreCultivating.Items.FindByValue(dr["MoreCultivating"].ToString()) != null)
                {
                    rblMoreCultivating.Items.FindByValue(dr["MoreCultivating"].ToString()).Selected = true;
                }
                if (rblMoreCultivating.SelectedValue == "Yes")
                {
                    txtCultivatingCrop.Text = dr["CultivatingCrop"].ToString();
                }
                txtAgriUse.Text = dr["AgriUse"].ToString();
                txtProUse.Text = dr["ProUse"].ToString();
                if (rblDIKS.Items.FindByValue(dr["Demonstrate"].ToString()) != null)
                {
                    rblDIKS.Items.FindByValue(dr["Demonstrate"].ToString()).Selected = true;
                }
                txtPrecTrained.Text = dr["PercTrained"].ToString();
                txtPreTrainig.Text = dr["PreTraining"].ToString();
                txtPostTraining.Text = dr["PostTraining"].ToString();
                if (rblKOLFI.Items.FindByValue(dr["LoanObtain"].ToString()) != null)
                {
                    rblKOLFI.Items.FindByValue(dr["LoanObtain"].ToString()).Selected = true;
                }
                if (rblManageMoney.Items.FindByValue(dr["ManageMoney"].ToString()) != null)
                {
                    rblManageMoney.Items.FindByValue(dr["ManageMoney"].ToString()).Selected = true;
                }
                if (rblBuisnessDevelop.Items.FindByValue(dr["BusinessDevelop"].ToString()) != null)
                {
                    rblBuisnessDevelop.Items.FindByValue(dr["BusinessDevelop"].ToString()).Selected = true;
                }
                if (rblBuisnessDevelop.SelectedValue == "Yes")
                {
                    txtBusinessPlanType.Text = dr["TypeofBusiness"].ToString();
                }
                if (rblICTAccess.Items.FindByValue(dr["ICTAccess"].ToString()) != null)
                {
                    rblICTAccess.Items.FindByValue(dr["ICTAccess"].ToString()).Selected = true;
                }
                if (rblCropChoice.Items.FindByValue(dr["CropChoice"].ToString()) != null)
                {
                    rblCropChoice.Items.FindByValue(dr["CropChoice"].ToString()).Selected = true;
                }
                if (rblInput.Items.FindByValue(dr["Input"].ToString()) != null)
                {
                    rblInput.Items.FindByValue(dr["Input"].ToString()).Selected = true;
                }
                if (rblDeciding.Items.FindByValue(dr["Deciding"].ToString()) != null)
                {
                    rblDeciding.Items.FindByValue(dr["Deciding"].ToString()).Selected = true;
                }
                if (rblTimimg.Items.FindByValue(dr["Timing"].ToString()) != null)
                {
                    rblTimimg.Items.FindByValue(dr["Timing"].ToString()).Selected = true;
                }
                if (rblDecidingTime.Items.FindByValue(dr["DecidingTime"].ToString()) != null)
                {
                    rblDecidingTime.Items.FindByValue(dr["DecidingTime"].ToString()).Selected = true;
                }
                if (rblHarvesting.Items.FindByValue(dr["Harvesting"].ToString()) != null)
                {
                    rblHarvesting.Items.FindByValue(dr["Harvesting"].ToString()).Selected = true;
                }
                if (rblSaleLand.Items.FindByValue(dr["SaleLand"].ToString()) != null)
                {
                    rblSaleLand.Items.FindByValue(dr["SaleLand"].ToString()).Selected = true;
                }
                if (rblSoWomen.Items.FindByValue(dr["SoWomen"].ToString()) != null)
                {
                    rblSoWomen.Items.FindByValue(dr["SoWomen"].ToString()).Selected = true;
                }
                if (rblSoMaterial.Items.FindByValue(dr["SoMaterial"].ToString()) != null)
                {
                    rblSoMaterial.Items.FindByValue(dr["SoMaterial"].ToString()).Selected = true;
                }
                if (rblSoAgro.Items.FindByValue(dr["SoAgro"].ToString()) != null)
                {
                    rblSoAgro.Items.FindByValue(dr["SoAgro"].ToString()).Selected = true;
                }
                if (rblSoSelling.Items.FindByValue(dr["SoSelling"].ToString()) != null)
                {
                    rblSoSelling.Items.FindByValue(dr["SoSelling"].ToString()).Selected = true;
                }
                if (rblSoExpenditure.Items.FindByValue(dr["SoExpenditure"].ToString()) != null)
                {
                    rblSoExpenditure.Items.FindByValue(dr["SoExpenditure"].ToString()).Selected = true;
                }
                if (rblJoWomen.Items.FindByValue(dr["JoWomen"].ToString()) != null)
                {
                    rblJoWomen.Items.FindByValue(dr["JoWomen"].ToString()).Selected = true;
                }
                if (rblJoMaterial.Items.FindByValue(dr["JoMaterial"].ToString()) != null)
                {
                    rblJoMaterial.Items.FindByValue(dr["JoMaterial"].ToString()).Selected = true;
                }
                if (rblJoAgro.Items.FindByValue(dr["JoAgro"].ToString()) != null)
                {
                    rblJoAgro.Items.FindByValue(dr["JoAgro"].ToString()).Selected = true;
                }
                if (rblJoSelling.Items.FindByValue(dr["JoSelling"].ToString()) != null)
                {
                    rblJoSelling.Items.FindByValue(dr["JoSelling"].ToString()).Selected = true;
                }
                if (rblJoExpenditure.Items.FindByValue(dr["JoExpenditure"].ToString()) != null)
                {
                    rblJoExpenditure.Items.FindByValue(dr["JoExpenditure"].ToString()).Selected = true;
                }
                if (rblOnFarm.Items.FindByValue(dr["OnFarm"].ToString()) != null)
                {
                    rblOnFarm.Items.FindByValue(dr["OnFarm"].ToString()).Selected = true;
                }
                if (rblOffFarm.Items.FindByValue(dr["OffFarm"].ToString()) != null)
                {
                    rblOffFarm.Items.FindByValue(dr["OffFarm"].ToString()).Selected = true;
                }
                if (rblShareHolder.Items.FindByValue(dr["ShareHolder"].ToString()) != null)
                {
                    rblShareHolder.Items.FindByValue(dr["ShareHolder"].ToString()).Selected = true;
                }
                if (rblShareHolder.SelectedValue == "Yes")
                {
                    if (ddlFPCName.Items.FindByValue(dr["FPCID"].ToString()) != null)
                    {
                        ddlFPCName.Items.FindByValue(dr["FPCID"].ToString()).Selected = true;
                    }
                    txtFPCShares.Text = dr["FPCShares"].ToString();
                }
                if (rblFinance.Items.FindByValue(dr["Financialliteracy"].ToString()) != null)
                {
                    rblFinance.Items.FindByValue(dr["Financialliteracy"].ToString()).Selected = true;
                }
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

            string tablequery = "UPDATE tblWFsYearData SET WFno=" + ddlWF.SelectedValue + ", Year='" + Year + "', Business='" + isBusinessService + "', AccessService='" + BusinessServiceName + "', AccessServiceOther='" + BusinessServicceeOther + "', ClimateFriendly='" + ClimateAgriculture + "', UseofOrganicManure='" + NUOM + "' , Useofwaterconservation='" + NUMIF + "', UseofMultiCropping='" + NUMC + "',  OTillageFarming='" + NOTF + "', DirectSeededRiceBSR='" + NDSBSR + "', SysytemofRootIntensification='" + NSRI + "', CarbonReduction='" + NCR + "', UseofSeedsVariety='" + NUSV + "', Mixedcropping='" + NMC + "', PracticeType='" + OtherPractivce + "', MoreCultivating='" + MoreCultivating + "', CultivatingCrop='" + CultivatingCrop + "', AgriUse='" + AgriUse + "', ProUse='" + ProUse + "', Demonstrate='" + DIKS + "', PercTrained='" + PrecTrained + "', PreTraining='" + PreTrainig + "', PostTraining='" + PostTraining + "', LoanObtain='" + KnowLoanObtain + "', ManageMoney='" + ManageMoney + "', BusinessDevelop='" + BuisnessDevelop + "', TypeofBusiness='" + TypeofBusiness + "', ICTAccess='" + ICTAccess + "', OnFarm='" + OnFarm + "', OffFarm='" + OffFarm + "', CropChoice='" + CropChoice + "', Input='" + Input + "', Deciding='" + Deciding + "', Timing='" + Timimg + "', DecidingTime='" + DecidingTime + "', Harvesting='" + Harvesting + "', SaleLand='" + SaleLand + "', SoWomen='" + SoWomen + "', SoMaterial='" + SoMaterial + "', SoAgro='" + SoAgro + "', SoSelling='" + SoSelling + "', SoExpenditure='" + SoExpenditure + "', JoWomen='" + JoWomen + "', JoMaterial='" + JoMaterial + "', JoAgro='" + JoAgro + "', JoSelling='" + JoSelling + "', JoExpenditure='" + JoExpenditure + "', ShareHolder='" + ShareHolder + "', FPCName='" + FPCName + "', FPCID=" + FPCID + ", FPCShares='" + NoofShares + "', MajorSourceofFamily='" + MajorSource + "', OtherMajorSource='" + OtehrSource + "', MajorSourceIncome='" + SourceIncome + "', isMNREGA='" + MNREGA + "', MNREGADays='" + MNREGADays + "', IsWomenLaboure='" + isLabour + "', NatureofWork='" + LabourNature + "', IsBenefit='" + isBenfits + "', NameofBenefitScheme='" + BenfitName + "', OtherBenefitSchemeName='" + OtherBenfit + "', BenefitIncome='" + BenfitAmount + "', isLivestock='" + isLivestock + "', NumberOfLiveStock='" + NoofLiveStock + "', CowLivestock='" + Cow + "', BuffaloLivestock='" + Buffalo + "', GoatLivestock='" + Goat + "', PoultryLivestock='" + Poultry + "', MilkLivestock='" + Milk + "', OtherLivestock='" + OtherLivestock + "', islandinthenameofwoman='" + isOwnlandSelfName + "', OwnLandSelfName='" + OwnlandSelfName + "', OwnLand='" + OtherOwnland + "', RentalLand='" + RentalLand + "', TotalLandinHectors='" + TotalLand + "', IsIrrigatedLand='" + isIrrigationLand + "', irrigatedLandinAcr='" + IrrigationLand + "', SourceofIrrigation='" + IrrigationSource + "', SourceOfIrrigationOther='" + OtherIrrigationSource + "', NonIrrigated='" + NonIrrigationLand + "', IsOwnershipinLand='" + isOwnershipinland + "', AreaofOwnershipLand='" + OwnershipLand + "', DemoPlot='" + DemoPlot + "', IsGovScheme='" + isGovScheme + "', GovSchemeName='" + SchemeName + "', GovSchemeAmount='" + SchemeAmount + "', IsPaddy='" + isPaddy + "', PaddyAcr='" + Paddy + "', PaddyAvg='" + PaddyAvg + "', isWheat='" + IsWheat + "', WheatAcr='" + Wheat + "', WheatAvg='" + WheatAvg + "', isPulseCrop='" + isPulse + "', PulseCropAcr ='" + Pulse + "', PulseCropAvg='" + PulseAvg + "', PulseCropType='" + PulseType + "', IsOilCrop='" + isOil + "', OilCropAcr='" + Oil + "', OilCropAvg='" + OilAvg + "', OilCropType='" + OilType + "', isVegitables='" + isVegitables + "', VegitablesAcr='" + Vegitables + "', VegitablesAvg='" + VegitablesAvg + "', VegitableCropType='" + VegitablesType + "',  IsOtherCrop='" + isOthercrops + "', OtherCropsName='" + Othercrops + "', OtherCropAcr='" + OthercropAcr + "', OtherCropAvg='" + OthercropAvg + "',  IsSharecrops='" + isShareCropper + "', SharecropsLand='" + ShareCropLand + "', HasAttendedTraining='" + isTrainingAttended + "', TrainingName='" + TrainingName + "', TrainingOther='" + OtherTrainingName + "', TrainingFollowUps='" + NoofFallowUps + "',Financialliteracy='" + Financialliteracy + "', TotalAnualIncome='" + TotalIncome + "' where WFDataID=" + Session["WFDataID"];
            if (db.UpdateQuery(tablequery, "", "", "") > 0)
            {
                if (rblWantFPC.SelectedValue == "Yes")
                {
                    string query1 = "select * from tblWFs where WFno = " + ddlWF.SelectedValue + "";
                    DataSet ds1 = db.getResultset(query1, "", "", "");

                    if (ds1 != null && ds1.Tables[0].Rows.Count > 0)
                    {
                        string fpcinsert = "update tblFPCMembers set State='" + ddlstate.SelectedValue + "', District='" + ddlDistrict.SelectedValue + "', Block='" + ddlBlock.SelectedValue + "', Village='" + ddlVillage.SelectedValue + "', FPCName='" + ddlFPCName1.SelectedValue + "', MemberName='" + ddlWF.SelectedItem.Text + "', FatherorHusbandName='" + ds1.Tables[0].Rows[0]["HusbandName"] + "', Age='" + ds1.Tables[0].Rows[0]["Age"] + "', Category='" + ds1.Tables[0].Rows[0]["SocialCategory"] + "', EducationalQualification='" + ds1.Tables[0].Rows[0]["Qualification"] + "', ContactNo='" + ds1.Tables[0].Rows[0]["ContactNumber"] + "', AadhaarNo='" + ds1.Tables[0].Rows[0]["AdharNo"] + "', DateofJoiningFPC='" + DateTime.Now + "'";
                        db.UpdateQuery(fpcinsert, "", "", "");
                        ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "ShowAlert('Added Details Successfully.','success')", true);
                    }
                }
                ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "ShowAlert('Updated Details Successfully.','success')", true);
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
                string query = "select * from tblWFsYearData where Year='" + txtYear.Text + "' and Wfno=" + ddlWF.SelectedValue + " and WFDataID !=" + Session["WFDataID"];
                DataSet ds = db.getResultset(query, "", "", "");
                if (ds != null && ds.Tables[0].Rows.Count > 0)
                {
                    txtYear.Text = "";
                    ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "ShowAlert('Selected Year has already existed in the data.','error')", true);
                }
            }
        }

        protected void rblWantFPC_SelectedIndexChanged(object sender, EventArgs e)
        {
            string str = rblWantFPC.SelectedValue;
            if (str == "Yes")
            {
                string query = "select FPCName from tblFPCRegistration";
                DataSet ds = db.getResultset(query, "", "", "");

                if (ds != null && ds.Tables[0].Rows.Count > 0)
                {
                    ddlFPCName1.DataSource = ds;
                    ddlFPCName1.DataValueField = "FPCName";
                    ddlFPCName1.DataTextField = "FPCName";
                    ddlFPCName1.DataBind();
                    ddlFPCName1.Items.Insert(0, "Select");
                }
                dvFPCName.Visible = true;
            }
            else
            {
                dvFPCName.Visible = false;
            }

        }
    }
}






