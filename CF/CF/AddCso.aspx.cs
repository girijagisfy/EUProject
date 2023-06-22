using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using CF;
using System.Data;
using System.Configuration;
using CF.Models;

namespace CF
{
    public partial class AddCso : System.Web.UI.Page
    {
        DbErrorLog db = new DbErrorLog();
        string User = "";
        Generator genobj = new Generator();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserType"] != null)
            {
                User = Session["UserType"].ToString();
                if (User == "Admin")
                {
                    Page.UnobtrusiveValidationMode = UnobtrusiveValidationMode.None;
                    if (!IsPostBack)
                    {
                        LoadStates();
                        //LoadDistrict();
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
            string query = "select StateId,StateName from tblStates order by StateName";
            DataSet ds = db.getResultset(query, "", "", "");

            if (ds != null && ds.Tables[0].Rows.Count > 0)
            {
                ddlStates.DataSource = ds;
                ddlStates.DataValueField = "StateId";
                ddlStates.DataTextField = "StateName";
                ddlStates.DataBind();
                ddlStates.Items.Insert(0, "Select");
            }
            else
            {
                ddlStates.Items.Clear();
                ddlStates.Items.Insert(0, "Select");
            }
        }
        public void LoadDistrict()
        {
            string query = "select DistrictID,District from tblDistricts order by District";
            DataSet ds = db.getResultset(query, "", "", "");

            if (ds != null && ds.Tables[0].Rows.Count > 0)
            {
                ddlDisrtict.DataSource = ds;
                ddlDisrtict.DataValueField = "DistrictID";
                ddlDisrtict.DataTextField = "District";
                ddlDisrtict.DataBind();
                ddlDisrtict.Items.Insert(0, "Select");
            }
            else
            {
                ddlDisrtict.Items.Clear();
                ddlDisrtict.Items.Insert(0, "Select");
            }
        }
        public void LoadBlock()
        {
            string query = "select BlockID,Block from tblBlocks order by Block";
            DataSet ds = db.getResultset(query, "", "", "");

            if (ds != null && ds.Tables[0].Rows.Count > 0)
            {
                ddlBlocks.DataSource = ds;
                ddlBlocks.DataValueField = "BlockID";
                ddlBlocks.DataTextField = "Block";
                ddlBlocks.DataBind();
                ddlBlocks.Items.Insert(0, "Select");
            }
            else
            {
                ddlBlocks.Items.Clear();
                ddlBlocks.Items.Insert(0, "Select");
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            string InputFileName = string.Empty;
            if (Csologo.HasFiles)
            {
                string ServerSavePath = ConfigurationManager.AppSettings["CSoLogoPath"].ToString();
                InputFileName = genobj.Randomlongstring() + "_" + Csologo.FileName.Trim();
                Csologo.SaveAs(ServerSavePath + InputFileName);
            }

            string PANNo = "NULL";
            string PANDate = "NULL";
            string PANExpiry = "NULL";
            if (rblPAN.SelectedValue == "Yes")
            {
                PANNo = "'" + txtPanNo.Text + "'";
                PANDate = "'" + txtPanDate.Text + "'";
                PANExpiry = "'" + txtPanExpiry.Text + "'";
            }
            string TANNo = "NULL";
            string TANDate = "NULL";
            string TANExpiry = "NULL";
            if (rblTAN.SelectedValue == "Yes")
            {
                TANNo = "'" + txtTanNo.Text + "'";
                TANDate = "'" + txtTanDate.Text + "'";
                TANExpiry = "'" + txtTanExpiry.Text + "'";
            }
            string D12ANo = "NULL";
            string D12ADate = "NULL";
            string D12AExpiry = "NULL";
            if (rbl12A.SelectedValue == "Yes")
            {
                D12ANo = "'" + txt12ANo.Text + "'";
                D12ADate = "'" + txt12ADate.Text + "'";
                D12AExpiry = "'" + txt12AExpiry.Text + "'";
            }
            string D80GNo = "NULL";
            string D80GDate = "NULL";
            string D80GExpiry = "NULL";
            if (rbl12A.SelectedValue == "Yes")
            {
                D80GNo = "'" + txt80GNo.Text + "'";
                D80GDate = "'" + txt80GDate.Text + "'";
                D80GExpiry = "'" + txt80GExpiry.Text + "'";
            }
            string GSTNo = "NULL";
            string GSTDate = "NULL";
            string GSTExpiry = "NULL";
            if (rblGST.SelectedValue == "Yes")
            {
                GSTNo = "'" + txtGSTNo.Text + "'";
                GSTDate = "'" + txtGSTDate.Text + "'";
                GSTExpiry = "'" + txtGSTExpiry.Text + "'";
            }
            string PFPCNo = "NULL";
            string PFPCAssociates = "NULL";
            string PFPCDetails = "NULL";
            if (rblFPCPromotion.SelectedValue == "Yes")
            {
                PFPCNo = "'" + txtPromotion1.Text + "'";
                PFPCAssociates = "'" + txtPromotion2.Text + "'";
                PFPCDetails = "'" + txtPromotion3.Text + "'";
            }
            string WFACGNo = "NULL";
            string WFACGAssociates = "NULL";
            string WFACGDetails = "NULL";
            if (rblWFACG.SelectedValue == "Yes")
            {
                WFACGNo = "'" + txtWFACG1.Text + "'";
                WFACGAssociates = "'" + txtWFACG2.Text + "'";
                WFACGDetails = "'" + txtWFACG3.Text + "'";
            }
            string IGPENo = "NULL";
            string IGPEAssociates = "NULL";
            string IGPEDetails = "NULL";
            if (rblIGPE.SelectedValue == "Yes")
            {
                IGPENo = "'" + txtIGPE1.Text + "'";
                IGPEAssociates = "'" + txtIGPE2.Text + "'";
                IGPEDetails = "'" + txtIGPE3.Text + "'";
            }
            string WPRILNo = "NULL";
            string WPRILAssociates = "NULL";
            string WPRILDetails = "NULL";
            if (rblWPRIL.SelectedValue == "Yes")
            {
                WPRILNo = "'" + txtWPRIL1.Text + "'";
                WPRILAssociates = "'" + txtWPRIL2.Text + "'";
                WPRILDetails = "'" + txtWPRIL3.Text + "'";
            }
            string ASCONo = "NULL";
            string ASCOAssociates = "NULL";
            string ASCODetails = "NULL";
            if (rblASCO.SelectedValue == "Yes")
            {
                ASCONo = "'" + txtASCO1.Text + "'";
                ASCOAssociates = "'" + txtASCO2.Text + "'";
                ASCODetails = "'" + txtASCO3.Text + "'";
            }
            string SocietyAct = ddlSocietyAct.SelectedValue;
            if (SocietyAct == "Other")
            {
                SocietyAct = txtOtherAct.Text;
            }
            string insertQ = "INSERT INTO tblCso(CSOName, StateId, DistrictID, BlockID, RegisteredAddress, RegisteredAddressmobileno, RegisteredAddressEmail, RegisteredAddresswebsite, Correspondenceaddress, Correspondenceaddressmobileno, CorrespondenceaddressEmail, NameofContactPerson, AddressofContactPerson, MobilenoofContactPerson, EmailofContactPerson, RegistrationNo, DateofRegistration, RegistrationExpiryDate, RegistrationAct, FCRARegistrationNo, FCRARegistrationDate, FCRARegExpiryDate, DistancefromProjectOfficeFaizabad, PAN, PANNo, PANDate, PANExpiry, TAN, TANno, TANDate, TANExpiry, [12A], [12Ano], [12ADate], [12AExpiry], [80G], [80Gno], [80GDate], [80GExpiry], GST, GSTNo, GSTDate, GSTExpiry, OtherNGODarpan, OrganizationVision, OrganizationMission, OrganizationProjectArea, TargetCommunity, AgricultureDevelopment, WomenEmpowerment, Education, Health, WaterandSanitation, SkillDevelopment, OtherMajorprogrammaticFocus, OtherMajorprogrammaticFocusList, WomenSHG, WomenFarmersGroups, AdolescentGirlsGroup, JointLiabilityGroup, CommunitybasedorganizationsOtherIfany, DetailofFedrationifany, NariSangh, PFPCWorkExperiance, PFPCWorkExperianceNoofFPC, PFPCWorkExperianceAssociates, PFPCWorkExperianceDetails, WFACGWorkExperiance, WFACGWorkExperianceYears, WFACGWorkExperianceAssociates, WFACGWorkExperianceDetails, IGPEWorkExperiance, IGPEWorkExperianceYears, IGPEWorkExperianceAssociates, IGPEWorkExperianceDetails, WPRILWorkExperiance, WPRILWorkExperianceYears, WPRILWorkExperianceAssociates, WPRILWorkExperianceDetails, ASCOWorkExperiance, ASCOWorkExperianceYears, ASCOWorkExperianceAssociates, ASCOWorkExperianceDetails, imagename) VALUES('" + txtCso.Text + "'," + ddlStates.SelectedValue + "," + ddlDisrtict.SelectedValue + "," + ddlBlocks.SelectedValue + ",'" + txtregaddr.Text + "','" + txtregPhone.Text + "','" + txtregEmail.Text + "','" + txtregwebsite.Text + "','" + txtcraddr.Text + "','" + txtcrPhone.Text + "','" + txtcremail.Text + "','" + txtcontname.Text + "','" + txtcontAddr.Text + "','" + txtcontphone.Text + "','" + txtcontemail.Text + "','" + txtregno.Text + "','" + txtregdate.Text + "','" + txtregExpire.Text + "','" + SocietyAct + "','" + txtFCRAregno.Text + "','" + txtFCRADate.Text + "','" + txtFCRAExpiry.Text + "','" + txtdistPO.Text + "','" + rblPAN.SelectedValue + "'," + PANNo + "," + PANDate + "," + PANExpiry + ",'" + rblTAN.SelectedValue + "'," + TANNo + "," + TANDate + "," + TANExpiry + ",'" + rbl12A.SelectedValue + "'," + D12ANo + "," + D12ADate + "," + D12AExpiry + ",'" + rbl80G.SelectedValue + "'," + D80GNo + "," + D80GDate + "," + D80GExpiry + ",'" + rblGST.SelectedValue + "'," + GSTNo + "," + GSTDate + "," + GSTExpiry + ",'" + rblNGO.SelectedValue + "','" + txtOV.Text + "','" + txtOM.Text + "','" + txtOC.Text + "','" + txtTC.Text + "','" + rblAD.SelectedValue + "','" + rblWEG.SelectedValue + "','" + rblED.SelectedValue + "','" + rblHT.SelectedValue + "','" + rblWS.SelectedValue + "','" + rblSD.SelectedValue + "','" + rblOA.SelectedValue + "','" + hfFocusData.Value + "','" + txtWSHG.Text + "','" + txtWFG.Text + "','" + txtAGG.Text + "','" + txtJLG.Text + "','" + txtOIF.Text + "','" + txtDFA.Text + "','" + TXTNariSingh.Text + "','" + rblFPCPromotion.SelectedValue + "'," + PFPCNo + "," + PFPCAssociates + "," + PFPCDetails + ",'" + rblWFACG.SelectedValue + "'," + WFACGNo + "," + WFACGAssociates + "," + WFACGDetails + ",'" + rblIGPE.SelectedValue + "'," + IGPENo + "," + IGPEAssociates + "," + IGPEDetails + ",'" + rblWPRIL.SelectedValue + "'," + WPRILNo + "," + WPRILAssociates + "," + WPRILDetails + ",'" + rblASCO.SelectedValue + "'," + ASCONo + "," + ASCOAssociates + "," + ASCODetails + ",'" + InputFileName + "'); select @@IDENTITY as CSOID;";
            DataSet DS = db.getResultset(insertQ, "", "", "");
            if (DS != null && DS.Tables[0].Rows.Count > 0)
            {
                if (hiddenDataArrayId.Value != "")
                {
                    string[] data = hiddenDataArrayId.Value.Split('$');
                    if (data.Length > 0)
                    {
                        int count = 0;
                        for (int i = 0; i < data.Length; i++)
                        {
                            string[] datavalues = data[i].Split(':');
                            string ngoquery = "INSERT INTO tblCsoNGODetails(CSOID, NGOName, DateofRegistration, DateofExpiry) VALUES(" + DS.Tables[0].Rows[0]["CSOID"] + ",'" + datavalues[0] + "','" + datavalues[1] + "','" + datavalues[2] + "')";
                            db.UpdateQuery(ngoquery, "", "", "");
                            count++;
                        }
                    }
                    else
                    {
                        ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "ShowAlert('You have submitted data successfully. Thank you.','success')", true);
                    }
                }
                string track = "insert into tblMasterDataTracking(Date,UpdatedBy,UpdatedTo,UpdatedRecord) values('" + DateTime.Now + "','" + Session["UserID"] + "','CSO','" + DS.Tables[0].Rows[0]["CSOID"] + " - " + txtCso.Text + " - " + ddlBlocks.SelectedValue + "')";
                db.UpdateQuery(track, "", "", "");

                ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "ShowAlert('You have submitted data successfully. Thank you.','success')", true);
            }
            else
            {
                ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "ShowAlert('Something went wrong please try again.','warning')", true);
            }
        }

