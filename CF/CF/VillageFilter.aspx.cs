using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using Excel = Microsoft.Office.Interop.Excel;
using ClosedXML.Excel;
using System.IO;
using System.Drawing;

namespace CF
{
    public partial class VillageFilter : System.Web.UI.Page
    {
        DbErrorLog db = new DbErrorLog();
        string User = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserType"] != null)
            {
                User = Session["UserType"].ToString();
                if (User == "Admin")
                {
                    if (!IsPostBack)
                    {

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

        public class ColumnList
        {
            public string COLUMN_NAME { get; set; }
        }

        [WebMethod]
        public static List<ColumnList> BindColumns()
        {
            DbErrorLog db = new DbErrorLog();
            List<ColumnList> lst = new List<ColumnList>();
            string selectWF = "SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME in ('tblVillageInfo', 'tblCSO', 'tblVillages', 'tblBlocks', 'tblDistricts', 'tblStates') and COLUMN_NAME not in ('Status', 'UserType', 'Remarks', 'CSOID', 'DistrictID', 'BlockID', 'RegisteredAddress', 'Correspondenceaddress',  'NameandaddressofcontactPerson', 'DistancefromProjectOfficeFaizabad', 'DateofRegistration', 'FCRARegistrationdetail', 'PAN', 'TAN', '12A', '80G', 'GST', 'OtherIfanyNGODarpan',  'OrganizationVision', 'OrganizationMission', 'Organizationcoverageorprojectarea', 'TargetCommunity', 'Agriculturedevelopment', 'WomenempowermentandGovernance', 'Education',  'Health', 'WaterandSanitation', 'SkillDevelopment', 'OtherMajorprogrammaticFocus', 'MajorprogrammaticfocusOtherifany',  'WomenSHG', 'WomenFarmersGroups', 'AdolescentGirlsGroup', 'JointLiabilityGroup',  'CommunitybasedorganizationsOtherIfany', 'DetailofFedrationifany', 'NariSangh',  'WorkingexperienceonpromotionofFarmersProducerCompanyFPC', 'ExperienceinworkingwithWomenFarmersAgricultureClimateChangeandGenderetcIfany',  'ExperienceinimplementingIGPEntrepreneurships',  'ExperienceinworkingwithPRILocalAdminandGovernmentDepartments', 'AnystrikingaccomplishmentbytheorganizationUniquesomethingdifferent', 'RandomNum', 'Vid', 'MajorsectorwiseNeeds', 'NameoftheWSHGs', 'RegisteredAddressmobileno', 'RegisteredAddressEmail', 'RegisteredAddresswebsite', 'Correspondenceaddressmobileno', 'CorrespondenceaddressEmail', 'Correspondenceaddresswebsite', 'addressofcontactPerson', 'MobilenoofcontactPerson', 'EmailofcontactPerson', 'RegistrationNo', 'Registrationact', 'FCRARegistrationDate', 'PANno', 'PANDate', 'PANExpiry', 'TANno', 'TANDate', 'TANExpiry', '12Ano', '12Adate', '12AExpiry', '80Gno', '80GDate', '80GExpiry', 'GSTNo', 'GSTDate', 'GSTExpiry', 'OtherIfanyname', 'OtherIfanyregno', 'websiteofcontactPerson', '80GDOR', 'imagename', 'VillageID', 'PFPCWorkExperiance', 'PFPCWorkExperianceAssociates', 'PFPCWorkExperianceDetails', 'PFPCWorkExperianceNoofFPC', 'WFACGWorkExperiance', 'WFACGWorkExperianceAssociates', 'WFACGWorkExperianceDetails', 'WFACGWorkExperianceYears', 'IGPEWorkExperiance', 'IGPEWorkExperianceAssociates', 'IGPEWorkExperianceDetails', 'IGPEWorkExperianceYears', 'WPRILWorkExperiance', 'WPRILWorkExperianceAssociates', 'WPRILWorkExperianceDetails', 'WPRILWorkExperianceYears', 'ASCOWorkExperiance', 'ASCOWorkExperianceAssociates', 'ASCOWorkExperianceDetails', 'ASCOWorkExperianceYears', 'OtherMajorprogrammaticFocus', 'OtherMajorprogrammaticFocusList', 'RegistrationExpiryDate', 'FCRARegExpiryDate', 'FCRARegistrationNo', 'OtherNGODarpan', 'OrganizationProjectArea', 'NameofContactPerson', 'WomenEmpowerment', 'StateID', 'StateId')";
            DataSet ds = db.getResultset(selectWF, "", "", "");
            if (ds != null && ds.Tables[0].Rows.Count > 0)
            {
                for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                {
                    ColumnList clmnName = new ColumnList();
                    clmnName.COLUMN_NAME = ds.Tables[0].Rows[i]["COLUMN_NAME"].ToString();
                    lst.Add(clmnName);
                }
            }
            return lst;
        }

        public class SelectedColumnDataList
        {
            public string selectedColumnData { get; set; }
        }

        [WebMethod]
        public static List<SelectedColumnDataList> BindDataFromColumns(string selectedColumn)
        {
            DbErrorLog db = new DbErrorLog();
            List<SelectedColumnDataList> Datalst = new List<SelectedColumnDataList>();

            string selectWFGData = "";

            if (selectedColumn == "CSOName")
            {
                selectWFGData = "select distinct CSOName from tblCSO";
            }
            else if (selectedColumn == "Block")
            {
                selectWFGData = "select Block from tblBlocks";
            }
            else if (selectedColumn == "District")
            {
                selectWFGData = "select District from tblDistricts";
            }
            else if (selectedColumn == "StateName")
            {
                selectWFGData = "select StateName from tblStates";
            }
            else
            {
                selectWFGData = "SELECT distinct " + selectedColumn + " FROM tblVillageInfo a left outer join tblVillages b on a.VillageID=b.VillageID where " + selectedColumn + " is not null and  " + selectedColumn + "!='' order by " + selectedColumn + " asc";
            }
            DataSet ds = db.getResultset(selectWFGData, "", "", "");
            if (ds != null && ds.Tables[0].Rows.Count > 0)
            {
                for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                {
                    SelectedColumnDataList SelectedclmnData = new SelectedColumnDataList();
                    SelectedclmnData.selectedColumnData = ds.Tables[0].Rows[i][0].ToString();
                    Datalst.Add(SelectedclmnData);
                }
            }
            return Datalst;
        }

        protected void gvVillage_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName != "Sort" && e.CommandName != "Page")
            {
                if (e.CommandName == "btnEdit")
                {
                    string strid = e.CommandArgument.ToString();
                    int rowIndex = int.Parse(e.CommandArgument.ToString());
                    string val = (string)this.gvVillage.DataKeys[rowIndex]["Vid"].ToString();
                    Session["Vid"] = val;
                    Response.Redirect("~/EditVillage.aspx");
                }
                else if (e.CommandName == "Hamlet")
                {
                    string strid = e.CommandArgument.ToString();
                    int rowIndex = int.Parse(e.CommandArgument.ToString());
                    string val = (string)this.gvVillage.DataKeys[rowIndex]["Vid"].ToString();
                    Session["Vid"] = val;
                    Response.Redirect("~/VillageHamlet.aspx");
                }
                else if (e.CommandName == "Inactive")
                {
                    GridViewRow row = (GridViewRow)(((Control)e.CommandSource).NamingContainer);
                    int RowIndex = row.RowIndex;
                    string val = (string)this.gvVillage.DataKeys[RowIndex]["Vid"].ToString();
                    string deleteQ = "update tblVillageInfo set Status=0 where Vid=" + val;
                    if (db.UpdateQuery(deleteQ, "", "", "") > 0)
                    {
                        ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "ShowAlert('You have deactivated successfully.','success')", true);
                    }
                    else
                    {
                        ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "ShowAlert('Something went wrong please try again.','warning')", true);
                    }
                }
                else if (e.CommandName == "Active")
                {
                    GridViewRow row = (GridViewRow)(((Control)e.CommandSource).NamingContainer);
                    int RowIndex = row.RowIndex;
                    string val = (string)this.gvVillage.DataKeys[RowIndex]["Vid"].ToString();
                    string deleteQ = "update tblVillageInfo set Status=1 where Vid=" + val;
                    if (db.UpdateQuery(deleteQ, "", "", "") > 0)
                    {
                        ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "ShowAlert('You have activated successfully.','success')", true);
                    }
                    else
                    {
                        ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "ShowAlert('Something went wrong please try again.','warning')", true);
                    }
                }
            }
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            GridViewRow gvRow = (GridViewRow)(sender as Control).Parent.Parent;
            int index = gvRow.RowIndex;
            string val = (string)this.gvVillage.DataKeys[index]["Vid"].ToString();

            string deleteQ = "Delete from tblVillageInfo where Vid=" + val + ";Delete from tblHamletInfo where Villageid=" + val + ";";
            if (db.UpdateQuery(deleteQ, "", "", "") > 0)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "ShowAlert('You have deleted Village successfully.','success')", true);
            }
            else
            {
                ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "ShowAlert('Something went wrong / Delete Data Under this Village.','warning')", true);
            }
        }

        protected void gvVillage_Sorting(object sender, GridViewSortEventArgs e)
        {
            DataSet ds = (DataSet)ViewState["dirState"];
            DataTable dtrslt = ds.Tables[0];
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
                gvVillage.DataSource = dtrslt;
                gvVillage.DataBind();
            }

            for (int i = 0; i < gvVillage.Columns.Count; i++)
            {
                string lbText = gvVillage.Columns[i].SortExpression;

                if (lbText == e.SortExpression)
                {
                    TableCell tableCell = gvVillage.HeaderRow.Cells[i];
                    System.Web.UI.WebControls.Image img = new System.Web.UI.WebControls.Image();
                    img.ImageUrl = (Convert.ToString(ViewState["sortdr"]) == "Asc") ? "~/Images/ArrowUp.gif" : "~/Images/ArrowDown.gif";
                    tableCell.Controls.Add(new LiteralControl("&nbsp;"));
                    tableCell.Controls.Add(img);
                }
            }
        }

        protected void gvVillage_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvVillage.PageIndex = e.NewPageIndex;
            GetDetails();
        }

        protected void btnApply_Click(object sender, EventArgs e)
        {
            GetDetails();
        }

        protected void GetDetails()
        {
            string Qdata = "";
            string Exp = "";
            string andCond = "";
            if (hiddenDataArrayId.Value != "" && hiddenDataArrayId.Value != null)
            {
                string[] filterOptions = hiddenDataArrayId.Value.ToString().Split('$');

                for (int i = 0; i < filterOptions.Length; i++)
                {
                    string[] arrFilter = filterOptions[i].Split(':');

                    if (arrFilter[0] != "Select" && arrFilter[3] != "Select")
                    {
                        andCond = " And";
                        if (i == filterOptions.Length - 1)
                        {
                            arrFilter[2] = "";
                        }

                        if (arrFilter[1] == "Is")
                        {
                            Exp = "=";
                        }
                        else if (arrFilter[1] == "Is Not")
                        {
                            Exp = "!=";
                        }
                        //else if (arrFilter[1] == "Is Less Than")
                        //{
                        //    Exp = "<";
                        //}
                        //else if (arrFilter[1] == "Is Greater Than")
                        //{
                        //    Exp = ">";
                        //}
                        //else if (arrFilter[1] == "Is Greater Than Equal")
                        //{
                        //    Exp = ">=";
                        //}
                        //else if (arrFilter[1] == "Is Less Than Equal")
                        //{
                        //    Exp = "<=";
                        //}

                        if (arrFilter[0] == "CSOName")
                        {
                            Qdata += " CSOName" + Exp + "'" + arrFilter[3] + "' " + arrFilter[2] + "";
                        }
                        else
                        {
                            Qdata += " " + arrFilter[0] + Exp + "'" + arrFilter[3] + "' " + arrFilter[2] + "";
                        }
                    }
                    else
                    {
                        andCond = "";
                    }
                }
            }
            string SelectQ = "SELECT  [Vid],StateName,e.District,d.Block, c.[Village],[CSOName],A.[Status], count(distinct g.Hid) as HamletCount FROM [tblVillageInfo] A left outer join [tblCSO] B on A.[CSOID]=B.[CSOID]  left outer join tblvillages c on a.VillageID=c.VillageID left outer join tblBlocks d on a.BlockID=d.BlockID left outer join tblDistricts e on a.DistrictID=e.DistrictID left outer join tblStates f on e.StateID=f.StateId left outer join tblHamletInfo g on a.Vid=g.Villageid where 1=1 " + andCond + "" + Qdata + " group by [Vid],StateName,e.District,d.Block, c.[Village],[CSOName],A.[Status] order by [CSOName],Village asc";

            DataSet ds = db.getResultset(SelectQ, "", "", "");
            gvVillage.DataSource = ds;
            gvVillage.DataBind();
            hiddenDataArrayId.Value = "";

            ViewState["CSOCondetion"] = andCond + "" + Qdata;
            ViewState["dirState"] = ds;
            ViewState["sortdr"] = "Asc";
        }

        protected void btnReport_Click(object sender, EventArgs e)
        {
            string query = "SELECT StateName,[CSOName],e.District,g.DistanceofDistrict,g.SubdistrictName,g.DistanceofSubdistrict,d.Block,g.DistanceofBlockfromVillage,a.GramPanchayatName,g.DistancefromGramPanchayat,c.[Village],g.DistanceofVillage,NameofHamlet,g.PostofficeName,g.DistancefromPostoffice,g.PostOfficepin,g.PolicestationName,g.DistanceofPolicestation,[Year],[Rank],h.SCHH,h.STHH,h.OBCHH,h.GeneralHH, h.TotalPopulation,h.MalePopulation,h.FemalePopulation,h.BoysPopulation,h.GirlsPopulation,h.TransgenderPopulation, h.SCPopulation, h.STPopulation, h.OBCPopulation, h.GemeralPopulation, h.TotalLand, h.CultivableLand, h.PloughingLand, h.IrrigatedLand, h.UnirrigatedLand, h.LandInderForest, h.WasteLand, h.PastureLand, h.OtherLand, h.landupto1acr, h.land1to2hec, h.land2to4hec, h.landmorethan4, h.NoofFamilieshavenoLand, h.Jan, h.Feb, h.Mar, h.Apr, h.May, h.Jun, h.Jul, h.Aug, h.Sep, h.Oct, h.Nov, h.Dec, h.AveragewaterLevel, h.AverageWaterTDSinDrinkingSource, h.DWSPublicWells, h.DWSPrivateWells, h.DWSPublicHandPumps, h.[DWSPrivateHandPumps], h.[DWSPublicTaps], h.[DWSPublicPonds], h.[DWSCanal], h.[DWSPublicTubewell], h.[DWSPrivateTubwell], h.[DWSDieselPumps], h.[WSPublicWells], h.[WSPrivateWells], h.[WSPublicHandPumps], h.[WSPrivateHandPumps], h.[WSPublicTaps], h.[WSPublicPonds], h.[WSCanal], h.[WSPublicTubewell], h.[WSPrivateTubwell], h.[WSDieselPumps], h.[WSOther], h.ConditionofHealthCentresSubcentreorANM, h.[ConditionofHealthCentresPHC], h.[ConditionofHealthCentresCHC], h.[ConditionofHealthCentresPrivateClinic], h.[ConditionofHealthCentresAnimalDispensary], h.[ConditionofHealthCentresVolunteerhealthworker], h.[QualityofservicesSubcentreorANM], h.[QualityofservicesPHC], h.[QualityofservicesCHC], h.[QualityofservicesPrivateClinic], h.[QualityofservicesAnimalDispensary], h.[QualityofservicesVolunteerhealthworker], h.[OverallVillageOpenDefecation], h.[HHsWithToilets], h.[HHsUtilizingToilets], h.[HHsusingPublicToilets], h.[HHsConnectedWithDrainage], h.[PrimarySchool], h.[PrimarySchoolDistance], h.[PrimaryCshoolBoys], h.[PrimarySchoolGirls], h.[PrimarySchoolTransgender], h.[PrimarySchoolTotal], h.[PrimaryNeverAttendedBoys], h.[PrimaryNeverAttendedGirls], h.[PrimaryBoysDropped], h.[PrimaryGuirlsDropped], h.[PrimaryBoysGoing], h.[PrimaryGirlsGoing], h.[Primary6to11Boys], h.[Primary6to11Girls], h.[PrimaryLiteracyStatus], h.[UpperPrimarySchool], h.[UpperPrimarySchoolDistance], h.[UpperPrimaryCshoolBoys], h.[UpperPrimarySchoolGirls], h.[UpperPrimarySchoolTransgender], h.[UpperPrimarySchoolTotal], h.[UpperPrimaryNeverAttendedBoys], h.[UpperPrimaryNeverAttendedGirls], h.[UpperPrimaryBoysDropped], h.[UpperPrimaryGuirlsDropped], h.[UpperPrimaryBoysGoing], h.[UpperPrimaryGirlsGoing], h.[UpperPrimary6to11Boys],h.[UpperPrimary6to11Girls], h.[UpperPrimaryLiteracyStatus], h.[SecondarySchool], h.[SecondarySchoolDistance], h.[SecondaryCshoolBoys], h.[SecondarySchoolGirls], h.[SecondarySchoolTransgender], h.[SecondarySchoolTotal], h.[SecondaryNeverAttendedBoys], h.[SecondaryNeverAttendedGirls], h.[SecondaryBoysDropped], h.[SecondaryGuirlsDropped], h.[SecondaryBoysGoing], h.[SecondaryGirlsGoing], h.[Secondary6to11Boys], h.[Secondary6to11Girls], h.[SecondaryLiteracyStatus], h.[HigherSecondarySchool], h.[HigherSecondarySchoolDistance], h.[HigherSecondaryCshoolBoys], h.[HigherSecondarySchoolGirls], h.[HigherSecondarySchoolTransgender], h.[HigherSecondarySchoolTotal], h.[HigherSecondaryNeverAttendedBoys], h.[HigherSecondaryNeverAttendedGirls], h.[HigherSecondaryBoysDropped], h.[HigherSecondaryGuirlsDropped], h.[HigherSecondaryBoysGoing], h.[HigherSecondaryGirlsGoing], h.[HigherSecondary6to11Boys], h.[HigherSecondary6to11Girls], h.[HigherSecondaryLiteracyStatus], h.[MadrasaSchool], h.[MadrasaSchoolDistance], h.[MadrasaCshoolBoys], h.[MadrasaSchoolGirls], h.[MadrasaSchoolTransgender], h.[MadrasaSchoolTotal], h.[MadrasaNeverAttendedBoys], h.[MadrasaNeverAttendedGirls], h.[MadrasaBoysDropped], h.[MadrasaGuirlsDropped], h.[MadrasaBoysGoing], h.[MadrasaGirlsGoing], h.[Madrasa6to11Boys], h.[Madrasa6to11Girls], h.[MadrasaLiteracyStatus], h.[NooffamilieshavingWidowsorDisabilities], h.[NooffamilieshavingWidowsorDisabilities], h.[Publicdistributionsystemcards], h.[HouseholdcoverwithAtalPensionScheme], h.[Householdcoverwithaccidentalinsurance], h.[Householdcoverwithlifeinsurance], h.[Householdhavinglabourregistrationcard], h.[NoofWomenSelfHelpGroupsformedinthevillage], h.[NameoftheWSHGs], h.[TotalNoofmembersinWSHGs], h.[NoofWomenFarmersGroups], h.[TotalNoofmembersinWFGs], h.[TotalNoofmembersinotherCBOs], h.[ElectricityFacility], h.[HouseholdhavingLPG], h.[MajorsectorwiseNeeds] FROM [tblVillageInfo] A left outer join [tblCSO] B on A.[CSOID]=B.[CSOID]  left outer join tblvillages c on a.VillageID=c.VillageID left outer join tblBlocks d on a.BlockID=d.BlockID left outer join tblDistricts e on a.DistrictID=e.DistrictID left outer join tblStates f on e.StateID=f.StateId left outer join tblHamletInfo g on a.Vid=g.Villageid left outer join tblHamletData h on g.Hid=h.Hid where 1=1 " + ViewState["CSOCondetion"] + " order by [CSOName],Village,NameofHamlet,Year,Rank asc";
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

        protected void gvVillage_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                string Status = gvVillage.DataKeys[e.Row.RowIndex].Values[1].ToString();

                if (Status == "True")
                {
                    Button btnSave = (Button)e.Row.FindControl("btnStatus");
                    btnSave.Text = "Inactive";
                    btnSave.CommandName = "Inactive";
                    btnSave.CssClass = "btn btn-danger";
                }
                else
                {
                    Button btnSave = (Button)e.Row.FindControl("btnStatus");
                    btnSave.Text = "Active";
                    btnSave.CommandName = "Active";
                    btnSave.CssClass = "btn btn-warning";
                }
            }
        }

        protected void Gridview1_RowCreated(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                if (Convert.ToString(Session["UserType"]) == "CSO")
                {
                    e.Row.Cells[6].CssClass = "hiddencol";
                }
            }
            else if (e.Row.RowType == DataControlRowType.Header)
            {
                if (Convert.ToString(Session["UserType"]) == "CSO")
                {
                    e.Row.Cells[6].CssClass = "hiddencol";
                }
            }
        }

    }
}