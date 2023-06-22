using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CF
{
    public partial class EditHamlet : System.Web.UI.Page
    {
        DbErrorLog db = new DbErrorLog();
        string Vid = "";
        string Hid = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            Page.UnobtrusiveValidationMode = UnobtrusiveValidationMode.None;
            if (Session["Vid"] != null)
            {
                if (Session["Hid"] != null)
                {
                    Hid = Session["Hid"].ToString();

                    if (!IsPostBack)
                    {
                        loadData();
                    }
                }
                else
                {
                    Response.Redirect("~/VillageHamlet.aspx");
                }
            }
            else
            {
                Response.Redirect("~/VillagesInfo.aspx");
            }
        }

        public void loadData()
        {
            string query = "select Vid,StateName,Village,CSOName,Block,District, b.GramPanchayatName, b.[VillageID],[NameofHamlet],[NameofGramPanchayat],[PostofficeName],[DistancefromPostoffice],[BlockName],[DistanceofBlockfromVillage],[PolicestationName],[DistanceofPolicestation],[SubdistrictName],[DistanceofSubdistrict],[DistrictName],[DistanceofDistrict],[PostOfficepin],[DistancefromGramPanchayat],[DistanceofVillage] from tblHamletInfo a left outer join tblVillageInfo b on a.Villageid=b.Vid left outer join tblVillages c on b.villageID = c.villageID left outer join tblCSO d on b.CSOID=d.CSOID left outer join tblBlocks e on e.BlockID = d.BlockID left outer join tblDistricts f on f.DistrictID =d.DistrictID left outer join tblStates g on g.StateId=f.StateID where Hid = " + Hid;
            DataSet Datads = db.getResultset(query, "", "", "");
            if (Datads != null && Datads.Tables[0].Rows.Count > 0)
            {
                string Villageid = Session["Vid"].ToString();
                txtCSO.Text = Datads.Tables[0].Rows[0]["CSOName"].ToString();
                txtState.Text = Datads.Tables[0].Rows[0]["StateName"].ToString();
                txtDistrict.Text = Datads.Tables[0].Rows[0]["District"].ToString();
                txtBlock.Text = Datads.Tables[0].Rows[0]["Block"].ToString();
                txtvillagename.Text = Datads.Tables[0].Rows[0]["Village"].ToString();
                txtGramPanchayat.Text = Datads.Tables[0].Rows[0]["GramPanchayatName"].ToString();

                txtHamlet.Text = Datads.Tables[0].Rows[0]["NameofHamlet"].ToString();
                txtDistrict.Text = Datads.Tables[0].Rows[0]["DistrictName"].ToString(); ;
                txtdistDistrictdistance.Text = Datads.Tables[0].Rows[0]["DistanceofDistrict"].ToString(); ;
                txtsubdist.Text = Datads.Tables[0].Rows[0]["SubdistrictName"].ToString();
                txtDistsubdist.Text = Datads.Tables[0].Rows[0]["DistanceofSubdistrict"].ToString();
                txtBlock.Text = Datads.Tables[0].Rows[0]["BlockName"].ToString();
                txtDistBlock.Text = Datads.Tables[0].Rows[0]["DistanceofBlockfromVillage"].ToString();
                txtGramPanchayat.Text = Datads.Tables[0].Rows[0]["NameofGramPanchayat"].ToString();
                txtDistvillagename.Text = Datads.Tables[0].Rows[0]["DistanceofVillage"].ToString();
                txtDistGramPanchayat.Text = Datads.Tables[0].Rows[0]["DistancefromGramPanchayat"].ToString();
                txtPostoffice.Text = Datads.Tables[0].Rows[0]["PostofficeName"].ToString();
                txtDistPostoffice.Text = Datads.Tables[0].Rows[0]["DistancefromPostoffice"].ToString();
                txtPoliceStation.Text = Datads.Tables[0].Rows[0]["PolicestationName"].ToString();
                txtDistPoliceStation.Text = Datads.Tables[0].Rows[0]["DistanceofPolicestation"].ToString();
                txtpostpin.Text = Datads.Tables[0].Rows[0]["PostOfficepin"].ToString();
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
            string GramPanchayatName = txtGramPanchayat.Text;
            string DistancefromGramPanchayat = txtDistGramPanchayat.Text;
            string DistanceFromVillage = txtDistvillagename.Text;
            string PostofficeName = txtPostoffice.Text;
            string DistancefromPostoffice = txtDistPostoffice.Text;
            string PolicestationName = txtPoliceStation.Text;
            string DistanceofPolicestation = txtDistPoliceStation.Text;
            string PostOfficepin = txtpostpin.Text;

            string UpdateHamlet = "update [tblHamletInfo] set [Villageid]='" + Villageid + "',[NameofHamlet]='" + NameofHamlet + "',[NameofGramPanchayat]='" + GramPanchayatName + "',[DistancefromGramPanchayat]='" + DistancefromGramPanchayat + "',[PostofficeName]='" + PostofficeName + "',[DistancefromPostoffice]='" + DistancefromPostoffice + "',[BlockName]='" + BlockName + "',[DistanceofBlockfromVillage]='" + DistanceofBlockfromVillage + "',[PolicestationName]='" + PolicestationName + "',[DistanceofPolicestation]='" + DistanceofPolicestation + "',[SubdistrictName]='" + SubdistrictName + "',[DistanceofSubdistrict]='" + DistanceofSubdistrict + "',[DistrictName]='" + DistrictName + "',[DistanceofDistrict]='" + DistanceofDistrict + "',[DistanceofVillage]='" + DistanceFromVillage + "', PostOfficepin = '" + PostOfficepin + "' where Hid = " + Hid;

            if (db.UpdateQuery(UpdateHamlet, "", "", "") > 0)
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