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
        try
        {
            if (Session["Name"] != null)
            {
                Label mastertxt = (Label)Master.FindControl("lblProfile");
                mastertxt.Text = Session["Name"].ToString();
                if (!IsPostBack)
                {
                    ViewState["ps"] = 10;
                    GetCustomerInfo();
                }
            }
            else
            {
                Response.Redirect("index.aspx");
            }
        }
        catch { }
    }

    private void GetCustomerInfo()
    {
        try
        {
            gvCustomerUpdate.PageSize = int.Parse(ViewState["ps"].ToString());
            DataSet ds = customerBl.GetCustomer(0);
            gvCustomerUpdate.DataSource = ds;
            Session["dt"] = ds.Tables[0];
            gvCustomerUpdate.DataBind();

        }
        catch{ }
    }
    protected void gvCustomerUpdate_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {
            if (e.CommandName == "Edit")
            {
                int id = Convert.ToInt32(e.CommandArgument);
                GridViewRow row = gvCustomerUpdate.Rows[id];
                Response.Redirect("~/CustomerUpdate.aspx?id=" + row.Cells[0].Text);
            }
        }
        catch { }
    }

    protected void gvCustomerUpdate_RowEditing(object sender, GridViewEditEventArgs e)
    {
        try
        {
            gvCustomerUpdate.EditIndex = e.NewEditIndex;
            GetCustomerInfo();
        }
        catch { }
    }
    protected void gvCustomerUpdate_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        try
        {
            gvCustomerUpdate.PageIndex = e.NewPageIndex;
            GetCustomerInfo();
        }
        catch { }
    }


    protected void btnAdd_Click(object sender, EventArgs e)
    {
        try
        {
            Response.Redirect("NewCustomer.aspx");
        }
        catch { }
    }
    protected void cmdSearch_Click(object sender, ImageClickEventArgs e)
    {
        try
        {
            SearchFromList(txtSearch.Text.Trim());
        }
        catch { }
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
        catch  {}
    }
    protected void imgbtnRefresh_Click(object sender, ImageClickEventArgs e)
    {
        try
        {
            Response.Redirect("CustomerInfoUpdateList.aspx");
        }
        catch { }
    }
    protected void DropPage_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            ViewState["ps"] = DropPage.SelectedItem.ToString().Trim();
            GetCustomerInfo();
        }
        catch { }
    }
}