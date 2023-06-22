using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
namespace CF
{
    public partial class EditFinanceLiteracy : System.Web.UI.Page
    {
        DbErrorLog db = new DbErrorLog();
        protected void Page_Load(object sender, EventArgs e)
        {
            Page.UnobtrusiveValidationMode = UnobtrusiveValidationMode.None;
            if (Session["HDid"] != null)
            {
                if (Session["FLid"] != null)
                {
                    if (!IsPostBack)
                    {
                        GetHamlet();
                    }
                }
                else
                {
                    Response.Redirect("~/FinancialLiteracyInfo.aspx");
                }
            }
            else
            {
                Response.Redirect("~/HamletDataInfo.aspx");
            }
        }

        public void GetHamlet()
        {
            string query = "select StateName,NameofHamlet,village,Block,District,CSOName,Year,FLid,i.BankName, BankDistance, NameofcooperativeSociety, SocietyDistance, HHsWithBankAccounts, benefitingFromRevolvingFund, HHsWithKCC, HHsWithMudraLoan  from tblFinancialLiteracyandInclusion i left outer join tblhamletdata h on i.HdId=h.HDid left outer join tblHamletInfo a on a.hid=h.hid left outer join tblVillageInfo b on a.Villageid=b.Vid left outer join tblVillages c on b.VillageID=c.VillageID left outer join tblBlocks d on b.BlockID = d.BlockID left outer join tblDistricts e on b.DistrictID=e.DistrictID left outer join tblCSO f on b.CSOID = f.CSOID left outer join tblStates g on g.StateId=e.StateID where FLid=" + Session["FLid"];
            DataSet ds = db.getResultset(query, "", "", "");
            if (ds != null && ds.Tables[0].Rows.Count > 0)
            {
                txtState.Text = ds.Tables[0].Rows[0]["StateName"].ToString();
                txtCSO.Text = ds.Tables[0].Rows[0]["CSOName"].ToString();
                txtDistrict.Text = ds.Tables[0].Rows[0]["District"].ToString();
                txtBlock.Text = ds.Tables[0].Rows[0]["Block"].ToString();
                txtvillagename.Text = ds.Tables[0].Rows[0]["village"].ToString();
                txthamlet.Text = ds.Tables[0].Rows[0]["NameofHamlet"].ToString();

                txtBank.Text = ds.Tables[0].Rows[0]["BankName"].ToString();
                txtBankdistance.Text = ds.Tables[0].Rows[0]["BankDistance"].ToString();
                txtCooperative.Text = ds.Tables[0].Rows[0]["NameofcooperativeSociety"].ToString();
                txtCooperativeDistance.Text = ds.Tables[0].Rows[0]["SocietyDistance"].ToString();
                txtHHBanks.Text = ds.Tables[0].Rows[0]["HHsWithBankAccounts"].ToString();
                txtRevolving.Text = ds.Tables[0].Rows[0]["benefitingFromRevolvingFund"].ToString();
                txtKCC.Text = ds.Tables[0].Rows[0]["HHsWithKCC"].ToString();
                txtMudra.Text = ds.Tables[0].Rows[0]["HHsWithMudraLoan"].ToString();
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

            string query = "update tblFinancialLiteracyandInclusion set BankName='" + Bank + "', BankDistance='" + BanDistance + "', NameofcooperativeSociety='" + Cooperative + "', SocietyDistance='" + CooperativeDist + "', HHsWithBankAccounts='" + HHBanks + "', benefitingFromRevolvingFund='" + Revolving + "', HHsWithKCC='" + KCC + "', HHsWithMudraLoan='" + Mudra + "' where FLid=" + Session["FLid"];
            if (db.UpdateQuery(query, "", "", "") > 0)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "ShowAlert('Data Updated Successfully.','success')", true);
            }
            else
            {
                ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "ShowAlert('Something went wrong please try again.','warning')", true);
            }
        }
    }
}