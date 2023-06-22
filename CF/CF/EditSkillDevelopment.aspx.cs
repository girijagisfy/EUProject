using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CF
{
    public partial class EditSkillDevelopment_aspx : System.Web.UI.Page
    {
        DbErrorLog db = new DbErrorLog();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["HDid"] != null)
            {
                if (Session["Skid"] != null)
                {
                    if (!IsPostBack)
                    {
                        GetHamlet();
                    }
                }
                else
                {
                    Response.Redirect("~/SkillDevelopmentinfo.aspx");
                }
            }
            else
            {
                Response.Redirect("~/HamletDataInfo.aspx");
            }
        }

        public void GetHamlet()
        {
            string Hid = Session["Hid"].ToString();
            string query = "select StateName,NameofHamlet,village,Block,District,CSOName,Year,Skid,Hamletid,NumberOfBPL, EmploymentStatus,PerOfUnemployee,PerofEmployeement,PerOfTraining,PerOfentrepreneurship,PerofWomenlookingforincomegenerationactivity,Perofhouseholdsmigratesforemployment,HouseholdshavingMGNREGAjobcards,Nooffamiliesinvolvedinfarmbasedlivelihoodactivities,Nooffamiliesinvolvedinnonfarmbasedlivelihoodactivities,PerofHHswithKitchengardens from tblSkillDevelopment i left outer join tblhamletdata h on i.HdId=h.HDid left outer join tblHamletInfo a on a.hid=h.hid left outer join tblVillageInfo b on a.Villageid=b.Vid left outer join tblVillages c on b.VillageID=c.VillageID left outer join tblBlocks d on b.BlockID = d.BlockID left outer join tblDistricts e on b.DistrictID=e.DistrictID left outer join tblCSO f on b.CSOID = f.CSOID left outer join tblStates g on g.StateId=e.StateID where Skid=" + Session["Skid"];
            DataSet ds = db.getResultset(query, "", "", "");
            if (ds != null && ds.Tables[0].Rows.Count > 0)
            {
                txtState.Text = ds.Tables[0].Rows[0]["StateName"].ToString();
                txtCSO.Text = ds.Tables[0].Rows[0]["CSOName"].ToString();
                txtDistrict.Text = ds.Tables[0].Rows[0]["District"].ToString();
                txtBlock.Text = ds.Tables[0].Rows[0]["Block"].ToString();
                txtvillagename.Text = ds.Tables[0].Rows[0]["village"].ToString();
                txthamlet.Text = ds.Tables[0].Rows[0]["NameofHamlet"].ToString();

                txtNumber.Text = ds.Tables[0].Rows[0]["NumberOfBPL"].ToString();
                txtstatus.Text = ds.Tables[0].Rows[0]["EmploymentStatus"].ToString();
                txtunemployed.Text = ds.Tables[0].Rows[0]["PerOfUnemployee"].ToString();
                txtlookingforemployment.Text = ds.Tables[0].Rows[0]["PerofEmployeement"].ToString();
                txtinterestedintraining.Text = ds.Tables[0].Rows[0]["PerOfTraining"].ToString();
                txtmigratesforemploymen.Text = ds.Tables[0].Rows[0]["PerOfentrepreneurship"].ToString();
                txtentrepreneurship.Text = ds.Tables[0].Rows[0]["PerofWomenlookingforincomegenerationactivity"].ToString();
                txtincomegeneration.Text = ds.Tables[0].Rows[0]["Perofhouseholdsmigratesforemployment"].ToString();
                txtMGNREGAjobcards.Text = ds.Tables[0].Rows[0]["HouseholdshavingMGNREGAjobcards"].ToString();
                txtfarmbasedlivelihood.Text = ds.Tables[0].Rows[0]["Nooffamiliesinvolvedinfarmbasedlivelihoodactivities"].ToString();
                txtnonfarmbasedlivelihood.Text = ds.Tables[0].Rows[0]["Nooffamiliesinvolvedinnonfarmbasedlivelihoodactivities"].ToString();
                txtKitchengardens.Text = ds.Tables[0].Rows[0]["PerofHHswithKitchengardens"].ToString();
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
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

            string insertQ = "UPDATE tblSkillDevelopment  set [NumberOfBPL]= '" + NumberOfBPL + "',[EmploymentStatus]= '" + EmploymentStatus + "', [PerOfUnemployee]= '" + PerOfUnemployee + "', [PerofEmployeement]= '" + PerofEmployeement + "', [PerOfTraining]= '" + PerOfTraining + "', [PerOfentrepreneurship]= '" + PerOfentrepreneurship + "', [PerofWomenlookingforincomegenerationactivity]= '" + PerofWomenlookingforincomegenerationactivity + "', [Perofhouseholdsmigratesforemployment]= '" + Perofhouseholdsmigratesforemployment + "', [HouseholdshavingMGNREGAjobcards]= '" + HouseholdshavingMGNREGAjobcards + "',[Nooffamiliesinvolvedinfarmbasedlivelihoodactivities]= '" + Nooffamiliesinvolvedinfarmbasedlivelihoodactivities + "',[Nooffamiliesinvolvedinnonfarmbasedlivelihoodactivities]= '" + Nooffamiliesinvolvedinnonfarmbasedlivelihoodactivities + "',[PerofHHswithKitchengardens]= '" + PerofHHswithKitchengardens + "'  where [Skid] = " + Session["Skid"];

            if (db.UpdateQuery(insertQ, "", "", "") > 0)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "ShowAlert('Data Update successufuly. ','success')", true);
                Response.Redirect("SkillDevelopmentinfo.aspx");
            }
            else
            {
                ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "ShowAlert('Something went wrong please try again.','warning')", true);
            }
        }
    }
}
