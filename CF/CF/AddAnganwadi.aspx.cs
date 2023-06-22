using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


namespace CF
{
    public partial class AddAnganwadi : System.Web.UI.Page
    {
        DbErrorLog db = new DbErrorLog();
        string Hid = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            Page.UnobtrusiveValidationMode = UnobtrusiveValidationMode.None;
            if (Session["Hid"] != null)
            {
                if (Session["HDid"] != null)
                {
                    Hid = Session["Hid"].ToString();
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
            else
            {
                Response.Redirect("~/VillageHamlet.aspx");
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
            string Name = txtAnganwadi.Text;
            string Enroll = txtEnroll.Text;
            string Functional = ddlStatus.SelectedValue;
            string b0to1boys = txt0to1boys.Text;
            string g0to1girls = txt0to1girls.Text;
            string b1to3boys = txt1to3Boys.Text;
            string g1to3girls = txt1to3Girls.Text;
            string b3to6boys = txt3to6Boys.Text;
            string g3to6girls = txt3to6Girls.Text;
            string twelve45 = txt12to45.Text;
            string Pregnents = txtPregnent.Text;
            string Lactating = txtLactating.Text;
            string Adults = txtAdults.Text;

            string query = "insert into tblAnganwadiDetails(HdId, NameofAnganwadicentres, EnrolmentinAnganwadiCentres, Anganwadiisfunctionalornot, Totalnoof0to1yearsBoys, Totalnoof1to3yearsBoys, Totalnoof3to6yearsBoys, Totalnoof0to1yearsGirls, Totalnoof1to3yearsGirls, Totalnoof3to6yearsGirls, NoofAdultGirlsUnder12To45, NoofLactatingUnder12To45, NoofPregnentUnder12To45, No12To45AgeGroup) values(" + Session["HDid"] + ",'" + Name + "','" + Enroll + "','" + Functional + "','" + b0to1boys + "','" + b1to3boys + "','" + b3to6boys + "','" + g0to1girls + "','" + g1to3girls + "','" + g3to6girls + "','" + Adults + "','" + Lactating + "','" + Pregnents + "','" + twelve45 + "')";

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