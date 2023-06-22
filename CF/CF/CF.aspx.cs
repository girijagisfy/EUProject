using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CF
{
    public partial class CF : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Page.UnobtrusiveValidationMode = UnobtrusiveValidationMode.None;
        }

        protected void AddTextBox(object sender, EventArgs e)
        {
            int index = pnlTextBoxes.Controls.OfType<TextBox>().ToList().Count + 1;
            this.CreateTextBox("txtNoofHamlets" + index);
        }

        private void CreateTextBox(string id)
        {

            System.Web.UI.HtmlControls.HtmlGenericControl createDiv = new System.Web.UI.HtmlControls.HtmlGenericControl("div");
            createDiv.ID = "Hamletdiv" + id;
            createDiv.Attributes.Add("class", "col-md-3 form-group");
            pnlTextBoxes.Controls.Add(createDiv);
            TextBox tb = new TextBox();
            tb.ID = "txtNoofHamlets" + id;
            tb.CssClass = "form-control";
            //id++;
            //hiddenHamlet.Value = index.ToString();
            createDiv.Controls.Add(tb);

            //TextBox txt = new TextBox();
            //txt.ID = id;
            //pnlTextBoxes.Controls.Add(txt);

            //Literal lt = new Literal();
            //lt.Text = "<br />";
            //pnlTextBoxes.Controls.Add(lt);
        }

        protected void GetTextBoxValues(object sender, EventArgs e)
        {
            string message = "";
            foreach (TextBox textBox in pnlTextBoxes.Controls.OfType<TextBox>())
            {
                message += textBox.ID + ": " + textBox.Text + "\\n";
            }
            ClientScript.RegisterClientScriptBlock(this.GetType(), "alert", "alert('" + message + "');", true);
        }


        protected void Page_Init(object sender, EventArgs e)
        {
            List<string> keys = Request.Form.AllKeys.Where(key => key.Contains("txtNoofHamlets")).ToList();
            int i = 1;
            foreach (string key in keys)
            {
                this.CreateTextBox("txtNoofHamlets" + i);
                i++;
            }
        }
    }
}