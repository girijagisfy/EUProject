using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CF
{
    public partial class EditWF : System.Web.UI.Page
    {
        DbErrorLog db = new DbErrorLog();
        string User = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserType"] != null)
            {
                User = Convert.ToString(Session["UserType"]);
                if (User == "Admin" || User == "CSO" || User == "WFG")
                {
                    Page.UnobtrusiveValidationMode = UnobtrusiveValidationMode.None;
                    if (Session["WfNo"] != null)
                    {
                        if (!IsPostBack)
                        {
                            if (User == "Admin")
                            {
                                LoadCSO();
                            }
                            else if (User == "CSO")
                            {
                                LoadCSOData();
                            }
                            else if (User == "WFG")
                            {
                                dvCSO.Visible = pnlVillage.Visible = pnlWFG.Visible = false;
                            }

                            LoadCategory();
                            LoadRationTypes();
                            LoadCBOType();
                            LoadData();
                        }
                    }
                    else
                    {
                        Response.Redirect("~/WFInfo.aspx");
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
        }

        protected void ServerValidation(object source, ServerValidateEventArgs args)
        {
            args.IsValid = ddlRationCardType.SelectedIndex > 0 || rblRationCard.SelectedValue == "Yes";
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
        public void LoadStates()
        {
            string selectVill = "Select StateId, StateName from tblStates order by StateName";
            DataSet dsV = db.getResultset(selectVill, "", "", "");
            if (dsV != null && dsV.Tables[0].Rows.Count > 0)
            {
                ddlstate.DataSource = dsV;
                ddlstate.DataTextField = "StateName";
                ddlstate.DataValueField = "StateId";
                ddlstate.DataBind();
                ddlstate.Items.Insert(0, "Select");
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
        }

        public void LoadCBOType()
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
        }

        public void LoadWFGs()
        {
            string query = "select WfgNo,WFGName from tblWFGs where VillageID = " + ddlVillage.SelectedValue + " order by WFGName";
            DataSet ds = db.getResultset(query, "", "", "");

            if (ds != null && ds.Tables[0].Rows.Count > 0)
            {
                ddlWFG.DataSource = ds;
                ddlWFG.DataValueField = "WfgNo";
                ddlWFG.DataTextField = "WFGName";
                ddlWFG.DataBind();
                ddlWFG.Items.Insert(0, "Select");
            }
        }

        public void LoadData()
        {
            string query = "select c.CSOID, d.StateId, c.DistrictID, c.BlockID,c.GramPanchayatName, a.VillageID, WFGID,b.Hamlet, WFno, WomenName, HusbandName, Age, DOB, Qualification, OtherEducation, SocialCategoryID, AadharNo, isBankAccount, NameofBank, AccountHolder, AccountNo, IFSC, TotalFamilyMembers, IsCBOMember, NameofCBO, CBONatureID, isRationcard, RationcardTypeID, isUjjwalaGasConnection, IsToilet, ToiletFunction,OtherInformation, ContactNumber,Percentage,ICTAccess,OnFarm,OffFarm,SolelyParticipate,JointlyParticipate,Financialliteracy,Deciding, Branch,ShareHolder,  Religion, ReligionOther, IsDisable, DisabilityType, DisabilityOther, VocationalTraining, BaselineSurvey, ClimateStudy, GenderStudy,MaritalStatus from tblWFs a left outer join tblVillageInfo c on a.VillageID = c.Vid left outer join tblCSO d on c.CSOID = d.CSOID left outer join tblWFGs b on a.WFGID = b.WfgNo where WfNo = " + Session["WfNo"];

            DataSet ds = db.getResultset(query, "", "", "");
            DataTable dt = new DataTable();
            if (ds != null && ds.Tables[0].Rows.Count > 0)
            {
                dt = ds.Tables[0];

                if (User == "Admin" || User == "CSO")
                {
                    if (ddlCSO.Items.FindByValue(dt.Rows[0]["CSOID"].ToString()) != null)
                    {
                        ddlCSO.Items.FindByValue(dt.Rows[0]["CSOID"].ToString()).Selected = true;
                    }
                    LoadStates();
                    if (ddlstate.Items.FindByValue(dt.Rows[0]["StateId"].ToString()) != null)
                    {
                        ddlstate.Items.FindByValue(dt.Rows[0]["StateId"].ToString()).Selected = true;
                    }
                    loadDist();
                    if (ddlDistrict.Items.FindByValue(dt.Rows[0]["DistrictID"].ToString()) != null)
                    {
                        ddlDistrict.Items.FindByValue(dt.Rows[0]["DistrictID"].ToString()).Selected = true;
                    }
                    loadBlock();
                    if (ddlBlock.Items.FindByValue(dt.Rows[0]["BlockID"].ToString()) != null)
                    {
                        ddlBlock.Items.FindByValue(dt.Rows[0]["BlockID"].ToString()).Selected = true;
                    }
                    loadVillage();
                    if (ddlVillage.Items.FindByValue(dt.Rows[0]["VillageID"].ToString()) != null)
                    {
                        ddlVillage.Items.FindByValue(dt.Rows[0]["VillageID"].ToString()).Selected = true;
                    }
                    txtGrampanchayat.Text = dt.Rows[0]["GramPanchayatName"].ToString();
                    LoadWFGs();
                    if (ddlWFG.Items.FindByValue(dt.Rows[0]["WFGID"].ToString()) != null)
                    {
                        ddlWFG.Items.FindByValue(dt.Rows[0]["WFGID"].ToString()).Selected = true;
                    }
                    txtHamlet.Text = dt.Rows[0]["Hamlet"].ToString();
                }
                txtGrampanchayat.Text = dt.Rows[0]["GramPanchayatName"].ToString();
                txtNameofWomen.Text = dt.Rows[0]["WomenName"].ToString();
                txtFatherName.Text = dt.Rows[0]["HusbandName"].ToString();
                if (ddlSocialCategory.Items.FindByValue(dt.Rows[0]["SocialCategoryID"].ToString()) != null)
                {
                    ddlSocialCategory.Items.FindByValue(dt.Rows[0]["SocialCategoryID"].ToString()).Selected = true;
                }
                txtAge.Text = dt.Rows[0]["Age"].ToString();
                txtDOB.Text = dt.Rows[0]["DOB"].ToString();
                txtAadharNo.Text = dt.Rows[0]["AadharNo"].ToString();
                if (ddlEducationQualification.Items.FindByValue(dt.Rows[0]["Qualification"].ToString()) != null)
                {
                    ddlEducationQualification.Items.FindByValue(dt.Rows[0]["Qualification"].ToString()).Selected = true;
                }
                if (ddlEducationQualification.SelectedValue == "Other")
                {
                    txtOtherQualification.Text = dt.Rows[0]["OtherEducation"].ToString();
                }
                txtFamilyMembers.Text = dt.Rows[0]["TotalFamilyMembers"].ToString();
                if (rblRationCard.Items.FindByValue(dt.Rows[0]["isRationcard"].ToString()) != null)
                {
                    rblRationCard.Items.FindByValue(dt.Rows[0]["isRationcard"].ToString()).Selected = true;
                }
                if (rblRationCard.SelectedValue == "Yes")
                {
                    if (ddlRationCardType.Items.FindByValue(dt.Rows[0]["RationcardTypeID"].ToString()) != null)
                    {
                        ddlRationCardType.Items.FindByValue(dt.Rows[0]["RationcardTypeID"].ToString()).Selected = true;
                    }
                }
                if (rblCBO.Items.FindByValue(dt.Rows[0]["IsCBOMember"].ToString()) != null)
                {
                    rblCBO.Items.FindByValue(dt.Rows[0]["IsCBOMember"].ToString()).Selected = true;
                }
                if (rblCBO.SelectedValue == "Yes")
                {
                    txtMemberofAnyCBOName.Text = dt.Rows[0]["NameofCBO"].ToString();
                    if (ddlCBOtype.Items.FindByValue(dt.Rows[0]["CBONatureID"].ToString()) != null)
                    {
                        ddlCBOtype.Items.FindByValue(dt.Rows[0]["CBONatureID"].ToString()).Selected = true;
                    }
                }
                if (dt.Rows[0]["Religion"].ToString() != "")
                {
                    if (ddlReligion.Items.FindByValue(dt.Rows[0]["Religion"].ToString()) != null)
                    {
                        ddlReligion.Items.FindByValue(dt.Rows[0]["Religion"].ToString()).Selected = true;
                    }
                    else
                    {
                        ddlReligion.Items.FindByValue("Others").Selected = true;
                    }
                }
                if (ddlMaritalStatus.Items.FindByValue(dt.Rows[0]["MaritalStatus"].ToString()) != null)
                {
                    ddlMaritalStatus.Items.FindByValue(dt.Rows[0]["MaritalStatus"].ToString()).Selected = true;
                }
                if (ddlReligion.SelectedValue == "Others")
                {
                    txtOtherReligion.Text = dt.Rows[0]["ReligionOther"].ToString();
                }
                if (rblDisability.Items.FindByValue(dt.Rows[0]["IsDisable"].ToString()) != null)
                {
                    rblDisability.Items.FindByValue(dt.Rows[0]["IsDisable"].ToString()).Selected = true;
                }
                if (rblDisability.SelectedValue == "Yes")
                {
                    if (ddlDisabilityType.Items.FindByValue(dt.Rows[0]["DisabilityType"].ToString()) != null)
                    {
                        ddlDisabilityType.Items.FindByValue(dt.Rows[0]["DisabilityType"].ToString()).Selected = true;
                    }
                    if (ddlDisabilityType.SelectedValue == "Other")
                    {
                        txtDisabilitySpecify.Text = dt.Rows[0]["DisabilityOther"].ToString();
                    }
                }
                if (rblVocationalTraining.Items.FindByValue(dt.Rows[0]["VocationalTraining"].ToString()) != null)
                {
                    rblVocationalTraining.Items.FindByValue(dt.Rows[0]["VocationalTraining"].ToString()).Selected = true;
                }
                if (rblBaselineSurvey.Items.FindByValue(dt.Rows[0]["BaselineSurvey"].ToString()) != null)
                {
                    rblBaselineSurvey.Items.FindByValue(dt.Rows[0]["BaselineSurvey"].ToString()).Selected = true;
                }
                if (rblClimateStudy.Items.FindByValue(dt.Rows[0]["ClimateStudy"].ToString()) != null)
                {
                    rblClimateStudy.Items.FindByValue(dt.Rows[0]["ClimateStudy"].ToString()).Selected = true;
                }
                if (rblGenderStudy.Items.FindByValue(dt.Rows[0]["GenderStudy"].ToString()) != null)
                {
                    rblGenderStudy.Items.FindByValue(dt.Rows[0]["GenderStudy"].ToString()).Selected = true;
                }

                if (rblBank.Items.FindByValue(dt.Rows[0]["isBankAccount"].ToString()) != null)
                {
                    rblBank.Items.FindByValue(dt.Rows[0]["isBankAccount"].ToString()).Selected = true;
                }
                if (rblBank.SelectedValue == "Yes")
                {
                    txtBankName.Text = dt.Rows[0]["NameofBank"].ToString();
                    txtBranchName.Text = dt.Rows[0]["Branch"].ToString();
                    txtAccountHolderName.Text = dt.Rows[0]["AccountHolder"].ToString();
                    txtAccountNo.Text = dt.Rows[0]["AccountNo"].ToString();
                    txtIFSC.Text = dt.Rows[0]["IFSC"].ToString();
                }
                if (rblGas.Items.FindByValue(dt.Rows[0]["isUjjwalaGasConnection"].ToString()) != null)
                {
                    rblGas.Items.FindByValue(dt.Rows[0]["isUjjwalaGasConnection"].ToString()).Selected = true;
                }


                if (rblToilet.Items.FindByValue(dt.Rows[0]["IsToilet"].ToString()) != null)
                {
                    rblToilet.Items.FindByValue(dt.Rows[0]["IsToilet"].ToString()).Selected = true;
                }
                if (rblToilet.SelectedValue == "Yes")
                {
                    if (rblToiletState.Items.FindByValue(dt.Rows[0]["ToiletFunction"].ToString()) != null)
                    {
                        rblToiletState.Items.FindByValue(dt.Rows[0]["ToiletFunction"].ToString()).Selected = true;
                    }
                }




                txtContact.Text = dt.Rows[0]["ContactNumber"].ToString();
                txtinformation.Text = dt.Rows[0]["OtherInformation"].ToString();

                //ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "GetFields()", true);
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
                    if (ddlstate.Items.FindByValue(csods.Tables[0].Rows[0]["StateId"].ToString()) != null)
                    {
                        ddlstate.Items.FindByValue(csods.Tables[0].Rows[0]["StateId"].ToString()).Selected = true;
                    }
                    loadDist();
                    if (ddlDistrict.Items.FindByValue(csods.Tables[0].Rows[0]["DistrictID"].ToString()) != null)
                    {
                        ddlDistrict.Items.FindByValue(csods.Tables[0].Rows[0]["DistrictID"].ToString()).Selected = true;
                    }
                    loadBlock();
                    if (ddlBlock.Items.FindByValue(csods.Tables[0].Rows[0]["BlockID"].ToString()) != null)
                    {
                        ddlBlock.Items.FindByValue(csods.Tables[0].Rows[0]["BlockID"].ToString()).Selected = true;
                    }

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

            string query = "UPDATE dbo.tblWFs SET WFGID=" + WFG + ", VillageID=" + villageid + ", WomenName='" + WomenName + "', HusbandName='" + HusbandName + "', Age='" + Age + "', DOB=Convert(Date,'" + DOB + "'), Qualification='" + Education + "', OtherEducation='" + OtherEducation + "', SocialCategoryID=" + SocialCat + ", AadharNo=" + Aadhar + ", isBankAccount='" + HaveBank + "', NameofBank='" + BankNane + "', AccountHolder='" + accountholdername + "', AccountNo='" + accountno + "', IFSC='" + ifsc + "', TotalFamilyMembers='" + FamilyNo + "', IsCBOMember='" + CBOoption + "', NameofCBO='" + CBOName + "', CBONatureID=" + CBONature + ", isRationcard='" + RationOption + "', RationcardTypeID=" + CardType + ", isUjjwalaGasConnection='" + UjjwalaGas + "', IsToilet='" + isToilet + "', ToiletFunction='" + Toilet + "',    OtherInformation='" + Infoermation + "', ContactNumber='" + Contact + "',OffFarm='" + OffFarm + "',Percentage='" + Percentage + "',ICTAccess='" + ICTAccess + "',OnFarm='" + OnFarm + "',Deciding='" + Deciding + "',SolelyParticipate='" + SolelyParticipate + "',JointlyParticipate='" + JointlyParticipate + "',ShareHolder='" + ShareHolder + "', Financialliteracy='" + Financialliteracy + "', Branch='" + branch + "',  Religion='" + Religion + "', ReligionOther='" + ReligionOther + "', IsDisable='" + HaveDisability + "', DisabilityType='" + DisabilityType + "', DisabilityOther='" + DisabilitySpecify + "', VocationalTraining='" + VocationalTraining + "', BaselineSurvey='" + BaselineSurvey + "', ClimateStudy='" + Climate + "', GenderStudy='" + GenderStudy + "', MaritalStatus='" + ddlMaritalStatus.SelectedValue + "',FamilyIncome='" + FamilyIncome + "' where WfNo=" + Session["WfNo"];


            if (db.UpdateQuery(query, "", "", "") > 0)
            {


                string track = "insert into tblMasterDataTracking(Date,UpdatedBy,UpdatedTo,UpdatedRecord) values('" + DateTime.Now + "','" + Session["UserID"] + "','Women Profile','" + Session["WFno"] + " - " + WomenName + " - " + HusbandName + "')";
                if (db.UpdateQuery(track, "", "", "") > 0)
                {
                }
                ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "ShowAlert('Data Updated successfully. Thank you.','success')", true);
            }
            else
            {
                ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "ShowAlert('Something went wrong please try again.','warning')", true);
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
            }
            else
            {
                txtHamlet.Text = "";
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
