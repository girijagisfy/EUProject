using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Configuration;
using Excel = Microsoft.Office.Interop.Excel;
using ClosedXML.Excel;
using System.IO;
using System.Drawing;

namespace CF
{
    public partial class WFInfo : System.Web.UI.Page
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
                        dvVillage.Visible = false;
                        ddlvillage.Visible = false;
                        if (User != "Admin")
                        {
                            btnFilter.Visible = false;
                        }
                        if (User == "Admin")
                        {
                            btnReport.Visible = false;
                        }
                        if (User != "WFG")
                        {
                            dvVillage.Visible = true;
                            ddlvillage.Visible = true;
                            GetVillages();
                        }
                        GetDetails();
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

        public void GetVillages()
        {
            string VillageCondetion = "";
            if (User == "CSO")
            {
                VillageCondetion = " and CSOID = " + Session["ClientID"];
            }
            string query = "Select Vid,Village from tblVillageInfo b left outer join tblVillages a on a.VillageID = b.VillageID where 1=1 " + VillageCondetion + " order by VIllage";
            DataSet ds = db.getResultset(query, "", "", "");

            ddlvillage.DataSource = ds;
            ddlvillage.DataTextField = "Village";
            ddlvillage.DataValueField = "Vid";
            ddlvillage.DataBind();
            ddlvillage.Items.Insert(0, "All");
        }
        public void GetDetails()
        {
            string status = "";
            if (ddlStatus.SelectedIndex == 1)
            {
                status = " and a.Status = 1";
            }
            else if (ddlStatus.SelectedIndex == 2)
            {
                status = " and a.Status = 0";
            }
            string villageid = "";
            string Condetion = "";
            if (User == "Admin")
            {
                if (ddlvillage.SelectedValue != "All")
                {
                    villageid = "and c.Vid =" + ddlvillage.SelectedValue;
                }
            }
            else if (User == "CSO")
            {
                Condetion = " and a.Csoid=" + Session["ClientID"];
                if (ddlvillage.SelectedValue != "All")
                {
                    villageid = "and c.Vid =" + ddlvillage.SelectedValue;
                }
            }
            else if (User == "WFG")
            {
                Condetion = " and a.WFGID=" + Session["ClientID"];
            }
            string query = "SELECT WfNo, WomenName, Village, CSOName, b.WFGName, ContactNumber,a.Status FROM dbo.tblWFs a left outer join tblWFGs b on a.WFGID = b.WfgNo  left outer join tblVillageInfo c on a.VillageID = c.Vid left outer join tblVillages e on c.VillageID = e.VillageID left outer join tblCSO d on c.CSOID = d.CSOID where 1=1 " + status + villageid + Condetion + " order by WomenName";

            DataSet ds = db.getResultset(query, "", "", "");
            DataTable dt = new DataTable();
            if (ds != null && ds.Tables[0].Rows.Count > 0)
            {
                dt = ds.Tables[0];
            }
            gvWF.DataSource = dt;
            gvWF.DataBind();

            ViewState["dirState"] = dt;
            ViewState["sortdr"] = "Asc";

        }


