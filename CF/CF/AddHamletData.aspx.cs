using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CF
{
    public partial class AddHamletData : System.Web.UI.Page
    {
        DbErrorLog db = new DbErrorLog();
        protected void Page_Load(object sender, EventArgs e)
        {
            Page.UnobtrusiveValidationMode = UnobtrusiveValidationMode.None;
            if (Session["Hid"] != null)
            {
                if (!IsPostBack)
                {
                    loaddata();
                }
            }
            else
            {
                Response.Redirect("~/HamletDataInfo.aspx");
            }
        }

        public void loaddata()
        {
            string query = "select Vid,StateName,Village,CSOName,Block,District, b.GramPanchayatName, b.[VillageID],[NameofHamlet],[NameofGramPanchayat],[PostofficeName],[DistancefromPostoffice],[BlockName],[DistanceofBlockfromVillage],[PolicestationName],[DistanceofPolicestation],[SubdistrictName],[DistanceofSubdistrict],[DistrictName],[DistanceofDistrict],[PostOfficepin],[DistancefromGramPanchayat],[DistanceofVillage] from tblHamletInfo a left outer join tblVillageInfo b on a.Villageid=b.Vid left outer join tblVillages c on b.villageID = c.villageID left outer join tblCSO d on b.CSOID=d.CSOID left outer join tblBlocks e on e.BlockID = d.BlockID left outer join tblDistricts f on f.DistrictID =d.DistrictID left outer join tblStates g on g.StateId=f.StateID where Hid = " + Session["Hid"];
            DataSet Datads = db.getResultset(query, "", "", "");
            if (Datads != null && Datads.Tables[0].Rows.Count > 0)
            {
                string Villageid = Session["Vid"].ToString();
                txtCSO.Text = Datads.Tables[0].Rows[0]["CSOName"].ToString();
                txtState.Text = Datads.Tables[0].Rows[0]["StateName"].ToString();
                txtDistrict.Text = Datads.Tables[0].Rows[0]["District"].ToString();
                txtBlock.Text = Datads.Tables[0].Rows[0]["Block"].ToString();
                txtvillagename.Text = Datads.Tables[0].Rows[0]["Village"].ToString();
                txtGramPanchayat.Text = Datads.Tables[0].Rows[0]["GramPanchayatName"].ToString();

                txtHamlet.Text = Datads.Tables[0].Rows[0]["NameofHamlet"].ToString();
                txtDistrict.Text = Datads.Tables[0].Rows[0]["DistrictName"].ToString(); ;
                txtdistDistrictdistance.Text = Datads.Tables[0].Rows[0]["DistanceofDistrict"].ToString(); ;
                txtsubdist.Text = Datads.Tables[0].Rows[0]["SubdistrictName"].ToString();
                txtDistsubdist.Text = Datads.Tables[0].Rows[0]["DistanceofSubdistrict"].ToString();
                txtBlock.Text = Datads.Tables[0].Rows[0]["BlockName"].ToString();
                txtDistBlock.Text = Datads.Tables[0].Rows[0]["DistanceofBlockfromVillage"].ToString();
                txtGramPanchayat.Text = Datads.Tables[0].Rows[0]["NameofGramPanchayat"].ToString();
                txtDistvillagename.Text = Datads.Tables[0].Rows[0]["DistanceofVillage"].ToString();
                txtDistGramPanchayat.Text = Datads.Tables[0].Rows[0]["DistancefromGramPanchayat"].ToString();
                txtPostoffice.Text = Datads.Tables[0].Rows[0]["PostofficeName"].ToString();
                txtDistPostoffice.Text = Datads.Tables[0].Rows[0]["DistancefromPostoffice"].ToString();
                txtPoliceStation.Text = Datads.Tables[0].Rows[0]["PolicestationName"].ToString();
                txtDistPoliceStation.Text = Datads.Tables[0].Rows[0]["DistanceofPolicestation"].ToString();
                txtpostpin.Text = Datads.Tables[0].Rows[0]["PostOfficepin"].ToString();
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            string Villageid = Session["Vid"].ToString();
            string SCHH = txtSCHH.Text;
            string STHH = txtSTHH.Text;
            string OBCHH = txtOBCHH.Text;
            string GeneralHH = txtGenHH.Text;
            //string MinorityHH = txtMinHH.Text;
            string SCpop = txtsc.Text;
            string STpop = txtst.Text;
            string OBCpop = txtobc.Text;
           // string Minoritypop = txtminority.Text;
            string Generalpop = txtgeneral.Text;
            string Population = txtPopulation.Text;
            string malepop = txtmalePop.Text;
            string femalepop = txtfemalePop.Text;
            string boyspop = txtboyPop.Text;
            string girlspop = txtgirlsPop.Text;
            string Transgengerpop = txttransgenderPop.Text;
            string TotalLand = txttotalland.Text;
            string CultivableLand = txtcultiland.Text;
            string LandPloughing = txtlandplough.Text;
            string IrrigatedLand = txtirrgate.Text;
            string UniriigateLand = txtunirrgate.Text;
            string landForest = txtforestland.Text;
            string WasteLand = txtwasteland.Text;
            string pastureLand = txtpastureland.Text;
            string Otherland = txtotherland.Text;
            string landupto1acr = txtlessthanoneland.Text;
            string land1to2hec = txtonetotwo.Text;
            string land2to4hec = txt2to4.Text;
            string landmorethan4 = txtMorethen4.Text;
            string Landless = txtlandless.Text;
            string Jan = txtJan.Text;
            string Feb = txtFeb.Text;
            string Mar = txtMar.Text;
            string Apr = txtApr.Text;
            string May = txtMay.Text;
            string Jun = txtJun.Text;
            string Jul = txtJul.Text;
            string Aug = txtAug.Text;
            string Sep = txtSep.Text;
            string Oct = txtOct.Text;
            string Nov = txtNov.Text;
            string Dec = txtDec.Text;
            string AveragewaterLevel = txtavgwtrlvl.Text;
            string AverageWaterTDSinDrinkingSource = txtwtrTDS.Text;
            string DWSPublicWells = txtPublicwalls.Text;
            string DWSPrivateWells = txtPrivatewalls.Text;
            string DWSPublicHandPumps = txtPublichandPumps.Text;
            string DWSPrivateHandPumps = txtPrivateHandPumps.Text;
            string DWSPublicTaps = txtPublicTaps.Text;
            string DWSPublicPonds = txtPublicPonds.Text;
            string DWSCanal = txtCanal.Text;
            string DWSPublicTubewell = txtPublicTubwell.Text;
            string DWSPrivateTubwell = txtPrivateTubwell.Text;
            string DWSDieselPumps = txtDieselPumps.Text;
            // string DWSOther= TextBox108.Text;
            // Working source
            string WSPublicWells = txtWSPublicWells.Text;
            string WSPrivateWells = txtWSPrivateWell.Text;
            string WSPublicHandPumps = txtWSPublicHandPump.Text;
            string WSPrivateHandPumps = txtWSPrivateHandPump.Text;
            string WSPublicTaps = txtWSPublicTaps.Text;
            string WSPublicPonds = txtWSPublicPonds.Text;
            string WSCanal = txtWSCanal.Text;
            string WSPublicTubewell = txtWSPublicTubWell.Text;
            string WSPrivateTubwell = txtWSPrivateTubwell.Text;
            string WSDieselPumps = txtWSDieselPump.Text;
            string WSOther = txtWSOtherPumpset.Text;
            string CHCSubcentreorANM = string.Empty;
            if (rblCHCSubcentreorANM.SelectedValue != null)
            {
                CHCSubcentreorANM = rblCHCSubcentreorANM.SelectedValue;
            }
            string CHCPHC = string.Empty;
            if (rblCHCPHC.SelectedValue != null)
            {
                CHCPHC = rblCHCPHC.SelectedValue;
            }
            string CHCCHC = string.Empty;
            if (rblCHCCHC.SelectedValue != null)
            {
                CHCCHC = rblCHCCHC.SelectedValue;
            }
            string CHCPrivateClinic = string.Empty;
            if (rblCHCPrivateClinic.SelectedValue != null)
            {
                CHCPrivateClinic = rblCHCPrivateClinic.SelectedValue;
            }
            string CHCAnimalDispensary = string.Empty;
            if (rblCHCAnimalDispensary.SelectedValue != null)
            {
                CHCAnimalDispensary = rblCHCAnimalDispensary.SelectedValue;
            }
            string CHCVolunteerhealthworker = string.Empty;
            if (rblCHCVolunteerhealthworker.SelectedValue != null)
            {
                CHCVolunteerhealthworker = rblCHCVolunteerhealthworker.SelectedValue;
            }
            string QSSubcentreorANM = ddlQSSubcentreorANM.SelectedValue;
            string QSPHC = ddlQSPHC.SelectedValue;
            string QSCHC = ddlQSCHC.SelectedValue;
            string QSPrivateClinic = ddlQSPrivateClinic.SelectedValue;
            string QSAnimalDispensary = ddlQSAnimalDispensary.SelectedValue;
            string QSVolunteerhealthworker = ddlQSVolunteerhealthworker.SelectedValue;
            string OpenDefecation = txtOpenDefecation.Text;
            string HHsWithToilets = txtHHToilets.Text;
            string HHsUtilizingToilets = txtHHUtilizingToilets.Text;
            string HHsPublicToilets = txtHHPublicToilets.Text;
            string HHsWithDrainage = txtHHDrainage.Text;

            string PrimarySchool = rblPrimaryScholDetails.SelectedValue;
            string PrimarySchoolDistance = "";
            string PrimaryCshoolBoys = "";
            string PrimarySchoolGirls = "";
            string PrimarySchoolTransgender = "";
            string PrimarySchoolTotal = "";
            string PrimaryNeverAttendedBoys = "";
            string PrimaryNeverAttendedGirls = "";
            string PrimaryBoysDropped = "";
            string PrimaryGuirlsDropped = "";
            string PrimaryBoysGoing = "";
            string PrimaryGirlsGoing = "";
            string Primary6to11Boys = "";
            string Primary6to11Girls = "";
            string PrimaryLiteracyStatus = "";
            if (PrimarySchool == "Yes")
            {
                PrimarySchoolDistance = txtPrimarySchoolDistance.Text;
                PrimaryCshoolBoys = txtPrimaryCshoolBoys.Text;
                PrimarySchoolGirls = txtPrimarySchoolGirls.Text;
                PrimarySchoolTransgender = txtPrimarySchoolTransgender.Text;
                PrimarySchoolTotal = txtPrimarySchoolTotal.Text;
                PrimaryNeverAttendedBoys = txtPrimaryNeverAttendedBoys.Text;
                PrimaryNeverAttendedGirls = txtPrimaryNeverAttendedGirls.Text;
                PrimaryBoysDropped = txtPrimaryBoysDropped.Text;
                PrimaryGuirlsDropped = txtPrimaryGuirlsDropped.Text;
                PrimaryBoysGoing = txtPrimaryBoysGoing.Text;
                PrimaryGirlsGoing = txtPrimaryGirlsGoing.Text;
                Primary6to11Boys = txtPrimary6to11Boys.Text;
                Primary6to11Girls = txtPrimary6to11Girls.Text;
                PrimaryLiteracyStatus = txtPrimaryLiteracyStatus.Text;
            }

            string UpperPrimarySchool = rblUpperPrimary.SelectedValue;
            string UpperPrimarySchoolDistance = "";
            string UpperPrimaryCshoolBoys = "";
            string UpperPrimarySchoolGirls = "";
            string UpperPrimarySchoolTransgender = "";
            string UpperPrimarySchoolTotal = "";
            string UpperPrimaryNeverAttendedBoys = "";
            string UpperPrimaryNeverAttendedGirls = "";
            string UpperPrimaryBoysDropped = "";
            string UpperPrimaryGuirlsDropped = "";
            string UpperPrimaryBoysGoing = "";
            string UpperPrimaryGirlsGoing = "";
            string UpperPrimary6to11Boys = "";
            string UpperPrimary6to11Girls = "";
            string UpperPrimaryLiteracyStatus = "";
            if (UpperPrimarySchool == "Yes")
            {
                UpperPrimarySchoolDistance = txtUpperPrimarySchoolDistance.Text;
                UpperPrimaryCshoolBoys = txtUpperPrimaryCshoolBoys.Text;
                UpperPrimarySchoolGirls = txtUpperPrimarySchoolGirls.Text;
                UpperPrimarySchoolTransgender = txtUpperPrimarySchoolTransgender.Text;
                UpperPrimarySchoolTotal = txtUpperPrimarySchoolTotal.Text;
                UpperPrimaryNeverAttendedBoys = txtUpperPrimaryNeverAttendedBoys.Text;
                UpperPrimaryNeverAttendedGirls = txtUpperPrimaryNeverAttendedGirls.Text;
                UpperPrimaryBoysDropped = txtUpperPrimaryBoysDropped.Text;
                UpperPrimaryGuirlsDropped = txtUpperPrimaryGuirlsDropped.Text;
                UpperPrimaryBoysGoing = txtUpperPrimaryBoysGoing.Text;
                UpperPrimaryGirlsGoing = txtUpperPrimaryGirlsGoing.Text;
                UpperPrimary6to11Boys = txtUpperPrimary6to11Boys.Text;
                UpperPrimary6to11Girls = txtUpperPrimary6to11Girls.Text;
                UpperPrimaryLiteracyStatus = txtUpperPrimaryLiteracyStatus.Text;
            }

            string SecondarySchool = rblSecondary.SelectedValue;
            string SecondarySchoolDistance = "";
            string SecondaryCshoolBoys = "";
            string SecondarySchoolGirls = "";
            string SecondarySchoolTransgender = "";
            string SecondarySchoolTotal = "";
            string SecondaryNeverAttendedBoys = "";
            string SecondaryNeverAttendedGirls = "";
            string SecondaryBoysDropped = "";
            string SecondaryGuirlsDropped = "";
            string SecondaryBoysGoing = "";
            string SecondaryGirlsGoing = "";
            string Secondary6to11Boys = "";
            string Secondary6to11Girls = "";
            string SecondaryLiteracyStatus = "";
            if (SecondarySchool == "Yes")
            {
                SecondarySchoolDistance = txtSecondarySchoolDistance.Text;
                SecondaryCshoolBoys = txtSecondaryCshoolBoys.Text;
                SecondarySchoolGirls = txtSecondarySchoolGirls.Text;
                SecondarySchoolTransgender = txtSecondarySchoolTransgender.Text;
                SecondarySchoolTotal = txtSecondarySchoolTotal.Text;
                SecondaryNeverAttendedBoys = txtSecondaryNeverAttendedBoys.Text;
                SecondaryNeverAttendedGirls = txtSecondaryNeverAttendedGirls.Text;
                SecondaryBoysDropped = txtSecondaryBoysDropped.Text;
                SecondaryGuirlsDropped = txtSecondaryGuirlsDropped.Text;
                SecondaryBoysGoing = txtSecondaryBoysGoing.Text;
                SecondaryGirlsGoing = txtSecondaryGirlsGoing.Text;
                Secondary6to11Boys = txtSecondary6to11Boys.Text;
                Secondary6to11Girls = txtSecondary6to11Girls.Text;
                SecondaryLiteracyStatus = txtSecondaryLiteracyStatus.Text;
            }

            string HigherSecondarySchool = rblHigherSecondary.SelectedValue;
            string HigherSecondarySchoolDistance = "";
            string HigherSecondaryCshoolBoys = "";
            string HigherSecondarySchoolGirls = "";
            string HigherSecondarySchoolTransgender = "";
            string HigherSecondarySchoolTotal = "";
            string HigherSecondaryNeverAttendedBoys = "";
            string HigherSecondaryNeverAttendedGirls = "";
            string HigherSecondaryBoysDropped = "";
            string HigherSecondaryGuirlsDropped = "";
            string HigherSecondaryBoysGoing = "";
            string HigherSecondaryGirlsGoing = "";
            string HigherSecondary6to11Boys = "";
            string HigherSecondary6to11Girls = "";
            string HigherSecondaryLiteracyStatus = "";
            if (HigherSecondarySchool == "Yes")
            {
                HigherSecondarySchoolDistance = txtHigherSecondarySchoolDistance.Text;
                HigherSecondaryCshoolBoys = txtHigherSecondaryCshoolBoys.Text;
                HigherSecondarySchoolGirls = txtHigherSecondarySchoolGirls.Text;
                HigherSecondarySchoolTransgender = txtHigherSecondarySchoolTransgender.Text;
                HigherSecondarySchoolTotal = txtHigherSecondarySchoolTotal.Text;
                HigherSecondaryNeverAttendedBoys = txtHigherSecondaryNeverAttendedBoys.Text;
                HigherSecondaryNeverAttendedGirls = txtHigherSecondaryNeverAttendedGirls.Text;
                HigherSecondaryBoysDropped = txtHigherSecondaryBoysDropped.Text;
                HigherSecondaryGuirlsDropped = txtHigherSecondaryGuirlsDropped.Text;
                HigherSecondaryBoysGoing = txtHigherSecondaryBoysGoing.Text;
                HigherSecondaryGirlsGoing = txtHigherSecondaryGirlsGoing.Text;
                HigherSecondary6to11Boys = txtHigherSecondary6to11Boys.Text;
                HigherSecondary6to11Girls = txtHigherSecondary6to11Girls.Text;
                HigherSecondaryLiteracyStatus = txtHigherSecondaryLiteracyStatus.Text;
            }

            string MadrasaSchool = rblMadrasa.SelectedValue;
            string MadrasaSchoolDistance = "";
            string MadrasaCshoolBoys = "";
            string MadrasaSchoolGirls = "";
            string MadrasaSchoolTransgender = "";
            string MadrasaSchoolTotal = "";
            string MadrasaNeverAttendedBoys = "";
            string MadrasaNeverAttendedGirls = "";
            string MadrasaBoysDropped = "";
            string MadrasaGuirlsDropped = "";
            string MadrasaBoysGoing = "";
            string MadrasaGirlsGoing = "";
            string Madrasa6to11Boys = "";
            string Madrasa6to11Girls = "";
            string MadrasaLiteracyStatus = "";
            if (MadrasaSchool == "Yes")
            {
                MadrasaSchoolDistance = txtMadrasaSchoolDistance.Text;
                MadrasaCshoolBoys = txtMadrasaCshoolBoys.Text;
                MadrasaSchoolGirls = txtMadrasaSchoolGirls.Text;
                MadrasaSchoolTransgender = txtMadrasaSchoolTransgender.Text;
                MadrasaSchoolTotal = txtMadrasaSchoolTotal.Text;
                MadrasaNeverAttendedBoys = txtMadrasaNeverAttendedBoys.Text;
                MadrasaNeverAttendedGirls = txtMadrasaNeverAttendedGirls.Text;
                MadrasaBoysDropped = txtMadrasaBoysDropped.Text;
                MadrasaGuirlsDropped = txtMadrasaGuirlsDropped.Text;
                MadrasaBoysGoing = txtMadrasaBoysGoing.Text;
                MadrasaGirlsGoing = txtMadrasaGirlsGoing.Text;
                Madrasa6to11Boys = txtMadrasa6to11Boys.Text;
                Madrasa6to11Girls = txtMadrasa6to11Girls.Text;
                MadrasaLiteracyStatus = txtMadrasaLiteracyStatus.Text;
            }

            string Widows = txtWidows.Text;
            string DistributionCard = txtDistributionCards.Text;
            string AtlaScheme = txtAtlaScheme.Text;
            string AccidentalInsurance = txtAccidentalInsurance.Text;
            string LifeInsurance = txtLifeInsurance.Text;
            string LabourCard = txtLabourCard.Text;
            string WSHGs = txtWSHGs.Text;
            string WSHGName = txtNameofWSHGs.Text;
            string WSHGMembers = txtWSHGmembers.Text;
            string WFGs = txtWFGs.Text;
            string WFGMembers = txtWFGMembers.Text;
            string OtherCBO = txtOtherCBO.Text;
            string CBOMembers = txtOtherCBOMembers.Text;
            string Electricity = ddlElectricity.SelectedValue;
            string LPG = txtLPGs.Text;
            string Majorneeds = txtMajorNeeds.Text;


            string InsertHamlet = "INSERT INTO [dbo].[tblHamletData] ([Hid],[Year],[Rank],[ElectricityFacility],[HouseholdhavingLPG],[MajorsectorwiseNeeds],[NoofWomenSelfHelpGroupsformedinthevillage],[NameoftheWSHGs],[TotalNoofmembersinWSHGs],[NoofWomenFarmersGroups],[TotalNoofmembersinWFGs],[NoofOtherCBOsNariSanghWomenHealthGroups],[TotalNoofmembersinotherCBOs],[NooffamilieshavingWidowsorDisabilities],[Publicdistributionsystemcards],[HouseholdcoverwithAtalPensionScheme],[Householdcoverwithaccidentalinsurance],[Householdcoverwithlifeinsurance],[Householdhavinglabourregistrationcard],[TotalLand],[CultivableLand],[PloughingLand],[IrrigatedLand],[UnirrigatedLand],[LandInderForest],[WasteLand],[PastureLand],[OtherLand],[NoofFamilieshavenoLand],[OverallVillageOpenDefecation],[HHsWithToilets],[HHsUtilizingToilets],[HHsusingPublicToilets],[HHsConnectedWithDrainage],[AveragewaterLevel],[AverageWaterTDSinDrinkingSource],[DWSPublicWells],[DWSPrivateWells],[DWSPublicHandPumps],[DWSPrivateHandPumps],[DWSPublicTaps],[DWSPublicPonds],[DWSCanal],[DWSPublicTubewell],[DWSPrivateTubwell],[DWSDieselPumps],[WSPublicWells],[WSPrivateWells],[WSPublicHandPumps],[WSPrivateHandPumps],[WSPublicTaps],[WSPublicPonds],[WSCanal],[WSPublicTubewell],[WSPrivateTubwell],[WSDieselPumps],[WSOther],[TotalPopulation],[MalePopulation],[FemalePopulation],[SCPopulation],[STPopulation],[OBCPopulation],[GemeralPopulation],[Jan],[Feb],[Mar],[Apr],[May],[Jun],[Jul],[Aug],[Sep],[Oct],[Nov],[Dec],[ConditionofHealthCentresSubcentreorANM],[ConditionofHealthCentresPHC],[ConditionofHealthCentresCHC],[ConditionofHealthCentresPrivateClinic],[ConditionofHealthCentresAnimalDispensary],[ConditionofHealthCentresVolunteerhealthworker],[QualityofservicesSubcentreorANM],[QualityofservicesPHC],[QualityofservicesCHC],[QualityofservicesPrivateClinic],[QualityofservicesAnimalDispensary],[QualityofservicesVolunteerhealthworker],[BoysPopulation],[GirlsPopulation],[TransgenderPopulation],[PrimarySchool],[PrimarySchoolDistance],[PrimaryCshoolBoys],[PrimarySchoolGirls],[PrimarySchoolTransgender],[PrimarySchoolTotal],[PrimaryNeverAttendedBoys],[PrimaryNeverAttendedGirls],[PrimaryBoysDropped],[PrimaryGuirlsDropped],[PrimaryBoysGoing],[PrimaryGirlsGoing],[Primary6to11Boys],[Primary6to11Girls],[PrimaryLiteracyStatus],[UpperPrimarySchool],[UpperPrimarySchoolDistance],[UpperPrimaryCshoolBoys],[UpperPrimarySchoolGirls],[UpperPrimarySchoolTransgender],[UpperPrimarySchoolTotal],[UpperPrimaryNeverAttendedBoys],[UpperPrimaryNeverAttendedGirls],[UpperPrimaryBoysDropped],[UpperPrimaryGuirlsDropped],[UpperPrimaryBoysGoing],[UpperPrimaryGirlsGoing],[UpperPrimary6to11Boys],[UpperPrimary6to11Girls],[UpperPrimaryLiteracyStatus],[SecondarySchool],[SecondarySchoolDistance],[SecondaryCshoolBoys],[SecondarySchoolGirls],[SecondarySchoolTransgender],[SecondarySchoolTotal],[SecondaryNeverAttendedBoys],[SecondaryNeverAttendedGirls],[SecondaryBoysDropped],[SecondaryGuirlsDropped],[SecondaryBoysGoing],[SecondaryGirlsGoing],[Secondary6to11Boys],[Secondary6to11Girls],[SecondaryLiteracyStatus],[HigherSecondarySchool],[HigherSecondarySchoolDistance],[HigherSecondaryCshoolBoys],[HigherSecondarySchoolGirls],[HigherSecondarySchoolTransgender],[HigherSecondarySchoolTotal],[HigherSecondaryNeverAttendedBoys],[HigherSecondaryNeverAttendedGirls],[HigherSecondaryBoysDropped],[HigherSecondaryGuirlsDropped],[HigherSecondaryBoysGoing],[HigherSecondaryGirlsGoing],[HigherSecondary6to11Boys],[HigherSecondary6to11Girls],[HigherSecondaryLiteracyStatus],[MadrasaSchool],[MadrasaSchoolDistance],[MadrasaCshoolBoys],[MadrasaSchoolGirls],[MadrasaSchoolTransgender],[MadrasaSchoolTotal],[MadrasaNeverAttendedBoys],[MadrasaNeverAttendedGirls],[MadrasaBoysDropped],[MadrasaGuirlsDropped],[MadrasaBoysGoing],[MadrasaGirlsGoing],[Madrasa6to11Boys],[Madrasa6to11Girls],[MadrasaLiteracyStatus],STHH,OBCHH,GeneralHH, landupto1acr, land1to2hec, land2to4hec, landmorethan4) VALUES(" + Session["Hid"] + ",'" + txtYear.Text + "','" + txtRanking.Text + "','" + Electricity + "','" + LPG + "','" + Majorneeds + "','" + WSHGs + "','" + WSHGName + "','" + WSHGMembers + "','" + WFGs + "','" + WFGMembers + "','" + OtherCBO + "','" + CBOMembers + "','" + Widows + "','" + DistributionCard + "','" + AtlaScheme + "','" + AccidentalInsurance + "','" + LifeInsurance + "','" + LabourCard + "','" + TotalLand + "','" + CultivableLand + "','" + LandPloughing + "','" + IrrigatedLand + "','" + UniriigateLand + "','" + landForest + "','" + WasteLand + "','" + pastureLand + "','" + Otherland + "','" + Landless + "','" + OpenDefecation + "','" + HHsWithToilets + "','" + HHsUtilizingToilets + "','" + HHsPublicToilets + "','" + HHsWithDrainage + "','" + AveragewaterLevel + "','" + AverageWaterTDSinDrinkingSource + "','" + DWSPublicWells + "','" + DWSPrivateWells + "','" + DWSPublicHandPumps + "','" + DWSPrivateHandPumps + "','" + DWSPublicTaps + "','" + DWSPublicPonds + "','" + DWSCanal + "','" + DWSPublicTubewell + "','" + DWSPrivateTubwell + "','" + DWSDieselPumps + "','" + WSPublicWells + "','" + WSPrivateWells + "','" + WSPublicHandPumps + "','" + WSPrivateHandPumps + "','" + WSPublicTaps + "','" + WSPublicPonds + "','" + WSCanal + "','" + WSPublicTubewell + "','" + WSPrivateTubwell + "','" + WSDieselPumps + "','" + WSOther + "','" + Population + "','" + malepop + "','" + femalepop + "','" + SCpop + "','" + STpop + "','" + OBCpop + "','" + Generalpop + "','" + Jan + "','" + Feb + "','" + Mar + "','" + Apr + "','" + May + "','" + Jun + "','" + Jul + "','" + Aug + "','" + Sep + "','" + Oct + "','" + Nov + "','" + Dec + "','" + CHCSubcentreorANM + "','" + CHCPHC + "','" + CHCCHC + "','" + CHCPrivateClinic + "','" + CHCAnimalDispensary + "','" + CHCVolunteerhealthworker + "','" + QSSubcentreorANM + "','" + QSPHC + "','" + QSCHC + "','" + QSPrivateClinic + "','" + QSAnimalDispensary + "','" + QSVolunteerhealthworker + "','" + boyspop + "','" + girlspop + "','" + Transgengerpop +  "','" + PrimarySchool + "','" + PrimarySchoolDistance + "','" + PrimaryCshoolBoys + "','" + PrimarySchoolGirls + "','" + PrimarySchoolTransgender + "','" + PrimarySchoolTotal + "','" + PrimaryNeverAttendedBoys + "','" + PrimaryNeverAttendedGirls + "','" + PrimaryBoysDropped + "','" + PrimaryGuirlsDropped + "','" + PrimaryBoysGoing + "','" + PrimaryGirlsGoing + "','" + Primary6to11Boys + "','" + Primary6to11Girls + "','" + PrimaryLiteracyStatus + "','" + UpperPrimarySchool + "','" + UpperPrimarySchoolDistance + "','" + UpperPrimaryCshoolBoys + "','" + UpperPrimarySchoolGirls + "','" + UpperPrimarySchoolTransgender + "','" + UpperPrimarySchoolTotal + "','" + UpperPrimaryNeverAttendedBoys + "','" + UpperPrimaryNeverAttendedGirls + "','" + UpperPrimaryBoysDropped + "','" + UpperPrimaryGuirlsDropped + "','" + UpperPrimaryBoysGoing + "','" + UpperPrimaryGirlsGoing + "','" + UpperPrimary6to11Boys + "','" + UpperPrimary6to11Girls + "','" + UpperPrimaryLiteracyStatus + "','" + SecondarySchool + "','" + SecondarySchoolDistance + "','" + SecondaryCshoolBoys + "','" + SecondarySchoolGirls + "','" + SecondarySchoolTransgender + "','" + SecondarySchoolTotal + "','" + SecondaryNeverAttendedBoys + "','" + SecondaryNeverAttendedGirls + "','" + SecondaryBoysDropped + "','" + SecondaryGuirlsDropped + "','" + SecondaryBoysGoing + "','" + SecondaryGirlsGoing + "','" + Secondary6to11Boys + "','" + Secondary6to11Girls + "','" + SecondaryLiteracyStatus + "','" + HigherSecondarySchool + "','" + HigherSecondarySchoolDistance + "','" + HigherSecondaryCshoolBoys + "','" + HigherSecondarySchoolGirls + "','" + HigherSecondarySchoolTransgender + "','" + HigherSecondarySchoolTotal + "','" + HigherSecondaryNeverAttendedBoys + "','" + HigherSecondaryNeverAttendedGirls + "','" + HigherSecondaryBoysDropped + "','" + HigherSecondaryGuirlsDropped + "','" + HigherSecondaryBoysGoing + "','" + HigherSecondaryGirlsGoing + "','" + HigherSecondary6to11Boys + "','" + HigherSecondary6to11Girls + "','" + HigherSecondaryLiteracyStatus + "','" + MadrasaSchool + "','" + MadrasaSchoolDistance + "','" + MadrasaCshoolBoys + "','" + MadrasaSchoolGirls + "','" + MadrasaSchoolTransgender + "','" + MadrasaSchoolTotal + "','" + MadrasaNeverAttendedBoys + "','" + MadrasaNeverAttendedGirls + "','" + MadrasaBoysDropped + "','" + MadrasaGuirlsDropped + "','" + MadrasaBoysGoing + "','" + MadrasaGirlsGoing + "','" + Madrasa6to11Boys + "','" + Madrasa6to11Girls + "','" + MadrasaLiteracyStatus + "', '" + SCHH + "','" + STHH + "','" + OBCHH + "','" + GeneralHH + "','" + "','" + landupto1acr + "','" + land1to2hec + "','" + land2to4hec + "','" + landmorethan4 + "')";

            if (db.UpdateQuery(InsertHamlet, "", "", "") > 0)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "ShowAlert('You have submitted data successfully. Thank you.','success')", true);
            }
            else
            {
                ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "ShowAlert('Something went wrong please try again.','warning')", true);
            }
        }

        protected void txtYear_TextChanged(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(txtYear.Text))
            {
                string query = "select * from tblHamletData where Year='" + txtYear.Text + "' and Hid=" + Session["Hid"];
                DataSet ds = db.getResultset(query, "", "", "");
                if (ds != null && ds.Tables[0].Rows.Count > 0)
                {
                    txtYear.Text = "";
                    ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "ShowAlert('Selected Year has already existed in the data.','error')", true);
                }
            }
        }
    }
}