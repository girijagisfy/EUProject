using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CF
{
    public partial class EditLivestock : System.Web.UI.Page
    {
        DbErrorLog db = new DbErrorLog();
        string Hid = "";
        string Nid = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            Page.UnobtrusiveValidationMode = UnobtrusiveValidationMode.None;
            if (Session["Hid"] != null)
            {
                if (Session["Nid"] != null)
                {
                    Hid = Session["Hid"].ToString();
                    Nid = Session["Nid"].ToString();
                    if (!IsPostBack)
                    {
                        GetHamlet();
                    }
                }
                else
                {
                    Response.Redirect("~/LiveStockInfo.aspx");
                }
            }
            else
            {
                Response.Redirect("~/VillageHamlet.aspx");
            }
        }


        public void GetHamlet()
        {
            string query = "select StateName, NameofHamlet, village, Block, District, CSOName from tblHamletInfo a left outer join tblVillageInfo b on a.Villageid=b.Vid left outer join tblVillages c on b.VillageID=c.VillageID left outer join tblBlocks d on b.BlockID = d.BlockID left outer join tblDistricts e on b.DistrictID=e.DistrictID left outer join tblCSO f on b.CSOID = f.CSOID left outer join tblStates g on g.StateId=e.StateID where Hid=" + Hid;
            DataSet ds = db.getResultset(query, "", "", "");
            if (ds != null && ds.Tables[0].Rows.Count > 0)
            {
                txtState.Text = ds.Tables[0].Rows[0]["StateName"].ToString();
                txtCSO.Text = ds.Tables[0].Rows[0]["CSOName"].ToString();
                txtDistrict.Text = ds.Tables[0].Rows[0]["District"].ToString();
                txtBlock.Text = ds.Tables[0].Rows[0]["Block"].ToString();
                txtvillagename.Text = ds.Tables[0].Rows[0]["village"].ToString();
                txthamlet.Text = ds.Tables[0].Rows[0]["NameofHamlet"].ToString();
            }
           
           string query1 = "select Nid,LiveStockName,HHofLivestock,Population,Disease,Mortality,AverageIncome from tblNaturalResouce_Livestock  where Nid =" + Nid;
            DataSet datads = db.getResultset(query1, "", "", "");
            if (datads != null && datads.Tables[0].Rows.Count > 0)
              {
                txtLivestock.Text = datads.Tables[0].Rows[0]["LiveStockName"].ToString();
                txtHH.Text = datads.Tables[0].Rows[0]["HHofLivestock"].ToString();
                txtPopulation.Text = datads.Tables[0].Rows[0]["Population"].ToString();
                txtDiesease.Text = datads.Tables[0].Rows[0]["Disease"].ToString();
                txtMortality.Text = datads.Tables[0].Rows[0]["Mortality"].ToString();
                txtIncome.Text = datads.Tables[0].Rows[0]["AverageIncome"].ToString();
            }
        }

        protected void btnupdate_Click(object sender, EventArgs e)
        {
            string name = txtLivestock.Text;
            string HH = txtHH.Text;
            string population = txtPopulation.Text;
            string Disease = txtDiesease.Text;
            string Mortality = txtMortality.Text;
            string income = txtIncome.Text;

            string query = "update [tblNaturalResouce_Livestock] set [Hamletid]=" + Hid + ",[LiveStockName]='" + name + "',[HHofLivestock]='" + HH + "',[Population]='" + population + "',[Disease]='" + Disease + "',[Mortality]='" + Mortality + "',[AverageIncome]='" + income + "' where Nid = " + Session["Nid"];

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