        protected void gvWF_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvWF.PageIndex = e.NewPageIndex;
            GetDetails();
        }

        protected void gvWF_Sorting(object sender, GridViewSortEventArgs e)
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
                gvWF.DataSource = dtrslt;
                gvWF.DataBind();
            }

            for (int i = 0; i < gvWF.Columns.Count; i++)
            {
                string lbText = gvWF.Columns[i].SortExpression;

                if (lbText == e.SortExpression)
                {
                    TableCell tableCell = gvWF.HeaderRow.Cells[i];
                    System.Web.UI.WebControls.Image img = new System.Web.UI.WebControls.Image();
                    img.ImageUrl = (Convert.ToString(ViewState["sortdr"]) == "Asc") ? "~/Images/ArrowUp.gif" : "~/Images/ArrowDown.gif";
                    tableCell.Controls.Add(new LiteralControl("&nbsp;"));
                    tableCell.Controls.Add(img);
                }
            }
        }

        protected void gvWF_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName != "Sort" && e.CommandName != "Page")
            {
                if (e.CommandName == "btnEdit")
                {
                    string strid = e.CommandArgument.ToString();
                    int rowIndex = int.Parse(e.CommandArgument.ToString());
                    string val = (string)this.gvWF.DataKeys[rowIndex]["WfNo"].ToString();
                    Session["WfNo"] = val;
                    Response.Redirect("~/EditWF.aspx");
                }
                else if (e.CommandName == "Inactive")
                {
                    GridViewRow row = (GridViewRow)(((Control)e.CommandSource).NamingContainer);
                    int RowIndex = row.RowIndex;
                    string val = (string)this.gvWF.DataKeys[RowIndex]["WfNo"].ToString();
                    string deleteQ = "update tblWFs set Status=0 where WfNo=" + val;
                    if (db.UpdateQuery(deleteQ, "", "", "") > 0)
                    {
                        ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "ShowAlert('You have Deactivated successfully.','success')", true);
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
                    string val = (string)this.gvWF.DataKeys[RowIndex]["WfNo"].ToString();
                    string deleteQ = "update tblWFs set Status=1 where WfNo=" + val;
                    if (db.UpdateQuery(deleteQ, "", "", "") > 0)
                    {
                        ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "ShowAlert('You have Activated successfully.','success')", true);
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
            string val = (string)this.gvWF.DataKeys[index]["WfNo"].ToString();

            string deleteQ = "delete from tblWFsIncomeSourceDetails where WFno=" + val + ";delete from tblWFsGovBenefits where WFno=" + val + ";delete from tblWFsYearData where WFno=" + val + ";delete from tblwfs where wfno=" + val;
            if (db.UpdateQuery(deleteQ, "", "", "") > 0)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "ShowAlert('You have deleted successfully.','success')", true);
            }
            else
            {
                ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "ShowAlert('Something went wrong please try again.','warning')", true);
            }
        }

        protected void ddlvillage_SelectedIndexChanged(object sender, EventArgs e)
        {
            GetDetails();
        }

        protected void btnReport_Click(object sender, EventArgs e)
        {
            string status = "";
            if (ddlStatus.SelectedIndex == 1)
            {
                status = " and a.Status = 1";
            }
            else if (ddlStatus.SelectedIndex == 2)
            {
                status = " and a.Status = 0";
            }
            string villageid = "";
            string Condetion = "";
            if (User == "Admin")
            {
                if (ddlvillage.SelectedValue != "All")
                {
                    villageid = "and c.Vid =" + ddlvillage.SelectedValue;
                }
            }
            else if (User == "CSO")
            {
                Condetion = " and a.Csoid=" + Session["ClientID"];
                if (ddlvillage.SelectedValue != "All")
                {
                    villageid = "and c.Vid =" + ddlvillage.SelectedValue;
                }
            }
            else if (User == "WFG")
            {
                Condetion = " and a.WFGID=" + Session["ClientID"];
            }
            ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "ShowLoader()", true);
            string query = "Select a.WfNo,CSOName,k.StateName,District,Block,Village,Year,c.GramPanchayatName,WFGName,Hamlet,WomenName,HusbandName,MaritalStatus,Religion,ReligionOther,a.SocialCategory,AadharNo,Age,DOB,Qualification,TotalFamilyMembers,isRationcard,TypeofRationCard,isBankAccount,NameofBank,[Branch] as [BranchName],AccountHolder,AccountNo,IFSC,IsCBOMember,NameofCBO,NatureofCBO,isUjjwalaGasConnection,IsToilet,ToiletFunction,IsDisable,DisabilityType,DisabilityOther,VocationalTraining,BaselineSurvey,ClimateStudy,GenderStudy,a.[ICTAccess] as [Op2.3 WFGmembers accessICT],a.[OnFarm] as [Op2.3a.OnFarm],a.[OffFarm] as [Op2.3b.OffFarm],[SolelyParticipate] as [Op2.5.WFGmember solely decisions],[JointlyParticipate] as [Op2.5.WFGmember Jointly decisions],a.[ShareHolder] as [Op3.1.WFGmembers shareholder],a.[Financialliteracy] as [Op2.1.WFGmembers financial literacy],ContactNumber,a.[BusinessDevelop] as [Op2.2.WFG members with business developed],a.[AccessService] as [Oc1.3.WFGmembers with access to business],FamilyIncome,a.[ClimateFriendly] as [Oc1.4.WFGmembers practising climate friendly agriculture],a.[MoreCultivating] as [Oc.1.5.WFGmembers cultivating],a.[MajorSourceofFamily] as [Major Source of income of the family],a.[SourceOfIrrigationOther] as [other],a.[BuffaloLivestock] as [Buffalo],a.[CowLivestock] as [Cow],a.[GoatLivestock] as[Goat],a.[PoultryLivestock] as [Paultry],a.[IsOwnershipinLand] as [Family Land Ownership],a.[OwnLandSelfName] as [If Yes, area of land having ownership],a.[islandinthenameofwoman] as [Whether woman has ownership in land],a.[AreaofOwnershipLand] as [If Yes, area of land having ownership],a.[irrigatedLandinAcr] as [Total Irrigated land],[TotalNonIrrigatedLand] as [Total Non irrigated land],a.[SourceofIrrigation] as [Source of irrigation],a.[IsSharecrops] as [Whether a sharecropper],a.[SharecropsLand] as [IfYes,areaofland],a.DemoPlot,a.WheatAcr,a.PaddyAcr,a.OtherCropsName,a.OilCropAcr,a.VegitablesAcr,a.NameofBenefitScheme,a.OtherBenefitSchemeName,a.IsGovScheme,a.GovSchemeName,a.GovSchemeAmount,OtherInformation,a.isMNREGA,z.NumberOfLiveStock ,(case when z.isVegitables = 'Yes' then z.VegitablesAcr else '0' end) as StapleCrops, z.HasAttendedTraining,case when a.TrainingName='Other' then a.TrainingOther else a.TrainingName end TrainingName,z.TrainingFollowUps,z.Business,z.AccessService,concat('Use of organic manure:', z.UseofOrganicManure,', Use of water conservation.-Micro irrigantion facilites:', z.Useofwaterconservation,', Use of multi-cropping:', z.UseofMultiCropping,', O tillage farming:', z.OTillageFarming,', Direct seeded rice-BSR:', z.DirectSeededRiceBSR,', Sysytem of Root Intensification:', z.SysytemofRootIntensification, ', Carbon Reduction:', z.CarbonReduction,', Use of Seeds Variety:', z.UseofSeedsVariety,', Mixed cropping:', z.Mixedcropping,', Other:', z.PracticeType) PracticeType,z.CultivatingCrop, z.AgriUse, z.ProUse, PercTrained, z.PreTraining, z.PostTraining,z.LoanObtain, z.ManageMoney,concat('Choice of crops:',CropChoice,', Inputs-Material investment in agriculture:', Input,', Deciding crop cycle', a.Deciding,', Timing of cropping:', Timing,', Deciding crop sowing time:', DecidingTime, ', Crop harvesting', Harvesting, ', Sale/transfer of land:', SaleLand) as ProductiveResources,a.Status FROM tblWFs a  left outer join tblWFsYearData z on a.Wfno=z.WFno left outer join tblWFGs b on a.WFGID = b.WfgNo  left outer join tblVillageInfo c on a.VillageID = c.Vid left outer join tblCSO d on c.CSOID = d.CSOID left outer join tblSocialCategory e on a.SocialCategoryID = e.Sid left outer join tblCBONature f on a.CBONatureID = f.CBOID left outer join tblRationType g on a.RationcardTypeID = g.Rid left outer join tblVillages h on c.VillageID = h.VillageID left outer join tblBlocks i on i.BlockID = h.BlockID left outer join tblDistricts j on i.DistrictID = j.DistrictID left outer join tblStates k on k.StateId = j.StateID where 1 = 1" + status + villageid + Condetion + " order by WomenName";
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
                        string myName = Server.UrlEncode("WFReport_" + DateTime.Now.ToShortDateString() + ".xlsx");

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

        protected void gvWF_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                string Status = gvWF.DataKeys[e.Row.RowIndex].Values[1].ToString();

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

        protected void ddlStatus_SelectedIndexChanged(object sender, EventArgs e)
        {
            GetDetails();
        }

        protected void Gridview1_RowCreated(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                if (Convert.ToString(Session["UserType"]) == "CSO" || Convert.ToString(Session["UserType"]) == "WFG")
                {
                    e.Row.Cells[7].CssClass = "hiddencol";
                }
            }
            else if (e.Row.RowType == DataControlRowType.Header)
            {
                if (Convert.ToString(Session["UserType"]) == "CSO" || Convert.ToString(Session["UserType"]) == "WFG")
                {
                    e.Row.Cells[7].CssClass = "hiddencol";
                }
            }
        }
    }
}