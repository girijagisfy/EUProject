using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CF
{
    public partial class AddWF : System.Web.UI.Page
    {
        DbErrorLog db = new DbErrorLog();
        string User = "";
        protected void Page_Load(object sender, EventArgs e)
        {

            if (Session["ClientID"] != null)
            {
                User = Session["UserType"].ToString();
                if (User == "Admin" || User == "CSO" || User == "WFG")
                {
                    Page.UnobtrusiveValidationMode = UnobtrusiveValidationMode.None;
                    if (!IsPostBack)
                    {
                        if (User == "Admin")
                        {
                            LoadCSO();
                        }
                        else if (User == "CSO")
                        {
                            LoadCSOData();
                            loadVillage();

                            //dvCSO.Visible = false;
                        }
                        else if (User == "WFG")
                        {
                            dvCSO.Visible = false;
                            pnlVillage.Visible = false;
                            pnlWFG.Visible = false;
                        }

                        LoadCategory();
                        LoadRationTypes();
                        LoadCBOType();
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
            string query = "select * from tblCSO where CSOID = " + Session["ClientID"];
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
            else
            {
                ddlCSO.Items.Clear();
                ddlCSO.Items.Insert(0, "Select");
            }
        }
        public void LoadStates()
        {
            string selectVill = "select StateId,StateName from tblStates order by StateName";
            DataSet dsV = db.getResultset(selectVill, "", "", "");
            if (dsV != null && dsV.Tables[0].Rows.Count > 0)
            {
                ddlstate.DataSource = dsV;
                ddlstate.DataTextField = "StateName";
                ddlstate.DataValueField = "StateId";
                ddlstate.DataBind();
                ddlstate.Items.Insert(0, "Select");
            }
            else
            {
                ddlstate.Items.Clear();
                ddlstate.Items.Insert(0, "Select");
            }
        }
        public void loadDist()
        {
            string selectDist = "Select District,DistrictID from tblDistricts order by District";
            DataSet ds = db.getResultset(selectDist, "", "", "");
            if (ds != null && ds.Tables[0].Rows.Count > 0)
            {
                ddlDistrict.DataSource = ds;
                ddlDistrict.DataTextField = "District";
                ddlDistrict.DataValueField = "DistrictID";
                ddlDistrict.DataBind();
            }
        }

        public void loadBlock()
        {
            string selectDist = "Select Block,BlockID from tblBlocks order by Block";
            DataSet ds = db.getResultset(selectDist, "", "", "");
            if (ds != null && ds.Tables[0].Rows.Count > 0)
            {
                ddlBlock.DataSource = ds;
                ddlBlock.DataTextField = "Block";
                ddlBlock.DataValueField = "BlockID";
                ddlBlock.DataBind();
            }
        }

        public void LoadCategory()
        {
            string query = "select Sid,SocialCategory from tblSocialCategory order by SocialCategory";
            DataSet ds = db.getResultset(query, "", "", "");

            if (ds != null && ds.Tables[0].Rows.Count > 0)
            {
                ddlSocialCategory.DataSource = ds;
                ddlSocialCategory.DataValueField = "Sid";
                ddlSocialCategory.DataTextField = "SocialCategory";
                ddlSocialCategory.DataBind();
                ddlSocialCategory.Items.Insert(0, "Select");
            }
            else
            {
                ddlSocialCategory.Items.Clear();
                ddlSocialCategory.Items.Insert(0, "Select");
            }
        }

        public void loadVillage()
        {
            string block = "";
            if (User == "Admin")
            {
                block = ddlBlock.SelectedValue;
            }
            else if (User == "CSO")
            {
                string distblock = "select DistrictID,BlockID from tblCSO where CSOID = " + ddlCSO.SelectedValue;
                DataSet distds = db.getResultset(distblock, "", "", "");
                if (distds != null && distds.Tables[0].Rows.Count > 0)
                {
                    DataTable distdt = distds.Tables[0];
                    block = distdt.Rows[0]["BlockID"].ToString();
                }
            }

            string selectVill = "Select Vid,Village from tblVillageInfo a left outer join tblVillages b on a.VillageID = b.VillageID where a.VillageID is not null and a.BlockID =" + block + " order by Village";
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

        public void LoadRationTypes()
        {
            string query = "select Rid,RationType from tblRationType order by RationType";
            DataSet ds = db.getResultset(query, "", "", "");

            if (ds != null && ds.Tables[0].Rows.Count > 0)
            {
                ddlRationCardType.DataSource = ds;
                ddlRationCardType.DataValueField = "Rid";
                ddlRationCardType.DataTextField = "RationType";
                ddlRationCardType.DataBind();
                ddlRationCardType.Items.Insert(0, "Select");
            }
            else
            {
                ddlRationCardType.Items.Clear();
                ddlRationCardType.Items.Insert(0, "Select");
            }
        }
        protected void LoadCBOType()
        {
            string query = "select CBOID,CBONature from tblCBONature order by CBONature";
            DataSet ds = db.getResultset(query, "", "", "");

            if (ds != null && ds.Tables[0].Rows.Count > 0)
            {
                ddlCBOtype.DataSource = ds;
                ddlCBOtype.DataValueField = "CBOID";
                ddlCBOtype.DataTextField = "CBONature";
                ddlCBOtype.DataBind();
                ddlCBOtype.Items.Insert(0, "Select");
            }
            else
            {
                ddlCBOtype.Items.Clear();
                ddlCBOtype.Items.Insert(0, "Select");
            }
        }

        protected void ServerValidation(object source, ServerValidateEventArgs args)
        {
            args.IsValid = ddlRationCardType.SelectedIndex > 0 || rblRationCard.SelectedValue == "Yes";
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            string villageid = "";
            if (User == "Admin" || User == "CSO")
            {
                villageid = ddlVillage.SelectedValue;
            }
            string WFG = "";
            if (User == "WFG")
            {
                WFG = Session["ClientID"].ToString();
                string WFGquery = "select VillageID from tblWFGs where WfgNo = " + WFG;
                DataSet WFGds = db.getResultset(WFGquery, "", "", "");
                if (WFGds != null && WFGds.Tables[0].Rows.Count > 0)
                {
                    villageid = WFGds.Tables[0].Rows[0]["VillageID"].ToString();
                }
            }
            else
            {
                WFG = ddlWFG.SelectedValue;
            }
            string WomenName = txtNameofWomen.Text;
            string HusbandName = txtFatherName.Text;
            string SocialCat = ddlSocialCategory.SelectedValue;
            string Age = txtAge.Text;
            string DOB = Convert.ToDateTime(txtDOB.Text).ToString("MM-dd-yyyy");
            string Aadhar = txtAadharNo.Text;
            string Education = ddlEducationQualification.SelectedValue;
            string OtherEducation = string.Empty;
            if (Education == "Other")
            {
                OtherEducation = txtOtherQualification.Text;
            }
            string FamilyNo = txtFamilyMembers.Text;
            string VocationalTraining = rblVocationalTraining.SelectedValue;
            string BaselineSurvey = rblBaselineSurvey.SelectedValue;
            string Climate = rblClimateStudy.SelectedValue;
            string GenderStudy = rblGenderStudy.SelectedValue;


            string Religion = ddlReligion.SelectedValue;
            string ReligionOther = "";
            if (Religion == "Others")
            {
                ReligionOther = txtOtherReligion.Text;
            }
            string HaveDisability = rblDisability.SelectedValue;
            string DisabilityType = "";
            string DisabilitySpecify = "";
            if (HaveDisability == "Yes")
            {
                DisabilityType = ddlDisabilityType.SelectedValue;
                if (DisabilityType == "Other")
                {
                    DisabilitySpecify = txtDisabilitySpecify.Text;

                }
            }


            string RationOption = rblRationCard.SelectedValue;
            string CardType = "NULL";
            if (RationOption == "Yes")
            {
                CardType = ddlRationCardType.SelectedValue;
            }
            string CBOoption = rblCBO.SelectedValue;
            string CBOName = "";
            string CBONature = "NULL";
            if (CBOoption == "Yes")
            {
                CBOName = txtMemberofAnyCBOName.Text;
                CBONature = ddlCBOtype.SelectedValue;
            }
            string HaveBank = rblBank.SelectedValue;
            string BankNane = "";
            string branch = "";
            string accountholdername = "";
            string accountno = "";
            string ifsc = "";

            if (HaveBank == "Yes")
            {
                BankNane = txtBankName.Text;
                branch = txtBranchName.Text;
                accountholdername = txtAccountHolderName.Text;
                accountno = txtAccountNo.Text;
                ifsc = txtIFSC.Text;
            }
            string UjjwalaGas = rblGas.SelectedValue;


            string isToilet = rblToilet.SelectedValue;
            string Toilet = "";
            if (isToilet == "Yes")
            {
                Toilet = rblToiletState.SelectedValue;
            }


            string Infoermation = txtinformation.Text;
            string Contact = txtContact.Text;
            string Percentage = txtPercentage.Text;
            string ICTAccess = rblICT.SelectedValue;
            string OnFarm = rblfarm.SelectedValue;
            string OffFarm = rblOfffarm.Text;
            string Deciding = txtdecisions.Text;
            string SolelyParticipate = rblparticipate.SelectedValue;
            string JointlyParticipate = rbljointly.SelectedValue;
            string ShareHolder = rblshare.SelectedValue;
            string Financialliteracy = txtfinancial.Text;
            string FamilyIncome = txtIncome.Text;
            //CSOID, VillageID,  + CSO + "," + village + "
            string query = "INSERT INTO dbo.tblWFs(WFGID, VillageID, WomenName, HusbandName, Age, DOB, Qualification, OtherEducation, SocialCategoryID, AadharNo, isBankAccount, NameofBank, AccountHolder, AccountNo, IFSC, TotalFamilyMembers, IsCBOMember, NameofCBO, CBONatureID, isRationcard, RationcardTypeID, isUjjwalaGasConnection, IsToilet, ToiletFunction,OtherInformation, ContactNumber,Percentage,ICTAccess,OnFarm,OffFarm,SolelyParticipate,JointlyParticipate,Financialliteracy,Deciding, Branch,ShareHolder,Religion, ReligionOther, IsDisable, DisabilityType, DisabilityOther, VocationalTraining, BaselineSurvey, ClimateStudy, GenderStudy,MaritalStatus,FamilyIncome) VALUES(" + WFG + "," + villageid + ",'" + WomenName + "','" + HusbandName + "','" + Age + "',Convert(Date,'" + DOB + "'),'" + Education + "','" + OtherEducation + "','" + SocialCat + "','" + Aadhar + "','" + HaveBank + "','" + BankNane + "','" + accountholdername + "','" + accountno + "','" + ifsc + "','" + FamilyNo + "','" + CBOoption + "','" + CBOName + "'," + CBONature + ",'" + RationOption + "'," + CardType + ",'" + UjjwalaGas + "','" + isToilet + "','" + Toilet + "','" + Infoermation + "','" + Contact + "','" + Percentage + "','" + ICTAccess + "','" + OnFarm + "','" + OffFarm + "','" + SolelyParticipate + "','" + JointlyParticipate + "','" + Financialliteracy + "','" + Deciding + "','" + branch + "','" + ShareHolder + "','" + Religion + "','" + ReligionOther + "','" + HaveDisability + "','" + DisabilityType + "','" + DisabilitySpecify + "','" + VocationalTraining + "','" + BaselineSurvey + "','" + Climate + "','" + GenderStudy + "','" + ddlMaritalStatus.SelectedValue + "'," + FamilyIncome + "); select @@IDENTITY as WFno, @@IDENTITY WFGID; ";

            DataSet DS = db.getResultset(query, "", "", "");
            if (DS != null && DS.Tables[0].Rows.Count > 0)
            {


                if (rblWantFPC.SelectedValue == "Yes")
                {
                    string fpcinsert = "insert into tblFPCMembers(State, District, Block, Village, Hamlet, FPCName, MemberName, FatherorHusbandName, Age, Category, EducationalQualification, ContactNo, AadhaarNo, DateofJoiningFPC, GramPanchayat) values('" + ddlstate.SelectedValue + "','" + ddlDistrict.SelectedValue + "','" + ddlBlock.SelectedValue + "', '" + ddlVillage.SelectedValue + "','" + txtHamlet.Text + "','" + ddlFPCName.SelectedValue + "','" + txtNameofWomen.Text + "','" + txtFatherName.Text + "','" + txtAge.Text + "','" + ddlSocialCategory.SelectedValue + "','" + ddlEducationQualification.SelectedValue + "','" + txtContact.Text + "','" + txtAadharNo.Text + "','" + DateTime.Now + "','" + txtGrampanchayat.Text + "')";
                    db.UpdateQuery(fpcinsert, "", "", "");
                }
                string track = "insert into tblMasterDataTracking(Date,UpdatedBy,UpdatedTo,UpdatedRecord) values('" + DateTime.Now + "','" + Session["UserID"] + "','WF','" + DS.Tables[0].Rows[0]["WFno"] + " - " + txtNameofWomen.Text + " - " + ddlWFG.SelectedValue + "')";
                db.UpdateQuery(track, "", "", "");

                ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "ShowAlert('You have submitted data successfully. Thank you.','success')", true);
            }
            else
            {
                ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "ShowAlert('Something went wrong please try again.','warning')", true);
            }




        }

        protected void ddlCSO_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlCSO.SelectedIndex > 0)
            {
                ddlWFG.Items.Clear();
                ddlWFG.Items.Insert(0, "Select");

                string selectCSO = "SELECT [District],c.DistrictID,[Block],b.BlockID,D.StateId,StateName FROM tblCSO A,tblBlocks B,tblDistricts C ,tblStates D  where B.[BlockID ] = A.BlockID and C.[DistrictID] = A.DistrictID and D.[StateId] = A.StateId and CSOID =" + ddlCSO.SelectedValue;
                DataSet csods = db.getResultset(selectCSO, "", "", "");
                if (csods != null && csods.Tables[0].Rows.Count > 0)
                {
                    LoadStates();
                    ddlstate.Items.FindByText(csods.Tables[0].Rows[0]["StateName"].ToString()).Selected = true;
                    loadDist();
                    ddlDistrict.Items.FindByText(csods.Tables[0].Rows[0]["District"].ToString()).Selected = true;

                    loadBlock();
                    ddlBlock.Items.FindByText(csods.Tables[0].Rows[0]["Block"].ToString()).Selected = true;

                    loadVillage();
                }
            }
            else
            {
                ddlstate.Items.Clear();
                ddlstate.Items.Insert(0, "Select");
                ddlVillage.Items.Clear();
                ddlVillage.Items.Insert(0, "Select");
                ddlDistrict.Items.Clear();
                ddlDistrict.Items.Insert(0, "Select");
                ddlBlock.Items.Clear();
                ddlBlock.Items.Insert(0, "Select");
                txtHamlet.Text = "";
                txtGrampanchayat.Text = "";
                ddlWFG.Items.Clear();
                ddlWFG.Items.Insert(0, "Select");
            }

        }

        protected void ddlVillage_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlVillage.SelectedIndex > 0)
            {
                string query = "select WfgNo,WFGName from tblWFGs where VillageID = " + ddlVillage.SelectedValue + " order by WFGName";
                DataSet ds = db.getResultset(query, "", "", "");

                ddlWFG.DataSource = ds;
                ddlWFG.DataValueField = "WfgNo";
                ddlWFG.DataTextField = "WFGName";
                ddlWFG.DataBind();
                ddlWFG.Items.Insert(0, "Select");

                string Gquery = "select GramPanchayatName from tblVillageInfo where Vid = " + ddlVillage.SelectedValue;
                DataSet Gds = db.getResultset(Gquery, "", "", "");
                if (Gds != null && Gds.Tables[0].Rows.Count > 0)
                {
                    DataTable dt = Gds.Tables[0];
                    txtGrampanchayat.Text = dt.Rows[0]["GramPanchayatName"].ToString();
                }
                else
                {
                    txtGrampanchayat.Text = string.Empty;
                }
            }
            else
            {
                txtGrampanchayat.Text = string.Empty;
                txtHamlet.Text = string.Empty;
                ddlWFG.Items.Clear();
                ddlWFG.Items.Insert(0, "Select");
            }
        }



        protected void ddlWFG_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlWFG.SelectedIndex > 0)
            {
                string Hquery = "select Hamlet from tblWFGs where WfgNo =" + ddlWFG.SelectedValue;
                DataSet Hds = db.getResultset(Hquery, "", "", "");
                if (Hds != null && Hds.Tables[0].Rows.Count > 0)
                {
                    txtHamlet.Text = Hds.Tables[0].Rows[0]["Hamlet"].ToString();
                }
                else
                {
                    txtHamlet.Text = string.Empty;
                }
            }
            else
            {
                txtHamlet.Text = string.Empty;
            }
        }

        protected void txtDOB_TextChanged(object sender, EventArgs e)
        {
            DateTime today = DateTime.Now;
            if (!string.IsNullOrEmpty(txtDOB.Text))
            {
                int todayyear = Convert.ToDateTime(today).Year;
                string[] year = txtDOB.Text.Split('/');
                int DOBYear = Convert.ToInt32(year[2]);
                //int dobyear = Convert.ToDateTime(txtDOB.Text).Year;
                int age = todayyear - DOBYear;
                string agenew = age.ToString();
                txtAge.Text = agenew;
            }
        }

        private void getGridDetails()
        {
            string query = "SELECT FPCMemberId, MemberName, FatherorHusbandName, DOB FROM tblFPCMembers WHERE MemberName='" + txtCheckName.Text + "' AND FatherorHusbandName='" + txtCheckFather.Text + "' AND DOB='" + txtCheckDOB.Text + "'";
            DataSet ds = db.getResultset(query, "", "", "");
            DataTable dt = new DataTable();
            if ((ds != null) && (ds.Tables[0].Rows.Count > 0))
            {
                dt = ds.Tables[0];
                CheckIO.DataSource = dt;
                CheckIO.DataBind();
            }
        }

        protected void CheckIO_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "btnApply")
            {
                string strid = e.CommandArgument.ToString();
                int rowIndex = int.Parse(e.CommandArgument.ToString());
                string val = (string)this.CheckIO.DataKeys[rowIndex]["FPCMemberId"].ToString();


                string select = "SELECT * FROM tblFPCMembers WHERE FPCMemberId='" + val + "'";
                DataSet dsa = db.getResultset(select, "", "", "");
                DataTable dt = new DataTable();
                if ((dsa != null) && (dsa.Tables[0].Rows.Count > 0))
                {
                    dt = dsa.Tables[0];
                    txtGrampanchayat.Text = dt.Rows[0]["GramPanchayat"].ToString();
                    txtNameofWomen.Text = dt.Rows[0]["MemberName"].ToString();
                    txtFatherName.Text = dt.Rows[0]["FatherorHusbandName"].ToString();
                    txtDOB.Text = dt.Rows[0]["DOB"].ToString();
                    txtAge.Text = dt.Rows[0]["Age"].ToString();
                    //if (dt.Rows[0]["Category"].ToString() != "")
                    //{
                    //    ddlSocialCategory.Items.FindByValue(dt.Rows[0]["Category"].ToString()).Selected = true;
                    //}
                    if (ddlEducationQualification.Items.FindByValue(dt.Rows[0]["EducationalQualification"].ToString()) != null)
                    {
                        ddlEducationQualification.Items.FindByValue(dt.Rows[0]["EducationalQualification"].ToString()).Selected = true;
                    }
                    txtContact.Text = dt.Rows[0]["ContactNo"].ToString();
                    txtAadharNo.Text = dt.Rows[0]["AadhaarNo"].ToString();
                }
                else
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "ShowAlert('Something went wrong please try again.','warning')", true);
                }
            }
        }

        protected void CheckIO_Sorting(object sender, GridViewSortEventArgs e)
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
                CheckIO.DataSource = dtrslt;
                CheckIO.DataBind();
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            getGridDetails();
        }

        protected void rblWantFPC_SelectedIndexChanged(object sender, EventArgs e)
        {
            string str = rblWantFPC.SelectedValue;
            if (str == "Yes")
            {
                string query = "select FPCName from tblFPCRegistration";
                DataSet ds = db.getResultset(query, "", "", "");

                if (ds != null && ds.Tables[0].Rows.Count > 0)
                {
                    ddlFPCName.DataSource = ds;
                    ddlFPCName.DataValueField = "FPCName";
                    ddlFPCName.DataTextField = "FPCName";
                    ddlFPCName.DataBind();
                    ddlFPCName.Items.Insert(0, "Select");
                }
                else
                {
                    ddlFPCName.Items.Clear();
                    ddlFPCName.Items.Insert(0, "Select");
                }
                dvFPCName.Visible = true;
            }
            else
            {
                dvFPCName.Visible = false;
            }
        }
    }
}