using CF.Models;
using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Configuration;
using System.Data;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CF
{
    public partial class FPCRegistration : System.Web.UI.Page
    {
        DbErrorLog db = new DbErrorLog();
        string User = string.Empty;
        Generator genobj = new Generator();
        protected void Page_Load(object sender, EventArgs e)
        {
            Page.UnobtrusiveValidationMode = UnobtrusiveValidationMode.None;
            if (Session["UserType"] != null)
            {
                User = Session["UserType"].ToString();
                if (User == "Admin")
                {
                    if (!IsPostBack)
                    {
                        LoadStates();
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

        protected void loadCso()
        {
            string selectCso = "select [CSOName] from [tblCSO]";
            DataSet dataSet = db.getResultset(selectCso, "", "", "");
            //if (dataSet != null && dataSet.Tables[0].Rows.Count > 0)
            //{
            ddlCSO.DataSource = dataSet;
            ddlCSO.DataTextField = "CSOName";
            ddlCSO.DataValueField = "CSOName";
            ddlCSO.DataBind();
            ddlCSO.Items.Insert(0, "Select");
            //}
        }

        protected void CheckBoxRequired_ServerValidate(object source, ServerValidateEventArgs args)
        {
            args.IsValid = cbConfirm.Checked;
        }

        protected void txtuser_TextChanged(object sender, EventArgs e)
        {

            string query = "select UserName from dbo.tblFPCRegistration where UserName='" + txtUserName.Text + "'";

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

            //

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

            string fileName = "";
            bool status = true;
            if (fuFpcLogo.HasFile)
            {
                if (fuFpcLogo.PostedFile.ContentLength <= 100000)
                {
                    fileName = order + fuFpcLogo.FileName;
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

                        status = false;
                    }
                    else
                    {
                        //upload the file onto the server                 
                        string FolderPath = ConfigurationManager.ConnectionStrings["fpcLogo"].ConnectionString;
                        string FilePath = FolderPath + fileName;
                        fuFpcLogo.SaveAs(FilePath);
                    }
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

            if (status == true)
            {
                string Query = "INSERT INTO tblFPCRegistration(StateID, CSOName, BlockID, DistrictID, FPCName, FPCAddress, FPCContactNumber, FPCEmail, FPCWebsite, TotalMembers, MaleMembers, FemaleMembers,TransGenderMembers, SFMFMembers, STMembers, SCMembers, OBCMembers,GeneralMembers, NoofVillagesCovered, NoofBlocksCovered, NoofDistrictsCovered, NoofSharesMobilizedbyFPC,SharedMoneyMobilizedbyFPC, SFACEquitySupportAvailed, EquityGrantFundMobilizedbyFPC, FPCRegistrationdate, LegalActunderWhichFPC, CINNo, SupportTakenfromotherAgency, SupportAmt, FPCBankAccountNo, AccountType, BankName, BankBranch, IFSCCode, FPCBusinessAddress, TAN, TANNumber, TANDate, TANExpiry, PAN, PANNumber, PANDate, PANExpiry, GST, GSTNumber, GSTDate, GSTExpiry, ServiceTax, ServiceTaxNumber, ServiceTaxDate, ServiceTaxExpiry, BusinesslicenseTaken, EmployeeAppointed, DirectorsAppointed, UserName, Password, FpcLogo,OtherLegalAct,UploadFile,UploadFileName) VALUES(" + state + ",'" + CSO + "','" + Blocks + "','" + Districts + "','" + FPCName + "','" + FPCAddress + "','" + FPCContact + "','" + FPCemail + "','" + FPCWebsite + "','" + totalMem + "','" + male + "','" + female + "','" + trans + "','" + sfmf + "','" + st + "','" + sc + "','" + obc + "','" + gen + "','" + VillgesCovered + "','" + BlocksCovered + "','" + DistrictsCovered + "','" + NoofSharesMobilized + "','" + SharedMoneyMobilized + "','" + SFAC + "','" + EquityGrant + "','" + FPCRegisterdate + "','" + LegalAct + "','" + CINnumber + "','" + SupportTakenfromotherAgency + "','" + Support + "','" + FPCBankNumber + "','" + AccountType + "','" + BankName + "','" + BankBranch + "','" + IFSCcode + "','" + FPCBusinessAddress + "','" + TAN + "','" + TANNumber + "','" + TANDate + "','" + TANExpiry + "','" + PAN + "','" + PANNumber + "','" + PANDate + "','" + PANExpiry + "','" + GST + "','" + GSTNumber + "','" + GSTDate + "','" + GSTExpiry + "','" + TAX + "','" + TAXNumber + "','" + TAXDate + "','" + TAXExpiry + "','" + BusinessLicense + "','" + EmployeAppint + "','" + Directors + "','" + UserName + "','" + Password + "','" + fileName + "','" + otherLeagelAct + "','" + FullPath + "', '" + UploadFileName + "'); select @@IDENTITY as fpcid";
                DataSet ds = db.getResultset(Query, "", "", "");
                if (ds != null && ds.Tables[0].Rows.Count > 0)
                {
                    //About us
                    string FPCId = ds.Tables[0].Rows[0]["fpcid"].ToString();
                    string Overview = txtOverview.Text;
                    string Mission = txtMission.Text;
                    string Vission = txtVission.Text;
                    string Chairperson = txtChairperson.Text;
                    string BusinessModel = txtBusinessModel.Text;
                    string Socialandenvironment = txtSocialandenvironment.Text;
                    string CoreValues = txtCorevalues.Text;
                    string Organizationpolicy = string.Empty;

                    string Aboutus = "INSERT INTO tblFPCRegAboutus(FPCId, Overview, Mission, Vission, Chairperson, BusinessModel,Socialandenvironment,CoreValues) VALUES(" + FPCId + ",'" + Overview + "','" + Mission + "','" + Vission + "','" + Chairperson + "','" + BusinessModel + "','" + Socialandenvironment + "','" + CoreValues + "')";

                    db.UpdateQuery(Aboutus, "", "", "");

                    string[] SupportTaken = hiddenDataArrayId.Value.ToString().Split('$');
                    //Begin Tran SupportTaken;save Tran SaveSupportTaken;

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

                    if (DirectorsMembers.Length > 0 && !string.IsNullOrEmpty(DirectorsMembers[0]))
                    {
                        for (int i = 0; i < DirectorsMembers.Length; i++)
                        {
                            string[] DirectorMembersData = DirectorsMembers[i].Split(':');
                            string insertQ2 = "INSERT INTO [tblBODMembers]([FPCId],[BoardMemberName],[Gender],[MobileNo],[DirectorType],[PeriodFrom],[PeriodTo]) VALUES(" + Session["FPCid"] + ",'" + DirectorMembersData[0] + "','" + DirectorMembersData[1] + "','" + DirectorMembersData[2] + "','" + DirectorMembersData[3] + "','" + DirectorMembersData[4] + "','" + DirectorMembersData[5] + "')";
                            db.UpdateQuery(insertQ2, "", "", "");
                        }
                    }

                    ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "ShowAlert('FPC Registered Successfully. Thank you.','success')", true);
                }
                else
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "ShowAlert('Something went wrong please try again.','warning')", true);
                }
            }
            //    }
            //    else
            //    {
            //        ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "ShowAlert('Logo should be less than 100kb.','warning')", true);
            //    }
            //}
            //else
            //{
            //    ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "ShowAlert('Please Upload FPC Logo.','warning')", true);
            //}
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
                ddlDistrict.Items.Insert(0, "Select");
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

        //protected void ddlSFACEquity_SelectedIndexChanged(object sender, EventArgs e)
        //{
        //    if (ddlSFACEquity.SelectedIndex > 0)
        //    {
        //        if (ddlSFACEquity.SelectedValue == "Yes")
        //        {
        //            dvEquityGrant.Visible = true;
        //        }
        //        else
        //        {
        //            dvEquityGrant.Visible = false;
        //        }
        //    }
        //    else
        //    {
        //        dvEquityGrant.Visible = false;
        //    }
        //}

        //protected void ddlSupportTaken_SelectedIndexChanged(object sender, EventArgs e)
        //{
        //    if (ddlSupportTaken.SelectedIndex > 0)
        //    {
        //        if (ddlSupportTaken.SelectedValue == "Yes")
        //        {
        //            dvSupportTaken.Visible = true;
        //            AddSupportTaken.Visible = true;
        //        }
        //        else
        //        {
        //            dvSupportTaken.Visible = false;
        //            AddSupportTaken.Visible = false;
        //        }
        //    }
        //    else
        //    {
        //        dvSupportTaken.Visible = false;
        //        AddSupportTaken.Visible = false;
        //    }
        //}

        //protected void ddlBusinessTaken_SelectedIndexChanged(object sender, EventArgs e)
        //{
        //    if (ddlBusinessTaken.SelectedIndex > 0)
        //    {
        //        if (ddlBusinessTaken.SelectedValue == "Yes")
        //        {
        //            dvBusiness.Visible = true;
        //            AddBusiness.Visible = true;
        //        }
        //        else
        //        {
        //            dvBusiness.Visible = false;
        //            AddBusiness.Visible = false;
        //        }
        //    }
        //    else
        //    {
        //        dvBusiness.Visible = false;
        //        AddBusiness.Visible = false;
        //    }
        //}
    }
}