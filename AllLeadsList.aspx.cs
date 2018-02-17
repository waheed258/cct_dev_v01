using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BusinessLogic;
using System.Data;
using BusinessObjects;

public partial class AllLeadsList : System.Web.UI.Page
{
    NewLeadBL newLeadBL = new NewLeadBL();
    DataSet ds = new DataSet();
    int id = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["Name"] != null)
        {
            Label mastertxt = (Label)Master.FindControl("lblProfile");
            mastertxt.Text = Session["Name"].ToString();
            if (!IsPostBack)
            {
                lblpermissions.Text = "";
                divAllLeadsList.Visible = true;
                divmessage.Visible = false;
                GetGridData();
            }
        }
        else
        {
            Response.Redirect("index.aspx");
        }
    }
    protected void GetGridData()
    {
        try
        {
            ds = newLeadBL.GetLeadData();
            gvAllLeads.DataSource = ds;
            ViewState["dt"] = ds.Tables[0];
            gvAllLeads.DataBind();
        }
        catch (Exception ex)
        {

        }
    }

    protected void gvAllLeads_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {
            if (e.CommandName == "Edit")
            {
                int id = Convert.ToInt32(e.CommandArgument);
                GridViewRow row = gvAllLeads.Rows[id];
                int res = Convert.ToInt32(gvAllLeads.DataKeys[row.RowIndex].Values[0]);
                Response.Redirect("~/NewLead.aspx?id=" + Server.UrlEncode(res.ToString()) + "&isleadallocate=" + 0);
            }
        }
        catch (Exception ex)
        { 
        
        }
    }
    protected void gvAllLeads_RowEditing(object sender, GridViewEditEventArgs e)
    {
        gvAllLeads.EditIndex = e.NewEditIndex;
        GetGridData();
    }
    protected void gvAllLeads_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvAllLeads.PageIndex = e.NewPageIndex;
        GetGridData();
    }
    protected void gvAllLeads_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        //if (e.Row.RowType == DataControlRowType.DataRow)
        //{
        //    e.Row.Cells[9].Text = e.Row.Cells[9].Text.TrimEnd(',');
        //    e.Row.Cells[10].Text = e.Row.Cells[10].Text.TrimEnd(',');
        //}
    }
    protected void btnAdd_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/NewCustomer.aspx");
    }

    public void SearchFromList(string instring)
    {
        try
        {
            if (ViewState["dt"] != null)
            {
                DataTable dt = (DataTable)ViewState["dt"];
                DataRow[] dr = dt.Select(
                     "CLIENTREQID like '%" + instring +
                    "%' OR Convert(CREATEDDATE, 'System.String') LIKE '%" + instring +
                    "%' OR CREATEDBY LIKE '%" + instring +
                    "%' OR ASSIGNEDTO LIKE '%" + instring +
                    "%' OR STATUS LIKE '%" + instring + "%'");
                if (dr.Count() > 0)
                {
                    gvAllLeads.DataSource = dr.CopyToDataTable();
                    gvAllLeads.DataBind();
                }
            }
        }
        catch (Exception ex)
        {

        }
    }

    protected void cmdSearch_Click(object sender, ImageClickEventArgs e)
    {
        SearchFromList(txtSearch.Text.Trim());
    }
    protected void imgbtnRefresh_Click(object sender, ImageClickEventArgs e)
    {
        Response.Redirect("AllLeadsList.aspx");
    }
}