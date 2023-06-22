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
using ClosedXML.Excel;

namespace CF
{
    public partial class VillageDataReport : System.Web.UI.Page
    {
        DbErrorLog db = new DbErrorLog();
        string User = string.Empty;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserType"] != null)
            {
                User = Session["UserType"].ToString();
                if (User == "Admin" || User == "CSO")
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

        protected void ddlCSO_SelectedIndexChanged(object sender, EventArgs e)
        {
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
                ddlstate.Items.Insert(0, "All");
                ddlVillage.Items.Clear();
                ddlVillage.Items.Insert(0, "All");
                ddlDistrict.Items.Clear();
                ddlDistrict.Items.Insert(0, "All");
                ddlBlock.Items.Clear();
                ddlBlock.Items.Insert(0, "All");
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
                Condetion += " and b.CSOID=" + ddlCSO.SelectedValue;
            }
            else
            {
                if (ddlstate.SelectedIndex > 0 && ddlstate.SelectedValue != "All")
                {
                    Condetion += " and f.StateID=" + ddlstate.SelectedValue;
                }
                if (ddlDistrict.SelectedIndex > 0 && ddlDistrict.SelectedValue != "All")
                {
                    Condetion += " and e.DistrictID=" + ddlDistrict.SelectedValue;
                }
                if (ddlBlock.SelectedIndex > 0 && ddlBlock.SelectedValue != "All")
                {
                    Condetion += " and d.BlockID=" + ddlBlock.SelectedValue;
                }
            }
            if (ddlVillage.SelectedIndex > 0 && ddlVillage.SelectedValue != "All")
            {
                Condetion += " and Vid=" + ddlVillage.SelectedValue;
            }
            if (!string.IsNullOrEmpty(txtYear.Text))
            {
                Condetion += " and h.Year='" + txtYear.Text + "'";
            }
            string query = "SELECT StateName,[CSOName],e.District,g.DistanceofDistrict,g.SubdistrictName,g.DistanceofSubdistrict,d.Block,g.DistanceofBlockfromVillage,a.GramPanchayatName,g.DistancefromGramPanchayat,c.[Village],g.DistanceofBlockfromVillage as DistanceofVillage,NameofHamlet,g.PostofficeName,g.DistancefromPostoffice,g.PostOfficepin,g.PolicestationName,g.DistanceofPolicestation,[Year],h.SCHH,h.STHH,h.OBCHH,h.GeneralHH, h.TotalPopulation,h.MalePopulation,h.FemalePopulation,h.BoysPopulation,h.GirlsPopulation,h.TransgenderPopulation, h.SCPopulation, h.STPopulation, h.OBCPopulation, h.GemeralPopulation, h.TotalLand, h.CultivableLand, h.PloughingLand, h.IrrigatedLand, h.UnirrigatedLand, h.LandInderForest, h.WasteLand, h.PastureLand, h.OtherLand, h.landupto1acr, h.land1to2hec, h.land2to4hec, h.landmorethan4, h.NoofFamilieshavenoLand, h.Jan, h.Feb, h.Mar, h.Apr, h.May, h.Jun, h.Jul, h.Aug, h.Sep, h.Oct, h.Nov, h.Dec, h.AveragewaterLevel, h.AverageWaterTDSinDrinkingSource, h.DWSPublicWells, h.DWSPrivateWells, h.DWSPublicHandPumps, h.[DWSPrivateHandPumps], h.[DWSPublicTaps], h.[DWSPublicPonds], h.[DWSCanal], h.[DWSPublicTubewell], h.[DWSPrivateTubwell], h.[DWSDieselPumps], h.[WSPublicWells], h.[WSPrivateWells], h.[WSPublicHandPumps], h.[WSPrivateHandPumps], h.[WSPublicTaps], h.[WSPublicPonds], h.[WSCanal], h.[WSPublicTubewell], h.[WSPrivateTubwell], h.[WSDieselPumps], h.[WSOther], h.ConditionofHealthCentresSubcentreorANM, h.[ConditionofHealthCentresPHC], h.[ConditionofHealthCentresCHC], h.[ConditionofHealthCentresPrivateClinic], h.[ConditionofHealthCentresAnimalDispensary], h.[ConditionofHealthCentresVolunteerhealthworker], h.[QualityofservicesSubcentreorANM], h.[QualityofservicesPHC], h.[QualityofservicesCHC], h.[QualityofservicesPrivateClinic], h.[QualityofservicesAnimalDispensary], h.[QualityofservicesVolunteerhealthworker], h.[OverallVillageOpenDefecation], h.[HHsWithToilets], h.[HHsUtilizingToilets], h.[HHsusingPublicToilets], h.[HHsConnectedWithDrainage], h.[PrimarySchool], h.[PrimarySchoolDistance], h.[PrimaryCshoolBoys], h.[PrimarySchoolGirls], h.[PrimarySchoolTransgender], h.[PrimarySchoolTotal], h.[PrimaryNeverAttendedBoys], h.[PrimaryNeverAttendedGirls], h.[PrimaryBoysDropped], h.[PrimaryGuirlsDropped], h.[PrimaryBoysGoing], h.[PrimaryGirlsGoing], h.[Primary6to11Boys], h.[Primary6to11Girls], h.[PrimaryLiteracyStatus], h.[UpperPrimarySchool], h.[UpperPrimarySchoolDistance], h.[UpperPrimaryCshoolBoys], h.[UpperPrimarySchoolGirls], h.[UpperPrimarySchoolTransgender], h.[UpperPrimarySchoolTotal], h.[UpperPrimaryNeverAttendedBoys], h.[UpperPrimaryNeverAttendedGirls], h.[UpperPrimaryBoysDropped], h.[UpperPrimaryGuirlsDropped], h.[UpperPrimaryBoysGoing], h.[UpperPrimaryGirlsGoing], h.[UpperPrimary6to11Boys],h.[UpperPrimary6to11Girls], h.[UpperPrimaryLiteracyStatus], h.[SecondarySchool], h.[SecondarySchoolDistance], h.[SecondaryCshoolBoys], h.[SecondarySchoolGirls], h.[SecondarySchoolTransgender], h.[SecondarySchoolTotal], h.[SecondaryNeverAttendedBoys], h.[SecondaryNeverAttendedGirls], h.[SecondaryBoysDropped], h.[SecondaryGuirlsDropped], h.[SecondaryBoysGoing], h.[SecondaryGirlsGoing], h.[Secondary6to11Boys], h.[Secondary6to11Girls], h.[SecondaryLiteracyStatus], h.[HigherSecondarySchool], h.[HigherSecondarySchoolDistance], h.[HigherSecondaryCshoolBoys], h.[HigherSecondarySchoolGirls], h.[HigherSecondarySchoolTransgender], h.[HigherSecondarySchoolTotal], h.[HigherSecondaryNeverAttendedBoys], h.[HigherSecondaryNeverAttendedGirls], h.[HigherSecondaryBoysDropped], h.[HigherSecondaryGuirlsDropped], h.[HigherSecondaryBoysGoing], h.[HigherSecondaryGirlsGoing], h.[HigherSecondary6to11Boys], h.[HigherSecondary6to11Girls], h.[HigherSecondaryLiteracyStatus], h.[MadrasaSchool], h.[MadrasaSchoolDistance], h.[MadrasaCshoolBoys], h.[MadrasaSchoolGirls], h.[MadrasaSchoolTransgender], h.[MadrasaSchoolTotal], h.[MadrasaNeverAttendedBoys], h.[MadrasaNeverAttendedGirls], h.[MadrasaBoysDropped], h.[MadrasaGuirlsDropped], h.[MadrasaBoysGoing], h.[MadrasaGirlsGoing], h.[Madrasa6to11Boys], h.[Madrasa6to11Girls], h.[MadrasaLiteracyStatus], h.[NooffamilieshavingWidowsorDisabilities], h.[NooffamilieshavingWidowsorDisabilities], h.[Publicdistributionsystemcards], h.[HouseholdcoverwithAtalPensionScheme], h.[Householdcoverwithaccidentalinsurance], h.[Householdcoverwithlifeinsurance], h.[Householdhavinglabourregistrationcard], h.[NoofWomenSelfHelpGroupsformedinthevillage], h.[NameoftheWSHGs], h.[TotalNoofmembersinWSHGs], h.[NoofWomenFarmersGroups], h.[TotalNoofmembersinWFGs], h.[TotalNoofmembersinotherCBOs], h.[ElectricityFacility], h.[HouseholdhavingLPG], h.[MajorsectorwiseNeeds] FROM [tblVillageInfo] A left outer join [tblCSO] B on A.[CSOID]=B.[CSOID]  left outer join tblvillages c on a.VillageID=c.VillageID left outer join tblBlocks d on a.BlockID=d.BlockID left outer join tblDistricts e on a.DistrictID=e.DistrictID left outer join tblStates f on e.StateID=f.StateId left outer join tblHamletInfo g on a.Vid=g.Villageid left outer join tblHamletData h on g.Hid=h.Hid where 1=1 " + Condetion + " order by [CSOName],Village,NameofHamlet,Year asc";
            DataSet ds = db.getResultset(query, "", "", "");
            DataTable dt = new DataTable();
            if (ds != null && ds.Tables[0].Rows.Count > 0)
            {
                dt = ds.Tables[0];
                // Response.Write("<script>alert('excel fired')</script>");
                using (XLWorkbook wb = new XLWorkbook())
                {
                    wb.Worksheets.Add(ds.Tables[0]);
                    using (MemoryStream stream = new MemoryStream())
                    {
                        wb.SaveAs(stream);
                        stream.Position = 0;
                        string myName = Server.UrlEncode("Village_Report" + DateTime.Now.ToShortDateString() + ".xlsx");

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
                ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "ShowAlert('Something went wrong / No Records Found.','error')", true);
            }
        }
    }
}