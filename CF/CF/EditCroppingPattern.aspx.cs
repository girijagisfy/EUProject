using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


namespace CF
{
    public partial class EditCroppingPattern : System.Web.UI.Page
    {
        DbErrorLog db = new DbErrorLog();
        protected void Page_Load(object sender, EventArgs e)
        {
            Page.UnobtrusiveValidationMode = UnobtrusiveValidationMode.None;
            if (Session["HDid"] != null)
            {
                if (Session["NCid"] != null)
                {
                    if (!IsPostBack)
                    {
                        GetHamlet();
                    }
                }
                else
                {
                    Response.Redirect("~/CroppingInfo");
                }
            }
            else
            {
                Response.Redirect("~/HamletDataInfo.aspx");
            }
        }

        public void GetHamlet()
        {
            string query = "select StateName,NameofHamlet,village,Block,District,CSOName,Year,PatternName, TotalAreainacr, AverageProduction, AverageIncome from tblNaturalResouce_CroppingPattern i left outer join tblhamletdata h on i.HdId=h.HDid left outer join tblHamletInfo a on a.hid=h.hid left outer join tblVillageInfo b on a.Villageid=b.Vid left outer join tblVillages c on b.VillageID=c.VillageID left outer join tblBlocks d on b.BlockID = d.BlockID left outer join tblDistricts e on b.DistrictID=e.DistrictID left outer join tblCSO f on b.CSOID = f.CSOID left outer join tblStates g on g.StateId=e.StateID where NCid=" + Session["NCid"];
            DataSet ds = db.getResultset(query, "", "", "");
            if (ds != null && ds.Tables[0].Rows.Count > 0)
            {

                txtState.Text = ds.Tables[0].Rows[0]["StateName"].ToString();
                txtCSO.Text = ds.Tables[0].Rows[0]["CSOName"].ToString();
                txtDistrict.Text = ds.Tables[0].Rows[0]["District"].ToString();
                txtBlock.Text = ds.Tables[0].Rows[0]["Block"].ToString();
                txtvillagename.Text = ds.Tables[0].Rows[0]["village"].ToString();
                txthamlet.Text = ds.Tables[0].Rows[0]["NameofHamlet"].ToString();
                txtPattern.Text = ds.Tables[0].Rows[0]["PatternName"].ToString();
                txtTotaAcr.Text = ds.Tables[0].Rows[0]["TotalAreainacr"].ToString();
                txtProduction.Text = ds.Tables[0].Rows[0]["AverageProduction"].ToString();
                txtIncome.Text = ds.Tables[0].Rows[0]["AverageIncome"].ToString();
            }

        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            string name = txtPattern.Text;
            string TotalAcr = txtTotaAcr.Text;
            string Production = txtProduction.Text;
            string Income = txtIncome.Text;

            string query = "update tblNaturalResouce_CroppingPattern set PatternName='" + name + "', TotalAreainacr='" + TotalAcr + "', AverageProduction='" + Production + "', AverageIncome='" + Income + "' where NCid=" + Session["NCid"];

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