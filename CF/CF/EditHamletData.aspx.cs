using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CF
{
    public partial class EditHamletData : System.Web.UI.Page
    {
        DbErrorLog db = new DbErrorLog();
        protected void Page_Load(object sender, EventArgs e)
        {
            Page.UnobtrusiveValidationMode = UnobtrusiveValidationMode.None;
            if (Session["Hid"] != null)
            {
                if (Session["HDid"] != null)
                {
                    if (!IsPostBack)
                    {
                        loadData();
                    }
                }
                else
                {
                    Response.Redirect("~/HamletDataInfo.aspx");
                }
            }
            else
            {
                Response.Redirect("~/VillageHamlet.aspx");
            }
        }

        public void loadData()
        {
            string query = "select StateName,Village,CSOName,Block,District, c.GramPanchayatName,c.[VillageID],[DistanceofVillage],[NameofHamlet],[NameofGramPanchayat],[PostofficeName],[DistancefromPostoffice],[BlockName],[DistanceofBlockfromVillage],b.[DistancefromGramPanchayat],[PolicestationName],[DistanceofPolicestation],[SubdistrictName],[DistanceofSubdistrict],[DistrictName],[DistanceofDistrict],b.[PostOfficepin], [Year],[Rank],a.[ElectricityFacility],a.[HouseholdhavingLPG],a.[MajorsectorwiseNeeds],a.[NoofWomenSelfHelpGroupsformedinthevillage],a.[NameoftheWSHGs],a.[TotalNoofmembersinWSHGs],a.[NoofWomenFarmersGroups],a.[TotalNoofmembersinWFGs],a.[NoofOtherCBOsNariSanghWomenHealthGroups],a.[TotalNoofmembersinotherCBOs],a.[NooffamilieshavingWidowsorDisabilities],a.[Publicdistributionsystemcards],a.[HouseholdcoverwithAtalPensionScheme],a.[Householdcoverwithaccidentalinsurance],a.[Householdcoverwithlifeinsurance],a.[Householdhavinglabourregistrationcard],a.[TotalLand],a.[CultivableLand],a.[PloughingLand],a.[IrrigatedLand],a.[UnirrigatedLand],a.[LandInderForest],a.[WasteLand],a.[PastureLand],a.[OtherLand],a.[NoofFamilieshavenoLand],a.[OverallVillageOpenDefecation],a.[HHsWithToilets],a.[HHsUtilizingToilets],a.[HHsusingPublicToilets],a.[HHsConnectedWithDrainage],a.[AveragewaterLevel],a.[AverageWaterTDSinDrinkingSource],a.[DWSPublicWells],a.[DWSPrivateWells],a.[DWSPublicHandPumps],a.[DWSPrivateHandPumps],a.[DWSPublicTaps],a.[DWSPublicPonds],a.[DWSCanal],a.[DWSPublicTubewell],a.[DWSPrivateTubwell],a.[DWSDieselPumps],a.[DWSOther],a.[WSPublicWells],a.[WSPrivateWells],a.[WSPublicHandPumps],a.[WSPrivateHandPumps],a.[WSPublicTaps],a.[WSPublicPonds],a.[WSCanal],a.[WSPublicTubewell],a.[WSPrivateTubwell],a.[WSDieselPumps],a.[WSOther],a.[TotalPopulation],a.[MalePopulation],a.[FemalePopulation],a.[SCPopulation],a.[STPopulation],a.[OBCPopulation],a.[GemeralPopulation],a.[Jan],a.[Feb],a.[Mar],a.[Apr],a.[May],a.[Jun],a.[Jul],a.[Aug],a.[Sep],a.[Oct],a.[Nov],a.[Dec],a.[ConditionofHealthCentresSubcentreorANM],a.[ConditionofHealthCentresPHC],a.[ConditionofHealthCentresCHC],a.[ConditionofHealthCentresPrivateClinic],a.[ConditionofHealthCentresAnimalDispensary],a.[ConditionofHealthCentresVolunteerhealthworker],a.[QualityofservicesSubcentreorANM],a.[QualityofservicesPHC],a.[QualityofservicesCHC],a.[QualityofservicesPrivateClinic],a.[QualityofservicesAnimalDispensary],a.[QualityofservicesVolunteerhealthworker],a.[BoysPopulation],a.[GirlsPopulation],a.[TransgenderPopulationa.[PrimarySchool],a.[PrimarySchoolDistance],a.[PrimaryCshoolBoys],a.[PrimarySchoolGirls],a.[PrimarySchoolTransgender],a.[PrimarySchoolTotal],a.[PrimaryNeverAttendedBoys],a.[PrimaryNeverAttendedGirls],a.[PrimaryBoysDropped],a.[PrimaryGuirlsDropped],a.[PrimaryBoysGoing],a.[PrimaryGirlsGoing],a.[Primary6to11Boys],a.[Primary6to11Girls],a.[PrimaryLiteracyStatus],a.[UpperPrimarySchool],a.[UpperPrimarySchoolDistance],a.[UpperPrimaryCshoolBoys],a.[UpperPrimarySchoolGirls],a.[UpperPrimarySchoolTransgender],a.[UpperPrimarySchoolTotal],a.[UpperPrimaryNeverAttendedBoys],a.[UpperPrimaryNeverAttendedGirls],a.[UpperPrimaryBoysDropped],a.[UpperPrimaryGuirlsDropped],a.[UpperPrimaryBoysGoing],a.[UpperPrimaryGirlsGoing],a.[UpperPrimary6to11Boys],a.[UpperPrimary6to11Girls],a.[UpperPrimaryLiteracyStatus],a.[SecondarySchool],a.[SecondarySchoolDistance],a.[SecondaryCshoolBoys],a.[SecondarySchoolGirls],a.[SecondarySchoolTransgender],a.[SecondarySchoolTotal],a.[SecondaryNeverAttendedBoys],a.[SecondaryNeverAttendedGirls],a.[SecondaryBoysDropped],a.[SecondaryGuirlsDropped],a.[SecondaryBoysGoing],a.[SecondaryGirlsGoing],a.[Secondary6to11Boys],a.[Secondary6to11Girls],a.[SecondaryLiteracyStatus],a.[HigherSecondarySchool],a.[HigherSecondarySchoolDistance],a.[HigherSecondaryCshoolBoys],a.[HigherSecondarySchoolGirls],a.[HigherSecondarySchoolTransgender],a.[HigherSecondarySchoolTotal],a.[HigherSecondaryNeverAttendedBoys],a.[HigherSecondaryNeverAttendedGirls],a.[HigherSecondaryBoysDropped],a.[HigherSecondaryGuirlsDropped],a.[HigherSecondaryBoysGoing],a.[HigherSecondaryGirlsGoing],a.[HigherSecondary6to11Boys],a.[HigherSecondary6to11Girls],a.[HigherSecondaryLiteracyStatus],a.[MadrasaSchool],a.[MadrasaSchoolDistance],a.[MadrasaCshoolBoys],a.[MadrasaSchoolGirls],a.[MadrasaSchoolTransgender],a.[MadrasaSchoolTotal],a.[MadrasaNeverAttendedBoys],a.[MadrasaNeverAttendedGirls],a.[MadrasaBoysDropped],a.[MadrasaGuirlsDropped],a.[MadrasaBoysGoing],a.[MadrasaGirlsGoing],a.[Madrasa6to11Boys],a.[Madrasa6to11Girls], a.[MadrasaLiteracyStatus], a.SCHH, a.STHH, a.OBCHH, a.GeneralHH,  a.landupto1acr, a.land1to2hec, a.land2to4hec, a.landmorethan4 from tblHamletData a left outer join tblHamletInfo b on a.Hid=b.Hid left outer join tblVillageInfo c on b.Villageid=c.Vid left outer join tblVillages d on c.villageID = d.villageID left outer join tblCSO e on c.CSOID=e.CSOID left outer join tblBlocks f on f.BlockID = c.BlockID left outer join tblDistricts g on g.DistrictID =c.DistrictID left outer join tblStates h on h.StateId=c.StateID where HDid = " + Session["HDid"];
            DataSet Datads = db.getResultset(query, "", "", "");
            if (Datads != null && Datads.Tables[0].Rows.Count > 0)
            {
                txtCSO.Text = Datads.Tables[0].Rows[0]["CSOName"].ToString();
                txtState.Text = Datads.Tables[0].Rows[0]["StateName"].ToString();
                txtDistrict.Text = Datads.Tables[0].Rows[0]["District"].ToString();
                txtBlock.Text = Datads.Tables[0].Rows[0]["Block"].ToString();
                txtvillagename.Text = Datads.Tables[0].Rows[0]["Village"].ToString();
                txtGramPanchayat.Text = Datads.Tables[0].Rows[0]["GramPanchayatName"].ToString();
                txtYear.Text = Datads.Tables[0].Rows[0]["Year"].ToString();
                txtRanking.Text = Datads.Tables[0].Rows[0]["Rank"].ToString();
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

                txtSCHH.Text = Datads.Tables[0].Rows[0]["SCHH"].ToString();
                txtSTHH.Text = Datads.Tables[0].Rows[0]["STHH"].ToString();
                txtOBCHH.Text = Datads.Tables[0].Rows[0]["OBCHH"].ToString();
                txtGenHH.Text = Datads.Tables[0].Rows[0]["GeneralHH"].ToString();
                //txtMinHH.Text = Datads.Tables[0].Rows[0]["MinorityHH"].ToString();
                txtsc.Text = Datads.Tables[0].Rows[0]["SCPopulation"].ToString();
                txtst.Text = Datads.Tables[0].Rows[0]["STPopulation"].ToString();
                txtobc.Text = Datads.Tables[0].Rows[0]["OBCPopulation"].ToString();
                //txtminority.Text = Datads.Tables[0].Rows[0]["MinorityPopulation"].ToString();
                txtgeneral.Text = Datads.Tables[0].Rows[0]["GemeralPopulation"].ToString();
                txtPopulation.Text = Datads.Tables[0].Rows[0]["TotalPopulation"].ToString();
                txtmalePop.Text = Datads.Tables[0].Rows[0]["MalePopulation"].ToString();
                txtfemalePop.Text = Datads.Tables[0].Rows[0]["FemalePopulation"].ToString();
                txtboyPop.Text = Datads.Tables[0].Rows[0]["BoysPopulation"].ToString();
                txtgirlsPop.Text = Datads.Tables[0].Rows[0]["GirlsPopulation"].ToString();
                txttransgenderPop.Text = Datads.Tables[0].Rows[0]["TransgenderPopulation"].ToString();
                txttotalland.Text = Datads.Tables[0].Rows[0]["TotalLand"].ToString();
                txtcultiland.Text = Datads.Tables[0].Rows[0]["CultivableLand"].ToString();
                txtlandplough.Text = Datads.Tables[0].Rows[0]["PloughingLand"].ToString();
                txtirrgate.Text = Datads.Tables[0].Rows[0]["IrrigatedLand"].ToString();
                txtunirrgate.Text = Datads.Tables[0].Rows[0]["UnirrigatedLand"].ToString();
                txtforestland.Text = Datads.Tables[0].Rows[0]["LandInderForest"].ToString();
                txtwasteland.Text = Datads.Tables[0].Rows[0]["WasteLand"].ToString();
                txtpastureland.Text = Datads.Tables[0].Rows[0]["PastureLand"].ToString();
                txtotherland.Text = Datads.Tables[0].Rows[0]["OtherLand"].ToString();
                txtlessthanoneland.Text = Datads.Tables[0].Rows[0]["landupto1acr"].ToString();
                txtonetotwo.Text = Datads.Tables[0].Rows[0]["land1to2hec"].ToString();
                txt2to4.Text = Datads.Tables[0].Rows[0]["land2to4hec"].ToString();
                txtMorethen4.Text = Datads.Tables[0].Rows[0]["landmorethan4"].ToString();
                txtlandless.Text = Datads.Tables[0].Rows[0]["NoofFamilieshavenoLand"].ToString();
                txtJan.Text = Datads.Tables[0].Rows[0]["Jan"].ToString();
                txtFeb.Text = Datads.Tables[0].Rows[0]["Feb"].ToString();
                txtMar.Text = Datads.Tables[0].Rows[0]["Mar"].ToString();
                txtApr.Text = Datads.Tables[0].Rows[0]["Apr"].ToString();
                txtMay.Text = Datads.Tables[0].Rows[0]["May"].ToString();
                txtJun.Text = Datads.Tables[0].Rows[0]["Jun"].ToString();
                txtJul.Text = Datads.Tables[0].Rows[0]["Jul"].ToString();
                txtAug.Text = Datads.Tables[0].Rows[0]["Aug"].ToString();
                txtSep.Text = Datads.Tables[0].Rows[0]["Sep"].ToString();
                txtOct.Text = Datads.Tables[0].Rows[0]["Oct"].ToString();
                txtNov.Text = Datads.Tables[0].Rows[0]["Nov"].ToString();
                txtDec.Text = Datads.Tables[0].Rows[0]["Dec"].ToString();
                txtavgwtrlvl.Text = Datads.Tables[0].Rows[0]["AveragewaterLevel"].ToString();
                txtwtrTDS.Text = Datads.Tables[0].Rows[0]["AverageWaterTDSinDrinkingSource"].ToString();
                txtPublicwalls.Text = Datads.Tables[0].Rows[0]["DWSPublicWells"].ToString();
                txtPrivatewalls.Text = Datads.Tables[0].Rows[0]["DWSPrivateWells"].ToString();
                txtPublichandPumps.Text = Datads.Tables[0].Rows[0]["DWSPublicHandPumps"].ToString();
                txtPrivateHandPumps.Text = Datads.Tables[0].Rows[0]["DWSPrivateHandPumps"].ToString();
                txtPublicTaps.Text = Datads.Tables[0].Rows[0]["DWSPublicTaps"].ToString();
                txtPublicPonds.Text = Datads.Tables[0].Rows[0]["DWSPublicPonds"].ToString();
                txtCanal.Text = Datads.Tables[0].Rows[0]["DWSCanal"].ToString();
                txtPublicTubwell.Text = Datads.Tables[0].Rows[0]["DWSPublicTubewell"].ToString();
                txtPrivateTubwell.Text = Datads.Tables[0].Rows[0]["DWSPrivateTubwell"].ToString();
                txtDieselPumps.Text = Datads.Tables[0].Rows[0]["DWSDieselPumps"].ToString();
                // string DWSOther= TextBox108.Text = Datads.Tables[0].Rows[0]["name"].ToString();
                // Working source
                txtWSPublicWells.Text = Datads.Tables[0].Rows[0]["WSPublicWells"].ToString();
                txtWSPrivateWell.Text = Datads.Tables[0].Rows[0]["WSPrivateWells"].ToString();
                txtWSPublicHandPump.Text = Datads.Tables[0].Rows[0]["WSPublicHandPumps"].ToString();
                txtWSPrivateHandPump.Text = Datads.Tables[0].Rows[0]["WSPrivateHandPumps"].ToString();
                txtWSPublicTaps.Text = Datads.Tables[0].Rows[0]["WSPublicTaps"].ToString();
                txtWSPublicPonds.Text = Datads.Tables[0].Rows[0]["WSPublicPonds"].ToString();
                txtWSCanal.Text = Datads.Tables[0].Rows[0]["WSCanal"].ToString();
                txtWSPublicTubWell.Text = Datads.Tables[0].Rows[0]["WSPublicTubewell"].ToString();
                txtWSPrivateTubwell.Text = Datads.Tables[0].Rows[0]["WSPrivateTubwell"].ToString();
                txtWSDieselPump.Text = Datads.Tables[0].Rows[0]["WSDieselPumps"].ToString();
                txtWSOtherPumpset.Text = Datads.Tables[0].Rows[0]["WSOther"].ToString();
                if (rblCHCSubcentreorANM.Items.FindByValue(Datads.Tables[0].Rows[0]["ConditionofHealthCentresSubcentreorANM"].ToString()) != null)
                {
                    rblCHCSubcentreorANM.Items.FindByValue(Datads.Tables[0].Rows[0]["ConditionofHealthCentresSubcentreorANM"].ToString()).Selected = true;
                }
                if (rblCHCPHC.Items.FindByValue(Datads.Tables[0].Rows[0]["ConditionofHealthCentresPHC"].ToString()) != null)
                {
                    rblCHCPHC.Items.FindByValue(Datads.Tables[0].Rows[0]["ConditionofHealthCentresPHC"].ToString()).Selected = true;
                }
                if (rblCHCCHC.Items.FindByValue(Datads.Tables[0].Rows[0]["ConditionofHealthCentresCHC"].ToString()) != null)
                {
                    rblCHCCHC.Items.FindByValue(Datads.Tables[0].Rows[0]["ConditionofHealthCentresCHC"].ToString()).Selected = true;
                }
                if (rblCHCPrivateClinic.Items.FindByValue(Datads.Tables[0].Rows[0]["ConditionofHealthCentresPrivateClinic"].ToString()) != null)
                {
                    rblCHCPrivateClinic.Items.FindByValue(Datads.Tables[0].Rows[0]["ConditionofHealthCentresPrivateClinic"].ToString()).Selected = true;
                }
                if (rblCHCAnimalDispensary.Items.FindByValue(Datads.Tables[0].Rows[0]["ConditionofHealthCentresAnimalDispensary"].ToString()) != null)
                {
                    rblCHCAnimalDispensary.Items.FindByValue(Datads.Tables[0].Rows[0]["ConditionofHealthCentresAnimalDispensary"].ToString()).Selected = true;
                }
                if (rblCHCVolunteerhealthworker.Items.FindByValue(Datads.Tables[0].Rows[0]["ConditionofHealthCentresVolunteerhealthworker"].ToString()) != null)
                {
                    rblCHCVolunteerhealthworker.Items.FindByValue(Datads.Tables[0].Rows[0]["ConditionofHealthCentresVolunteerhealthworker"].ToString()).Selected = true;
                }
                if (rblCHCVolunteerhealthworker.Items.FindByValue(Datads.Tables[0].Rows[0]["ConditionofHealthCentresVolunteerhealthworker"].ToString()) != null)
                {
                    rblCHCVolunteerhealthworker.Items.FindByValue(Datads.Tables[0].Rows[0]["ConditionofHealthCentresVolunteerhealthworker"].ToString()).Selected = true;
                }
                if (ddlQSSubcentreorANM.Items.FindByValue(Datads.Tables[0].Rows[0]["QualityofservicesSubcentreorANM"].ToString()) != null)
                {
                    ddlQSSubcentreorANM.Items.FindByValue(Datads.Tables[0].Rows[0]["QualityofservicesSubcentreorANM"].ToString()).Selected = true;
                }
                if (ddlQSPHC.Items.FindByValue(Datads.Tables[0].Rows[0]["QualityofservicesPHC"].ToString()) != null)
                {
                    ddlQSPHC.Items.FindByValue(Datads.Tables[0].Rows[0]["QualityofservicesPHC"].ToString()).Selected = true;
                }
                if (ddlQSCHC.Items.FindByValue(Datads.Tables[0].Rows[0]["QualityofservicesCHC"].ToString()) != null)
                {
                    ddlQSCHC.Items.FindByValue(Datads.Tables[0].Rows[0]["QualityofservicesCHC"].ToString()).Selected = true;
                }
                if (ddlQSPrivateClinic.Items.FindByValue(Datads.Tables[0].Rows[0]["QualityofservicesPrivateClinic"].ToString()) != null)
                {
                    ddlQSPrivateClinic.Items.FindByValue(Datads.Tables[0].Rows[0]["QualityofservicesPrivateClinic"].ToString()).Selected = true;
                }
                if (ddlQSAnimalDispensary.Items.FindByValue(Datads.Tables[0].Rows[0]["QualityofservicesAnimalDispensary"].ToString()) != null)
                {
                    ddlQSAnimalDispensary.Items.FindByValue(Datads.Tables[0].Rows[0]["QualityofservicesAnimalDispensary"].ToString()).Selected = true;
                }
                if (ddlQSVolunteerhealthworker.Items.FindByValue(Datads.Tables[0].Rows[0]["QualityofservicesVolunteerhealthworker"].ToString()) != null)
                {
                    ddlQSVolunteerhealthworker.Items.FindByValue(Datads.Tables[0].Rows[0]["QualityofservicesVolunteerhealthworker"].ToString()).Selected = true;
                }
                txtOpenDefecation.Text = Datads.Tables[0].Rows[0]["OverallVillageOpenDefecation"].ToString();
                txtHHToilets.Text = Datads.Tables[0].Rows[0]["HHsWithToilets"].ToString();
                txtHHUtilizingToilets.Text = Datads.Tables[0].Rows[0]["HHsUtilizingToilets"].ToString();
                txtHHPublicToilets.Text = Datads.Tables[0].Rows[0]["HHsusingPublicToilets"].ToString();
                txtHHDrainage.Text = Datads.Tables[0].Rows[0]["HHsConnectedWithDrainage"].ToString();

                rblPrimaryScholDetails.SelectedValue = Datads.Tables[0].Rows[0]["PrimarySchool"].ToString();
                if (rblPrimaryScholDetails.SelectedValue == "Yes")
                {
                    txtPrimarySchoolDistance.Text = Datads.Tables[0].Rows[0]["PrimarySchoolDistance"].ToString();
                    txtPrimaryCshoolBoys.Text = Datads.Tables[0].Rows[0]["PrimaryCshoolBoys"].ToString();
                    txtPrimarySchoolGirls.Text = Datads.Tables[0].Rows[0]["PrimarySchoolGirls"].ToString();
                    txtPrimarySchoolTransgender.Text = Datads.Tables[0].Rows[0]["PrimarySchoolTransgender"].ToString();
                    txtPrimarySchoolTotal.Text = Datads.Tables[0].Rows[0]["PrimarySchoolTotal"].ToString();
                    txtPrimaryNeverAttendedBoys.Text = Datads.Tables[0].Rows[0]["PrimaryNeverAttendedBoys"].ToString();
                    txtPrimaryNeverAttendedGirls.Text = Datads.Tables[0].Rows[0]["PrimaryNeverAttendedGirls"].ToString();
                    txtPrimaryBoysDropped.Text = Datads.Tables[0].Rows[0]["PrimaryBoysDropped"].ToString();
                    txtPrimaryGuirlsDropped.Text = Datads.Tables[0].Rows[0]["PrimaryGuirlsDropped"].ToString();
                    txtPrimaryBoysGoing.Text = Datads.Tables[0].Rows[0]["PrimaryBoysGoing"].ToString();
                    txtPrimaryGirlsGoing.Text = Datads.Tables[0].Rows[0]["PrimaryGirlsGoing"].ToString();
                    txtPrimary6to11Boys.Text = Datads.Tables[0].Rows[0]["Primary6to11Boys"].ToString();
                    txtPrimary6to11Girls.Text = Datads.Tables[0].Rows[0]["Primary6to11Girls"].ToString();
                    txtPrimaryLiteracyStatus.Text = Datads.Tables[0].Rows[0]["PrimaryLiteracyStatus"].ToString();
                }

                rblUpperPrimary.SelectedValue = Datads.Tables[0].Rows[0]["UpperPrimarySchool"].ToString();
                if (rblUpperPrimary.SelectedValue == "Yes")
                {
                    txtUpperPrimarySchoolDistance.Text = Datads.Tables[0].Rows[0]["UpperPrimarySchoolDistance"].ToString();
                    txtUpperPrimaryCshoolBoys.Text = Datads.Tables[0].Rows[0]["UpperPrimaryCshoolBoys"].ToString();
                    txtUpperPrimarySchoolGirls.Text = Datads.Tables[0].Rows[0]["UpperPrimarySchoolGirls"].ToString();
                    txtUpperPrimarySchoolTransgender.Text = Datads.Tables[0].Rows[0]["UpperPrimarySchoolTransgender"].ToString();
                    txtUpperPrimarySchoolTotal.Text = Datads.Tables[0].Rows[0]["UpperPrimarySchoolTotal"].ToString();
                    txtUpperPrimaryNeverAttendedBoys.Text = Datads.Tables[0].Rows[0]["UpperPrimaryNeverAttendedBoys"].ToString();
                    txtUpperPrimaryNeverAttendedGirls.Text = Datads.Tables[0].Rows[0]["UpperPrimaryNeverAttendedGirls"].ToString();
                    txtUpperPrimaryBoysDropped.Text = Datads.Tables[0].Rows[0]["UpperPrimaryBoysDropped"].ToString();
                    txtUpperPrimaryGuirlsDropped.Text = Datads.Tables[0].Rows[0]["UpperPrimaryGuirlsDropped"].ToString();
                    txtUpperPrimaryBoysGoing.Text = Datads.Tables[0].Rows[0]["UpperPrimaryBoysGoing"].ToString();
                    txtUpperPrimaryGirlsGoing.Text = Datads.Tables[0].Rows[0]["UpperPrimaryGirlsGoing"].ToString();
                    txtUpperPrimary6to11Boys.Text = Datads.Tables[0].Rows[0]["UpperPrimary6to11Boys"].ToString();
                    txtUpperPrimary6to11Girls.Text = Datads.Tables[0].Rows[0]["UpperPrimary6to11Girls"].ToString();
                    txtUpperPrimaryLiteracyStatus.Text = Datads.Tables[0].Rows[0]["UpperPrimaryLiteracyStatus"].ToString();
                }

                rblSecondary.SelectedValue = Datads.Tables[0].Rows[0]["SecondarySchool"].ToString();
                if (rblSecondary.SelectedValue == "Yes")
                {
                    txtSecondarySchoolDistance.Text = Datads.Tables[0].Rows[0]["SecondarySchoolDistance"].ToString();
                    txtSecondaryCshoolBoys.Text = Datads.Tables[0].Rows[0]["SecondaryCshoolBoys"].ToString();
                    txtSecondarySchoolGirls.Text = Datads.Tables[0].Rows[0]["SecondarySchoolGirls"].ToString();
                    txtSecondarySchoolTransgender.Text = Datads.Tables[0].Rows[0]["SecondarySchoolTransgender"].ToString();
                    txtSecondarySchoolTotal.Text = Datads.Tables[0].Rows[0]["SecondarySchoolTotal"].ToString();
                    txtSecondaryNeverAttendedBoys.Text = Datads.Tables[0].Rows[0]["SecondaryNeverAttendedBoys"].ToString();
                    txtSecondaryNeverAttendedGirls.Text = Datads.Tables[0].Rows[0]["SecondaryNeverAttendedGirls"].ToString();
                    txtSecondaryBoysDropped.Text = Datads.Tables[0].Rows[0]["SecondaryBoysDropped"].ToString();
                    txtSecondaryGuirlsDropped.Text = Datads.Tables[0].Rows[0]["SecondaryGuirlsDropped"].ToString();
                    txtSecondaryBoysGoing.Text = Datads.Tables[0].Rows[0]["SecondaryBoysGoing"].ToString();
                    txtSecondaryGirlsGoing.Text = Datads.Tables[0].Rows[0]["SecondaryGirlsGoing"].ToString();
                    txtSecondary6to11Boys.Text = Datads.Tables[0].Rows[0]["Secondary6to11Boys"].ToString();
                    txtSecondary6to11Girls.Text = Datads.Tables[0].Rows[0]["Secondary6to11Girls"].ToString();
                    txtSecondaryLiteracyStatus.Text = Datads.Tables[0].Rows[0]["SecondaryLiteracyStatus"].ToString();
                }

                rblHigherSecondary.SelectedValue = Datads.Tables[0].Rows[0]["HigherSecondarySchool"].ToString();
                if (rblHigherSecondary.SelectedValue == "Yes")
                {
                    txtHigherSecondarySchoolDistance.Text = Datads.Tables[0].Rows[0]["HigherSecondarySchoolDistance"].ToString();
                    txtHigherSecondaryCshoolBoys.Text = Datads.Tables[0].Rows[0]["HigherSecondaryCshoolBoys"].ToString();
                    txtHigherSecondarySchoolGirls.Text = Datads.Tables[0].Rows[0]["HigherSecondarySchoolGirls"].ToString();
                    txtHigherSecondarySchoolTransgender.Text = Datads.Tables[0].Rows[0]["HigherSecondarySchoolTransgender"].ToString();
                    txtHigherSecondarySchoolTotal.Text = Datads.Tables[0].Rows[0]["HigherSecondarySchoolTotal"].ToString();
                    txtHigherSecondaryNeverAttendedBoys.Text = Datads.Tables[0].Rows[0]["HigherSecondaryNeverAttendedBoys"].ToString();
                    txtHigherSecondaryNeverAttendedGirls.Text = Datads.Tables[0].Rows[0]["HigherSecondaryNeverAttendedGirls"].ToString();
                    txtHigherSecondaryBoysDropped.Text = Datads.Tables[0].Rows[0]["HigherSecondaryBoysDropped"].ToString();
                    txtHigherSecondaryGuirlsDropped.Text = Datads.Tables[0].Rows[0]["HigherSecondaryGuirlsDropped"].ToString();
                    txtHigherSecondaryBoysGoing.Text = Datads.Tables[0].Rows[0]["HigherSecondaryBoysGoing"].ToString();
                    txtHigherSecondaryGirlsGoing.Text = Datads.Tables[0].Rows[0]["HigherSecondaryGirlsGoing"].ToString();
                    txtHigherSecondary6to11Boys.Text = Datads.Tables[0].Rows[0]["HigherSecondary6to11Boys"].ToString();
                    txtHigherSecondary6to11Girls.Text = Datads.Tables[0].Rows[0]["HigherSecondary6to11Girls"].ToString();
                    txtHigherSecondaryLiteracyStatus.Text = Datads.Tables[0].Rows[0]["HigherSecondaryLiteracyStatus"].ToString();
                }

                rblMadrasa.SelectedValue = Datads.Tables[0].Rows[0]["MadrasaSchool"].ToString();
                if (rblMadrasa.SelectedValue == "Yes")
                {
                    txtMadrasaSchoolDistance.Text = Datads.Tables[0].Rows[0]["MadrasaSchoolDistance"].ToString();
                    txtMadrasaCshoolBoys.Text = Datads.Tables[0].Rows[0]["MadrasaCshoolBoys"].ToString();
                    txtMadrasaSchoolGirls.Text = Datads.Tables[0].Rows[0]["MadrasaSchoolGirls"].ToString();
                    txtMadrasaSchoolTransgender.Text = Datads.Tables[0].Rows[0]["MadrasaSchoolTransgender"].ToString();
                    txtMadrasaSchoolTotal.Text = Datads.Tables[0].Rows[0]["MadrasaSchoolTotal"].ToString();
                    txtMadrasaNeverAttendedBoys.Text = Datads.Tables[0].Rows[0]["MadrasaNeverAttendedBoys"].ToString();
                    txtMadrasaNeverAttendedGirls.Text = Datads.Tables[0].Rows[0]["MadrasaNeverAttendedGirls"].ToString();
                    txtMadrasaBoysDropped.Text = Datads.Tables[0].Rows[0]["MadrasaBoysDropped"].ToString();
                    txtMadrasaGuirlsDropped.Text = Datads.Tables[0].Rows[0]["MadrasaGuirlsDropped"].ToString();
                    txtMadrasaBoysGoing.Text = Datads.Tables[0].Rows[0]["MadrasaBoysGoing"].ToString();
                    txtMadrasaGirlsGoing.Text = Datads.Tables[0].Rows[0]["MadrasaGirlsGoing"].ToString();
                    txtMadrasa6to11Boys.Text = Datads.Tables[0].Rows[0]["Madrasa6to11Boys"].ToString();
                    txtMadrasa6to11Girls.Text = Datads.Tables[0].Rows[0]["Madrasa6to11Girls"].ToString();
                    txtMadrasaLiteracyStatus.Text = Datads.Tables[0].Rows[0]["MadrasaLiteracyStatus"].ToString();
                }

                txtWidows.Text = Datads.Tables[0].Rows[0]["NooffamilieshavingWidowsorDisabilities"].ToString();
                txtDistributionCards.Text = Datads.Tables[0].Rows[0]["Publicdistributionsystemcards"].ToString();
                txtAtlaScheme.Text = Datads.Tables[0].Rows[0]["HouseholdcoverwithAtalPensionScheme"].ToString();
                txtAccidentalInsurance.Text = Datads.Tables[0].Rows[0]["Householdcoverwithaccidentalinsurance"].ToString();
                txtLifeInsurance.Text = Datads.Tables[0].Rows[0]["Householdcoverwithlifeinsurance"].ToString();
                txtLabourCard.Text = Datads.Tables[0].Rows[0]["Householdhavinglabourregistrationcard"].ToString();
                txtWSHGs.Text = Datads.Tables[0].Rows[0]["NoofWomenSelfHelpGroupsformedinthevillage"].ToString();
                txtNameofWSHGs.Text = Datads.Tables[0].Rows[0]["NameoftheWSHGs"].ToString();
                txtWSHGmembers.Text = Datads.Tables[0].Rows[0]["TotalNoofmembersinWSHGs"].ToString();
                txtWFGs.Text = Datads.Tables[0].Rows[0]["NoofWomenFarmersGroups"].ToString();
                txtWFGMembers.Text = Datads.Tables[0].Rows[0]["TotalNoofmembersinWFGs"].ToString();
                txtOtherCBO.Text = Datads.Tables[0].Rows[0]["NoofOtherCBOsNariSanghWomenHealthGroups"].ToString();
                txtOtherCBOMembers.Text = Datads.Tables[0].Rows[0]["TotalNoofmembersinotherCBOs"].ToString();
                if (ddlElectricity.Items.FindByValue(Datads.Tables[0].Rows[0]["ElectricityFacility"].ToString()) != null)
                {
                    ddlElectricity.Items.FindByValue(Datads.Tables[0].Rows[0]["ElectricityFacility"].ToString()).Selected = true;
                }
                txtLPGs.Text = Datads.Tables[0].Rows[0]["HouseholdhavingLPG"].ToString();
                txtMajorNeeds.Text = Datads.Tables[0].Rows[0]["MajorsectorwiseNeeds"].ToString();
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
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
                //dvPrimary1.Visible = dvPrimary2.Visible = dvPrimary3.Visible = dvPrimary4.Visible = dvPrimary5.Visible = dvPrimary6.Visible = true;
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
                //dvUpperPrimary1.Visible = dvUpperPrimary2.Visible = dvUpperPrimary3.Visible = dvUpperPrimary4.Visible = dvUpperPrimary5.Visible = dvUpperPrimary6.Visible = true;
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
                //dvSecondary1.Visible = dvSecondary2.Visible = dvSecondary3.Visible = dvSecondary4.Visible = dvSecondary5.Visible = dvSecondary6.Visible = true;
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
                //dvHigher1.Visible = dvHigher2.Visible = dvHigher3.Visible = dvHigher4.Visible = dvHigher5.Visible = dvHigher6.Visible = true;
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
                //dvMadarsa1.Visible = dvMadarsa2.Visible = dvMadarsa3.Visible = dvMadarsa4.Visible = dvMadarsa5.Visible = dvMadarsa6.Visible = true;
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

            string UpdateHamlet = "update [tblHamletData] set [Year]='" + txtYear.Text + "',[Rank]='" + txtRanking.Text + "', [ElectricityFacility]='" + Electricity + "',[HouseholdhavingLPG]='" + LPG + "',[MajorsectorwiseNeeds]='" + Majorneeds + "',[NoofWomenSelfHelpGroupsformedinthevillage]='" + WSHGs + "',[NameoftheWSHGs]='" + WSHGName + "',[TotalNoofmembersinWSHGs]='" + WSHGMembers + "',[NoofWomenFarmersGroups]='" + WFGs + "',[TotalNoofmembersinWFGs]='" + WFGMembers + "',[NoofOtherCBOsNariSanghWomenHealthGroups]='" + OtherCBO + "',[TotalNoofmembersinotherCBOs]='" + CBOMembers + "',[NooffamilieshavingWidowsorDisabilities]='" + Widows + "',[Publicdistributionsystemcards]='" + DistributionCard + "',[HouseholdcoverwithAtalPensionScheme]='" + AtlaScheme + "',[Householdcoverwithaccidentalinsurance]='" + AccidentalInsurance + "',[Householdcoverwithlifeinsurance]='" + LifeInsurance + "',[Householdhavinglabourregistrationcard]='" + LabourCard + "',[TotalLand]='" + TotalLand + "',[CultivableLand]='" + CultivableLand + "',[PloughingLand]='" + LandPloughing + "',[IrrigatedLand]='" + IrrigatedLand + "',[UnirrigatedLand]='" + UniriigateLand + "',[LandInderForest]='" + landForest + "',[WasteLand]='" + WasteLand + "',[PastureLand]='" + pastureLand + "',[OtherLand]='" + Otherland + "',[NoofFamilieshavenoLand]='" + Landless + "',[OverallVillageOpenDefecation]='" + OpenDefecation + "',[HHsWithToilets]='" + HHsWithToilets + "',[HHsUtilizingToilets]='" + HHsUtilizingToilets + "',[HHsusingPublicToilets]='" + HHsPublicToilets + "',[HHsConnectedWithDrainage]='" + HHsWithDrainage + "',[AveragewaterLevel]='" + AveragewaterLevel + "',[AverageWaterTDSinDrinkingSource]='" + AverageWaterTDSinDrinkingSource + "',[DWSPublicWells]='" + DWSPublicWells + "',[DWSPrivateWells]='" + DWSPrivateWells + "',[DWSPublicHandPumps]='" + DWSPublicHandPumps + "',[DWSPrivateHandPumps]='" + DWSPrivateHandPumps + "',[DWSPublicTaps]='" + DWSPublicTaps + "',[DWSPublicPonds]='" + DWSPublicPonds + "',[DWSCanal]='" + DWSCanal + "',[DWSPublicTubewell]='" + DWSPublicTubewell + "',[DWSPrivateTubwell]='" + DWSPrivateTubwell + "',[DWSDieselPumps]='" + DWSDieselPumps + "',[WSPublicWells]='" + WSPublicWells + "',[WSPrivateWells]='" + WSPrivateWells + "',[WSPublicHandPumps]='" + WSPublicHandPumps + "',[WSPrivateHandPumps]='" + WSPrivateHandPumps + "',[WSPublicTaps]='" + WSPublicTaps + "',[WSPublicPonds]='" + WSPublicPonds + "',[WSCanal]='" + WSCanal + "',[WSPublicTubewell]='" + WSPublicTubewell + "',[WSPrivateTubwell]='" + WSPrivateTubwell + "',[WSDieselPumps]='" + WSDieselPumps + "',[WSOther]='" + WSOther + "',[TotalPopulation]='" + Population + "',[MalePopulation]='" + malepop + "',[FemalePopulation]='" + femalepop + "',[SCPopulation]='" + SCpop + "',[STPopulation]='" + STpop + "',[OBCPopulation]='" + OBCpop + "',[GemeralPopulation]='" + Generalpop + "',[Jan]='" + Jan + "',[Feb]='" + Feb + "',[Mar]='" + Mar + "',[Apr]='" + Apr + "',[May]='" + May + "',[Jun]='" + Jun + "',[Jul]='" + Jul + "',[Aug]='" + Aug + "',[Sep]='" + Sep + "',[Oct]='" + Oct + "',[Nov]='" + Nov + "',[Dec]='" + Dec + "',[ConditionofHealthCentresSubcentreorANM]='" + CHCSubcentreorANM + "',[ConditionofHealthCentresPHC]='" + CHCPHC + "',[ConditionofHealthCentresCHC]='" + CHCCHC + "',[ConditionofHealthCentresPrivateClinic]='" + CHCPrivateClinic + "',[ConditionofHealthCentresAnimalDispensary]='" + CHCAnimalDispensary + "',[ConditionofHealthCentresVolunteerhealthworker]='" + CHCVolunteerhealthworker + "',[QualityofservicesSubcentreorANM]='" + QSSubcentreorANM + "',[QualityofservicesPHC]='" + QSPHC + "',[QualityofservicesCHC]='" + QSCHC + "',[QualityofservicesPrivateClinic]='" + QSPrivateClinic + "',[QualityofservicesAnimalDispensary]='" + QSAnimalDispensary + "',[QualityofservicesVolunteerhealthworker]='" + QSVolunteerhealthworker + "',[BoysPopulation]='" + boyspop + "',[GirlsPopulation]='" + girlspop + "',[TransgenderPopulation]='" + Transgengerpop + "',[PrimarySchool]='" + PrimarySchool + "',[PrimarySchoolDistance]='" + PrimarySchoolDistance + "',[PrimaryCshoolBoys]='" + PrimaryCshoolBoys + "',[PrimarySchoolGirls]='" + PrimarySchoolGirls + "',[PrimarySchoolTransgender]='" + PrimarySchoolTransgender + "',[PrimarySchoolTotal]='" + PrimarySchoolTotal + "',[PrimaryNeverAttendedBoys]='" + PrimaryNeverAttendedBoys + "',[PrimaryNeverAttendedGirls]='" + PrimaryNeverAttendedGirls + "',[PrimaryBoysDropped]='" + PrimaryBoysDropped + "',[PrimaryGuirlsDropped]='" + PrimaryGuirlsDropped + "',[PrimaryBoysGoing]='" + PrimaryBoysGoing + "',[PrimaryGirlsGoing]='" + PrimaryGirlsGoing + "',[Primary6to11Boys]='" + Primary6to11Boys + "',[Primary6to11Girls]='" + Primary6to11Girls + "',[PrimaryLiteracyStatus]='" + PrimaryLiteracyStatus + "',[UpperPrimarySchool]='" + UpperPrimarySchool + "',[UpperPrimarySchoolDistance]='" + UpperPrimarySchoolDistance + "',[UpperPrimaryCshoolBoys]='" + UpperPrimaryCshoolBoys + "',[UpperPrimarySchoolGirls]='" + UpperPrimarySchoolGirls + "',[UpperPrimarySchoolTransgender]='" + UpperPrimarySchoolTransgender + "',[UpperPrimarySchoolTotal]='" + UpperPrimarySchoolTotal + "',[UpperPrimaryNeverAttendedBoys]='" + UpperPrimaryNeverAttendedBoys + "',[UpperPrimaryNeverAttendedGirls]='" + UpperPrimaryNeverAttendedGirls + "',[UpperPrimaryBoysDropped]='" + UpperPrimaryBoysDropped + "',[UpperPrimaryGuirlsDropped]='" + UpperPrimaryGuirlsDropped + "',[UpperPrimaryBoysGoing]='" + UpperPrimaryBoysGoing + "',[UpperPrimaryGirlsGoing]='" + UpperPrimaryGirlsGoing + "',[UpperPrimary6to11Boys]='" + UpperPrimary6to11Boys + "',[UpperPrimary6to11Girls]='" + UpperPrimary6to11Girls + "',[UpperPrimaryLiteracyStatus]='" + UpperPrimaryLiteracyStatus + "',[SecondarySchool]='" + SecondarySchool + "',[SecondarySchoolDistance]='" + SecondarySchoolDistance + "',[SecondaryCshoolBoys]='" + SecondaryCshoolBoys + "',[SecondarySchoolGirls]='" + SecondarySchoolGirls + "',[SecondarySchoolTransgender]='" + SecondarySchoolTransgender + "',[SecondarySchoolTotal]='" + SecondarySchoolTotal + "',[SecondaryNeverAttendedBoys]='" + SecondaryNeverAttendedBoys + "',[SecondaryNeverAttendedGirls]='" + SecondaryNeverAttendedGirls + "',[SecondaryBoysDropped]='" + SecondaryBoysDropped + "',[SecondaryGuirlsDropped]='" + SecondaryGuirlsDropped + "',[SecondaryBoysGoing]='" + SecondaryBoysGoing + "',[SecondaryGirlsGoing]='" + SecondaryGirlsGoing + "',[Secondary6to11Boys]='" + Secondary6to11Boys + "',[Secondary6to11Girls]='" + Secondary6to11Girls + "',[SecondaryLiteracyStatus]='" + SecondaryLiteracyStatus + "',[HigherSecondarySchool]='" + HigherSecondarySchool + "',[HigherSecondarySchoolDistance]='" + HigherSecondarySchoolDistance + "',[HigherSecondaryCshoolBoys]='" + HigherSecondaryCshoolBoys + "',[HigherSecondarySchoolGirls]='" + HigherSecondarySchoolGirls + "',[HigherSecondarySchoolTransgender]='" + HigherSecondarySchoolTransgender + "',[HigherSecondarySchoolTotal]='" + HigherSecondarySchoolTotal + "',[HigherSecondaryNeverAttendedBoys]='" + HigherSecondaryNeverAttendedBoys + "',[HigherSecondaryNeverAttendedGirls]='" + HigherSecondaryNeverAttendedGirls + "',[HigherSecondaryBoysDropped]='" + HigherSecondaryBoysDropped + "',[HigherSecondaryGuirlsDropped]='" + HigherSecondaryGuirlsDropped + "',[HigherSecondaryBoysGoing]='" + HigherSecondaryBoysGoing + "',[HigherSecondaryGirlsGoing]='" + HigherSecondaryGirlsGoing + "',[HigherSecondary6to11Boys]='" + HigherSecondary6to11Boys + "',[HigherSecondary6to11Girls]='" + HigherSecondary6to11Girls + "',[HigherSecondaryLiteracyStatus]='" + HigherSecondaryLiteracyStatus + "',[MadrasaSchool]='" + MadrasaSchool + "',[MadrasaSchoolDistance]='" + MadrasaSchoolDistance + "',[MadrasaCshoolBoys]='" + MadrasaCshoolBoys + "',[MadrasaSchoolGirls]='" + MadrasaSchoolGirls + "',[MadrasaSchoolTransgender]='" + MadrasaSchoolTransgender + "',[MadrasaSchoolTotal]='" + MadrasaSchoolTotal + "',[MadrasaNeverAttendedBoys]='" + MadrasaNeverAttendedBoys + "',[MadrasaNeverAttendedGirls]='" + MadrasaNeverAttendedGirls + "',[MadrasaBoysDropped]='" + MadrasaBoysDropped + "',[MadrasaGuirlsDropped]='" + MadrasaGuirlsDropped + "',[MadrasaBoysGoing]='" + MadrasaBoysGoing + "',[MadrasaGirlsGoing]='" + MadrasaGirlsGoing + "',[Madrasa6to11Boys]='" + Madrasa6to11Boys + "',[Madrasa6to11Girls]='" + Madrasa6to11Girls + "',[MadrasaLiteracyStatus]='" + MadrasaLiteracyStatus + "',SCHH='" + SCHH + "',STHH='" + STHH + "',OBCHH='" + OBCHH + "',GeneralHH='" + GeneralHH + "', landupto1acr='" + landupto1acr + "', land1to2hec='" + land1to2hec + "', land2to4hec='" + land2to4hec + "', landmorethan4='" + landmorethan4 + "' where HDid = " + Session["HDid"];

            if (db.UpdateQuery(UpdateHamlet, "", "", "") > 0)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "ShowAlert('You have Updated data successfully.','success')", true);
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
                string query = "select * from tblWFsYearData where Year='" + txtYear.Text + "' and Hid=" + Session["Hid"] + " and HDid !=" + Session["HDid"];
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