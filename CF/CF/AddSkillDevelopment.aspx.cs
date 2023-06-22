using System;
using System.Collections.Generic;
using System.Linq;
using System.Data;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CF
{
    public partial class AdSkillDevelopment : System.Web.UI.Page
    {
        DbErrorLog db = new DbErrorLog();
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
            string NumberOfBPL = txtNumber.Text;
            string EmploymentStatus = txtstatus.Text;
            string PerOfUnemployee = txtunemployed.Text;
            string PerofEmployeement = txtlookingforemployment.Text;
            string PerOfTraining = txtinterestedintraining.Text;
            string PerOfentrepreneurship = txtentrepreneurship.Text;
            string PerofWomenlookingforincomegenerationactivity = txtincomegeneration.Text;
            string Perofhouseholdsmigratesforemployment = txtmigratesforemploymen.Text;
            string HouseholdshavingMGNREGAjobcards = txtMGNREGAjobcards.Text;
            string Nooffamiliesinvolvedinfarmbasedlivelihoodactivities = txtfarmbasedlivelihood.Text;
            string Nooffamiliesinvolvedinnonfarmbasedlivelihoodactivities = txtnonfarmbasedlivelihood.Text;
            string PerofHHswithKitchengardens = txtKitchengardens.Text;

            string Skill = "INSERT INTO [dbo].[tblSkillDevelopment]([HDid],[NumberOfBPL],[EmploymentStatus],[PerOfUnemployee],[PerofEmployeement],[PerOfTraining],[PerOfentrepreneurship],[PerofWomenlookingforincomegenerationactivity],[Perofhouseholdsmigratesforemployment],[HouseholdshavingMGNREGAjobcards],[Nooffamiliesinvolvedinfarmbasedlivelihoodactivities],[Nooffamiliesinvolvedinnonfarmbasedlivelihoodactivities],[PerofHHswithKitchengardens] )  VALUES( " + Session["HDid"] + ",'" + NumberOfBPL + "','" + EmploymentStatus + "','" + PerOfUnemployee + "','" + PerofEmployeement + "','" + PerOfTraining + "','" + PerOfentrepreneurship + "','" + PerofWomenlookingforincomegenerationactivity + "','" + Perofhouseholdsmigratesforemployment + "','" + HouseholdshavingMGNREGAjobcards + "','" + Nooffamiliesinvolvedinfarmbasedlivelihoodactivities + "','" + Nooffamiliesinvolvedinnonfarmbasedlivelihoodactivities + "','" + PerofHHswithKitchengardens + "'  )";
            if (db.UpdateQuery(Skill, "", "", "") > 0)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "ShowAlert('Data submitted successufuly. ','success')", true);
            }

            else
            {
                ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "ShowAlert('Something went wrong please try again.','warning')", true);
            }
        }
    }
}


