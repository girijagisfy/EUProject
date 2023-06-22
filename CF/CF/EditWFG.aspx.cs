using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CF
{
    public partial class EditWFG : System.Web.UI.Page
    {
        DbErrorLog db = new DbErrorLog();
        string User = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserType"] != null)
            {
                User = Session["UserType"].ToString();
                if (User == "Admin" || User == "CSO")
                {
                    Page.UnobtrusiveValidationMode = UnobtrusiveValidationMode.None;
                    if (Session["WfgNo"] != null)
                    {
                        if (!IsPostBack)
                        {
                            if (User == "Admin")
                            {
                                LoadCSO();
                            }
                            if (User == "CSO")
                            {
                                LoadCSO();
                                ddlCSO.Items.FindByValue(Session["ClientID"].ToString()).Selected = true;
                                ddlCSO.Enabled = false;


                                //dvCSO.Visible = false;
                            }
                            LoadStates();
                            loadDist();
                            loadBlock();
                            LoadCategory();
                            LoadData();
                        }
                    }
                    else
                    {
                        Response.Redirect("~/WFGInfo.aspx");
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
            string selectVill = "Select * from tblStates";
            DataSet dsV = db.getResultset(selectVill, "", "", "");
            if (dsV != null && dsV.Tables[0].Rows.Count > 0)
            {
                ddlState.DataSource = dsV;
                ddlState.DataTextField = "StateName";
                ddlState.DataValueField = "StateId";
                ddlState.DataBind();
                ddlState.Items.Insert(0, "Select");
            }
        }

        public void LoadCSO()
        {
            string query = "select Csoid,Csoname from tblCso where Status=1 order by Csoname";
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
                ddlDistrict.Items.Insert(0, "Select");
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
                ddlBlock.Items.Insert(0, "Select");
            }
        }

        public void LoadCategory()
        {
            string query = "select Sid,SocialCategory from tblSocialCategory order by SocialCategory";
            DataSet ds = db.getResultset(query, "", "", "");

            if (ds != null && ds.Tables[0].Rows.Count > 0)
            {
                ddlSocialCaegory0.DataSource = ds;
                ddlSocialCaegory0.DataValueField = "Sid";
                ddlSocialCaegory0.DataTextField = "SocialCategory";
                ddlSocialCaegory0.DataBind();
                ddlSocialCaegory0.Items.Insert(0, "Select");
            }
        }

        public void LoadVillages()
        {
            string Blockondetion = "";
            if (User == "Admin")
            {
                Blockondetion = ddlBlock.SelectedValue;
            }
            else if (User == "CSO")
            {
                string distblock = "select DistrictID,BlockID,StateId from tblCSO where CSOID = " + ddlCSO.SelectedValue;
                DataSet distds = db.getResultset(distblock, "", "", "");
                if (distds != null && distds.Tables[0].Rows.Count > 0)
                {
                    Blockondetion = distds.Tables[0].Rows[0]["BlockID"].ToString();
                    if (ddlState.Items.FindByValue(distds.Tables[0].Rows[0]["StateId"].ToString()) != null)
                    {
                        ddlState.Items.FindByValue(distds.Tables[0].Rows[0]["StateId"].ToString()).Selected = true;
                    }
                    ddlState.Enabled = false;
                    if (ddlDistrict.Items.FindByValue(distds.Tables[0].Rows[0]["DistrictID"].ToString()) != null)
                    {
                        ddlDistrict.Items.FindByValue(distds.Tables[0].Rows[0]["DistrictID"].ToString()).Selected = true;
                    }
                    if (ddlBlock.Items.FindByValue(distds.Tables[0].Rows[0]["BlockID"].ToString()) != null)
                    {
                        ddlBlock.Items.FindByValue(distds.Tables[0].Rows[0]["BlockID"].ToString()).Selected = true;
                    }
                }

            }
            string selectVill = "Select Vid,Village from tblVillageInfo a left outer join tblVillages b on a.VillageID = b.VillageID where a.BlockID =" + Blockondetion + " order by village";
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

        public void LoadData()
        {
            string query = "select a.VillageID, c.CSOID, WFGName, WFGMembers, WFGTypeID, Hamlet, PresidentName, PresidentContact, Remarks, c.GramPanchayatName, a.BankName, a.AccountHolderName, a.BankAccountNumber, a.BankIFSCcode from tblWFGs a  left outer join tblVillageInfo c on a.VillageID = c.Vid left outer join tblCso b on c.CSOID = b.Csoid where WfgNo = " + Session["WfgNo"];

            DataSet ds = db.getResultset(query, "", "", "");

            DataTable dt = new DataTable();
            if (ds != null && ds.Tables[0].Rows.Count > 0)
            {
                dt = ds.Tables[0];
            }

            if (User == "Admin")
            {
                if (ddlCSO.Items.FindByValue(dt.Rows[0]["CSOID"].ToString()) != null)
                {
                    ddlCSO.Items.FindByValue(dt.Rows[0]["CSOID"].ToString()).Selected = true;
                }

                string distblock = "select DistrictID,BlockID,StateId from tblCSO where CSOID = " + ddlCSO.SelectedValue;
                DataSet distds = db.getResultset(distblock, "", "", "");
                if (distds != null && distds.Tables[0].Rows.Count > 0)
                {
                    if (ddlState.Items.FindByValue(distds.Tables[0].Rows[0]["StateId"].ToString()) != null)
                    {
                        ddlState.Items.FindByValue(distds.Tables[0].Rows[0]["StateId"].ToString()).Selected = true;
                    }
                    ddlState.Enabled = false;
                    if (ddlDistrict.Items.FindByValue(distds.Tables[0].Rows[0]["DistrictID"].ToString()) != null)
                    {
                        ddlDistrict.Items.FindByValue(distds.Tables[0].Rows[0]["DistrictID"].ToString()).Selected = true;
                    }
                    if (ddlBlock.Items.FindByValue(distds.Tables[0].Rows[0]["BlockID"].ToString()) != null)
                    {
                        ddlBlock.Items.FindByValue(distds.Tables[0].Rows[0]["BlockID"].ToString()).Selected = true;
                    }
                }
            }
            //GramPanchayat();
            //ddlGrampanchayat.Items.FindByValue(dt.Rows[0]["NameofGramPanchayat"].ToString()).Selected = true;

            LoadVillages();
            if (dt.Rows[0]["VillageID"].ToString() != "")
            {
                if (ddlVillage.Items.FindByValue(dt.Rows[0]["VillageID"].ToString()) != null)
                {
                    ddlVillage.Items.FindByValue(dt.Rows[0]["VillageID"].ToString()).Selected = true;
                }
                string Gquery = "select GramPanchayatName from tblVillageInfo where Vid = " + ddlVillage.SelectedValue;
                DataSet Gds = db.getResultset(Gquery, "", "", "");
                if (Gds != null && Gds.Tables[0].Rows.Count > 0)
                {
                    txtGramPanchayat.Text = Gds.Tables[0].Rows[0]["GramPanchayatName"].ToString();
                }
                string Hquery = "select NameofHamlet from tblHamletInfo where Villageid =" + ddlVillage.SelectedValue;
                DataSet Hds = db.getResultset(Hquery, "", "", "");
                if (Hds != null && Hds.Tables[0].Rows.Count > 0)
                {
                    ddlHamlet.DataSource = Hds;
                    ddlHamlet.DataValueField = "NameofHamlet";
                    ddlHamlet.DataTextField = "NameofHamlet";
                    ddlHamlet.DataBind();
                    ddlHamlet.Items.Insert(0, "Select");
                }
                if (ddlHamlet.Items.FindByValue(dt.Rows[0]["Hamlet"].ToString()) != null)
                {
                    ddlHamlet.Items.FindByValue(dt.Rows[0]["Hamlet"].ToString()).Selected = true;
                }
            }
            txtNameofWFG.Text = dt.Rows[0]["WFGName"].ToString();
            txtNoofMembers.Text = dt.Rows[0]["WFGMembers"].ToString();
            if (ddlSocialCaegory0.Items.FindByValue(dt.Rows[0]["WFGTypeID"].ToString()) != null)
            {
                ddlSocialCaegory0.Items.FindByValue(dt.Rows[0]["WFGTypeID"].ToString()).Selected = true;
            }
            txtPresident.Text = dt.Rows[0]["PresidentName"].ToString();
            txtPresidentContact.Text = dt.Rows[0]["PresidentContact"].ToString();
            txtRemarks.Text = dt.Rows[0]["Remarks"].ToString();
            txtBank.Text = dt.Rows[0]["BankName"].ToString();
            txtBankHolder.Text = dt.Rows[0]["AccountHolderName"].ToString();
            txtIFSC.Text = dt.Rows[0]["BankIFSCcode"].ToString();
            txtACCNo.Text = dt.Rows[0]["BankAccountNumber"].ToString();
        }

        public void loadVillage()
        {
            string selectVill = "Select Vid,Village from tblVillageInfo a left outer join tblVillages b on a.VillageID = b.VillageID where a.BlockID =" + ddlBlock.SelectedValue + " order by village";
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

        protected void ddlCSO_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlCSO.SelectedIndex > 0)
            {
                string cso = ddlCSO.SelectedValue;
                string selectCSO = "select DistrictID,BlockID,StateId from tblCSO where CSOID =" + cso;
                DataSet ds = db.getResultset(selectCSO, "", "", "");
                if (ds.Tables[0].Rows.Count > 0 && ds != null)
                {
                    LoadStates();
                    if (ddlState.Items.FindByValue(ds.Tables[0].Rows[0]["StateId"].ToString()) != null)
                    {
                        ddlState.Items.FindByValue(ds.Tables[0].Rows[0]["StateId"].ToString()).Selected = true;
                    }
                    loadDist();
                    if (ddlDistrict.Items.FindByValue(ds.Tables[0].Rows[0]["DistrictID"].ToString()) != null)
                    {
                        ddlDistrict.Items.FindByValue(ds.Tables[0].Rows[0]["DistrictID"].ToString()).Selected = true;
                    }

                    loadBlock();
                    if (ddlBlock.Items.FindByValue(ds.Tables[0].Rows[0]["BlockID"].ToString()) != null)
                    {
                        ddlBlock.Items.FindByValue(ds.Tables[0].Rows[0]["BlockID"].ToString()).Selected = true;
                    }

                    loadVillage();
                }
            }
            else
            {
                ddlVillage.Items.Clear();
                ddlVillage.Items.Insert(0, "Select");
                ddlDistrict.Items.Clear();
                ddlDistrict.Items.Insert(0, "Select");
                ddlBlock.Items.Clear();
                ddlBlock.Items.Insert(0, "Select");
                ddlHamlet.Items.Clear();
                ddlHamlet.Items.Insert(0, "Select");
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {

            string cso = ddlCSO.SelectedValue;
            string village = ddlVillage.SelectedValue;
            string WFGName = txtNameofWFG.Text;
            string WFGmembers = txtNoofMembers.Text;
            string WFGType = ddlSocialCaegory0.SelectedValue;
            string Hamlet = "";
            if (ddlHamlet.SelectedValue != "Select")
            {
                Hamlet = "'" + ddlHamlet.SelectedValue + "'";
            }
            else
            {
                Hamlet = "NULL";
            }
            string President = txtPresident.Text;
            string presno = txtPresidentContact.Text;
            string remarks = txtRemarks.Text;
            /*CSOID,  " + cso + ",*/
            string insertQ = "update tblWFGs set VillageID=" + village + ", WFGName='" + WFGName + "', WFGMembers=" + WFGmembers + ", WFGTypeID=" + WFGType + ", Hamlet=" + Hamlet + ", BankName='" + txtBank.Text + "', AccountHolderName='" + txtBankHolder.Text + "', BankAccountNumber='" + txtACCNo.Text + "', BankIFSCcode='" + txtIFSC.Text + "', PresidentName='" + President + "', PresidentContact='" + presno + "', Remarks='" + remarks + "' where WfgNo=" + Session["WfgNo"];

            if (db.UpdateQuery(insertQ, "", "", "") > 0)
            {
                string track = "insert into tblMasterDataTracking(Date,UpdatedBy,UpdatedTo,UpdatedRecord) values('" + DateTime.Now + "','" + Session["UserID"] + "','Women Former Group','" + Session["WfgNo"] + " - " + WFGName + " - " + village + "')";
                db.UpdateQuery(track, "", "", "");
                ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "ShowAlert('You have submitted data successfully. Thank you.','success')", true);
            }
            else
            {
                ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "ShowAlert('Something went wrong please try again.','warning')", true);
            }
        }

        protected void ddlVillage_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlVillage.SelectedIndex > 0)
            {
                string Gquery = "select GramPanchayatName from tblVillageInfo where Vid = " + ddlVillage.SelectedValue;
                DataSet Gds = db.getResultset(Gquery, "", "", "");
                if (Gds != null && Gds.Tables[0].Rows.Count > 0)
                {
                    DataTable dt = Gds.Tables[0];
                    txtGramPanchayat.Text = dt.Rows[0]["GramPanchayatName"].ToString();
                }

                string Hquery = "select NameofHamlet from tblHamletInfo where Villageid =" + ddlVillage.SelectedValue + " order by NameofHamlet";
                DataSet Hds = db.getResultset(Hquery, "", "", "");
                if (Hds != null && Hds.Tables[0].Rows.Count > 0)
                {
                    ddlHamlet.DataSource = Hds;
                    ddlHamlet.DataValueField = "NameofHamlet";
                    ddlHamlet.DataTextField = "NameofHamlet";
                    ddlHamlet.DataBind();
                    ddlHamlet.Items.Insert(0, "Select");
                }
            }
            else
            {
                txtGramPanchayat.Text = "";
                ddlHamlet.Items.Clear();
                ddlHamlet.Items.Insert(0, "Select");
            }
        }
    }
}