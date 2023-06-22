using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CF
{
    public partial class AddHamlet : System.Web.UI.Page
    {
        DbErrorLog db = new DbErrorLog();
        protected void Page_Load(object sender, EventArgs e)
        {

            Page.UnobtrusiveValidationMode = UnobtrusiveValidationMode.None;
            if (Session["Vid"] != null)
            {
                if (!IsPostBack)
                {
                    //loadCSO();
                    loaddata();
                }
            }
            else
            {
                Response.Redirect("~/VillagesInfo.aspx");
            }
        }
        //public void loadCSO()
        //{
        //    string selectCSO = "select [CSOID],[CSOName]from tblCSO";
        //    DataSet ds = db.getResultset(selectCSO, "", "", "");
        //    if (ds.Tables[0].Rows.Count > 0 && ds != null)
        //    {
        //        ddlCso.DataSource = ds.Tables[0];
        //        ddlCso.DataTextField = "CSOName";
        //        ddlCso.DataValueField = "CSOID";
        //        ddlCso.DataBind();
        //        ddlCso.Items.Insert(0, "Select");
        //    }
        //}
        public void loaddata()
        {
            string vidCondetion = Session["Vid"].ToString();
            string selectCSO = "SELECT Vid,StateName,Village,CSOName,Block,District, a.GramPanchayatName FROM tblVillageInfo a left outer join tblVillages b on a.villageID = b.villageID left outer join tblCSO c on a.CSOID=c.CSOID left outer join tblBlocks e on e.BlockID = c.BlockID left outer join tblDistricts d on d.DistrictID =c.DistrictID left outer join tblStates f on f.StateId=d.StateID where Vid=" + vidCondetion;
            DataSet ds = db.getResultset(selectCSO, "", "", "");
            if (ds.Tables[0].Rows.Count > 0 && ds != null)
            {
                txtCSO.Text = ds.Tables[0].Rows[0]["CSOName"].ToString();
                txtState.Text = ds.Tables[0].Rows[0]["StateName"].ToString();
                txtDistrict.Text = ds.Tables[0].Rows[0]["District"].ToString();
                txtBlock.Text = ds.Tables[0].Rows[0]["Block"].ToString();
                txtvillagename.Text = ds.Tables[0].Rows[0]["Village"].ToString();
                txtGramPanchayat.Text = ds.Tables[0].Rows[0]["GramPanchayatName"].ToString();
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            string Villageid = Session["Vid"].ToString();
            string NameofHamlet = txtHamlet.Text;
            string DistrictName = txtDistrict.Text;
            string DistanceofDistrict = txtdistDistrictdistance.Text;
            string SubdistrictName = txtsubdist.Text;
            string DistanceofSubdistrict = txtDistsubdist.Text;
            string BlockName = txtBlock.Text;
            string DistanceofBlockfromVillage = txtDistBlock.Text;
            string DistanceFromVillage = txtDistvillagename.Text;
            string GramPanchayatName = txtGramPanchayat.Text;
            string DistancefromGramPanchayat = txtDistGramPanchayat.Text;
            string PostofficeName = txtPostoffice.Text;
            string DistancefromPostoffice = txtDistPostoffice.Text;
            string PolicestationName = txtPoliceStation.Text;
            string DistanceofPolicestation = txtDistPoliceStation.Text;
            string PostOfficepin = txtpostpin.Text;


            string InsertHamlet = "INSERT INTO [dbo].[tblHamletInfo] ([Villageid],[NameofHamlet],[NameofGramPanchayat],[DistancefromGramPanchayat],[PostofficeName],[DistancefromPostoffice],[BlockName],[DistanceofBlockfromVillage],[PolicestationName],[DistanceofPolicestation],[SubdistrictName],[DistanceofSubdistrict],[DistrictName],[DistanceofDistrict],[PostOfficepin],[DistanceofVillage]) VALUES('" + Villageid + "','" + NameofHamlet + "','" + GramPanchayatName + "','" + DistancefromGramPanchayat + "','" + PostofficeName + "','" + DistancefromPostoffice + "','" + BlockName + "','" + DistanceofBlockfromVillage + "','" + PolicestationName + "','" + DistanceofPolicestation + "','" + SubdistrictName + "','" + DistanceofSubdistrict + "','" + DistrictName + "','" + DistanceofDistrict + "','" + PostOfficepin + "','" + DistanceFromVillage + "')";

            if (db.UpdateQuery(InsertHamlet, "", "", "") > 0)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "ShowAlert('You have submitted data successfully. Thank you.','success')", true);
            }
            else
            {
                ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "ShowAlert('Something went wrong please try again.','warning')", true);
            }
        }
    }
}