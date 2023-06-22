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
using CF.Models;

namespace CF
{
    public partial class WfgFilter : System.Web.UI.Page
    {
        DbErrorLog db = new DbErrorLog();
        private Control sender;

        protected void Page_Load(object sender, EventArgs e)
        {

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
            string selectWF = "SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME in ('tblWFGs', 'tblCSO','tblStates','tblBlocks','tblDistricts','tblSocialCategory', 'tblVillages') and COLUMN_NAME not in ('Status', 'UserType', 'Remarks', 'CSOID', 'DistrictID', 'BlockID', 'RegisteredAddress', 'Correspondenceaddress',  'NameandaddressofcontactPerson', 'DistancefromProjectOfficeFaizabad', 'DateofRegistration', 'FCRARegistrationdetail', 'PAN', 'TAN', '12A', '80G', 'GST', 'OtherIfanyNGODarpan',  'OrganizationVision', 'OrganizationMission', 'Organizationcoverageorprojectarea', 'TargetCommunity', 'Agriculturedevelopment', 'WomenempowermentandGovernance', 'Education',  'Health', 'WaterandSanitation', 'SkillDevelopment', 'OtherMajorprogrammaticFocus', 'MajorprogrammaticfocusOtherifany',  'WomenSHG', 'WomenFarmersGroups', 'AdolescentGirlsGroup', 'JointLiabilityGroup',  'CommunitybasedorganizationsOtherIfany', 'DetailofFedrationifany', 'NariSangh',  'WorkingexperienceonpromotionofFarmersProducerCompanyFPC', 'ExperienceinworkingwithWomenFarmersAgricultureClimateChangeandGenderetcIfany',  'ExperienceinimplementingIGPEntrepreneurships',  'ExperienceinworkingwithPRILocalAdminandGovernmentDepartments', 'AnystrikingaccomplishmentbytheorganizationUniquesomethingdifferent', 'RandomNum', 'Vid', 'MajorsectorwiseNeeds', 'NameoftheWSHGs', 'RegisteredAddressmobileno', 'RegisteredAddressEmail', 'RegisteredAddresswebsite', 'Correspondenceaddressmobileno', 'CorrespondenceaddressEmail', 'Correspondenceaddresswebsite', 'addressofcontactPerson', 'MobilenoofcontactPerson', 'EmailofcontactPerson', 'RegistrationNo', 'Registrationact', 'FCRARegistrationDate', 'PANno', 'PANDate', 'PANExpiry', 'TANno', 'TANDate', 'TANExpiry', '12Ano', '12Adate', '12AExpiry', '80Gno', '80GDate', '80GExpiry', 'GSTNo', 'GSTDate', 'GSTExpiry', 'OtherIfanyname', 'OtherIfanyregno', 'websiteofcontactPerson', '80GDOR', 'imagename', 'VillageID', 'PFPCWorkExperiance', 'PFPCWorkExperianceAssociates', 'PFPCWorkExperianceDetails', 'PFPCWorkExperianceNoofFPC', 'WFACGWorkExperiance', 'WFACGWorkExperianceAssociates', 'WFACGWorkExperianceDetails', 'WFACGWorkExperianceYears', 'IGPEWorkExperiance', 'IGPEWorkExperianceAssociates', 'IGPEWorkExperianceDetails', 'IGPEWorkExperianceYears', 'WPRILWorkExperiance', 'WPRILWorkExperianceAssociates', 'WPRILWorkExperianceDetails', 'WPRILWorkExperianceYears', 'ASCOWorkExperiance', 'ASCOWorkExperianceAssociates', 'ASCOWorkExperianceDetails', 'ASCOWorkExperianceYears', 'OtherMajorprogrammaticFocus', 'OtherMajorprogrammaticFocusList', 'RegistrationExpiryDate', 'FCRARegExpiryDate', 'FCRARegistrationNo', 'OtherNGODarpan', 'OrganizationProjectArea', 'NameofContactPerson', 'WomenEmpowerment', 'StateID', 'StateId', 'Sid', 'WFGNo', 'WFGTypeID') order by COLUMN_NAME";
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
            if (selectedColumn == "Village")
            {
                selectWFGData = "SELECT distinct " + selectedColumn + " FROM tblVillageInfo a left outer join tblVillages b on a.VillageID=b.VillageID where " + selectedColumn + " is not null and  " + selectedColumn + "!='' order by " + selectedColumn + " asc";
            }
            //else if (selectedColumn == "AadharNo")
            //{
            //    selectWFGData = "select distinct case when AadharNo!= '' or AadharNo is not null then 'Yes' else 'No' end from tblWFs";
            //}
            else if (selectedColumn == "CSOName")
            {
                selectWFGData = "select distinct CSOName from tblCSO";
            }
            else if (selectedColumn == "SocialCategory")
            {
                selectWFGData = "select distinct SocialCategory from tblSocialCategory";
            }
            else if (selectedColumn == "District")
            {
                selectWFGData = "select distinct District from tblDistricts";
            }
            else if (selectedColumn == "Block")
            {
                selectWFGData = "select Block from tblBlocks";
            }
            else if (selectedColumn == "StateName")
            {
                selectWFGData = "select StateName from tblStates";
            }
            else
            {
                selectWFGData = "SELECT distinct " + selectedColumn + " FROM tblWFGs where " + selectedColumn + " is not null and  " + selectedColumn + "!='' order by " + selectedColumn + " asc";
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

        protected void btnApply_Click(object sender, EventArgs e)
        {
            GetDetails();
        }

        public void GetDetails()
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
                            Qdata += " c.SocialCategory" + Exp + "'" + arrFilter[3] + "' " + arrFilter[2] + "";
                        }
                        else if (arrFilter[0] == "CSOName")
                        {
                            Qdata += " d.CSOName" + Exp + "'" + arrFilter[3] + "' " + arrFilter[2] + "";
                        }
                        else if (arrFilter[0] == "Block")
                        {
                            Qdata += " g.tblBlocks" + Exp + "'" + arrFilter[3] + "' " + arrFilter[2] + "";
                        }
                        else if (arrFilter[0] == "District")
                        {
                            Qdata += " f.District" + Exp + "'" + arrFilter[3] + "' " + arrFilter[2] + "";
                        }
                        else if (arrFilter[0] == "StateName")
                        {
                            Qdata += " h.StateName" + Exp + "'" + arrFilter[3] + "' " + arrFilter[2] + "";
                        }
                        else
                        {
                            Qdata += " a." + arrFilter[0] + Exp + "'" + arrFilter[3] + "' " + arrFilter[2] + "";
                        }
                    }
                    else
                    {
                        andCond = "";
                    }
                }
            }
            string SelectQ = "SELECT WfgNo,StateName,District,Block, CSOName, Village, WFGName, WFGMembers, e.SocialCategory, Hamlet, BankName, AccountHolderName, BankAccountNumber, BankIFSCcode, PresidentName, PresidentContact, Remarks, a.Status FROM dbo.tblWFGs a left outer join tblVillageInfo b on a.VillageID = b.Vid left outer join tblVillages c on b.VillageID=c.VillageID left outer join tblCso d on d.CSOID = b.Csoid left outer join tblSocialCategory e on e.Sid = a.WFGTypeID left outer join tblDistricts f on f.DistrictID=d.DistrictID left outer join tblBlocks g on g.BlockID=d.BlockID left outer join tblStates h on h.StateId=f.StateID where 1=1 " + andCond + "" + Qdata;

            DataSet ds = db.getResultset(SelectQ, "", "", "");
            gvWFG.DataSource = ds;
            gvWFG.DataBind();
            hiddenDataArrayId.Value = "";
            ViewState["dirState"] = ds;
            ViewState["sortdr"] = "Asc";
        }

        protected void gvWFG_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName != "Sort" && e.CommandName != "Page")
            {
                if (e.CommandName == "btnEdit")
                {
                    string strid = e.CommandArgument.ToString();
                    int rowIndex = int.Parse(e.CommandArgument.ToString());
                    string val = (string)this.gvWFG.DataKeys[rowIndex]["WfgNo"].ToString();
                    Session["WfgNo"] = val;
                    Response.Redirect("~/EditWFG.aspx");
                }
                else if (e.CommandName == "Inactive")
                {
                    GridViewRow row = (GridViewRow)(((Control)e.CommandSource).NamingContainer);
                    int RowIndex = row.RowIndex;
                    string val = (string)this.gvWFG.DataKeys[RowIndex]["WfgNo"].ToString();
                    string deleteQ = "update tblWFGs set Status=0 where WfgNo= " + val + "; update tblWFs set Status=0 where WFGID = " + val + ";update tblClients set Status=0 where UserType='WFG' and ClientID = " + val + ";";
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
                    string val = (string)this.gvWFG.DataKeys[RowIndex]["WfgNo"].ToString();
                    string deleteQ = "update  tblWFGs set Status=1 where WfgNo= " + val + "; update tblWFs set Status=1 where WFGID = " + val + ";update tblClients set Status=1 where UserType='WFG' and ClientID = " + val + ";";
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

        protected void gvWFG_Sorting(object sender, GridViewSortEventArgs e)
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
                gvWFG.DataSource = dtrslt;
                gvWFG.DataBind();

            }

            for (int i = 0; i < gvWFG.Columns.Count; i++)
            {
                string lbText = gvWFG.Columns[i].SortExpression;

                if (lbText == e.SortExpression)
                {
                    TableCell tableCell = gvWFG.HeaderRow.Cells[i];
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
            string val = (string)this.gvWFG.DataKeys[index]["WfgNo"].ToString();

            string deleteQ = "Delete from tblWFGs  where WfgNo= " + val + "; ";
            if (db.UpdateQuery(deleteQ, "", "", "") > 0)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "ShowAlert('You have deleted successfully.','success')", true);
            }
            else
            {
                ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "ShowAlert('Something went wrong / Delete Data Under this group.','warning')", true);
            }
        }

        protected void gvWFG_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvWFG.PageIndex = e.NewPageIndex;
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
                        string myName = Server.UrlEncode("WFGReport_" + DateTime.Now.ToShortDateString() + ".xlsx");

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

        protected void gvWFG_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                string Status = gvWFG.DataKeys[e.Row.RowIndex].Values[1].ToString();

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