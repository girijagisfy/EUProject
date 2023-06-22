using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using ClosedXML.Excel;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;

namespace CF
{
    public partial class VillageHamlet : System.Web.UI.Page
    {
        DbErrorLog db = new DbErrorLog();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Vid"] != null)
            {
                if (!IsPostBack)
                {
                    GetDetails();
                }
            }
            else
            {
                Response.Redirect("~/VillagesInfo.aspx");
            }
        }

        protected void GetDetails()
        {
            string vidCondetion = Session["Vid"].ToString();

            string selectQ = "SELECT [Hid],[Village],[NameofHamlet] FROM [dbo].[tblHamletInfo] A  left outer join [tblVillageInfo] B on A.[Villageid]=B.[Vid] left outer join tblVillages c on b.VillageID=c.VillageID where 1=1 and B.[Vid]=" + vidCondetion;

            DataSet ds = db.getResultset(selectQ, "", "", "");
            DataTable dt = new DataTable();
            if (ds != null && ds.Tables[0].Rows.Count > 0)
            {
                dt = ds.Tables[0];
            }

            Gridview1.DataSource = dt;
            Gridview1.DataBind();

            ViewState["dirState"] = dt;
            ViewState["sortdr"] = "Asc";
        }
        protected void Gridview1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName.Equals("btnEdit"))
            {
                string strid = e.CommandName.ToString();
                int rowIndex = int.Parse(e.CommandArgument.ToString());
                string val = (string)this.Gridview1.DataKeys[rowIndex]["Hid"].ToString();
                Session["Hid"] = val;
                Response.Redirect("EditHamlet.aspx");
            }
            if (e.CommandName.Equals("btnEditData"))
            {
                string strid = e.CommandName.ToString();
                int rowIndex = int.Parse(e.CommandArgument.ToString());
                string val = (string)this.Gridview1.DataKeys[rowIndex]["Hid"].ToString();
                Session["Hid"] = val;
                Response.Redirect("HamletDataInfo.aspx");
            }
        }

        protected void btnReport_Click(object sender, EventArgs e)
        {
            string query = "SELECT StateName,[CSOName],e.District,g.DistanceofDistrict,g.SubdistrictName,g.DistanceofSubdistrict,d.Block,g.DistanceofBlockfromVillage,a.GramPanchayatName,g.DistancefromGramPanchayat,c.[Village],g.DistanceofVillage,NameofHamlet,g.PostofficeName,g.DistancefromPostoffice,g.PostOfficepin,g.PolicestationName,g.DistanceofPolicestation,[Year],h.SCHH,h.STHH,h.OBCHH,h.GeneralHH, h.TotalPopulation,h.MalePopulation,h.FemalePopulation,h.BoysPopulation,h.GirlsPopulation,h.TransgenderPopulation, h.SCPopulation, h.STPopulation, h.OBCPopulation, h.GemeralPopulation,  h.TotalLand, h.CultivableLand, h.PloughingLand, h.IrrigatedLand, h.UnirrigatedLand, h.LandInderForest, h.WasteLand, h.PastureLand, h.OtherLand, h.landupto1acr, h.land1to2hec, h.land2to4hec, h.landmorethan4, h.NoofFamilieshavenoLand, h.Jan, h.Feb, h.Mar, h.Apr, h.May, h.Jun, h.Jul, h.Aug, h.Sep, h.Oct, h.Nov, h.Dec, h.AveragewaterLevel, h.AverageWaterTDSinDrinkingSource, h.DWSPublicWells, h.DWSPrivateWells, h.DWSPublicHandPumps, h.[DWSPrivateHandPumps], h.[DWSPublicTaps], h.[DWSPublicPonds], h.[DWSCanal], h.[DWSPublicTubewell], h.[DWSPrivateTubwell], h.[DWSDieselPumps], h.[WSPublicWells], h.[WSPrivateWells], h.[WSPublicHandPumps], h.[WSPrivateHandPumps], h.[WSPublicTaps], h.[WSPublicPonds], h.[WSCanal], h.[WSPublicTubewell], h.[WSPrivateTubwell], h.[WSDieselPumps], h.[WSOther], h.ConditionofHealthCentresSubcentreorANM, h.[ConditionofHealthCentresPHC], h.[ConditionofHealthCentresCHC], h.[ConditionofHealthCentresPrivateClinic], h.[ConditionofHealthCentresAnimalDispensary], h.[ConditionofHealthCentresVolunteerhealthworker], h.[QualityofservicesSubcentreorANM], h.[QualityofservicesPHC], h.[QualityofservicesCHC], h.[QualityofservicesPrivateClinic], h.[QualityofservicesAnimalDispensary], h.[QualityofservicesVolunteerhealthworker], h.[OverallVillageOpenDefecation], h.[HHsWithToilets], h.[HHsUtilizingToilets], h.[HHsusingPublicToilets], h.[HHsConnectedWithDrainage], h.[PrimarySchool], h.[PrimarySchoolDistance], h.[PrimaryCshoolBoys], h.[PrimarySchoolGirls], h.[PrimarySchoolTransgender], h.[PrimarySchoolTotal], h.[PrimaryNeverAttendedBoys], h.[PrimaryNeverAttendedGirls], h.[PrimaryBoysDropped], h.[PrimaryGuirlsDropped], h.[PrimaryBoysGoing], h.[PrimaryGirlsGoing], h.[Primary6to11Boys], h.[Primary6to11Girls], h.[PrimaryLiteracyStatus], h.[UpperPrimarySchool], h.[UpperPrimarySchoolDistance], h.[UpperPrimaryCshoolBoys], h.[UpperPrimarySchoolGirls], h.[UpperPrimarySchoolTransgender], h.[UpperPrimarySchoolTotal], h.[UpperPrimaryNeverAttendedBoys], h.[UpperPrimaryNeverAttendedGirls], h.[UpperPrimaryBoysDropped], h.[UpperPrimaryGuirlsDropped], h.[UpperPrimaryBoysGoing], h.[UpperPrimaryGirlsGoing], h.[UpperPrimary6to11Boys],h.[UpperPrimary6to11Girls], h.[UpperPrimaryLiteracyStatus], h.[SecondarySchool], h.[SecondarySchoolDistance], h.[SecondaryCshoolBoys], h.[SecondarySchoolGirls], h.[SecondarySchoolTransgender], h.[SecondarySchoolTotal], h.[SecondaryNeverAttendedBoys], h.[SecondaryNeverAttendedGirls], h.[SecondaryBoysDropped], h.[SecondaryGuirlsDropped], h.[SecondaryBoysGoing], h.[SecondaryGirlsGoing], h.[Secondary6to11Boys], h.[Secondary6to11Girls], h.[SecondaryLiteracyStatus], h.[HigherSecondarySchool], h.[HigherSecondarySchoolDistance], h.[HigherSecondaryCshoolBoys], h.[HigherSecondarySchoolGirls], h.[HigherSecondarySchoolTransgender], h.[HigherSecondarySchoolTotal], h.[HigherSecondaryNeverAttendedBoys], h.[HigherSecondaryNeverAttendedGirls], h.[HigherSecondaryBoysDropped], h.[HigherSecondaryGuirlsDropped], h.[HigherSecondaryBoysGoing], h.[HigherSecondaryGirlsGoing], h.[HigherSecondary6to11Boys], h.[HigherSecondary6to11Girls], h.[HigherSecondaryLiteracyStatus], h.[MadrasaSchool], h.[MadrasaSchoolDistance], h.[MadrasaCshoolBoys], h.[MadrasaSchoolGirls], h.[MadrasaSchoolTransgender], h.[MadrasaSchoolTotal], h.[MadrasaNeverAttendedBoys], h.[MadrasaNeverAttendedGirls], h.[MadrasaBoysDropped], h.[MadrasaGuirlsDropped], h.[MadrasaBoysGoing], h.[MadrasaGirlsGoing], h.[Madrasa6to11Boys], h.[Madrasa6to11Girls], h.[MadrasaLiteracyStatus], h.[NooffamilieshavingWidowsorDisabilities], h.[NooffamilieshavingWidowsorDisabilities], h.[Publicdistributionsystemcards], h.[HouseholdcoverwithAtalPensionScheme], h.[Householdcoverwithaccidentalinsurance], h.[Householdcoverwithlifeinsurance], h.[Householdhavinglabourregistrationcard], h.[NoofWomenSelfHelpGroupsformedinthevillage], h.[NameoftheWSHGs], h.[TotalNoofmembersinWSHGs], h.[NoofWomenFarmersGroups], h.[TotalNoofmembersinWFGs], h.[TotalNoofmembersinotherCBOs], h.[ElectricityFacility], h.[HouseholdhavingLPG], h.[MajorsectorwiseNeeds] FROM [tblVillageInfo] A left outer join [tblCSO] B on A.[CSOID]=B.[CSOID]  left outer join tblvillages c on a.VillageID=c.VillageID left outer join tblBlocks d on a.BlockID=d.BlockID left outer join tblDistricts e on a.DistrictID=e.DistrictID left outer join tblStates f on e.StateID=f.StateId left outer join tblHamletInfo g on a.Vid=g.Villageid left outer join tblHamletData h on g.Hid=h.Hid where where Vid=" + Session["Vid"] + " order by [CSOName],Village,NameofHamlet,Year asc";
            DataSet ds = db.getResultset(query, "", "", "");
            if (ds != null && ds.Tables[0].Rows.Count > 0)
            {
                using (XLWorkbook wb = new XLWorkbook())
                {
                    wb.Worksheets.Add(ds.Tables[0]);
                    using (MemoryStream stream = new MemoryStream())
                    {
                        wb.SaveAs(stream);
                        stream.Position = 0;
                        string myName = Server.UrlEncode("Hamlet_Info_" + DateTime.Now.ToShortDateString() + ".xlsx");

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
                ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "ShowAlert('No Records Found.','error','')", true);
            }
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            GridViewRow gvRow = (GridViewRow)(sender as Control).Parent.Parent;
            int index = gvRow.RowIndex;
            string val = (string)this.Gridview1.DataKeys[index]["Hid"].ToString();

            string deleteQ = "delete from tblHamletinfo where Hid = " + val + "; delete from tblAnganwadiDetails where HamletID=" + val + "; delete from tblNaturalResouce_Livestock where HamletID=" + val + "; delete from tblNaturalResouce_CroppingPattern where HamletID=" + val + "; delete from tblDiseasesinvillage where HamletID=" + val + "; delete from tblFinancialLiteracyandInclusion  where HamletID=" + val + "; delete from tblDetailsofVillageService where HamletID=" + val + "; ";
            if (db.UpdateQuery(deleteQ, "", "", "") > 0)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "ShowAlert('You have deleted cso successfully.','success')", true);
            }
            else
            {
                ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "ShowAlert('Something went wrong please try again.','warning')", true);
            }
        }

        protected void Gridview1_Sorting(object sender, GridViewSortEventArgs e)
        {
            DataTable dtrslt = (DataTable)ViewState["dirState"];

            //DataTable dtrslt = ds.Tables[0];

            if (dtrslt.Rows.Count > 0)
            {

                if (Convert.ToString(ViewState["sortdr"]) == "Asc")
                {
                    dtrslt.DefaultView.Sort = e.SortExpression + " Desc";
                    ViewState["sortdr"] = "Desc";
                }
                else
                {
                    dtrslt.DefaultView.Sort = e.SortExpression + " Asc";
                    ViewState["sortdr"] = "Asc";
                }
                Gridview1.DataSource = dtrslt;
                Gridview1.DataBind();
            }

            for (int i = 0; i < Gridview1.Columns.Count; i++)
            {
                string lbText = Gridview1.Columns[i].SortExpression;

                if (lbText == e.SortExpression)
                {
                    TableCell tableCell = Gridview1.HeaderRow.Cells[i];
                    Image img = new Image();
                    img.ImageUrl = (Convert.ToString(ViewState["sortdr"]) == "Asc") ? "~/Images/ArrowUp.gif" : "~/Images/ArrowDown.gif";
                    tableCell.Controls.Add(new LiteralControl("&nbsp;"));
                    tableCell.Controls.Add(img);
                }
            }
        }

        protected void Gridview1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            Gridview1.PageIndex = e.NewPageIndex;
            GetDetails();
        }

        protected void Gridview1_RowCreated(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                if (Convert.ToString(Session["UserType"]) == "CSO")
                {
                    e.Row.Cells[4].CssClass = "hiddencol";
                }
            }
            else if (e.Row.RowType == DataControlRowType.Header)
            {
                if (Convert.ToString(Session["UserType"]) == "CSO")
                {
                    e.Row.Cells[4].CssClass = "hiddencol";
                }
            }
        }
    }
}