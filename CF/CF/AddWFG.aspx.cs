using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CF
{
    public partial class AddWFG : System.Web.UI.Page
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
                    if (!IsPostBack)
                    {
                        if (User == "Admin")
                        {
                            LoadCSO();
                        }
                        if (User == "CSO")
                        {
                            //dvCSO.Visible = false;
                            //dvDistrict.Visible = false;
                            //dvBlock.Visible = false;
                            LoadCSOData();
                            loadVillage();
                        }
                        LoadCategory();
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
                LoadStates();
                if (ddlState.Items.FindByValue(ds.Tables[0].Rows[0]["StateId"].ToString()) != null)
                {
                    ddlState.Items.FindByValue(ds.Tables[0].Rows[0]["StateId"].ToString()).Selected = true;
                }
                ddlState.Enabled = false;
                LoadCSO();
                if (ddlCSO.Items.FindByValue(Session["ClientID"].ToString()) != null)
                {
                    ddlCSO.Items.FindByValue(Session["ClientID"].ToString()).Selected = true;
                }
                ddlCSO.Enabled = false;
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
            else
            {
                ddlCSO.Items.Clear();
                ddlCSO.Items.Insert(0, "Select");
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
            else
            {
                ddlSocialCaegory0.Items.Clear();
                ddlSocialCaegory0.Items.Insert(0, "Select");
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
            string insertQ = "insert into tblWFGs (VillageID, WFGName, WFGMembers, WFGTypeID, Hamlet, BankName, AccountHolderName, BankAccountNumber, BankIFSCcode, PresidentName, PresidentContact, Remarks) values(" + village + ",'" + WFGName + "'," + WFGmembers + "," + WFGType + "," + Hamlet + ",'" + txtBank.Text + "','" + txtBankHolder.Text + "','" + txtACCNo.Text + "','" + txtIFSC.Text + "','" + President + "','" + presno + "','" + remarks + "');  select @@IDENTITY as WFGNO;";

            DataSet DS = db.getResultset(insertQ, "", "", "");
            if (DS != null && DS.Tables[0].Rows.Count > 0)
            {
                string track = "insert into tblMasterDataTracking(Date,UpdatedBy,UpdatedTo,UpdatedRecord) values('" + DateTime.Now + "','" + Session["UserID"] + "','Women Former Group','" + DS.Tables[0].Rows[0]["WFGNO"] + " - " + WFGName + " - " + village + "')";
                db.UpdateQuery(track, "", "", "");
                ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "ShowAlert('You have submitted data successfully. Thank you.','success')", true);
            }
            else
            {
                ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "ShowAlert('Something went wrong please try again.','warning')", true);
            }
        }

        protected void ddlCso_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlCSO.SelectedIndex > 0)
            {
                string cso = ddlCSO.SelectedValue;
                string selectCSO = "SELECT [District],c.DistrictID,[Block],b.BlockID,D.StateId,StateName FROM tblCSO A,tblBlocks B,tblDistricts C ,tblStates D  where B.[BlockID ] = A.BlockID and C.[DistrictID] = A.DistrictID and D.[StateId] = A.StateId and CSOID =" + cso;
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
                ddlState.Items.Clear();
                ddlDistrict.Items.Clear();
                ddlBlock.Items.Clear();
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

        public void LoadStates()
        {
            string selectVill = "select StateId,StateName from tblStates order by StateName";
            DataSet dsV = db.getResultset(selectVill, "", "", "");
            if (dsV != null && dsV.Tables[0].Rows.Count > 0)
            {
                ddlState.DataSource = dsV;
                ddlState.DataTextField = "StateName";
                ddlState.DataValueField = "StateId";
                ddlState.DataBind();
                ddlState.Items.Insert(0, "Select");
            }
            else
            {
                ddlState.Items.Clear();
                ddlState.Items.Insert(0, "Select");
            }
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
            else
            {
                ddlVillage.Items.Clear();
                ddlVillage.Items.Insert(0, "Select");
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

        //protected void ddlCSO_SelectedIndexChanged(object sender, EventArgs e)
        //{
        //    if (ddlCSO.SelectedIndex > 0)
        //    {

        //        string query = "select distinct NameofGramPanchayat from tblVillageinfo where CSOID = '" + ddlCSO.SelectedValue + "' order by NameofGramPanchayat";
        //        DataSet ds = db.getResultset(query, "", "", "");

        //        if (ds != null && ds.Tables[0].Rows.Count > 0)
        //        {
        //            ddlGrampanchayat.DataSource = ds;
        //            ddlGrampanchayat.DataValueField = "NameofGramPanchayat";
        //            ddlGrampanchayat.DataTextField = "NameofGramPanchayat";
        //            ddlGrampanchayat.DataBind();
        //            ddlGrampanchayat.Items.Insert(0, "Select");

        //        }
        //        //txtGrampanchayat.Text = "";
        //        ddlHamlet.Items.Clear();
        //        ddlHamlet.Items.Insert(0, "Select");
        //        string distblock = "select District,Block from tblCSO a left outer join tblDistricts b on a.DistrictID = b.SNo left outer join tblBlocks c on a.BlockID = c.Bid where CSOID = " + ddlCSO.SelectedValue;
        //        DataSet distds = db.getResultset(distblock, "", "", "");
        //        if (distds != null && distds.Tables[0].Rows.Count > 0)
        //        {
        //            DataTable dt = distds.Tables[0];
        //            txtDistrict.Text = dt.Rows[0]["District"].ToString();
        //            txtBlock.Text = dt.Rows[0]["Block"].ToString();
        //        }
        //    }
        //    else
        //    {
        //        ddlGrampanchayat.Items.Clear();
        //        ddlGrampanchayat.Items.Insert(0, "Select");
        //        ddlVillage.Items.Clear();
        //        ddlVillage.Items.Insert(0, "Select");
        //        txtBlock.Text = "";
        //        txtDistrict.Text = "";
        //        //txtGrampanchayat.Text = "";
        //        ddlHamlet.Items.Clear();
        //        ddlHamlet.Items.Insert(0, "Select");
        //    }
        //}

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
                else
                {
                    ddlHamlet.Items.Clear();
                    ddlHamlet.Items.Insert(0, "Select");
                }
            }
            else
            {
                // txtGrampanchayat.Text = "";
                ddlHamlet.Items.Clear();
                ddlHamlet.Items.Insert(0, "Select");
            }
        }

        //protected void ddlGrampanchayat_SelectedIndexChanged(object sender, EventArgs e)
        //{
        //    if (ddlGrampanchayat.SelectedIndex > 0)
        //    {
        //        string query = "select Vid, NameofVillage from tblVillageinfo where Status = 1 and NameofGramPanchayat = '" + ddlGrampanchayat.SelectedValue + "' order by NameofVillage";
        //        DataSet ds = db.getResultset(query, "", "", "");

        //        if (ds != null && ds.Tables[0].Rows.Count > 0)
        //        {
        //            ddlVillage.DataSource = ds;
        //            ddlVillage.DataValueField = "Vid";
        //            ddlVillage.DataTextField = "NameofVillage";
        //            ddlVillage.DataBind();
        //            ddlVillage.Items.Insert(0, "Select");

        //        }

        //    }
        //    else
        //    {
        //        ddlVillage.Items.Clear();
        //        ddlVillage.Items.Insert(0, "Select");
        //    }
        //}
    }
}