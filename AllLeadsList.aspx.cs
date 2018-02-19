using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BusinessLogic;
using System.Data;
using BusinessObjects;
using System.Text;

public partial class AllLeadsList : System.Web.UI.Page
{
    NewLeadBL newLeadBL = new NewLeadBL();
    DataSet ds = new DataSet();
    int id = 0;
    EncryptDecrypt encryptdecrypt = new EncryptDecrypt();
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
        catch { }
    }
    protected void GetGridData()
    {
        try
        {
            gvAllLeads.PageSize = int.Parse(ViewState["ps"].ToString());
            ds = newLeadBL.GetLeadData();
            gvAllLeads.DataSource = ds;
            ViewState["dt"] = ds.Tables[0];
            gvAllLeads.DataBind();
        }
        catch { }
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
                string encryptedparam = encryptdecrypt.Encrypt(res.ToString());
                string url = "NewLead.aspx?id=" + Server.UrlEncode(encryptedparam) + "&isleadallocate=" + 0;                
                string s = "window.open('" + url + "', '_blank');";
                ClientScript.RegisterStartupScript(this.GetType(), "script", s, true);
            }
        }
        catch { }
    }
    protected void gvAllLeads_RowEditing(object sender, GridViewEditEventArgs e)
    {
        try
        {
            gvAllLeads.EditIndex = e.NewEditIndex;
            GetGridData();
        }
        catch { }
    }
    protected void gvAllLeads_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        try
        {
            gvAllLeads.PageIndex = e.NewPageIndex;
            GetGridData();
        }
        catch { }
    }
    protected void gvAllLeads_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {

            //if (e.Row.RowType == DataControlRowType.DataRow)
            //{
            //    e.Row.Cells[9].Text = e.Row.Cells[9].Text.TrimEnd(',');
            //    e.Row.Cells[10].Text = e.Row.Cells[10].Text.TrimEnd(',');
            //}
        }
        catch { }
    }
    protected void btnAdd_Click(object sender, EventArgs e)
    {
        try
        {
            Response.Redirect("~/NewCustomer.aspx");
        }
        catch { }
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
    protected void imgbtnRefresh_Click(object sender, ImageClickEventArgs e)
    {
        try
        {
            Response.Redirect("AllLeadsList.aspx");
        }
        catch { }
    }
    protected void DropPage_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            ViewState["ps"] = DropPage.SelectedItem.ToString().Trim();
            GetGridData();
        }
        catch { }
    }
}