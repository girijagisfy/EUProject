using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CF
{
    public partial class EditAnganwadi : System.Web.UI.Page
    {
        DbErrorLog db = new DbErrorLog();
        protected void Page_Load(object sender, EventArgs e)
        {
            Page.UnobtrusiveValidationMode = UnobtrusiveValidationMode.None;
            if (Session["HDid"] != null)
            {
                if (Session["Anid"] != null)
                {
                    if (!IsPostBack)
                    {
                        GetHamlet();
                    }
                }
                else
                {
                    Response.Redirect("~/AnganwadiInfo.aspx");
                }
            }
            else
            {
                Response.Redirect("~/HamletDataInfo.aspx");
            }
        }

        public void GetHamlet()
        {
            string angqry = "select StateName,NameofHamlet,village,Block,District,CSOName,Year,Hamletid, NameofAnganwadicentres, EnrolmentinAnganwadiCentres, Anganwadiisfunctionalornot, Totalnoof0to1yearsBoys, Totalnoof1to3yearsBoys, Totalnoof3to6yearsBoys, Totalnoof0to1yearsGirls, Totalnoof1to3yearsGirls, Totalnoof3to6yearsGirls, NoofAdultGirlsUnder12To45, NoofLactatingUnder12To45, NoofPregnentUnder12To45, No12To45AgeGroup from tblAnganwadiDetails i left outer join tblhamletdata h on i.HdId=h.HDid left outer join tblHamletInfo a on a.hid=h.hid left outer join tblVillageInfo b on a.Villageid=b.Vid left outer join tblVillages c on b.VillageID=c.VillageID left outer join tblBlocks d on b.BlockID = d.BlockID left outer join tblDistricts e on b.DistrictID=e.DistrictID left outer join tblCSO f on b.CSOID = f.CSOID left outer join tblStates g on g.StateId=e.StateID where Anid=" + Session["Anid"];
            DataSet AnDs = db.getResultset(angqry, "", "", "");
            if (AnDs != null && AnDs.Tables[0].Rows.Count > 0)
            {
                txtState.Text = AnDs.Tables[0].Rows[0]["StateName"].ToString();
                txtCSO.Text = AnDs.Tables[0].Rows[0]["CSOName"].ToString();
                txtDistrict.Text = AnDs.Tables[0].Rows[0]["District"].ToString();
                txtBlock.Text = AnDs.Tables[0].Rows[0]["Block"].ToString();
                txtvillagename.Text = AnDs.Tables[0].Rows[0]["village"].ToString();
                txthamlet.Text = AnDs.Tables[0].Rows[0]["NameofHamlet"].ToString();
                txtYear.Text = AnDs.Tables[0].Rows[0]["Year"].ToString();

                txtAnganwadi.Text = AnDs.Tables[0].Rows[0]["NameofAnganwadicentres"].ToString();
                txtEnroll.Text = AnDs.Tables[0].Rows[0]["EnrolmentinAnganwadiCentres"].ToString();
                if (ddlStatus.Items.FindByValue(AnDs.Tables[0].Rows[0]["Anganwadiisfunctionalornot"].ToString()) != null)
                {
                    ddlStatus.Items.FindByValue(AnDs.Tables[0].Rows[0]["Anganwadiisfunctionalornot"].ToString()).Selected = true;
                }
                txt0to1boys.Text = AnDs.Tables[0].Rows[0]["Totalnoof0to1yearsBoys"].ToString(); ;
                txt0to1girls.Text = AnDs.Tables[0].Rows[0]["Totalnoof0to1yearsGirls"].ToString(); ;
                txt1to3Boys.Text = AnDs.Tables[0].Rows[0]["Totalnoof1to3yearsBoys"].ToString(); ;
                txt1to3Girls.Text = AnDs.Tables[0].Rows[0]["Totalnoof1to3yearsGirls"].ToString(); ;
                txt3to6Boys.Text = AnDs.Tables[0].Rows[0]["Totalnoof3to6yearsBoys"].ToString(); ;
                txt3to6Girls.Text = AnDs.Tables[0].Rows[0]["Totalnoof3to6yearsGirls"].ToString(); ;
                txt12to45.Text = AnDs.Tables[0].Rows[0]["No12To45AgeGroup"].ToString();
                txtPregnent.Text = AnDs.Tables[0].Rows[0]["NoofPregnentUnder12To45"].ToString();
                txtLactating.Text = AnDs.Tables[0].Rows[0]["NoofLactatingUnder12To45"].ToString();
                txtAdults.Text = AnDs.Tables[0].Rows[0]["NoofAdultGirlsUnder12To45"].ToString();
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

            string query = "update tblAnganwadiDetails set NameofAnganwadicentres='" + Name + "' , EnrolmentinAnganwadiCentres='" + Enroll + "', Anganwadiisfunctionalornot='" + Functional + "', Totalnoof0to1yearsBoys='" + b0to1boys + "', Totalnoof1to3yearsBoys='" + b1to3boys + "', Totalnoof3to6yearsBoys='" + b3to6boys + "', Totalnoof0to1yearsGirls='" + g0to1girls + "', Totalnoof1to3yearsGirls='" + g1to3girls + "', Totalnoof3to6yearsGirls='" + g3to6girls + "', NoofAdultGirlsUnder12To45='" + Adults + "', NoofLactatingUnder12To45='" + Lactating + "', NoofPregnentUnder12To45='" + Pregnents + "', No12To45AgeGroup='" + twelve45 + "' where Anid=" + Session["Anid"];

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