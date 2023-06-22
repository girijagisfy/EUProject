using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CF
{
    public partial class AddFinanceLiteracy : System.Web.UI.Page
    {
        DbErrorLog db = new DbErrorLog();
        string Hid = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            Page.UnobtrusiveValidationMode = UnobtrusiveValidationMode.None;
            if (Session["HDid"] != null)
            {
                if (!IsPostBack)
                {
                    GetHamlet();
                }
            }
            else
            {
                Response.Redirect("~/HamletDataInfo.aspx");
            }
        }

        public void GetHamlet()
        {
            string query = "select StateName,NameofHamlet,village,Block,District,CSOName,Year from tblhamletdata h left outer join tblHamletInfo a on a.hid=h.hid left outer join tblVillageInfo b on a.Villageid=b.Vid left outer join tblVillages c on b.VillageID=c.VillageID left outer join tblBlocks d on b.BlockID = d.BlockID left outer join tblDistricts e on b.DistrictID=e.DistrictID left outer join tblCSO f on b.CSOID = f.CSOID left outer join tblStates g on g.StateId=e.StateID where HDid=" + Session["HDid"];
            DataSet ds = db.getResultset(query, "", "", "");
            if (ds != null && ds.Tables[0].Rows.Count > 0)
            {
                txtState.Text = ds.Tables[0].Rows[0]["StateName"].ToString();
                txtCSO.Text = ds.Tables[0].Rows[0]["CSOName"].ToString();
                txtDistrict.Text = ds.Tables[0].Rows[0]["District"].ToString();
                txtBlock.Text = ds.Tables[0].Rows[0]["Block"].ToString();
                txtvillagename.Text = ds.Tables[0].Rows[0]["village"].ToString();
                txthamlet.Text = ds.Tables[0].Rows[0]["NameofHamlet"].ToString();
                txtYear.Text = ds.Tables[0].Rows[0]["Year"].ToString();
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            string Bank = txtBank.Text;
            string BanDistance = txtBankdistance.Text;
            string Cooperative = txtCooperative.Text;
            string CooperativeDist = txtCooperativeDistance.Text;
            string HHBanks = txtHHBanks.Text;
            string Revolving = txtRevolving.Text;
            string KCC = txtKCC.Text;
            string Mudra = txtMudra.Text;

            string query = "INSERT INTO tblFinancialLiteracyandInclusion (HDid, BankName, BankDistance, NameofcooperativeSociety, SocietyDistance, HHsWithBankAccounts, benefitingFromRevolvingFund, HHsWithKCC, HHsWithMudraLoan) values(" + Session["HDid"] + ",'" + Bank + "','" + BanDistance + "','" + Cooperative + "','" + CooperativeDist + "','" + HHBanks + "','" + Revolving + "','" + KCC + "','" + Mudra + "')";
            if (db.UpdateQuery(query, "", "", "") > 0)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "ShowAlert('Data Submitted Successfully.','success')", true);
            }
            else
            {
                ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "ShowAlert('Something went wrong please try again.','warning')", true);
            }
        }
    }
}