        protected void checkd_CheckedChanged(object sender, EventArgs e)
        {
            if (checkd.Checked)
            {
                txtcraddr.Text = txtregaddr.Text;
                txtcrPhone.Text = txtregPhone.Text;
                txtcremail.Text = txtregEmail.Text;
                //txtcrwebsite.Text = txtregwebsite.Text;

                txtcraddr.Enabled = false;
                txtcrPhone.Enabled = false;
                txtcremail.Enabled = false;
                //txtcrwebsite.Enabled = false;

            }
            else
            {
                txtcraddr.Text = "";
                txtcrPhone.Text = "";
                txtcremail.Text = "";
                //txtcrwebsite.Text = "";

                txtcraddr.Enabled = true;
                txtcrPhone.Enabled = true;
                txtcremail.Enabled = true;
                //txtcrwebsite.Enabled = true;
            }
        }

        protected void ddlDisrtict_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlDisrtict.SelectedIndex > 0)
            {
                string query = "select BlockID,Block from tblBlocks  where DistrictID = " + ddlDisrtict.SelectedValue + " order by Block";
                DataSet ds = db.getResultset(query, "", "", "");

                if (ds != null && ds.Tables[0].Rows.Count > 0)
                {
                    ddlBlocks.DataSource = ds;
                    ddlBlocks.DataValueField = "BlockID";
                    ddlBlocks.DataTextField = "Block";
                    ddlBlocks.DataBind();
                    ddlBlocks.Items.Insert(0, "Select");
                }
                else
                {
                    ddlBlocks.Items.Clear();
                    ddlBlocks.Items.Insert(0, "Select");
                }
            }
            else
            {
                ddlBlocks.Items.Clear();
                ddlBlocks.Items.Insert(0, "Select");
            }
        }

        protected void ddlStates_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlStates.SelectedIndex > 0)
            {
                string query = "select DistrictID,District from tblDistricts  where StateID = " + ddlStates.SelectedValue + " order by District";
                DataSet ds = db.getResultset(query, "", "", "");

                if (ds != null && ds.Tables[0].Rows.Count > 0)
                {
                    ddlDisrtict.DataSource = ds;
                    ddlDisrtict.DataValueField = "DistrictID";
                    ddlDisrtict.DataTextField = "District";
                    ddlDisrtict.DataBind();
                    ddlDisrtict.Items.Insert(0, "Select");
                }
                else
                {
                    ddlDisrtict.Items.Clear();
                    ddlDisrtict.Items.Insert(0, "Select");

                    ddlBlocks.Items.Clear();
                    ddlBlocks.Items.Insert(0, "Select");
                }
            }
            else
            {
                ddlDisrtict.Items.Clear();
                ddlDisrtict.Items.Insert(0, "Select");
            }
        }
    }
}