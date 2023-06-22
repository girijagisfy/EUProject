using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using ClosedXML.Excel;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CF
{
    public partial class VillagesInfo : System.Web.UI.Page
    {
        DbErrorLog db = new DbErrorLog();

        string User = "";
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
                        GetDetails();
                    }
                }
            }
            else
            {
                Response.Redirect("~/Logout.aspx");
            }
        }

        protected void GetDetails()
        {
            string CSOCondetion = "";
            if (Convert.ToString(Session["UserType"]) == "CSO")
            {
                btnFilter.Visible = false;
                CSOCondetion = " and B.CSOID=" + Session["ClientID"];
            }

            string selectQ = "SELECT  [Vid],StateName,e.District,d.Block, c.[Village],[CSOName],A.[Status], count(distinct g.Hid) as HamletCount FROM [tblVillageInfo] A left outer join [tblCSO] B on A.[CSOID]=B.[CSOID]  left outer join tblvillages c on a.VillageID=c.VillageID left outer join tblBlocks d on a.BlockID=d.BlockID left outer join tblDistricts e on a.DistrictID=e.DistrictID left outer join tblStates f on e.StateID=f.StateId left outer join tblHamletInfo g on a.Vid=g.Villageid where 1=1 " + CSOCondetion + " group by [Vid],StateName,e.District,d.Block, c.[Village],[CSOName],A.[Status] order by [CSOName],Village asc";

            DataSet ds = db.getResultset(selectQ, "", "", "");
            DataTable dt = new DataTable();
            if (ds != null && ds.Tables[0].Rows.Count > 0)
            {
                dt = ds.Tables[0];
            }

            Gridview1.DataSource = dt;
            Gridview1.DataBind();

            ViewState["CSOCondetion"] = CSOCondetion;
            ViewState["dirState"] = dt;
            ViewState["sortdr"] = "Asc";
        }

        protected void btnReport_Click(object sender, EventArgs e)
        {
            //string query = "SELECT StateName,[CSOName],e.District,g.DistanceofDistrict,g.SubdistrictName,g.DistanceofSubdistrict,d.Block,g.DistanceofBlockfromVillage,a.GramPanchayatName,g.DistancefromGramPanchayat,c.[Village],g.DistanceofVillage,NameofHamlet,g.PostofficeName,g.DistancefromPostoffice,g.PostOfficepin,g.PolicestationName,g.DistanceofPolicestation,[Year],[Rank],h.SCHH,h.STHH,h.OBCHH,h.GeneralHH,h.MinorityHH, h.TotalPopulation,h.MalePopulation,h.FemalePopulation,h.BoysPopulation,h.GirlsPopulation,h.TransgenderPopulation, h.SCPopulation, h.STPopulation, h.OBCPopulation, h.GemeralPopulation, h.MinorityPopulation, h.TotalLand, h.CultivableLand, h.PloughingLand, h.IrrigatedLand, h.UnirrigatedLand, h.LandInderForest, h.WasteLand, h.PastureLand, h.OtherLand, h.landupto1acr, h.land1to2hec, h.land2to4hec, h.landmorethan4, h.NoofFamilieshavenoLand, h.Jan, h.Feb, h.Mar, h.Apr, h.May, h.Jun, h.Jul, h.Aug, h.Sep, h.Oct, h.Nov, h.Dec, h.AveragewaterLevel, h.AverageWaterTDSinDrinkingSource, h.DWSPublicWells, h.DWSPrivateWells, h.DWSPublicHandPumps, h.[DWSPrivateHandPumps], h.[DWSPublicTaps], h.[DWSPublicPonds], h.[DWSCanal], h.[DWSPublicTubewell], h.[DWSPrivateTubwell], h.[DWSDieselPumps], h.[WSPublicWells], h.[WSPrivateWells], h.[WSPublicHandPumps], h.[WSPrivateHandPumps], h.[WSPublicTaps], h.[WSPublicPonds], h.[WSCanal], h.[WSPublicTubewell], h.[WSPrivateTubwell], h.[WSDieselPumps], h.[WSOther], h.ConditionofHealthCentresSubcentreorANM, h.[ConditionofHealthCentresPHC], h.[ConditionofHealthCentresCHC], h.[ConditionofHealthCentresPrivateClinic], h.[ConditionofHealthCentresAnimalDispensary], h.[ConditionofHealthCentresVolunteerhealthworker], h.[QualityofservicesSubcentreorANM], h.[QualityofservicesPHC], h.[QualityofservicesCHC], h.[QualityofservicesPrivateClinic], h.[QualityofservicesAnimalDispensary], h.[QualityofservicesVolunteerhealthworker], h.[OverallVillageOpenDefecation], h.[HHsWithToilets], h.[HHsUtilizingToilets], h.[HHsusingPublicToilets], h.[HHsConnectedWithDrainage], h.[PrimarySchool], h.[PrimarySchoolDistance], h.[PrimaryCshoolBoys], h.[PrimarySchoolGirls], h.[PrimarySchoolTransgender], h.[PrimarySchoolTotal], h.[PrimaryNeverAttendedBoys], h.[PrimaryNeverAttendedGirls], h.[PrimaryBoysDropped], h.[PrimaryGuirlsDropped], h.[PrimaryBoysGoing], h.[PrimaryGirlsGoing], h.[Primary6to11Boys], h.[Primary6to11Girls], h.[PrimaryLiteracyStatus], h.[UpperPrimarySchool], h.[UpperPrimarySchoolDistance], h.[UpperPrimaryCshoolBoys], h.[UpperPrimarySchoolGirls], h.[UpperPrimarySchoolTransgender], h.[UpperPrimarySchoolTotal], h.[UpperPrimaryNeverAttendedBoys], h.[UpperPrimaryNeverAttendedGirls], h.[UpperPrimaryBoysDropped], h.[UpperPrimaryGuirlsDropped], h.[UpperPrimaryBoysGoing], h.[UpperPrimaryGirlsGoing], h.[UpperPrimary6to11Boys],h.[UpperPrimary6to11Girls], h.[UpperPrimaryLiteracyStatus], h.[SecondarySchool], h.[SecondarySchoolDistance], h.[SecondaryCshoolBoys], h.[SecondarySchoolGirls], h.[SecondarySchoolTransgender], h.[SecondarySchoolTotal], h.[SecondaryNeverAttendedBoys], h.[SecondaryNeverAttendedGirls], h.[SecondaryBoysDropped], h.[SecondaryGuirlsDropped], h.[SecondaryBoysGoing], h.[SecondaryGirlsGoing], h.[Secondary6to11Boys], h.[Secondary6to11Girls], h.[SecondaryLiteracyStatus], h.[HigherSecondarySchool], h.[HigherSecondarySchoolDistance], h.[HigherSecondaryCshoolBoys], h.[HigherSecondarySchoolGirls], h.[HigherSecondarySchoolTransgender], h.[HigherSecondarySchoolTotal], h.[HigherSecondaryNeverAttendedBoys], h.[HigherSecondaryNeverAttendedGirls], h.[HigherSecondaryBoysDropped], h.[HigherSecondaryGuirlsDropped], h.[HigherSecondaryBoysGoing], h.[HigherSecondaryGirlsGoing], h.[HigherSecondary6to11Boys], h.[HigherSecondary6to11Girls], h.[HigherSecondaryLiteracyStatus], h.[MadrasaSchool], h.[MadrasaSchoolDistance], h.[MadrasaCshoolBoys], h.[MadrasaSchoolGirls], h.[MadrasaSchoolTransgender], h.[MadrasaSchoolTotal], h.[MadrasaNeverAttendedBoys], h.[MadrasaNeverAttendedGirls], h.[MadrasaBoysDropped], h.[MadrasaGuirlsDropped], h.[MadrasaBoysGoing], h.[MadrasaGirlsGoing], h.[Madrasa6to11Boys], h.[Madrasa6to11Girls], h.[MadrasaLiteracyStatus], h.[NooffamilieshavingWidowsorDisabilities], h.[NooffamilieshavingWidowsorDisabilities], h.[Publicdistributionsystemcards], h.[HouseholdcoverwithAtalPensionScheme], h.[Householdcoverwithaccidentalinsurance], h.[Householdcoverwithlifeinsurance], h.[Householdhavinglabourregistrationcard], h.[NoofWomenSelfHelpGroupsformedinthevillage], h.[NameoftheWSHGs], h.[TotalNoofmembersinWSHGs], h.[NoofWomenFarmersGroups], h.[TotalNoofmembersinWFGs], h.[TotalNoofmembersinotherCBOs], h.[ElectricityFacility], h.[HouseholdhavingLPG], h.[MajorsectorwiseNeeds] FROM [tblVillageInfo] A left outer join [tblCSO] B on A.[CSOID]=B.[CSOID]  left outer join tblvillages c on a.VillageID=c.VillageID left outer join tblBlocks d on a.BlockID=d.BlockID left outer join tblDistricts e on a.DistrictID=e.DistrictID left outer join tblStates f on e.StateID=f.StateId left outer join tblHamletInfo g on a.Vid=g.Villageid left outer join tblHamletData h on g.Hid=h.Hid where 1=1 " + ViewState["CSOCondetion"] + " order by [CSOName],Village,NameofHamlet,Year,Rank asc";
            string query = "SELECT  [Vid],StateName,e.District,d.Block, c.[Village],[CSOName],A.[Status], count(distinct g.Hid) as HamletCount FROM [tblVillageInfo] A left outer join [tblCSO] B on A.[CSOID]=B.[CSOID]  left outer join tblvillages c on a.VillageID=c.VillageID left outer join tblBlocks d on a.BlockID=d.BlockID left outer join tblDistricts e on a.DistrictID=e.DistrictID left outer join tblStates f on e.StateID=f.StateId left outer join tblHamletInfo g on a.Vid=g.Villageid where 1=1 " + ViewState["CSOCondetion"] + " group by [Vid],StateName,e.District,d.Block, c.[Village],[CSOName],A.[Status] order by [CSOName],Village asc";

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
                        string myName = Server.UrlEncode("Villages_Info_" + DateTime.Now.ToShortDateString() + ".xlsx");

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

        protected void Gridview1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName != "Sort" && e.CommandName != "Page")
            {
                if (e.CommandName.Equals("btnEdit"))
                {
                    string strid = e.CommandName.ToString();
                    int rowIndex = int.Parse(e.CommandArgument.ToString());
                    string val = (string)this.Gridview1.DataKeys[rowIndex]["Vid"].ToString();
                    Session["Vid"] = val;
                    Response.Redirect("EditVillage.aspx");

                }
                else if (e.CommandName.Equals("Hamlet"))
                {
                    string strid = e.CommandName.ToString();
                    int rowIndex = int.Parse(e.CommandArgument.ToString());
                    string val = (string)this.Gridview1.DataKeys[rowIndex]["Vid"].ToString();
                    Session["Vid"] = val;
                    Response.Redirect("VillageHamlet.aspx");
                }
                else if (e.CommandName == "Inactive")
                {
                    GridViewRow row = (GridViewRow)(((Control)e.CommandSource).NamingContainer);
                    int RowIndex = row.RowIndex;
                    string val = (string)this.Gridview1.DataKeys[RowIndex]["Vid"].ToString();
                    string deleteQ = "update tblVillageInfo set Status = 0 where Vid=" + val + "; update tblWFGs set Status=0 from tblWFGs a left outer join tblVillageInfo b on a.VillageID = b.Vid left outer join tblCSO c on b.CSOID=c.CSOID where a.VillageID = " + val + "; update tblWFs set Status=0 from tblWFs a left outer join tblWFGs b on a.WFGID=b.WfgNo left outer join tblVillageInfo c on b.VillageID = c.Vid left outer join tblCSO d on c.CSOID=d.CSOID where a.VillageID = " + val + "; update tblClients set Status=0 from tblClients a left outer join tblCSO b on a.ClientID=b.CSOID left outer join tblVillageInfo c on b.CSOID=c.CSOID where a.UserType = 'CSO' and c.Vid=" + val + ";update tblClients set Status=0 from tblClients a left outer join tblWFGs b on a.ClientID=b.WfgNo left outer join tblVillageInfo c on b.VillageID=c.Vid left outer join tblCSO d on c.CSOID=d.CSOID where a.UserType='WFG' and c.Vid=" + val;
                    if (db.UpdateQuery(deleteQ, "", "", "") > 0)
                    {
                        ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "ShowAlert('You have Deactivated Village successfully.','success')", true);
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
                    string val = (string)this.Gridview1.DataKeys[RowIndex]["Vid"].ToString();
                    string deleteQ = "update tblVillageInfo set Status = 1 where Vid=" + val + "; update tblWFGs set Status=1 from tblWFGs a left outer join tblVillageInfo b on a.VillageID = b.Vid left outer join tblCSO c on b.CSOID=c.CSOID where a.VillageID = " + val + "; update tblWFs set Status=1 from tblWFs a left outer join tblWFGs b on a.WFGID=b.WfgNo left outer join tblVillageInfo c on b.VillageID = c.Vid left outer join tblCSO d on c.CSOID=d.CSOID where a.VillageID = " + val + "; update tblClients set Status=1 from tblClients a left outer join tblCSO b on a.ClientID=b.CSOID left outer join tblVillageInfo c on b.CSOID=c.CSOID where a.UserType = 'CSO' and c.Vid=" + val + ";update tblClients set Status=1 from tblClients a left outer join tblWFGs b on a.ClientID=b.WfgNo left outer join tblVillageInfo c on b.VillageID=c.Vid left outer join tblCSO d on c.CSOID=d.CSOID where a.UserType='WFG' and c.Vid=" + val;
                    if (db.UpdateQuery(deleteQ, "", "", "") > 0)
                    {
                        ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "ShowAlert('You have Activated Village successfully.','success')", true);
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
            string val = (string)this.Gridview1.DataKeys[index]["Vid"].ToString();

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

        protected void Gridview1_RowDataBound(object sender, GridViewRowEventArgs e)
        {

            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                string Status = Gridview1.DataKeys[e.Row.RowIndex].Values[1].ToString();

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