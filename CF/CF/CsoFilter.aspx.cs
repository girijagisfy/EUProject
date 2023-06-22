using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Web.Services;
using ClosedXML.Excel;
using Newtonsoft.Json;
using System.Configuration;
using Excel = Microsoft.Office.Interop.Excel;
using System.IO;
using System.Drawing;

namespace CF
{
    public partial class CsoFilter : System.Web.UI.Page
    {
        DbErrorLog db = new DbErrorLog();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserType"] != null)
            {

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
            string selectWF = "SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME in ( 'tblCso', 'tblStates', 'tblBlocks', 'tblDistricts') and COLUMN_NAME not in ('CSOID','BlockID','Status','UserType','DistrictID','StateID') order by COLUMN_NAME";
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
            if (selectedColumn == "District")
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
            //else if (selectedColumn == "AadharNo")
            //{
            //    selectWFGData = "select distinct case when AadharNo!= '' or AadharNo is not null then 'Yes' else 'No' end from tblWFs";
            //}
            //else if (selectedColumn == "CSOName")
            //{
            //    selectWFGData = "select distinct CSOName from tblCSO";
            //}
            //else if (selectedColumn == "WFGTypeID")
            //{
            //    selectWFGData = "select distinct SocialCategory from tblSocialCategory";
            //}
            else
            {
                selectWFGData = "SELECT distinct [" + selectedColumn + "] FROM tblCso where [" + selectedColumn + "] is not null and  [" + selectedColumn + "] !='' order by [" + selectedColumn + "] asc";
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

                        if (arrFilter[0] == "CSOName")
                        {
                            Qdata += " a.CSOName" + Exp + "'" + arrFilter[3] + "' " + arrFilter[2] + "";
                        }
                        else if (arrFilter[0] == "RegisteredAddress")
                        {
                            Qdata += " a.RegisteredAddress" + Exp + "'" + arrFilter[3] + "' " + arrFilter[2] + "";
                        }
                        else if (arrFilter[0] == "Correspondenceaddress")
                        {
                            Qdata += " a.Correspondenceaddress" + Exp + "'" + arrFilter[3] + "' " + arrFilter[2] + "";
                        }
                        else if (arrFilter[0] == "NameandaddressofcontactPerson")
                        {
                            Qdata += " a.NameandaddressofcontactPerson" + Exp + "'" + arrFilter[3] + "' " + arrFilter[2] + "";
                        }
                        else if (arrFilter[0] == "DistancefromProjectOfficeFaizabad")
                        {
                            Qdata += " a.DistancefromProjectOfficeFaizabad" + Exp + "'" + arrFilter[3] + "' " + arrFilter[2] + "";
                        }
                        else if (arrFilter[0] == "DateofRegistration")
                        {
                            Qdata += " a.DateofRegistration" + Exp + "'" + arrFilter[3] + "' " + arrFilter[2] + "";
                        }
                        else if (arrFilter[0] == "FCRARegistrationdetail")
                        {
                            Qdata += " a.FCRARegistrationdetail" + Exp + "'" + arrFilter[3] + "' " + arrFilter[2] + "";
                        }
                        else if (arrFilter[0] == "PAN")
                        {
                            Qdata += " a.PAN" + Exp + "'" + arrFilter[3] + "' " + arrFilter[2] + "";
                        }
                        else if (arrFilter[0] == "TAN")
                        {
                            Qdata += " a.TAN" + Exp + "'" + arrFilter[3] + "' " + arrFilter[2] + "";
                        }
                        else if (arrFilter[0] == "12A")
                        {
                            Qdata += " a.[12A]" + Exp + "'" + arrFilter[3] + "' " + arrFilter[2] + "";
                        }
                        else if (arrFilter[0] == "80G")
                        {
                            Qdata += " a.[80G]" + Exp + "'" + arrFilter[3] + "' " + arrFilter[2] + "";
                        }
                        else if (arrFilter[0] == "GST")
                        {
                            Qdata += " a.GST" + Exp + "'" + arrFilter[3] + "' " + arrFilter[2] + "";
                        }
                        else if (arrFilter[0] == "OtherIfanyNGODarpan")
                        {
                            Qdata += " a.OtherIfanyNGODarpan" + Exp + "'" + arrFilter[3] + "' " + arrFilter[2] + "";
                        }
                        else if (arrFilter[0] == "OrganizationVision")
                        {
                            Qdata += " a.OrganizationVision" + Exp + "'" + arrFilter[3] + "' " + arrFilter[2] + "";
                        }
                        else if (arrFilter[0] == "OrganizationMission")
                        {
                            Qdata += " a.OrganizationMission" + Exp + "'" + arrFilter[3] + "' " + arrFilter[2] + "";
                        }
                        else if (arrFilter[0] == "Organizationcoverageorprojectarea")
                        {
                            Qdata += " a.Organizationcoverageorprojectarea" + Exp + "'" + arrFilter[3] + "' " + arrFilter[2] + "";
                        }
                        else if (arrFilter[0] == "TargetCommunity")
                        {
                            Qdata += " a.TargetCommunity" + Exp + "'" + arrFilter[3] + "' " + arrFilter[2] + "";
                        }
                        else if (arrFilter[0] == "Agriculturedevelopment")
                        {
                            Qdata += " a.Agriculturedevelopment" + Exp + "'" + arrFilter[3] + "' " + arrFilter[2] + "";
                        }
                        else if (arrFilter[0] == "WomenempowermentandGovernance")
                        {
                            Qdata += " a.WomenempowermentandGovernance" + Exp + "'" + arrFilter[3] + "' " + arrFilter[2] + "";
                        }
                        else if (arrFilter[0] == "Education")
                        {
                            Qdata += " a.Education" + Exp + "'" + arrFilter[3] + "' " + arrFilter[2] + "";
                        }
                        else if (arrFilter[0] == "Health")
                        {
                            Qdata += " a.Health" + Exp + "'" + arrFilter[3] + "' " + arrFilter[2] + "";
                        }
                        else if (arrFilter[0] == "WaterandSanitation")
                        {
                            Qdata += " a.WaterandSanitation" + Exp + "'" + arrFilter[3] + "' " + arrFilter[2] + "";
                        }
                        else if (arrFilter[0] == "SkillDevelopment")
                        {
                            Qdata += " a.SkillDevelopment" + Exp + "'" + arrFilter[3] + "' " + arrFilter[2] + "";
                        }
                        else if (arrFilter[0] == "MajorprogrammaticfocusOtherifany")
                        {
                            Qdata += " a.MajorprogrammaticfocusOtherifany" + Exp + "'" + arrFilter[3] + "' " + arrFilter[2] + "";
                        }
                        else if (arrFilter[0] == "WomenSHG")
                        {
                            Qdata += " a.WomenSHG" + Exp + "'" + arrFilter[3] + "' " + arrFilter[2] + "";
                        }
                        else if (arrFilter[0] == "WomenFarmersGroups")
                        {
                            Qdata += " a.AdolescentGirlsGroup" + Exp + "'" + arrFilter[3] + "' " + arrFilter[2] + "";
                        }
                        else if (arrFilter[0] == "JointLiabilityGroup")
                        {
                            Qdata += " a.JointLiabilityGroup" + Exp + "'" + arrFilter[3] + "' " + arrFilter[2] + "";
                        }
                        else if (arrFilter[0] == "CommunitybasedorganizationsOtherIfany")
                        {
                            Qdata += " a.CommunitybasedorganizationsOtherIfany" + Exp + "'" + arrFilter[3] + "' " + arrFilter[2] + "";
                        }
                        else if (arrFilter[0] == "DetailofFedrationifany")
                        {
                            Qdata += " a.DetailofFedrationifany" + Exp + "'" + arrFilter[3] + "' " + arrFilter[2] + "";
                        }
                        else if (arrFilter[0] == "NariSangh")
                        {
                            Qdata += " a.NariSangh" + Exp + "'" + arrFilter[3] + "' " + arrFilter[2] + "";
                        }
                        else if (arrFilter[0] == "WorkingexperienceonpromotionofFarmersProducerCompanyFPC")
                        {
                            Qdata += " a.WorkingexperienceonpromotionofFarmersProducerCompanyFPC" + Exp + "'" + arrFilter[3] + "' " + arrFilter[2] + "";
                        }
                        else if (arrFilter[0] == "ExperienceinworkingwithWomenFarmersAgricultureClimateChangeandGenderetcIfany")
                        {
                            Qdata += " a.ExperienceinworkingwithWomenFarmersAgricultureClimateChangeandGenderetcIfany" + Exp + "'" + arrFilter[3] + "' " + arrFilter[2] + "";
                        }
                        else if (arrFilter[0] == "ExperienceinimplementingIGPEntrepreneurships")
                        {
                            Qdata += " a.ExperienceinimplementingIGPEntrepreneurships" + Exp + "'" + arrFilter[3] + "' " + arrFilter[2] + "";
                        }
                        else if (arrFilter[0] == "ExperienceinworkingwithPRILocalAdminandGovernmentDepartments")
                        {
                            Qdata += " a.ExperienceinworkingwithPRILocalAdminandGovernmentDepartments" + Exp + "'" + arrFilter[3] + "' " + arrFilter[2] + "";
                        }
                        else if (arrFilter[0] == "AnystrikingaccomplishmentbytheorganizationUniquesomethingdifferent")
                        {
                            Qdata += " a.AnystrikingaccomplishmentbytheorganizationUniquesomethingdifferent" + Exp + "'" + arrFilter[3] + "' " + arrFilter[2] + "";
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

            string SelectQ = "SELECT a.CSOID, a.Status, a.Csoname,StateName, District, Block, a.RegisteredAddress, a.RegisteredAddressmobileno, a.RegisteredAddressEmail, a.RegisteredAddresswebsite, a.Correspondenceaddress, a.Correspondenceaddressmobileno, a.CorrespondenceaddressEmail, a.NameofContactPerson, a.AddressofContactPerson, a.MobilenoofContactPerson, a.EmailofContactPerson, a.RegistrationNo, a.DateofRegistration, a.RegistrationExpiryDate, a.RegistrationAct, a.FCRARegistrationNo, a.FCRARegistrationDate, a.FCRARegExpiryDate, a.DistancefromProjectOfficeFaizabad, a.PAN, a.PANNo, a.PANDate, a.PANExpiry, a.TAN, a.TANno, a.TANDate, a.TANExpiry, a.[12A], a.[12Ano], a.[12ADate], a.[12AExpiry], a.[80G], a.[80Gno], a.[80GDate], a.[80GExpiry], a.GST, a.GSTNo, a.GSTDate, a.GSTExpiry, a.OtherNGODarpan, a.OrganizationVision, a.OrganizationMission, a.OrganizationProjectArea, a.TargetCommunity, a.AgricultureDevelopment, a.WomenEmpowerment, a.Education, a.Health, a.WaterandSanitation, a.SkillDevelopment, a.OtherMajorprogrammaticFocus, a.OtherMajorprogrammaticFocusList, a.WomenSHG, a.WomenFarmersGroups, a.AdolescentGirlsGroup, a.JointLiabilityGroup, a.CommunitybasedorganizationsOtherIfany, a.DetailofFedrationifany, a.NariSangh, a.PFPCWorkExperiance, a.PFPCWorkExperianceNoofFPC, a.PFPCWorkExperianceAssociates, a.PFPCWorkExperianceDetails, a.WFACGWorkExperiance, a.WFACGWorkExperianceYears, a.WFACGWorkExperianceAssociates, a.WFACGWorkExperianceDetails, a.IGPEWorkExperiance, a.IGPEWorkExperianceYears, a.IGPEWorkExperianceAssociates, a.IGPEWorkExperianceDetails, a.WPRILWorkExperiance, a.WPRILWorkExperianceYears, a.WPRILWorkExperianceAssociates, a.WPRILWorkExperianceDetails, a.ASCOWorkExperiance, a.ASCOWorkExperianceYears, a.ASCOWorkExperianceAssociates, a.ASCOWorkExperianceDetails, a.imagename FROM [dbo].tblCso a left outer join tblBlocks c on a.BlockID=c.BlockID left outer join tblDistricts b on a.DistrictID = b.DistrictID left outer join tblStates d on b.StateID=d.StateId where 1 = 1 " + andCond + "" + Qdata + " order by CsoId";

            DataSet ds = db.getResultset(SelectQ, "", "", "");
            if (ds != null && ds.Tables[0].Rows.Count > 0)
            {
                Gridview1.DataSource = ds;
                Gridview1.DataBind();
                hiddenDataArrayId.Value = "";
                ViewState["dirState"] = ds;
                ViewState["sortdr"] = "Asc";
            }
            else
            {
                Gridview1.DataSource = ds;
                Gridview1.DataBind();
                ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "ShowAlert('No Data Found.','warning')", true);
            }
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            GridViewRow gvRow = (GridViewRow)(sender as Control).Parent.Parent;
            int index = gvRow.RowIndex;
            string val = (string)this.Gridview1.DataKeys[index]["CsoId"].ToString();

            string deleteQ = "update tblCSO set Status = 0 where CSOID = " + val + ";update tblVillageInfo set Status = 0 where CSOID=" + val + "; update tblWFGs set Status=0 from tblWFGs a left outer join tblVillageInfo b on a.VillageID = b.Vid left outer join tblCSO c on b.CSOID=c.CSOID where c.CSOID = " + val + "; update tblWFs set Status=0 from tblWFs a left outer join tblWFGs b on a.WFGID=b.WfgNo left outer join tblVillageInfo c on b.VillageID = c.Vid left outer join tblCSO d on c.CSOID=d.CSOID where c.CSOID = " + val + "; update tblClients set Status=0 where UserType = 'CSO' and ClientID=1;update tblClients set Status=0 from tblClients a left outer join tblWFGs b on a.ClientID=b.WfgNo left outer join tblVillageInfo c on b.VillageID=c.Vid left outer join tblCSO d on c.CSOID=d.CSOID where a.UserType='WFG' and c.CSOID=" + val;
            if (db.UpdateQuery(deleteQ, "", "", "") > 0)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "ShowAlert('You have deleted cso successfully.','success')", true);
            }
            else
            {
                ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "ShowAlert('Something went wrong / Delete Data Under this CSO.','warning')", true);
            }
        }

        protected void Gridview1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            Gridview1.PageIndex = e.NewPageIndex;
            GetDetails();
        }

        protected void Gridview1_Sorting(object sender, GridViewSortEventArgs e)
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
                Gridview1.DataSource = dtrslt;
                Gridview1.DataBind();
            }

            for (int i = 0; i < Gridview1.Columns.Count; i++)
            {
                string lbText = Gridview1.Columns[i].SortExpression;

                if (lbText == e.SortExpression)
                {
                    TableCell tableCell = Gridview1.HeaderRow.Cells[i];
                    System.Web.UI.WebControls.Image img = new System.Web.UI.WebControls.Image();
                    img.ImageUrl = (Convert.ToString(ViewState["sortdr"]) == "Asc") ? "~/Images/ArrowUp.gif" : "~/Images/ArrowDown.gif";
                    tableCell.Controls.Add(new LiteralControl("&nbsp;"));
                    tableCell.Controls.Add(img);
                }
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
                    string val = (string)this.Gridview1.DataKeys[rowIndex]["CsoId"].ToString();
                    Session["CsoId"] = val;
                    Response.Redirect("EditCso.aspx");
                }
                else if (e.CommandName == "Inactive")
                {
                    GridViewRow row = (GridViewRow)(((Control)e.CommandSource).NamingContainer);
                    int RowIndex = row.RowIndex;
                    string val = (string)this.Gridview1.DataKeys[RowIndex]["CsoId"].ToString();
                    string deleteQ = "update tblVillageInfo set Status = 0 where CSOID=" + val + "; update tblWFGs set Status=0 from tblWFGs a left outer join tblVillageInfo b on a.VillageID = b.Vid left outer join tblCSO c on b.CSOID=c.CSOID where c.CSOID = " + val + "; update tblWFs set Status=0 from tblWFs a left outer join tblWFGs b on a.WFGID=b.WfgNo left outer join tblVillageInfo c on b.VillageID = c.Vid left outer join tblCSO d on c.CSOID=d.CSOID where c.CSOID = " + val + "; update tblClients set Status=0 where UserType = 'CSO' and ClientID=" + val + ";update tblClients set Status=0 from tblClients a left outer join tblWFGs b on a.ClientID=b.WfgNo left outer join tblVillageInfo c on b.VillageID=c.Vid left outer join tblCSO d on c.CSOID=d.CSOID where a.UserType='WFG' and c.CSOID=" + val + ";update tblCSO set Status = 0 where CSOID = " + val + ";";
                    if (db.UpdateQuery(deleteQ, "", "", "") > 0)
                    {
                        ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "ShowAlert('You have deleted cso successfully.','success')", true);
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
                    string val = (string)this.Gridview1.DataKeys[RowIndex]["CsoId"].ToString();
                    string deleteQ = "update tblVillageInfo set Status = 1 where CSOID=" + val + "; update tblWFGs set Status=1 from tblWFGs a left outer join tblVillageInfo b on a.VillageID = b.Vid left outer join tblCSO c on b.CSOID=c.CSOID where c.CSOID = " + val + "; update tblWFs set Status=1 from tblWFs a left outer join tblWFGs b on a.WFGID=b.WfgNo left outer join tblVillageInfo c on b.VillageID = c.Vid left outer join tblCSO d on c.CSOID=d.CSOID where c.CSOID = " + val + "; update tblClients set Status=1 where UserType = 'CSO' and ClientID=" + val + ";update tblClients set Status=1 from tblClients a left outer join tblWFGs b on a.ClientID=b.WfgNo left outer join tblVillageInfo c on b.VillageID=c.Vid left outer join tblCSO d on c.CSOID=d.CSOID where a.UserType='WFG' and c.CSOID=" + val + ";update tblCSO set Status = 1 where CSOID = " + val + ";";
                    if (db.UpdateQuery(deleteQ, "", "", "") > 0)
                    {
                        ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "ShowAlert('You have deleted cso successfully.','success')", true);
                    }
                    else
                    {
                        ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "ShowAlert('Something went wrong please try again.','warning')", true);
                    }
                }
            }
        }

        protected void btnApply_Click(object sender, EventArgs e)
        {
           
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
                        string myName = Server.UrlEncode("CSOReport_" + DateTime.Now.ToShortDateString() + ".xlsx");

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
    }
}