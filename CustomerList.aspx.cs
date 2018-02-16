using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class CustomerList : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            Label mastertxt = (Label)Master.FindControl("lblProfile");
            if (Session["Name"] != null)
                mastertxt.Text = Session["Name"].ToString();
            else
                Response.Redirect("index.aspx", true);
            if (!IsPostBack)
            {

                lblpermissions.Text = "";
                divCustomerList.Visible = true;
                divmessage.Visible = false;

            }
        }
        catch { }
    }
}