using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

namespace CF
{
    public partial class EditDiseases : System.Web.UI.Page
    {
        DbErrorLog db = new DbErrorLog();

        protected void Page_Load(object sender, EventArgs e)
        {

            Page.UnobtrusiveValidationMode = UnobtrusiveValidationMode.None;

            if (Session["HDid"] != null)
            {
                if (Session["Disid"] != null)
                {
                    if (!IsPostBack)
                    {
                        GetHamlet();
                    }
                }
                else
                {
                    Response.Redirect("~/PrevalentDiseasesInfo.aspx");
                }
            }
            else
            {
                Response.Redirect("~/HamletDataInfo.aspx");
            }
        }

        public void GetHamlet()
        {
            string query = "select StateName,NameofHamlet,village,Block,District,CSOName,Year,Disid,Hamletid,DiseasesName, description from tblDiseasesinvillage i left outer join tblhamletdata h on i.HdId=h.HDid left outer join tblHamletInfo a on a.hid=h.hid left outer join tblVillageInfo b on a.Villageid=b.Vid left outer join tblVillages c on b.VillageID=c.VillageID left outer join tblBlocks d on b.BlockID = d.BlockID left outer join tblDistricts e on b.DistrictID=e.DistrictID left outer join tblCSO f on b.CSOID = f.CSOID left outer join tblStates g on g.StateId=e.StateID where Disid=" + Session["Disid"];
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

                TxtDiseasesName.Text = ds.Tables[0].Rows[0]["DiseasesName"].ToString();
                Txtdescription.Text = ds.Tables[0].Rows[0]["description"].ToString();
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            string DiseasesName = TxtDiseasesName.Text;
            string description = Txtdescription.Text;
            string insertQ = "UPDATE tblDiseasesinvillage set [DiseasesName]= '" + DiseasesName + "',[description]= '" + description + "' where [Disid] = " + Session["Disid"];

            if (db.UpdateQuery(insertQ, "", "", "") > 0)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "ShowAlert('Data Update successufuly. ','success')", true);
                Response.Redirect("PrevalentDiseasesInfo.aspx");
            }
            else
            {
                ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "ShowAlert('Something went wrong please try again.','warning')", true);
            }
        }
    }
}
