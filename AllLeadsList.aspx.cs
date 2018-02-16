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
        ds = newLeadBL.GetLeadData();
        gvAllLeads.DataSource = ds;
        Session["dt"] = ds.Tables[0];
        gvAllLeads.DataBind();
    }

    protected void gvAllLeads_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "Edit")
        {
            int id = Convert.ToInt32(e.CommandArgument);
            GridViewRow row = gvAllLeads.Rows[id];
            int res = Convert.ToInt32(gvAllLeads.DataKeys[row.RowIndex].Values[0]);
            Response.Redirect("~/NewLead.aspx?id=" + Server.UrlEncode(res.ToString()) + "&isleadallocate=" + 0);
        }
    }
    protected void gvAllLeads_RowEditing(object sender, GridViewEditEventArgs e)
    {
        gvAllLeads.EditIndex = e.NewEditIndex;
        GetGridData();
    }
    protected void gvAllLeads_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {

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
            if (Session["dt"] != null)
            {
                DataTable dt = (DataTable)Session["dt"];
                DataRow[] dr = dt.Select(
                    "ClientReqId like '%" + instring +
                    "%' OR Destination LIKE '%" + instring +
                    "%' OR Convert(NoOfPax, 'System.String') LIKE '%" + instring +
                    "%' OR Convert(NoOfAdults, 'System.String') LIKE '%" + instring +
                    "%' OR Convert(NoOfInfants, 'System.String') LIKE '%" + instring +
                    "%' OR Convert(NoOfChilds, 'System.String') LIKE '%" + instring +
                    "%' OR Services LIKE '%" + instring +
                    "%' OR AdditionalInfo LIKE '%" + instring +
                    "%' OR Class LIKE '%" + instring + "%'");
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
}