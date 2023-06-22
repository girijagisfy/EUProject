using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CF
{
    public partial class EditServiceProvider : System.Web.UI.Page
    {
        DbErrorLog db = new DbErrorLog();
        protected void Page_Load(object sender, EventArgs e)
        {
            Page.UnobtrusiveValidationMode = UnobtrusiveValidationMode.None;
            if (Session["HDid"] != null)
            {
                if (Session["FIid"] != null)
                {
                    if (!IsPostBack)
                    {
                        GetHamlet();
                    }
                }
                else
                {
                    Response.Redirect("~/ServiceProvidersinfo.aspx");
                }
            }
            else
            {
                Response.Redirect("~/HamletDataInfo.aspx");
            }
        }

        public void GetHamlet()
        {
            string query = "select StateName,NameofHamlet,village,Block,District,CSOName,Year,NameofProvider,Designation,ContactNumber,Department,Address from tblDetailsofVillageService i left outer join tblhamletdata h on i.HdId=h.HDid left outer join tblHamletInfo a on a.hid=h.hid left outer join tblVillageInfo b on a.Villageid=b.Vid left outer join tblVillages c on b.VillageID=c.VillageID left outer join tblBlocks d on b.BlockID = d.BlockID left outer join tblDistricts e on b.DistrictID=e.DistrictID left outer join tblCSO f on b.CSOID = f.CSOID left outer join tblStates g on g.StateId=e.StateID where FIid=" + Session["FIid"];
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

                Txtname.Text = ds.Tables[0].Rows[0]["NameofProvider"].ToString();
                Txtdesignation.Text = ds.Tables[0].Rows[0]["Designation"].ToString();
                TxtDepartment.Text = ds.Tables[0].Rows[0]["Department"].ToString();
                Txtcontactno.Text = ds.Tables[0].Rows[0]["ContactNumber"].ToString();
                TxtAddress.Text = ds.Tables[0].Rows[0]["Address"].ToString();
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            string Name = Txtname.Text;
            string Department = TxtDepartment.Text;
            string designaton = Txtdesignation.Text;
            string Address = TxtAddress.Text;
            string Contact = Txtcontactno.Text;

            string query = "update tblDetailsofVillageService set NameofProvider='" + Name + "',Designation='" + designaton + "',ContactNumber='" + Contact + "',Department='" + Department + "',Address='" + Address + "' where FIid=" + Session["FIid"];
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