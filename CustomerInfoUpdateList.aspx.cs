using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BusinessLogic;
using System.Data;
using BusinessObjects;


public partial class CustomerInfoUpdateList : System.Web.UI.Page
{
    CustomerBL customerBl = new CustomerBL();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["Name"] != null)
        {
            Label mastertxt = (Label)Master.FindControl("lblProfile");
            mastertxt.Text = Session["Name"].ToString();
            if (!IsPostBack)
            {
                GetCustomerInfo();
            }
        }
        else
        {
            Response.Redirect("index.aspx");
        }
    }

    private void GetCustomerInfo()
    {
        try
        {
            DataSet ds = customerBl.GetCustomer(0);
            gvCustomerUpdate.DataSource = ds;
            Session["dt"] = ds.Tables[0];
            gvCustomerUpdate.DataBind();

        }
        catch (Exception ex)
        {

        }
    }
    protected void gvCustomerUpdate_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "Edit")
        {
            int id = Convert.ToInt32(e.CommandArgument);
            GridViewRow row = gvCustomerUpdate.Rows[id];
            Response.Redirect("~/CustomerUpdate.aspx?id=" + row.Cells[0].Text);
        }
    }

    protected void gvCustomerUpdate_RowEditing(object sender, GridViewEditEventArgs e)
    {
        gvCustomerUpdate.EditIndex = e.NewEditIndex;
        GetCustomerInfo();
    }
    protected void gvCustomerUpdate_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvCustomerUpdate.PageIndex = e.NewPageIndex;
        GetCustomerInfo();
    }


    protected void btnAdd_Click(object sender, EventArgs e)
    {
        Response.Redirect("NewCustomer.aspx");
    }
    protected void cmdSearch_Click(object sender, ImageClickEventArgs e)
    {
        SearchFromList(txtSearch.Text.Trim());
    }
    public void SearchFromList(string instring)
    {
        try
        {
            if (Session["dt"] != null)
            {
                DataTable dt = (DataTable)Session["dt"];
                DataRow[] dr = dt.Select(
                    "CustomerName like '%" + instring +
                    "%' OR Surname LIKE '%" + instring +
                    "%' OR MobileNum LIKE '%" + instring +
                    "%' OR City LIKE '%" + instring +
                    "%' OR EmailId LIKE '%" + instring + "%'");
                if (dr.Count() > 0)
                {
                    gvCustomerUpdate.DataSource = dr.CopyToDataTable();
                    gvCustomerUpdate.DataBind();
                }
            }
        }
        catch (Exception ex)
        {

        }
    }
}