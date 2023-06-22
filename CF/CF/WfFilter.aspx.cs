using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Web.Services;
using Newtonsoft.Json;
using System.Configuration;
using Excel = Microsoft.Office.Interop.Excel;
using ClosedXML.Excel;
using System.IO;
using System.Drawing;

namespace CF
{
    public partial class WfFilter : System.Web.UI.Page
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
                        if (User != "Admin")
                        {
                            //btnReport.Visible = false;
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
            //string selectWF = "SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'tblWFs'";
            //DataSet ds = db.getResultset(selectWF, "", "", "");

            //ddlFilterColumn1.DataSource = ds;
            //ddlFilterColumn1.DataTextField = "COLUMN_NAME";
            //ddlFilterColumn1.DataValueField = "COLUMN_NAME";

            //ddlFilterColumn1.DataBind();
            //ddlFilterColumn1.Items.Insert(0, "Select");
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
            string selectWF = "SELECT  COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME in ('tblWFs', 'tblWFGs', 'tblCSO', 'tblStates',  'tblBlocks',  'tblDistricts',  'tblRationType','tblVillages','tblCBONature') and COLUMN_NAME not in ('Status', 'UserType', 'Remarks', 'CSOID', 'DistrictID', 'BlockID', 'RegisteredAddress', 'Correspondenceaddress',  'NameandaddressofcontactPerson', 'DistancefromProjectOfficeFaizabad', 'DateofRegistration', 'FCRARegistrationdetail', 'PAN', 'TAN', '12A', '80G', 'GST', 'OtherIfanyNGODarpan',  'OrganizationVision', 'OrganizationMission', 'Organizationcoverageorprojectarea', 'TargetCommunity', 'Agriculturedevelopment', 'WomenempowermentandGovernance', 'Education',  'Health', 'WaterandSanitation', 'SkillDevelopment', 'OtherMajorprogrammaticFocus', 'MajorprogrammaticfocusOtherifany',  'WomenSHG', 'WomenFarmersGroups', 'AdolescentGirlsGroup', 'JointLiabilityGroup',  'CommunitybasedorganizationsOtherIfany', 'DetailofFedrationifany', 'NariSangh',  'WorkingexperienceonpromotionofFarmersProducerCompanyFPC', 'ExperienceinworkingwithWomenFarmersAgricultureClimateChangeandGenderetcIfany',  'ExperienceinimplementingIGPEntrepreneurships',  'ExperienceinworkingwithPRILocalAdminandGovernmentDepartments', 'AnystrikingaccomplishmentbytheorganizationUniquesomethingdifferent', 'RandomNum', 'Vid', 'MajorsectorwiseNeeds', 'NameoftheWSHGs', 'RegisteredAddressmobileno', 'RegisteredAddressEmail', 'RegisteredAddresswebsite', 'Correspondenceaddressmobileno', 'CorrespondenceaddressEmail', 'Correspondenceaddresswebsite', 'addressofcontactPerson', 'MobilenoofcontactPerson', 'EmailofcontactPerson', 'RegistrationNo', 'Registrationact', 'FCRARegistrationDate', 'PANno', 'PANDate', 'PANExpiry', 'TANno', 'TANDate', 'TANExpiry', '12Ano', '12Adate', '12AExpiry', '80Gno', '80GDate', '80GExpiry', 'GSTNo', 'GSTDate', 'GSTExpiry', 'OtherIfanyname', 'OtherIfanyregno', 'websiteofcontactPerson', '80GDOR', 'imagename', 'VillageID', 'PFPCWorkExperiance', 'PFPCWorkExperianceAssociates', 'PFPCWorkExperianceDetails', 'PFPCWorkExperianceNoofFPC', 'WFACGWorkExperiance', 'WFACGWorkExperianceAssociates', 'WFACGWorkExperianceDetails', 'WFACGWorkExperianceYears', 'IGPEWorkExperiance', 'IGPEWorkExperianceAssociates', 'IGPEWorkExperianceDetails', 'IGPEWorkExperianceYears', 'WPRILWorkExperiance', 'WPRILWorkExperianceAssociates', 'WPRILWorkExperianceDetails', 'WPRILWorkExperianceYears', 'ASCOWorkExperiance', 'ASCOWorkExperianceAssociates', 'ASCOWorkExperianceDetails', 'ASCOWorkExperianceYears', 'OtherMajorprogrammaticFocus', 'OtherMajorprogrammaticFocusList', 'RegistrationExpiryDate', 'FCRARegExpiryDate', 'FCRARegistrationNo', 'OtherNGODarpan', 'OrganizationProjectArea', 'NameofContactPerson', 'WomenEmpowerment', 'StateID', 'StateId', 'CBOID', 'CBONatureID', 'Rid', 'Sid', 'SocialCategoryID', 'WFGTypeID', 'RationcardTypeID', 'TypeofRationCard', 'NatureofCBO','WomenName','AccessService','AccountHolder','AccountHolderName','AccountNo','Age','AgriUse','AreaofOwnershipLand','BankAccountNumber','BankIFSCcode','BankName','BaselineSurvey','BenefitTotal','Block','Branch','BuffaloLivestock','Business','BusinessDevelop','CBONature','ClimateFriendly','ClimateStudy','ContactNumber','CowLivestock','CSOName','CultivatingCrop','Deciding','Demonstrate','DemoPlot','DisabilityOther','DisabilityType','District','DOB','FamilyConsulted','FamilyIncome','FarmersCategory','Financialliteracy','FPCName','GenderStudy','GoatLivestock','GovSchemeAmount','GovSchemeName','GramPanchayatName','Hamlet','HasAttendedTraining','HusbandName','ICTAccess','IFSC','irrigatedLandinAcr','isBankAccount','IsBenefit','IsCBOMember','IsDisable','IsGovScheme','IsIrrigatedLand','islandinthenameofwoman','isLivestock','isMNREGA','IsOilCrop','IsOtherCrop','IsOwnershipinLand','IsPaddy','isPulseCrop','isRationcard','IsSharecrops','IsToilet','isUjjwalaGasConnection','isVegitables','isWheat','IsWomenLaboure','JointlyParticipate','LandType','LoanObtain','MajorSourceofFamily','ManageMoney','MaritalStatus','MilkLivestock','MNREGADays','MoreCultivating','NameofBank','NameofBenefitScheme','NameofCBO','NatureofWork','NonIrrigated','NoofFamilyMembersConsulted','NumberOfLiveStock','OffFarm','OilCropAcr','OilCropAvg','OilCropType','OnFarm','OtherBenefitSchemeName','OtherCropAcr','OtherCropAvg','OtherCropsName','OtherEducation','OtherInformation','OtherLivestock','OtherSourceofFamily','OwnLand','OwnLandSelfName','PaddyAcr','PaddyAvg','Percentage','PigLivestock','PostTraining','PoultryLivestock','PracticeType','PresidentContact','PresidentName','PreTraining','ProUse','PulseCropAcr','PulseCropAvg','PulseCropType','Qualification','RationType','Religion','ReligionOther','RentalLand','SharecropsLand','ShareHolder','SocialCategory','SolelyParticipate','SourceofIrrigation','SourceOfIrrigationOther','SourceTotal','StateName','ToiletFunction','TotalFamilyMembers','TotalLandinHectors','TotalNonIrrigatedLand','TrainingFollowUps','TrainingName','TrainingOther','VegitableCropType','VegitablesAcr','VegitablesAvg','Village','VName','VName','VocationalTraining','WanttoPartofFPC','WFGMembers','WFGName','WFGNames','WheatAcr','WheatAvg','AadharNo','WfgNo','WFGID') order by COLUMN_NAME";
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

            string selectWFData = "";
            if (selectedColumn == "CSOName")
            {
                selectWFData = "select distinct CSOName from tblCSO";
            }
            else if (selectedColumn == "SocialCategory")
            {
                selectWFData = "select distinct SocialCategory from tblSocialCategory";
            }
            else if (selectedColumn == "District")
            {
                selectWFData = "select distinct District from tblDistricts";
            }
            else if (selectedColumn == "Block")
            {
                selectWFData = "select Block from tblBlocks";
            }
            else if (selectedColumn == "StateName")
            {
                selectWFData = "select StateName from tblStates";
            }
            else if (selectedColumn == "WFGName")
            {
                selectWFData = "select WFGName from tblWFGs";
            }
            else if (selectedColumn == "RationType")
            {
                selectWFData = "select RationType from tblRationType";
            }
            else if (selectedColumn == "CBONature")
            {
                selectWFData = "select CBONature from tblCBONature";
            }
            else if (selectedColumn == "AadharNo")
            {
                selectWFData = "select distinct (case when AadharNo is null or AadharNo='' then 'No' else 'Yes' end) as AadharNo from tblWFs";
            }
            else if (selectedColumn == "Village")
            {
                selectWFData = "SELECT distinct " + selectedColumn + " FROM tblVillageInfo a left outer join tblVillages b on a.VillageID=b.VillageID where " + selectedColumn + " is not null and  " + selectedColumn + "!='' order by " + selectedColumn + " asc";
            }
            else
            {
                selectWFData = "SELECT distinct " + selectedColumn + " FROM tblWFs where " + selectedColumn + " is not null and  " + selectedColumn + "!='' order by " + selectedColumn + " asc";
            }
            DataSet ds = db.getResultset(selectWFData, "", "", "");
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

        protected void btnApply_Click(object sender, EventArgs e)
        {
            GetDetails();
        }

        public void GetDetails()
        {
            string Qdata = "";
            string Exp = "";
            string condetion = "";
            if (hiddenDataArrayId.Value != "")
            {
                string[] filterOptions = hiddenDataArrayId.Value.ToString().Split('$');
                for (int i = 0; i < filterOptions.Length; i++)
                {
                    string[] arrFilter = filterOptions[i].Split(':');
                    if (arrFilter[0] != "Select" && arrFilter[3] != "Select")
                    {
                        condetion = " and";
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
                        else if (arrFilter[1] == "Is Less Than")
                        {
                            Exp = "<";
                        }
                        else if (arrFilter[1] == "Is Greater Than")
                        {
                            Exp = ">";
                        }
                        else if (arrFilter[1] == "Is Greater Than Equal")
                        {
                            Exp = ">=";
                        }
                        else if (arrFilter[1] == "Is Less Than Equal")
                        {
                            Exp = "<=";
                        }

                        if (arrFilter[0] == "SocialCategory")
                        {
                            Qdata += " e.SocialCategory" + Exp + "'" + arrFilter[3] + "' " + arrFilter[2] + "";
                        }

                        else if (arrFilter[0] == "AadharNo")
                        {
                            if (arrFilter[3] == "Yes")
                            {
                                Exp = " IS NOT NULL";
                            }
                            else
                            {
                                Exp = " IS NULL";
                            }

                            Qdata += " a.AadharNo" + Exp + arrFilter[2] + "";
                        }
                        else if (arrFilter[0] == "RationType")
                        {
                            Qdata += " g.RationType" + Exp + "'" + arrFilter[3] + "' " + arrFilter[2] + "";
                        }
                        else if (arrFilter[0] == "CBONature")
                        {
                            Qdata += " f.CBONature" + Exp + "'" + arrFilter[3] + "' " + arrFilter[2] + "";
                        }
                        else if (arrFilter[0] == "Block")
                        {
                            Qdata += " i.tblBlocks" + Exp + "'" + arrFilter[3] + "' " + arrFilter[2] + "";
                        }
                        else if (arrFilter[0] == "District")
                        {
                            Qdata += " j.District" + Exp + "'" + arrFilter[3] + "' " + arrFilter[2] + "";
                        }
                        else if (arrFilter[0] == "StateName")
                        {
                            Qdata += " k.StateName" + Exp + "'" + arrFilter[3] + "' " + arrFilter[2] + "";
                        }
                        else if (arrFilter[0] == "Village")
                        {
                            Qdata += " h.Village" + Exp + "'" + arrFilter[3] + "' " + arrFilter[2] + "";
                        }
                        else if (arrFilter[0] == "WFGName")
                        {
                            Qdata += " b.WFGName" + Exp + "'" + arrFilter[3] + "' " + arrFilter[2] + "";
                        }
                        else if (arrFilter[0] == "CSOName")
                        {
                            Qdata += " CSOName" + Exp + "'" + arrFilter[3] + "' " + arrFilter[2] + "";
                        }
                        else
                        {
                            Qdata += " a." + arrFilter[0] + Exp + "'" + arrFilter[3] + "' " + arrFilter[2] + "";
                        }
                        
                    }
                }
            }
            string SelectQ = "SELECT a.WfNo,k.StateName,District,Block,CSOName,WFGName,WomenName,HusbandName,MaritalStatus,Village,c.GramPanchayatName,Age,DOB,Qualification,a.SocialCategory,SocialCategoryID,AadharNo,isBankAccount,NameofBank,AccountHolder,AccountNo,IFSC,TotalFamilyMembers,IsCBOMember,NameofCBO,CBONatureID,isRationcard,RationcardTypeID,IsToilet,ToiletFunction,ContactNumber,Branch,[BusinessDevelop] as [Op2.2WFG members business developed],[Percentage] as [Op1.3Percentage of trained],[ICTAccess] as [Op2.3WFGmembers accessICT],[OnFarm] as [Op2.3aOnFarm],[OffFarm] as [Op2.3bOffFarm],[SolelyParticipate] as [Op2.5WFGmember solely decisions],[JointlyParticipate] as [Op2.5WFGmember Jointly decisions],[Financialliteracy] as [Op2.1WFGmembers financial literacy],[Deciding] as [Op2.4WFGmember decisions],Religion,ReligionOther,IsDisable,DisabilityType,DisabilityOther,VocationalTraining,BaselineSurvey,ClimateStudy,GenderStudy,[AccessService] as [Oc1.3.WFGmembers with access to business],[ClimateFriendly] as [Oc1.4WFGmembers practising climate friendly agriculture],[MoreCultivating] as [Oc.1.5WFGmembers cultivating],[MajorSourceofFamily] as[Major Source of income of family],[SourceOfIrrigationOther] as [other],[BuffaloLivestock] as [Buffalo],[CowLivestock] as [Cow],[GoatLivestock] as[Goat],[PoultryLivestock] as [Paultry],[OwnLandSelfName] as [Family Land Ownership],[IsOwnershipinLand] as [area of land having ownership],[islandinthenameofwoman] as [Whether woman has ownership in land],[AreaofOwnershipLand] as [If Yes, area of land having ownership],[irrigatedLandinAcr] as [Total Irrigated land],[TotalNonIrrigatedLand] as [Total Non irrigated land],[SourceofIrrigation] as [Source of irrigation],[IsSharecrops] as [Whether a sharecropper],[SharecropsLand] as [IfYes,areaofland],[ShareHolder] as [Op3.1.WFGmembers shareholder],DemoPlot,WheatAcr,PaddyAcr,OtherCropsName,OilCropAcr,VegitablesAcr,NameofBenefitScheme,isUjjwalaGasConnection,OtherBenefitSchemeName,IsGovScheme,GovSchemeName,GovSchemeAmount,OtherInformation,isMNREGA,FamilyIncome,a.Status FROM tblWFs a left outer join tblWFGs b on a.WFGID = b.WfgNo  left outer join tblVillageInfo c on a.VillageID = c.Vid left outer join tblCSO d on c.CSOID = d.CSOID left outer join tblSocialCategory e on a.SocialCategoryID=e.Sid left outer join tblCBONature f on a.CBONatureID = f.CBOID left outer join tblRationType g on a.RationcardTypeID = g.Rid left outer join tblVillages h on c.VillageID=h.VillageID left outer join tblBlocks i on i.BlockID=h.BlockID left outer join tblDistricts j on i.DistrictID=j.DistrictID left outer join tblStates k on k.StateId=j.StateID where 1=1" + condetion + Qdata;
            DataSet ds = db.getResultset(SelectQ, "", "", "");

            gvWF.DataSource = ds;
            gvWF.DataBind();
            hiddenDataArrayId.Value = "";
            ViewState["dirState"] = ds;
            ViewState["sortdr"] = "Asc";
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

        protected void gvWF_Sorting(object sender, GridViewSortEventArgs e)
        {
            DataSet ds = (DataSet)ViewState["dirState"];

            DataTable dtrslt = ds.Tables[0];

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

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            GridViewRow gvRow = (GridViewRow)(sender as Control).Parent.Parent;
            int index = gvRow.RowIndex;
            string val = (string)this.gvWF.DataKeys[index]["WfNo"].ToString();

            string deleteQ = "update tblWFs set Status=0 where WfNo=" + val;
            if (db.UpdateQuery(deleteQ, "", "", "") > 0)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "ShowAlert('You have deleted successfully.','success')", true);
            }
            else
            {
                ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "ShowAlert('Something went wrong / Delete Data Under this group.','warning')", true);
            }
        }

        protected void gvWF_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvWF.PageIndex = e.NewPageIndex;
            GetDetails();
        }

        protected void btnReport_Click(object sender, EventArgs e)
        {
            DataSet ds = (DataSet)ViewState["dirState"];
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