using CF.Models;
using System;
using System.Configuration;
using System.Data;
using System.Drawing;
using System.IO;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CF
{
    public partial class FPCRegistrationEdit : System.Web.UI.Page
    {
        DbErrorLog db = new DbErrorLog();
        string User = "";
        Generator genobj = new Generator();
        protected void Page_Load(object sender, EventArgs e)
        {
            Page.UnobtrusiveValidationMode = UnobtrusiveValidationMode.None;
            if (Session["UserType"] != null)
            {
                User = Session["UserType"].ToString();
                if (User == "Admin")
                {
                    if (Session["FPCid"] != null)
                    {

                        if (!IsPostBack)
                        {
                            LoadData();
                        }
                    }
                    else
                    {
                        Response.Redirect("~/FPCInfo.aspx");
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

        public void LoadStates()
        {
            string query = "select StateId,StateName from tblStates";
            DataSet ds = db.getResultset(query, "", "", "");

            ddlState.DataSource = ds;
            ddlState.DataTextField = "StateName";
            ddlState.DataValueField = "StateId";
            ddlState.DataBind();
            ddlState.Items.Insert(0, "Select");
        }

        public void LoadDisricts()
        {
            string query = "select DistrictID,District from  tblDistricts where StateID='" + ddlState.SelectedValue + "'";
            DataSet ds = db.getResultset(query, "", "", "");

            ddlDistrict.DataSource = ds;
            ddlDistrict.DataTextField = "District";
            ddlDistrict.DataValueField = "DistrictID";
            ddlDistrict.DataBind();
        }

        public void LoadBlocks()
        {
            string Districts = "";
            foreach (ListItem item in ddlDistrict.Items)
            {
                if (item.Selected)
                {
                    if (Districts == "")
                    {
                        Districts = item.Value;
                    }
                    else
                    {
                        Districts += "," + item.Value;
                    }
                }
            }

            string blocksquery = "select BlockID,Block from tblBlocks where DistrictID in (" + Districts + ")";
            DataSet ds = db.getResultset(blocksquery, "", "", "");

            ddlBlocks.DataSource = ds;
            ddlBlocks.DataTextField = "Block";
            ddlBlocks.DataValueField = "BlockID";
            ddlBlocks.DataBind();
        }

        //protected void ddlBlocks_SelectedIndexChanged(object sender, EventArgs e)
        //{
        //    if (ddlBlocks.SelectedIndex > 0)
        //    {
        //        loadCso();
        //    }
        //    else
        //    {
        //        txtCSO.Text = string.Empty;
        //    }
        //}

        protected void loadCso()
        {
            string selectCso = "select [CSOName] from [tblCSO] where BlockID=" + ddlBlocks.SelectedValue + " order by CSOName";
            DataSet dataSet = db.getResultset(selectCso, "", "", "");
            ddlCSO.DataSource = dataSet;
            ddlCSO.DataTextField = "CSOName";
            ddlCSO.DataValueField = "CSOName";
            ddlCSO.DataBind();
            ddlCSO.Items.Insert(0, "Select");
        }

        public void LoadData()
        {
            string query = "SELECT a.FPCid, StateID, CSOName, BlockID, DistrictID, FPCName, FPCAddress, FPCContactNumber, FPCEmail, FPCWebsite, TotalMembers, MaleMembers, FemaleMembers,TransGenderMembers, SFMFMembers, STMembers, SCMembers, OBCMembers,GeneralMembers, NoofVillagesCovered, NoofBlocksCovered, NoofDistrictsCovered,NoofSharesMobilizedbyFPC, SharedMoneyMobilizedbyFPC, SFACEquitySupportAvailed, EquityGrantFundMobilizedbyFPC, FPCRegistrationdate, LegalActunderWhichFPC, CINNo, SupportTakenfromotherAgency, SupportAmt, FPCBankAccountNo, AccountType, BankName, BankBranch, IFSCCode, FPCBusinessAddress, TAN, TANNumber, TANDate, TANExpiry, PAN, PANNumber, PANDate, PANExpiry, GST, GSTNumber, GSTDate, GSTExpiry, ServiceTax, ServiceTaxNumber, ServiceTaxDate, ServiceTaxExpiry, BusinesslicenseTaken, EmployeeAppointed, DirectorsAppointed, UserName, Password,FpcLogo,OtherLegalAct FROM tblFPCRegistration a LEFT OUTER JOIN tblFPCRegAboutus b ON a.FPCid=b.FPCId where a.FPCid =" + Session["FPCId"];

            DataSet ds = db.getResultset(query, "", "", "");

            if (ds != null && ds.Tables[0].Rows.Count > 0)
            {
                DataTable dt = ds.Tables[0];
                LoadStates();
                if (ddlState.Items.FindByValue(dt.Rows[0]["StateID"].ToString()) != null)
                {
                    ddlState.Items.FindByValue(dt.Rows[0]["StateID"].ToString()).Selected = true;
                }
                LoadDisricts();
                if (ddlDistrict.Items.FindByValue(dt.Rows[0]["DistrictID"].ToString()) != null)
                {
                    ddlDistrict.Items.FindByValue(dt.Rows[0]["DistrictID"].ToString()).Selected = true;
                }
                LoadBlocks();
                if (ddlBlocks.Items.FindByValue(dt.Rows[0]["BlockID"].ToString()) != null)
                {
                    ddlBlocks.Items.FindByValue(dt.Rows[0]["BlockID"].ToString()).Selected = true;
                }
                string ServerSavePath = ConfigurationManager.ConnectionStrings["fpcLogoGet"].ConnectionString;
                if (!string.IsNullOrEmpty(dt.Rows[0]["FpcLogo"].ToString()))
                {
                    ImgPreview.Src = ServerSavePath + dt.Rows[0]["FpcLogo"].ToString();
                }
                ViewState["fpcLogo"] = dt.Rows[0]["FpcLogo"].ToString();
                loadCso();
                if (ddlCSO.Items.FindByText(dt.Rows[0]["CSOName"].ToString()) != null)
                {
                    ddlCSO.Items.FindByText(dt.Rows[0]["CSOName"].ToString()).Selected = true;
                }
                txtFPCName.Text = dt.Rows[0]["FPCName"].ToString();
                txtFPCAddress.Text = dt.Rows[0]["FPCAddress"].ToString();
                txtFPCConcact.Text = dt.Rows[0]["FPCContactNumber"].ToString();
                txtFPCEmail.Text = dt.Rows[0]["FPCEmail"].ToString();
                txtFPCWebsite.Text = dt.Rows[0]["FPCWebsite"].ToString();
                txtGeneral.Text = dt.Rows[0]["GeneralMembers"].ToString();
                txtTotalMembers.Text = dt.Rows[0]["TotalMembers"].ToString();
                txtmaleMembers.Text = dt.Rows[0]["MaleMembers"].ToString();
                txtfemaleMembers.Text = dt.Rows[0]["FemaleMembers"].ToString();
                txtTransgenderMembers.Text = dt.Rows[0]["TransGenderMembers"].ToString();
                txtSFMFmembers.Text = dt.Rows[0]["SFMFMembers"].ToString();
                txtSTmembers.Text = dt.Rows[0]["STMembers"].ToString();
                txtSCMembers.Text = dt.Rows[0]["SCMembers"].ToString();
                txtOBCMembers.Text = dt.Rows[0]["OBCMembers"].ToString();
                string SCMembers = "0";
                if (!string.IsNullOrEmpty(dt.Rows[0]["SCMembers"].ToString()))
                {
                    SCMembers = dt.Rows[0]["SCMembers"].ToString();
                }
                string STMembers = "0";
                if (!string.IsNullOrEmpty(dt.Rows[0]["STMembers"].ToString()))
                {
                    STMembers = dt.Rows[0]["STMembers"].ToString();
                }
                string OBCMembers = "0";
                if (!string.IsNullOrEmpty(dt.Rows[0]["OBCMembers"].ToString()))
                {
                    OBCMembers = dt.Rows[0]["OBCMembers"].ToString();
                }
                string GeneralMembers = "0";
                if (!string.IsNullOrEmpty(dt.Rows[0]["GeneralMembers"].ToString()))
                {
                    GeneralMembers = dt.Rows[0]["GeneralMembers"].ToString();
                }
                txtSocialCategoryTotal.Text = (Convert.ToInt32(STMembers) + Convert.ToInt32(OBCMembers) + Convert.ToInt32(SCMembers) + Convert.ToInt32(GeneralMembers)).ToString();

                txtVillgesCovered.Text = dt.Rows[0]["NoofVillagesCovered"].ToString();
                txtBlocksCovered.Text = dt.Rows[0]["NoofBlocksCovered"].ToString();
                txtDistrictsCovered.Text = dt.Rows[0]["NoofDistrictsCovered"].ToString();
                txtNoofSharesMobilized.Text = dt.Rows[0]["NoofSharesMobilizedbyFPC"].ToString();
                txtSharedMoneyMobilized.Text = dt.Rows[0]["SharedMoneyMobilizedbyFPC"].ToString();
                if (ddlSFACEquity.Items.FindByText(dt.Rows[0]["SFACEquitySupportAvailed"].ToString()) != null)
                {
                    ddlSFACEquity.Items.FindByText(dt.Rows[0]["SFACEquitySupportAvailed"].ToString()).Selected = true;
                }
                if (ddlSFACEquity.SelectedValue == "Yes")
                {
                    txtEquityGrant.Text = dt.Rows[0]["EquityGrantFundMobilizedbyFPC"].ToString();
                }
                txtFPCRegistrationDate.Text = dt.Rows[0]["FPCRegistrationdate"].ToString();
                if (ddlLegalActFPC.Items.FindByValue(dt.Rows[0]["LegalActunderWhichFPC"].ToString()) != null)
                {
                    ddlLegalActFPC.Items.FindByValue(dt.Rows[0]["LegalActunderWhichFPC"].ToString()).Selected = true;
                }
                txtCINNumber.Text = dt.Rows[0]["CINNo"].ToString();
                if (ddlSupportTaken.Items.FindByText(dt.Rows[0]["SupportTakenfromotherAgency"].ToString()) != null)
                {
                    ddlSupportTaken.Items.FindByText(dt.Rows[0]["SupportTakenfromotherAgency"].ToString()).Selected = true;
                }
                txtOtherLeagal.Text = dt.Rows[0]["OtherLegalAct"].ToString();

                if (ddlSupportTaken.SelectedValue == "Yes")
                {
                    string selectSupportTaken = "Select [AgencyName],[SchemeName],[SupportAmount],[SupportDate] from tblFpcRegistrationSupportTakenAgency where FPCId=" + Session["FPCId"];
                    DataSet dset = db.getResultset(selectSupportTaken, "", "", "");
                    if (dset != null && dset.Tables[0].Rows.Count > 0)
                    {
                        string SupportTakenString = "";
                        for (int i = 0; i < dset.Tables[0].Rows.Count; i++)
                        {
                            if (i == 0)
                            {
                                SupportTakenString += dset.Tables[0].Rows[i]["AgencyName"] + ":" + dset.Tables[0].Rows[i]["SchemeName"] + ":" + dset.Tables[0].Rows[i]["SupportAmount"] + ":" + dset.Tables[0].Rows[i]["SupportDate"];
                            }
                            else
                            {
                                SupportTakenString += "$" + dset.Tables[0].Rows[i]["AgencyName"] + ":" + dset.Tables[0].Rows[i]["SchemeName"] + ":" + dset.Tables[0].Rows[i]["SupportAmount"] + ":" + dset.Tables[0].Rows[i]["SupportDate"];
                            }
                        }

                        hiddenDataArrayId.Value = SupportTakenString;
                    }
                }

                string BankName = dt.Rows[0]["BankName"].ToString();
                string FPCBankNumber = dt.Rows[0]["FPCBankAccountNo"].ToString();
                string FPCAccountType = dt.Rows[0]["AccountType"].ToString();
                string BankBranch = dt.Rows[0]["BankBranch"].ToString();
                string IFSCCode = dt.Rows[0]["IFSCCode"].ToString();
                hiddenBankDetailsArray.Value = BankName + "$" + FPCBankNumber + "$" + FPCAccountType + "$" + BankBranch + "$" + IFSCCode;
                txtFPCBusinessAddress.Text = dt.Rows[0]["FPCBusinessAddress"].ToString();
                if (rblTAN.Items.FindByValue(dt.Rows[0]["TAN"].ToString()) != null)
                {
                    rblTAN.Items.FindByValue(dt.Rows[0]["TAN"].ToString()).Selected = true;
                }
                if (rblTAN.SelectedValue == "Yes")
                {
                    txtTanNo.Text = dt.Rows[0]["TANNumber"].ToString();
                    txtTanDate.Text = dt.Rows[0]["TANDate"].ToString();
                    txtTanExpiry.Text = dt.Rows[0]["TANExpiry"].ToString();
                }
                if (rblPAN.Items.FindByValue(dt.Rows[0]["PAN"].ToString()) != null)
                {
                    rblPAN.Items.FindByValue(dt.Rows[0]["PAN"].ToString()).Selected = true;
                }
                if (rblPAN.SelectedValue == "Yes")
                {
                    txtPanNo.Text = dt.Rows[0]["PANNumber"].ToString();
                    txtPanDate.Text = dt.Rows[0]["PANDate"].ToString();
                    txtPanExpiry.Text = dt.Rows[0]["PANExpiry"].ToString();
                }
                if (rblGST.Items.FindByValue(dt.Rows[0]["GST"].ToString()) != null)
                {
                    rblGST.Items.FindByValue(dt.Rows[0]["GST"].ToString()).Selected = true;
                }
                if (rblGST.SelectedValue == "Yes")
                {
                    txtGSTNo.Text = dt.Rows[0]["GSTNumber"].ToString();
                    txtGSTDate.Text = dt.Rows[0]["GSTDate"].ToString();
                    txtGSTExpiry.Text = dt.Rows[0]["GSTExpiry"].ToString();
                }
                if (rblServiceTax.Items.FindByValue(dt.Rows[0]["ServiceTax"].ToString()) != null)
                {
                    rblServiceTax.Items.FindByValue(dt.Rows[0]["ServiceTax"].ToString()).Selected = true;
                }
                if (rblServiceTax.SelectedValue == "Yes")
                {
                    txtServiceTAXNumber.Text = dt.Rows[0]["ServiceTaxNumber"].ToString();
                    txtServiceTaxDate.Text = dt.Rows[0]["ServiceTaxDate"].ToString();
                    txtServiceTaxExpiry.Text = dt.Rows[0]["ServiceTaxExpiry"].ToString();
                }

                if (ddlBusinessTaken.Items.FindByValue(dt.Rows[0]["BusinesslicenseTaken"].ToString()) != null)
                {
                    ddlBusinessTaken.Items.FindByValue(dt.Rows[0]["BusinesslicenseTaken"].ToString()).Selected = true;
                }

                if (ddlBusinessTaken.SelectedValue == "Yes")
                {
                    string businessLicnse = "Select [LicenceType],[LicenceNumber],[LicenceNameauthority],[LicenseRegistrationDate],[LicenseExpiryDate] from tblFpcRegistrationBusinessTaken where FPCId=" + Session["FPCId"];
                    DataSet dset1 = db.getResultset(businessLicnse, "", "", "");
                    if (dset1 != null && dset1.Tables[0].Rows.Count > 0)
                    {
                        string BusinessLicenseString = "";
                        for (int i = 0; i < dset1.Tables[0].Rows.Count; i++)
                        {
                            if (i == 0)
                            {
                                BusinessLicenseString += dset1.Tables[0].Rows[i]["LicenceType"] + ":" + dset1.Tables[0].Rows[i]["LicenceNumber"] + ":" + dset1.Tables[0].Rows[i]["LicenceNameauthority"] + ":" + dset1.Tables[0].Rows[i]["LicenseRegistrationDate"] + ":" + dset1.Tables[0].Rows[i]["LicenseExpiryDate"];
                            }
                            else
                            {
                                BusinessLicenseString += "$" + dset1.Tables[0].Rows[i]["LicenceType"] + ":" + dset1.Tables[0].Rows[i]["LicenceNumber"] + ":" + dset1.Tables[0].Rows[i]["LicenceNameauthority"] + ":" + dset1.Tables[0].Rows[i]["LicenseRegistrationDate"] + ":" + dset1.Tables[0].Rows[i]["LicenseExpiryDate"];
                            }
                        }

                        hiddenBusinessDataArray.Value = BusinessLicenseString;
                    }
                }
                if (ddlTeamMembers.Items.FindByValue(dt.Rows[0]["EmployeeAppointed"].ToString()) != null)
                {
                    ddlTeamMembers.Items.FindByValue(dt.Rows[0]["EmployeeAppointed"].ToString()).Selected = true;
                }

                if (ddlTeamMembers.SelectedValue == "Yes")
                {
                    string businessLicnse = "Select [Name],[Gender],[ContactNumber],[Designation],[DateofJoining],[DateofReliving] from tblFpcRegistrationTeamMembers where FPCId=" + Session["FPCId"];
                    DataSet dset2 = db.getResultset(businessLicnse, "", "", "");
                    if (dset2 != null && dset2.Tables[0].Rows.Count > 0)
                    {
                        string TeamMembersString = "";
                        for (int i = 0; i < dset2.Tables[0].Rows.Count; i++)
                        {
                            if (i == 0)
                            {
                                TeamMembersString += dset2.Tables[0].Rows[i]["Name"] + ":" + dset2.Tables[0].Rows[i]["Gender"] + ":" + dset2.Tables[0].Rows[i]["ContactNumber"] + ":" + dset2.Tables[0].Rows[i]["Designation"] + ":" + dset2.Tables[0].Rows[i]["DateofJoining"] + ":" + dset2.Tables[0].Rows[i]["DateofReliving"];
                            }
                            else
                            {
                                TeamMembersString += "$" + dset2.Tables[0].Rows[i]["Name"] + ":" + dset2.Tables[0].Rows[i]["Gender"] + ":" + dset2.Tables[0].Rows[i]["ContactNumber"] + ":" + dset2.Tables[0].Rows[i]["Designation"] + ":" + dset2.Tables[0].Rows[i]["DateofJoining"] + ":" + dset2.Tables[0].Rows[i]["DateofReliving"];
                            }
                        }

                        hiddenTeamMembersDataArray.Value = TeamMembersString;
                    }
                }
                if (ddlDirectors.Items.FindByValue(dt.Rows[0]["DirectorsAppointed"].ToString()) != null)
                {
                    ddlDirectors.Items.FindByValue(dt.Rows[0]["DirectorsAppointed"].ToString()).Selected = true;
                }

                if (ddlDirectors.SelectedValue == "Yes")
                {
                    string businessLicnse = "Select BODMemberId,[BoardMemberName],[Gender],[MobileNo],[BoardMemberName],[Gender],[MobileNo],[DirectorType],[PeriodFrom],[PeriodTo] from tblBODMembers where FPCId=" + Session["FPCId"];
                    DataSet dset2 = db.getResultset(businessLicnse, "", "", "");
                    if (dset2 != null && dset2.Tables[0].Rows.Count > 0)
                    {
                        string DirectorsString = "";
                        for (int i = 0; i < dset2.Tables[0].Rows.Count; i++)
                        {
                            if (i == 0)
                            {
                                DirectorsString += dset2.Tables[0].Rows[i]["BoardMemberName"] + ":" + dset2.Tables[0].Rows[i]["Gender"] + ":" + dset2.Tables[0].Rows[i]["MobileNo"] + ":" + dset2.Tables[0].Rows[i]["DirectorType"] + ":" + dset2.Tables[0].Rows[i]["PeriodFrom"] + ":" + dset2.Tables[0].Rows[i]["PeriodTo"] + ":" + dset2.Tables[0].Rows[i]["BODMemberId"];
                            }
                            else
                            {
                                DirectorsString += "$" + dset2.Tables[0].Rows[i]["BoardMemberName"] + ":" + dset2.Tables[0].Rows[i]["Gender"] + ":" + dset2.Tables[0].Rows[i]["MobileNo"] + ":" + dset2.Tables[0].Rows[i]["DirectorType"] + ":" + dset2.Tables[0].Rows[i]["PeriodFrom"] + ":" + dset2.Tables[0].Rows[i]["PeriodTo"] + ":" + dset2.Tables[0].Rows[i]["BODMemberId"];
                            }
                        }
                        hiddenDirectorsDataArray.Value = DirectorsString;
                    }
                }

                txtUserName.Text = dt.Rows[0]["UserName"].ToString();
                txtPassword.Text = dt.Rows[0]["Password"].ToString();
                txtConfirmPassword.Text = dt.Rows[0]["Password"].ToString();
                string FPCAbout = "Select Overview, Mission, Vission, Chairperson, BusinessModel,Socialandenvironment,CoreValues from tblFPCRegAboutus where FPCId=" + Session["FPCId"];
                DataSet abds = db.getResultset(FPCAbout, "", "", "");
                if (abds != null && abds.Tables[0].Rows.Count > 0)
                {
                    txtOverview.Text = abds.Tables[0].Rows[0]["Overview"].ToString();
                    txtMission.Text = abds.Tables[0].Rows[0]["Mission"].ToString();
                    txtVission.Text = abds.Tables[0].Rows[0]["Vission"].ToString();
                    txtChairperson.Text = abds.Tables[0].Rows[0]["Chairperson"].ToString();
                    txtBusinessModel.Text = abds.Tables[0].Rows[0]["BusinessModel"].ToString();
                    txtSocialandenvironment.Text = abds.Tables[0].Rows[0]["Socialandenvironment"].ToString();
                    txtCorevalues.Text = abds.Tables[0].Rows[0]["CoreValues"].ToString();
                }
            }
        }

        protected void CheckBoxRequired_ServerValidate(object source, ServerValidateEventArgs args)
        {
            args.IsValid = cbConfirm.Checked;
        }

        protected void txtuser_TextChanged(object sender, EventArgs e)
        {
            string query = "select UserName from dbo.tblFPCRegistration where UserName = '" + txtUserName.Text + "'";

            DataSet ds = db.getResultset(query, "", "", "");

            if (ds != null && ds.Tables[0].Rows.Count > 0)
            {
                lblCheck.Text = "User Id Already Exist";
                lblCheck.ForeColor = Color.Maroon;
            }
            else
            {
                lblCheck.Text = "User Id Available";
                lblCheck.ForeColor = Color.Green;
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            string state = ddlState.SelectedValue;
            string Districts = ddlDistrict.SelectedValue;
            string Blocks = ddlBlocks.SelectedValue;

            int male = 0;
            int female = 0;
            int trans = 0;
            int sfmf = 0;
            int st = 0;
            int sc = 0;
            int obc = 0;
            int gen = 0;
            if (!string.IsNullOrEmpty(txtmaleMembers.Text))
            {
                male = Convert.ToInt32(txtmaleMembers.Text);
            }
            if (!string.IsNullOrEmpty(txtfemaleMembers.Text))
            {
                female = Convert.ToInt32(txtfemaleMembers.Text);
            }
            if (!string.IsNullOrEmpty(txtTransgenderMembers.Text))
            {
                trans = Convert.ToInt32(txtTransgenderMembers.Text);
            }
            if (!string.IsNullOrEmpty(txtSFMFmembers.Text))
            {
                sfmf = Convert.ToInt32(txtSFMFmembers.Text);
            }
            if (!string.IsNullOrEmpty(txtSCMembers.Text))
            {
                sc = Convert.ToInt32(txtSCMembers.Text);
            }
            if (!string.IsNullOrEmpty(txtSTmembers.Text))
            {
                st = Convert.ToInt32(txtSTmembers.Text);
            }
            if (!string.IsNullOrEmpty(txtOBCMembers.Text))
            {
                obc = Convert.ToInt32(txtOBCMembers.Text);
            }
            if (!string.IsNullOrEmpty(txtGeneral.Text))
            {
                gen = Convert.ToInt32(txtGeneral.Text);
            }
            int totalMem = male + female + trans;
            txtTotalMembers.Text = totalMem.ToString();

            string CSO = ddlCSO.SelectedValue;
            string FPCName = txtFPCName.Text;
            string FPCAddress = txtFPCAddress.Text;
            string FPCContact = txtFPCConcact.Text;
            string FPCemail = txtFPCEmail.Text;
            string FPCWebsite = txtFPCWebsite.Text;
            string NoofEmployees = txtTotalMembers.Text;

            string VillgesCovered = txtVillgesCovered.Text;
            string BlocksCovered = txtBlocksCovered.Text;
            string DistrictsCovered = txtDistrictsCovered.Text;
            string NoofSharesMobilized = txtNoofSharesMobilized.Text;
            string SharedMoneyMobilized = txtSharedMoneyMobilized.Text;
            string SFAC = ddlSFACEquity.SelectedValue;
            string EquityGrant = string.Empty;
            if (SFAC == "Yes")
            {
                EquityGrant = txtEquityGrant.Text;
            }
            string FPCRegisterdate = txtFPCRegistrationDate.Text;
            string LegalAct = ddlLegalActFPC.SelectedValue;
            string CINnumber = txtCINNumber.Text;
            string SupportTakenfromotherAgency = ddlSupportTaken.SelectedValue;
            //need to remove
            string Support = txtSupport0.Text;
            string[] BankArray = hiddenBankDetailsArray.Value.Split('$');
            string BankName = BankArray[0];
            string FPCBankNumber = BankArray[1];
            string AccountType = BankArray[2];
            string BankBranch = BankArray[3];
            string IFSCcode = BankArray[4];

            string FPCBusinessAddress = txtFPCBusinessAddress.Text;

            //need to modify
            string TAN = rblTAN.SelectedValue;
            string TANNumber = string.Empty;
            string TANDate = string.Empty;
            string TANExpiry = string.Empty;
            if (TAN == "Yes")
            {
                TANNumber = txtTanNo.Text;
                TANDate = txtTanDate.Text;
                TANExpiry = txtTanExpiry.Text;
            }
            string PAN = rblPAN.SelectedValue;
            string PANNumber = string.Empty;
            string PANDate = string.Empty;
            string PANExpiry = string.Empty;
            if (PAN == "Yes")
            {
                PANNumber = txtPanNo.Text;
                PANDate = txtPanDate.Text;
                PANExpiry = txtPanExpiry.Text;
            }
            string GST = rblGST.SelectedValue;
            string GSTNumber = string.Empty;
            string GSTDate = string.Empty;
            string GSTExpiry = string.Empty;
            if (GST == "Yes")
            {
                GSTNumber = txtGSTNo.Text;
                GSTDate = txtGSTDate.Text;
                GSTExpiry = txtGSTExpiry.Text;
            }
            string TAX = rblServiceTax.SelectedValue;
            string TAXNumber = string.Empty;
            string TAXDate = string.Empty;
            string TAXExpiry = string.Empty;
            if (TAX == "Yes")
            {
                TAXNumber = txtServiceTAXNumber.Text;
                TAXDate = txtServiceTaxDate.Text;
                TAXExpiry = txtServiceTaxExpiry.Text;
            }

            string BusinessLicense = ddlBusinessTaken.SelectedValue;
            string BusinessLicenceData = string.Empty;
            if (BusinessLicense == "Yes")
            {
                BusinessLicenceData = hiddenBusinessDataArray.Value;
            }
            string otherLeagelAct = txtOtherLeagal.Text;
            string EmployeAppint = ddlTeamMembers.SelectedValue;

            string Directors = ddlDirectors.SelectedValue;
            string DirecctorsData = string.Empty;
            if (Directors == "Yes")
            {
                DirecctorsData = hiddenDirectorsDataArray.Value;
            }
            string UserName = txtUserName.Text;
            string Password = txtPassword.Text;

            Random rn = new Random();
            int order = rn.Next(1000000, 9999999);

            string fileName = ViewState["fpcLogo"].ToString();
            if (fuFpcLogo.HasFile)
            {
                if (fuFpcLogo.PostedFile.ContentLength <= 100000)
                {
                    if (string.IsNullOrEmpty(fileName))
                    {
                        fileName = order + fuFpcLogo.FileName;
                    }
                    string exten = Path.GetExtension(fileName);
                    //here we have to restrict file type            
                    exten = exten.ToLower();
                    string[] acceptedFileTypes = new string[6];
                    acceptedFileTypes[0] = ".jpg";
                    acceptedFileTypes[1] = ".jpeg";
                    acceptedFileTypes[2] = ".png";
                    bool acceptFile = false;
                    foreach (string af in acceptedFileTypes)
                    {
                        if (exten == af)
                        {
                            acceptFile = true;
                        }
                    }
                    if (!acceptFile)
                    {
                        //lblMsg.Text = "The file you are trying to upload is not a permitted file type!";
                        //fileName = "";
                        ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "ShowAlert('Please Upload Correct Format.','warning')", true);
                    }
                    else
                    {
                        //upload the file onto the server                 
                        string FolderPath = ConfigurationManager.ConnectionStrings["fpcLogo"].ConnectionString;
                        string FilePath = FolderPath + fileName;
                        fuFpcLogo.SaveAs(FilePath);
                    }
                }
                else
                {
                    ClientScript.RegisterStartupScript(this.
                        GetType(), "CallMyFunction", "ShowAlert('Logo should be less than 100kb.','warning')", true);
                }
            }
            string FullPath = string.Empty;
            string UploadFileName = string.Empty;

            if (fileuploadnew.HasFiles)
            {
                string filePath = ConfigurationManager.ConnectionStrings["FPCMembersData"].ConnectionString;
                string FileName = genobj.Randomlongstring() + "_" + fileuploadnew.FileName.Trim();
                FullPath = filePath + FileName;
                fileuploadnew.SaveAs(FullPath);
                UploadFileName = FileName;
            }
            string Query = "update tblFPCRegistration set StateID=" + state + ", CSOName='" + CSO + "', BlockID=" + Blocks + ", DistrictID=" + Districts + ", FPCName='" + FPCName + "', FPCAddress='" + FPCAddress + "', FPCContactNumber='" + FPCContact + "', FPCEmail='" + FPCemail + "', FPCWebsite='" + FPCWebsite + "', TotalMembers='" + totalMem + "', MaleMembers='" + male + "', FemaleMembers='" + female + "',TransGenderMembers='" + trans + "', SFMFMembers='" + sfmf + "', STMembers='" + st + "', SCMembers='" + sc + "', OBCMembers='" + obc + "',GeneralMembers='" + gen + "', NoofVillagesCovered='" + VillgesCovered + "', NoofBlocksCovered='" + BlocksCovered + "', NoofDistrictsCovered='" + DistrictsCovered + "',NoofSharesMobilizedbyFPC='" + NoofSharesMobilized + "', SharedMoneyMobilizedbyFPC='" + SharedMoneyMobilized + "', SFACEquitySupportAvailed='" + SFAC + "', EquityGrantFundMobilizedbyFPC='" + EquityGrant + "', FPCRegistrationdate='" + FPCRegisterdate + "', LegalActunderWhichFPC='" + LegalAct + "', CINNo='" + CINnumber + "', SupportTakenfromotherAgency='" + SupportTakenfromotherAgency + "', SupportAmt='" + Support + "', FPCBankAccountNo='" + FPCBankNumber + "', AccountType='" + AccountType + "', BankName='" + BankName + "', BankBranch='" + BankBranch + "', IFSCCode='" + IFSCcode + "', FPCBusinessAddress='" + FPCBusinessAddress + "', TAN='" + TAN + "', TANNumber='" + TANNumber + "', TANDate='" + TANDate + "', TANExpiry='" + TANExpiry + "', PAN='" + PAN + "', PANNumber='" + PANNumber + "', PANDate='" + PANDate + "', PANExpiry='" + PANExpiry + "', GST='" + GST + "', GSTNumber='" + GSTNumber + "', GSTDate='" + GSTDate + "', GSTExpiry='" + GSTExpiry + "', ServiceTax='" + TAX + "', ServiceTaxNumber='" + TAXNumber + "', ServiceTaxDate='" + TAXDate + "', ServiceTaxExpiry='" + TAXExpiry + "', BusinesslicenseTaken='" + BusinessLicense + "', EmployeeAppointed='" + EmployeAppint + "', DirectorsAppointed='" + Directors + "', UserName='" + UserName + "', Password='" + Password + "',FpcLogo='" + fileName + "',[UploadFile] = '"+ FullPath + "',[UploadFileName] = '" + UploadFileName +  "', OtherLegalAct='" + otherLeagelAct + "' where FPCid= " + Session["FPCid"];
            if (db.UpdateQuery(Query, "", "", "") > 0)
            {
                //About us
                string Overview = txtOverview.Text;
                string Mission = txtMission.Text;
                string Vission = txtVission.Text;
                string Chairperson = txtChairperson.Text;
                string BusinessModel = txtBusinessModel.Text;
                string Socialandenvironment = txtSocialandenvironment.Text;
                string CoreValues = txtCorevalues.Text;

                string Aboutus = "Update tblFPCRegAboutus SET Overview='" + Overview + "', Mission='" + Mission + "', Vission='" + Vission + "', Chairperson='" + Chairperson + "', BusinessModel='" + BusinessModel + "',Socialandenvironment='" + Socialandenvironment + "',CoreValues='" + CoreValues + "' where FPCId =" + Session["FPCid"];
                if (db.UpdateQuery(Aboutus, "", "", "") > 0)
                {
                }

                string[] SupportTaken = hiddenDataArrayId.Value.ToString().Split('$');
                //Begin Tran SupportTaken;save Tran SaveSupportTaken;
                string deleteSupportTaken = "delete from tblFpcRegistrationSupportTakenAgency where FPCId=" + Session["FPCid"];
                if (db.UpdateQuery(deleteSupportTaken, "", "", "") > 0)
                {

                }
                if (SupportTaken.Length > 0 && !string.IsNullOrEmpty(SupportTaken[0]))
                {
                    for (int i = 0; i < SupportTaken.Length; i++)
                    {
                        string[] datavalues = SupportTaken[i].Split(':');
                        string insertQ = "INSERT INTO [tblFpcRegistrationSupportTakenAgency]([FPCId],[AgencyName],[SchemeName],[SupportAmount],[SupportDate]) VALUES(" + Session["FPCid"] + ",'" + datavalues[0] + "','" + datavalues[1] + "','" + datavalues[2] + "','" + datavalues[3] + "')";
                        if (db.UpdateQuery(insertQ, "", "", "") > 0)
                        {

                        }
                    }
                }
                //Begin Tran LicenceTaken;save Tran SaveLicenceTaken;
                string[] Businesslicence = hiddenBusinessDataArray.Value.ToString().Split('$');
                string deleteBusinessLicenseTaken = "delete from tblFpcRegistrationBusinessTaken where FPCId=" + Session["FPCid"];
                if (db.UpdateQuery(deleteBusinessLicenseTaken, "", "", "") > 0)
                {

                }
                if (Businesslicence.Length > 0 && !string.IsNullOrEmpty(Businesslicence[0]))
                {
                    for (int i = 0; i < Businesslicence.Length; i++)
                    {
                        string[] licenceData = Businesslicence[i].Split(':');
                        string insertQ1 = "INSERT INTO [tblFpcRegistrationBusinessTaken]([FPCId],[LicenceType],[LicenceNumber],[LicenceNameauthority],[LicenseRegistrationDate],[LicenseExpiryDate]) VALUES(" + Session["FPCid"] + ",'" + licenceData[0] + "','" + licenceData[1] + "','" + licenceData[2] + "','" + licenceData[3] + "','" + licenceData[4] + "')";
                        if (db.UpdateQuery(insertQ1, "", "", "") > 0)
                        {

                        }
                    }
                }
                string[] teamMembers = hiddenTeamMembersDataArray.Value.ToString().Split('$');
                //Begin Tran TeamMembers;save Tran SaveTeamMembers;
                string deleteTeamMembers = "delete from tblFpcRegistrationTeamMembers where FPCId=" + Session["FPCid"];
                if (db.UpdateQuery(deleteTeamMembers, "", "", "") > 0)
                {

                }
                if (teamMembers.Length > 0 && !string.IsNullOrEmpty(teamMembers[0]))
                {
                    for (int i = 0; i < teamMembers.Length; i++)
                    {
                        string[] teamMembersData = teamMembers[i].Split(':');
                        string insertQ2 = "INSERT INTO [tblFpcRegistrationTeamMembers]([FPCId],[Name],[Gender],[ContactNumber],[Designation],[DateofJoining],[DateofReliving]) VALUES(" + Session["FPCid"] + ",'" + teamMembersData[0] + "','" + teamMembersData[1] + "','" + teamMembersData[2] + "','" + teamMembersData[3] + "','" + teamMembersData[4] + "','" + teamMembersData[5] + "')";
                        if (db.UpdateQuery(insertQ2, "", "", "") > 0)
                        {

                        }
                    }
                }

                string[] DirectorsMembers = DirecctorsData.Split('$');

                string deleteDirectorMembers = "delete from tblBODMembers where BODMemberId in (" + hfdeletedDirec.Value + ")";
                if (db.UpdateQuery(deleteDirectorMembers, "", "", "") > 0)
                {
                }
                if (DirectorsMembers.Length > 0 && !string.IsNullOrEmpty(DirectorsMembers[0]))
                {
                    for (int i = 0; i < DirectorsMembers.Length; i++)
                    {
                        string[] DirectorMembersData = DirectorsMembers[i].Split(':');
                        string insertQ2 = string.Empty;
                        if (!string.IsNullOrEmpty(DirectorMembersData[6]) && DirectorMembersData[6] != "0")
                        {
                            insertQ2 = "update [tblBODMembers] set [BoardMemberName]='" + DirectorMembersData[0] + "',[Gender]='" + DirectorMembersData[1] + "',[MobileNo]='" + DirectorMembersData[2] + "',[DirectorType]='" + DirectorMembersData[3] + "',[PeriodFrom]='" + DirectorMembersData[4] + "',[PeriodTo]='" + DirectorMembersData[5] + "' where BODMemberId=" + DirectorMembersData[6];
                        }
                        else
                        {
                            insertQ2 = "INSERT INTO [tblBODMembers]([FPCId],[BoardMemberName],[Gender],[MobileNo],[DirectorType],[PeriodFrom],[PeriodTo]) VALUES(" + Session["FPCid"] + ",'" + DirectorMembersData[0] + "','" + DirectorMembersData[1] + "','" + DirectorMembersData[2] + "','" + DirectorMembersData[3] + "','" + DirectorMembersData[4] + "','" + DirectorMembersData[5] + "')";
                        }
                        db.UpdateQuery(insertQ2, "", "", "");
                    }
                }

                ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "ShowAlert('Data Submitted successfully. Thank you.','success')", true);
            }
            else
            {
                ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "ShowAlert('Something went wrong please try again.','warning')", true);
            }
        }

        protected void ddlState_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlState.SelectedIndex > 0)
            {
                string query = "select DistrictID,District from  tblDistricts where StateID='" + ddlState.SelectedValue + "'";
                DataSet ds = db.getResultset(query, "", "", "");

                ddlDistrict.DataSource = ds;
                ddlDistrict.DataTextField = "District";
                ddlDistrict.DataValueField = "DistrictID";
                ddlDistrict.DataBind();
            }
            else
            {
                ddlDistrict.Items.Clear();
                ddlDistrict.Items.Insert(0, "Select");
                ddlBlocks.Items.Clear();
                ddlBlocks.Items.Insert(0, "Select");
                ddlCSO.Items.Clear();
                ddlCSO.Items.Insert(0, "Select");
            }
        }

        protected void ddlDistrict_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlDistrict.SelectedIndex > 0)
            {

                string blocksquery = "select BlockID,Block from tblBlocks where DistrictID =" + ddlDistrict.SelectedValue + " order by Block";
                DataSet ds = db.getResultset(blocksquery, "", "", "");

                ddlBlocks.DataSource = ds;
                ddlBlocks.DataTextField = "Block";
                ddlBlocks.DataValueField = "BlockID";
                ddlBlocks.DataBind();
                ddlBlocks.Items.Insert(0, "Select");
            }
            else
            {
                ddlBlocks.Items.Clear();
                ddlBlocks.Items.Insert(0, "Select");
                ddlCSO.Items.Clear();
                ddlCSO.Items.Insert(0, "Select");
            }
        }

        protected void ddlBlock_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlBlocks.SelectedIndex > 0)
            {
                string blocksquery = "Select CSOID ,CSOName from tblCSO where BlockID=" + ddlBlocks.SelectedValue + " order by CSOName";
                DataSet ds = db.getResultset(blocksquery, "", "", "");

                ddlCSO.DataSource = ds;
                ddlCSO.DataTextField = "CSOName";
                ddlCSO.DataValueField = "CSOName";
                ddlCSO.DataBind();
                ddlCSO.Items.Insert(0, "Select");
            }
            else
            {
                ddlCSO.Items.Clear();
                ddlCSO.Items.Insert(0, "Select");
            }
        }
    }
}