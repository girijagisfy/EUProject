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
    public partial class EditCso : System.Web.UI.Page
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
                    if (Session["CSOID"] != null)
                    {
                        Page.UnobtrusiveValidationMode = UnobtrusiveValidationMode.None;
                        if (!IsPostBack)
                        {
                            LoadStates();
                            loadData();
                            //LoadDistrict();
                            //LoadBlock();
                        }
                    }
                    else
                    {
                        Response.Redirect("~/CsoInfo.aspx");
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
        }
        public void LoadDistrict()
        {
            string query = "select DistrictID,District from tblDistricts  where StateID = " + ddlStates.SelectedValue + " order by District";
            //string query = "select DistrictID,District from tblDistricts order by District";
            DataSet ds = db.getResultset(query, "", "", "");

            if (ds != null && ds.Tables[0].Rows.Count > 0)
            {
                ddlDisrtict.DataSource = ds;
                ddlDisrtict.DataValueField = "DistrictID";
                ddlDisrtict.DataTextField = "District";
                ddlDisrtict.DataBind();
                ddlDisrtict.Items.Insert(0, "Select");
            }
        }
        public void LoadBlock()
        {

            string query = "select BlockID,Block from tblBlocks where DistrictID = " + ddlDisrtict.SelectedValue + " order by Block";
            DataSet ds = db.getResultset(query, "", "", "");

            if (ds != null && ds.Tables[0].Rows.Count > 0)
            {
                ddlBlocks.DataSource = ds;
                ddlBlocks.DataValueField = "BlockID";
                ddlBlocks.DataTextField = "Block";
                ddlBlocks.DataBind();
                ddlBlocks.Items.Insert(0, "Select");
            }
        }

        protected void loadData()
        {

            string selectQ = "SELECT CSOName, StateId, DistrictID, BlockID, RegisteredAddress, RegisteredAddressmobileno, RegisteredAddressEmail, RegisteredAddresswebsite, Correspondenceaddress, Correspondenceaddressmobileno, CorrespondenceaddressEmail, Correspondenceaddresswebsite, NameofContactPerson, AddressofContactPerson, MobilenoofContactPerson, EmailofContactPerson, WebsiteofContactPerson, RegistrationNo, DateofRegistration, RegistrationExpiryDate, RegistrationAct, FCRARegistrationNo, FCRARegistrationDate, FCRARegExpiryDate, DistancefromProjectOfficeFaizabad, PAN, PANNo, PANDate, PANExpiry, TAN, TANno, TANDate, TANExpiry, [12A], [12Ano], [12ADate], [12AExpiry], [80G], [80Gno], [80GDate], [80GExpiry], GST, GSTNo, GSTDate, GSTExpiry, OtherNGODarpan, OrganizationVision, OrganizationMission, OrganizationProjectArea, TargetCommunity, AgricultureDevelopment, WomenEmpowerment, Education, Health, WaterandSanitation, SkillDevelopment, OtherMajorprogrammaticFocus, OtherMajorprogrammaticFocusList, WomenSHG, WomenFarmersGroups, AdolescentGirlsGroup, JointLiabilityGroup, CommunitybasedorganizationsOtherIfany, DetailofFedrationifany, NariSangh, PFPCWorkExperiance, PFPCWorkExperianceNoofFPC, PFPCWorkExperianceAssociates, PFPCWorkExperianceDetails, WFACGWorkExperiance, WFACGWorkExperianceYears, WFACGWorkExperianceAssociates, WFACGWorkExperianceDetails, IGPEWorkExperiance, IGPEWorkExperianceYears, IGPEWorkExperianceAssociates, IGPEWorkExperianceDetails, WPRILWorkExperiance, WPRILWorkExperianceYears, WPRILWorkExperianceAssociates, WPRILWorkExperianceDetails, ASCOWorkExperiance, ASCOWorkExperianceYears, ASCOWorkExperianceAssociates, ASCOWorkExperianceDetails, imagename FROM tblCSO where CsoId=" + Session["CsoId"];
            DataSet ds = db.getResultset(selectQ, "", "", "");
            if (ds.Tables[0].Rows.Count > 0 && ds != null)
            {
                string path = ConfigurationManager.AppSettings["CSoLogoRead"].ToString();
                hfLogo.Value = ds.Tables[0].Rows[0]["imagename"].ToString();
                imgLogo.ImageUrl = path + ds.Tables[0].Rows[0]["imagename"].ToString();

                txtCso.Text = ds.Tables[0].Rows[0]["Csoname"].ToString();
                LoadStates();
                if (ddlStates.Items.FindByValue(ds.Tables[0].Rows[0]["StateId"].ToString()) != null)
                {
                    ddlStates.Items.FindByValue(ds.Tables[0].Rows[0]["StateId"].ToString()).Selected = true;
                }
                LoadDistrict();
                if (ddlDisrtict.Items.FindByValue(ds.Tables[0].Rows[0]["DistrictID"].ToString()) != null)
                {
                    ddlDisrtict.Items.FindByValue(ds.Tables[0].Rows[0]["DistrictID"].ToString()).Selected = true;
                }
                LoadBlock();
                if (ddlBlocks.Items.FindByValue(ds.Tables[0].Rows[0]["BlockID"].ToString()) != null)
                {
                    ddlBlocks.Items.FindByValue(ds.Tables[0].Rows[0]["BlockID"].ToString()).Selected = true;
                }
                txtregaddr.Text = ds.Tables[0].Rows[0]["RegisteredAddress"].ToString();
                txtregPhone.Text = ds.Tables[0].Rows[0]["RegisteredAddressmobileno"].ToString();
                txtregEmail.Text = ds.Tables[0].Rows[0]["RegisteredAddressEmail"].ToString();
                txtregwebsite.Text = ds.Tables[0].Rows[0]["RegisteredAddresswebsite"].ToString();
                txtcraddr.Text = ds.Tables[0].Rows[0]["Correspondenceaddress"].ToString();
                txtcrPhone.Text = ds.Tables[0].Rows[0]["Correspondenceaddressmobileno"].ToString();
                txtcremail.Text = ds.Tables[0].Rows[0]["CorrespondenceaddressEmail"].ToString();
                //txtcrwebsite.Text = ds.Tables[0].Rows[0]["Correspondenceaddresswebsite"].ToString();
                txtcontname.Text = ds.Tables[0].Rows[0]["NameofContactPerson"].ToString();
                txtcontAddr.Text = ds.Tables[0].Rows[0]["AddressofContactPerson"].ToString();
                txtcontphone.Text = ds.Tables[0].Rows[0]["MobilenoofContactPerson"].ToString();
                txtcontemail.Text = ds.Tables[0].Rows[0]["EmailofContactPerson"].ToString();
                //txtcontwebsite.Text = ds.Tables[0].Rows[0]["WebsiteofContactPerson"].ToString();
                txtregno.Text = ds.Tables[0].Rows[0]["RegistrationNo"].ToString();
                txtregdate.Text = ds.Tables[0].Rows[0]["DateofRegistration"].ToString();
                txtregExpire.Text = ds.Tables[0].Rows[0]["RegistrationExpiryDate"].ToString();
                if (ddlSocietyAct.Items.FindByValue(ds.Tables[0].Rows[0]["RegistrationAct"].ToString()) != null)
                {
                    ddlSocietyAct.Items.FindByValue(ds.Tables[0].Rows[0]["RegistrationAct"].ToString()).Selected = true;
                }
                else
                {
                    ddlSocietyAct.Items.FindByValue("Other").Selected = true;
                }
                if (ddlSocietyAct.SelectedValue == "Other")
                {
                    txtOtherAct.Text = ds.Tables[0].Rows[0]["RegistrationAct"].ToString();
                }
                txtFCRAregno.Text = ds.Tables[0].Rows[0]["FCRARegistrationNo"].ToString();
                txtFCRADate.Text = ds.Tables[0].Rows[0]["FCRARegistrationDate"].ToString();
                txtFCRAExpiry.Text = ds.Tables[0].Rows[0]["FCRARegExpiryDate"].ToString();
                txtdistPO.Text = ds.Tables[0].Rows[0]["DistancefromProjectOfficeFaizabad"].ToString();
                if (rblPAN.Items.FindByValue(ds.Tables[0].Rows[0]["PAN"].ToString()) != null)
                {
                    rblPAN.Items.FindByValue(ds.Tables[0].Rows[0]["PAN"].ToString()).Selected = true;
                }
                if (rblPAN.SelectedValue == "Yes")
                {
                    txtPanNo.Text = ds.Tables[0].Rows[0]["PANNo"].ToString();
                    txtPanDate.Text = ds.Tables[0].Rows[0]["PANDate"].ToString();
                    txtPanExpiry.Text = ds.Tables[0].Rows[0]["PANExpiry"].ToString();
                }

                if (rblTAN.Items.FindByValue(ds.Tables[0].Rows[0]["TAN"].ToString()) != null)
                {
                    rblTAN.Items.FindByValue(ds.Tables[0].Rows[0]["TAN"].ToString()).Selected = true;
                }
                if (rblTAN.SelectedValue == "Yes")
                {
                    txtTanNo.Text = ds.Tables[0].Rows[0]["TANNo"].ToString();
                    txtTanDate.Text = ds.Tables[0].Rows[0]["TANDate"].ToString();
                    txtTanExpiry.Text = ds.Tables[0].Rows[0]["TANExpiry"].ToString();
                }

                if (rbl12A.Items.FindByValue(ds.Tables[0].Rows[0]["12A"].ToString()) != null)
                {
                    rbl12A.Items.FindByValue(ds.Tables[0].Rows[0]["12A"].ToString()).Selected = true;
                }
                if (rbl12A.SelectedValue == "Yes")
                {
                    txt12ANo.Text = ds.Tables[0].Rows[0]["12ANo"].ToString();
                    txt12ADate.Text = ds.Tables[0].Rows[0]["12ADate"].ToString();
                    txt12AExpiry.Text = ds.Tables[0].Rows[0]["12AExpiry"].ToString();
                }

                if (rbl80G.Items.FindByValue(ds.Tables[0].Rows[0]["80G"].ToString()) != null)
                {
                    rbl80G.Items.FindByValue(ds.Tables[0].Rows[0]["80G"].ToString()).Selected = true;
                }
                if (rbl80G.SelectedValue == "Yes")
                {
                    txt80GNo.Text = ds.Tables[0].Rows[0]["80GNo"].ToString();
                    txt80GDate.Text = ds.Tables[0].Rows[0]["80GDate"].ToString();
                    txt80GExpiry.Text = ds.Tables[0].Rows[0]["80GExpiry"].ToString();
                }

                if (rblGST.Items.FindByValue(ds.Tables[0].Rows[0]["GST"].ToString()) != null)
                {
                    rblGST.Items.FindByValue(ds.Tables[0].Rows[0]["GST"].ToString()).Selected = true;
                }
                if (rblGST.SelectedValue == "Yes")
                {
                    txtGSTNo.Text = ds.Tables[0].Rows[0]["GSTNo"].ToString();
                    txtGSTDate.Text = ds.Tables[0].Rows[0]["GSTDate"].ToString();
                    txtGSTExpiry.Text = ds.Tables[0].Rows[0]["GSTExpiry"].ToString();
                }
                if (rblNGO.Items.FindByValue(ds.Tables[0].Rows[0]["OtherNGODarpan"].ToString()) != null)
                {
                    rblNGO.Items.FindByValue(ds.Tables[0].Rows[0]["OtherNGODarpan"].ToString()).Selected = true;
                }
                if (rblNGO.SelectedValue == "Yes")
                {
                    string NGOsDate = "select * from tblCsoNGODetails where CSOID=" + Session["CsoId"];
                    DataSet NGOds = db.getResultset(NGOsDate, "", "", "");
                    if (NGOds != null && NGOds.Tables[0].Rows.Count > 0)
                    {
                        string NGOString = "";
                        for (int i = 0; i < NGOds.Tables[0].Rows.Count; i++)
                        {
                            if (i == 0)
                            {
                                NGOString += NGOds.Tables[0].Rows[i]["NGOName"] + ":" + NGOds.Tables[0].Rows[i]["DateofRegistration"] + ":" + NGOds.Tables[0].Rows[i]["DateofExpiry"];
                            }
                            else
                            {
                                NGOString += "$" + NGOds.Tables[0].Rows[i]["NGOName"] + ":" + NGOds.Tables[0].Rows[i]["DateofRegistration"] + ":" + NGOds.Tables[0].Rows[i]["DateofExpiry"];
                            }
                        }
                        hiddenDataArrayId.Value = NGOString;
                    }
                }

                txtOV.Text = ds.Tables[0].Rows[0]["OrganizationVision"].ToString();
                txtOM.Text = ds.Tables[0].Rows[0]["OrganizationMission"].ToString();
                txtOC.Text = ds.Tables[0].Rows[0]["OrganizationProjectArea"].ToString();
                txtTC.Text = ds.Tables[0].Rows[0]["TargetCommunity"].ToString();

                if (rblAD.Items.FindByValue(ds.Tables[0].Rows[0]["AgricultureDevelopment"].ToString()) != null)
                {
                    rblAD.Items.FindByValue(ds.Tables[0].Rows[0]["AgricultureDevelopment"].ToString()).Selected = true;
                }
                if (rblWEG.Items.FindByValue(ds.Tables[0].Rows[0]["WomenEmpowerment"].ToString()) != null)
                {
                    rblWEG.Items.FindByValue(ds.Tables[0].Rows[0]["WomenEmpowerment"].ToString()).Selected = true;
                }
                if (rblED.Items.FindByValue(ds.Tables[0].Rows[0]["Education"].ToString()) != null)
                {
                    rblED.Items.FindByValue(ds.Tables[0].Rows[0]["Education"].ToString()).Selected = true;
                }
                if (rblHT.Items.FindByValue(ds.Tables[0].Rows[0]["Health"].ToString()) != null)
                {
                    rblHT.Items.FindByValue(ds.Tables[0].Rows[0]["Health"].ToString()).Selected = true;
                }
                if (rblWS.Items.FindByValue(ds.Tables[0].Rows[0]["WaterandSanitation"].ToString()) != null)
                {
                    rblWS.Items.FindByValue(ds.Tables[0].Rows[0]["WaterandSanitation"].ToString()).Selected = true;
                }
                if (rblSD.Items.FindByValue(ds.Tables[0].Rows[0]["SkillDevelopment"].ToString()) != null)
                {
                    rblSD.Items.FindByValue(ds.Tables[0].Rows[0]["SkillDevelopment"].ToString()).Selected = true;
                }
                if (rblOA.Items.FindByValue(ds.Tables[0].Rows[0]["OtherMajorprogrammaticFocus"].ToString()) != null)
                {
                    rblOA.Items.FindByValue(ds.Tables[0].Rows[0]["OtherMajorprogrammaticFocus"].ToString()).Selected = true;
                }

                if (rblOA.SelectedValue == "Yes")
                {
                    hfFocusData.Value = ds.Tables[0].Rows[0]["OtherMajorprogrammaticFocusList"].ToString();
                }
                txtWSHG.Text = ds.Tables[0].Rows[0]["WomenSHG"].ToString();
                txtWFG.Text = ds.Tables[0].Rows[0]["WomenFarmersGroups"].ToString();
                txtAGG.Text = ds.Tables[0].Rows[0]["AdolescentGirlsGroup"].ToString();
                txtJLG.Text = ds.Tables[0].Rows[0]["JointLiabilityGroup"].ToString();
                txtOIF.Text = ds.Tables[0].Rows[0]["CommunitybasedorganizationsOtherIfany"].ToString();
                txtDFA.Text = ds.Tables[0].Rows[0]["DetailofFedrationifany"].ToString();
                TXTNariSingh.Text = ds.Tables[0].Rows[0]["NariSangh"].ToString();

                if (rblFPCPromotion.Items.FindByValue(ds.Tables[0].Rows[0]["PFPCWorkExperiance"].ToString()) != null)
                {
                    rblFPCPromotion.Items.FindByValue(ds.Tables[0].Rows[0]["PFPCWorkExperiance"].ToString()).Selected = true;
                }
                if (rblFPCPromotion.SelectedValue == "Yes")
                {
                    txtPromotion1.Text = ds.Tables[0].Rows[0]["PFPCWorkExperianceNoofFPC"].ToString();
                    txtPromotion2.Text = ds.Tables[0].Rows[0]["PFPCWorkExperianceAssociates"].ToString();
                    txtPromotion3.Text = ds.Tables[0].Rows[0]["PFPCWorkExperianceDetails"].ToString();
                }

                if (rblWFACG.Items.FindByValue(ds.Tables[0].Rows[0]["WFACGWorkExperiance"].ToString()) != null)
                {
                    rblWFACG.Items.FindByValue(ds.Tables[0].Rows[0]["WFACGWorkExperiance"].ToString()).Selected = true;
                }
                if (rblWFACG.SelectedValue == "Yes")
                {
                    txtWFACG1.Text = ds.Tables[0].Rows[0]["WFACGWorkExperianceYears"].ToString();
                    txtWFACG2.Text = ds.Tables[0].Rows[0]["WFACGWorkExperianceAssociates"].ToString();
                    txtWFACG3.Text = ds.Tables[0].Rows[0]["WFACGWorkExperianceDetails"].ToString();
                }

                if (rblIGPE.Items.FindByValue(ds.Tables[0].Rows[0]["IGPEWorkExperiance"].ToString()) != null)
                {
                    rblIGPE.Items.FindByValue(ds.Tables[0].Rows[0]["IGPEWorkExperiance"].ToString()).Selected = true;
                }
                if (rblIGPE.SelectedValue == "Yes")
                {
                    txtIGPE1.Text = ds.Tables[0].Rows[0]["IGPEWorkExperianceYears"].ToString();
                    txtIGPE2.Text = ds.Tables[0].Rows[0]["IGPEWorkExperianceAssociates"].ToString();
                    txtIGPE3.Text = ds.Tables[0].Rows[0]["IGPEWorkExperianceDetails"].ToString();
                }

                if (rblWPRIL.Items.FindByValue(ds.Tables[0].Rows[0]["WPRILWorkExperiance"].ToString()) != null)
                {
                    rblWPRIL.Items.FindByValue(ds.Tables[0].Rows[0]["WPRILWorkExperiance"].ToString()).Selected = true;
                }
                if (rblWPRIL.SelectedValue == "Yes")
                {
                    txtWPRIL1.Text = ds.Tables[0].Rows[0]["WPRILWorkExperianceYears"].ToString();
                    txtWPRIL2.Text = ds.Tables[0].Rows[0]["WPRILWorkExperianceAssociates"].ToString();
                    txtWPRIL3.Text = ds.Tables[0].Rows[0]["WPRILWorkExperianceDetails"].ToString();
                }

                if (rblASCO.Items.FindByValue(ds.Tables[0].Rows[0]["ASCOWorkExperiance"].ToString()) != null)
                {
                    rblASCO.Items.FindByValue(ds.Tables[0].Rows[0]["ASCOWorkExperiance"].ToString()).Selected = true;
                }
                if (rblASCO.SelectedValue == "Yes")
                {
                    txtASCO1.Text = ds.Tables[0].Rows[0]["ASCOWorkExperianceYears"].ToString();
                    txtASCO2.Text = ds.Tables[0].Rows[0]["ASCOWorkExperianceAssociates"].ToString();
                    txtASCO3.Text = ds.Tables[0].Rows[0]["ASCOWorkExperianceDetails"].ToString();
                }
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            string InputFileName = string.Empty;
            if (Csologo.HasFiles)
            {
                string ServerSavePath = ConfigurationManager.AppSettings["CSoLogoPath"].ToString();
                if (hfLogo.Value == "")
                {
                    InputFileName = genobj.Randomlongstring() + "_" + Csologo.FileName.Trim();
                }
                else
                {
                    InputFileName = hfLogo.Value;
                }
                Csologo.SaveAs(ServerSavePath + InputFileName);
            }
            else
            {
                InputFileName = hfLogo.Value;
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
            string insertQ = "update tblCso set CSOName='" + txtCso.Text + "', StateId=" + ddlStates.SelectedValue + ", DistrictID=" + ddlDisrtict.SelectedValue + ", BlockID=" + ddlBlocks.SelectedValue + ", RegisteredAddress='" + txtregaddr.Text + "', RegisteredAddressmobileno='" + txtregPhone.Text + "', RegisteredAddressEmail='" + txtregEmail.Text + "', RegisteredAddresswebsite='" + txtregwebsite.Text + "', Correspondenceaddress='" + txtcraddr.Text + "', Correspondenceaddressmobileno='" + txtcrPhone.Text + "', CorrespondenceaddressEmail='" + txtcremail.Text + "',  NameofContactPerson='" + txtcontname.Text + "', AddressofContactPerson='" + txtcontAddr.Text + "', MobilenoofContactPerson='" + txtcontphone.Text + "', EmailofContactPerson='" + txtcontemail.Text + "', RegistrationNo='" + txtregno.Text + "', DateofRegistration='" + txtregdate.Text + "', RegistrationExpiryDate='" + txtregExpire.Text + "', RegistrationAct='" + SocietyAct + "', FCRARegistrationNo='" + txtFCRAregno.Text + "', FCRARegistrationDate='" + txtFCRADate.Text + "', FCRARegExpiryDate='" + txtFCRAExpiry.Text + "', DistancefromProjectOfficeFaizabad='" + txtdistPO.Text + "', PAN='" + rblPAN.SelectedValue + "', PANNo=" + PANNo + ", PANDate=" + PANDate + ", PANExpiry=" + PANExpiry + ", TAN='" + rblTAN.SelectedValue + "', TANno=" + TANNo + ", TANDate=" + TANDate + ", TANExpiry=" + TANExpiry + ", [12A]='" + rbl12A.SelectedValue + "', [12Ano]=" + D12ANo + ", [12ADate]=" + D12ADate + ", [12AExpiry]=" + D12AExpiry + ", [80G]='" + rbl80G.SelectedValue + "', [80Gno]=" + D80GNo + ", [80GDate]=" + D80GDate + ", [80GExpiry]=" + D80GExpiry + ", GST='" + rblGST.SelectedValue + "', GSTNo=" + GSTNo + ", GSTDate=" + GSTDate + ", GSTExpiry=" + GSTExpiry + ", OtherNGODarpan='" + rblNGO.SelectedValue + "', OrganizationVision='" + txtOV.Text + "', OrganizationMission='" + txtOM.Text + "', OrganizationProjectArea='" + txtOC.Text + "', TargetCommunity='" + txtTC.Text + "', AgricultureDevelopment='" + rblAD.SelectedValue + "', WomenEmpowerment='" + rblWEG.SelectedValue + "', Education='" + rblED.SelectedValue + "', Health='" + rblHT.SelectedValue + "', WaterandSanitation='" + rblWS.SelectedValue + "', SkillDevelopment='" + rblSD.SelectedValue + "', OtherMajorprogrammaticFocus='" + rblOA.SelectedValue + "', OtherMajorprogrammaticFocusList='" + hfFocusData.Value + "', WomenSHG='" + txtWSHG.Text + "', WomenFarmersGroups='" + txtWFG.Text + "', AdolescentGirlsGroup='" + txtAGG.Text + "', JointLiabilityGroup='" + txtJLG.Text + "', CommunitybasedorganizationsOtherIfany='" + txtOIF.Text + "', DetailofFedrationifany='" + txtDFA.Text + "', NariSangh='" + TXTNariSingh.Text + "', PFPCWorkExperiance='" + rblFPCPromotion.SelectedValue + "', PFPCWorkExperianceNoofFPC=" + PFPCNo + ", PFPCWorkExperianceAssociates=" + PFPCAssociates + ", PFPCWorkExperianceDetails=" + PFPCDetails + ", WFACGWorkExperiance='" + rblWFACG.SelectedValue + "', WFACGWorkExperianceYears=" + WFACGNo + ", WFACGWorkExperianceAssociates=" + WFACGAssociates + ", WFACGWorkExperianceDetails=" + WFACGDetails + ", IGPEWorkExperiance='" + rblIGPE.SelectedValue + "', IGPEWorkExperianceYears=" + IGPENo + ", IGPEWorkExperianceAssociates=" + IGPEAssociates + ", IGPEWorkExperianceDetails=" + IGPEDetails + ", WPRILWorkExperiance='" + rblWPRIL.SelectedValue + "', WPRILWorkExperianceYears=" + WPRILNo + ", WPRILWorkExperianceAssociates=" + WPRILAssociates + ", WPRILWorkExperianceDetails=" + WPRILDetails + ", ASCOWorkExperiance='" + rblASCO.SelectedValue + "', ASCOWorkExperianceYears=" + ASCONo + ", ASCOWorkExperianceAssociates=" + ASCOAssociates + ", ASCOWorkExperianceDetails=" + ASCODetails + ", imagename='" + InputFileName + "' where CSOID=" + Session["CSOID"];
            if (db.UpdateQuery(insertQ, "", "", "") > 0)
            {
                string deletedata = " delete from tblCsoNGODetails where CSOID=" + Session["CSOID"];
                db.UpdateQuery(deletedata, "", "", "");
                if (hiddenDataArrayId.Value != "")
                {
                    string[] data = hiddenDataArrayId.Value.Split('$');
                    if (data.Length > 0)
                    {
                        int count = 0;
                        for (int i = 0; i < data.Length; i++)
                        {
                            string[] datavalues = data[i].Split(':');
                            string ngoquery = "INSERT INTO tblCsoNGODetails(CSOID, NGOName, DateofRegistration, DateofExpiry) VALUES(" + Session["CSOID"] + ",'" + datavalues[0] + "','" + datavalues[1] + "','" + datavalues[2] + "')";
                            db.UpdateQuery(ngoquery, "", "", "");
                            count++;
                        }
                    }
                    else
                    {
                        ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "ShowAlert('You have Updated data successfully. Thank you.','success')", true);
                    }
                }
                string track = "insert into tblMasterDataTracking(Date,UpdatedBy,UpdatedTo,UpdatedRecord) values('" + DateTime.Now + "','" + Session["UserID"] + "','CSO','" + Session["CSOID"] + " - " + txtCso.Text + " - " + ddlBlocks.SelectedValue + "')";
                db.UpdateQuery(track, "", "", "");

                ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "ShowAlert('You have submitted data successfully. Thank you.','success')", true);
            }
            else
            {
                ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "ShowAlert('Something went wrong please try again.','warning')", true);
            }
        }

        protected void ddlDisrtict_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlDisrtict.SelectedIndex > 0)
            {
                string query = "select BlockID,Block from tblBlocks  where DistrictID = " + ddlDisrtict.SelectedValue + "order by Block";
                DataSet ds = db.getResultset(query, "", "", "");

                if (ds != null && ds.Tables[0].Rows.Count > 0)
                {
                    ddlBlocks.DataSource = ds;
                    ddlBlocks.DataValueField = "BlockID";
                    ddlBlocks.DataTextField = "Block";
                    ddlBlocks.DataBind();
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
    }
}