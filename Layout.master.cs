using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Layout : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!IsPostBack)
            {
                if (Session["UserType"].ToString() != "4")
                {
                    ulUser.Visible = false;
                    liLeadAllocation.Visible = false;
                }
                else
                {
                    ulUser.Visible = true;
                    liLeadAllocation.Visible = true;
                }
            }
        }
        catch { }
    }
}
