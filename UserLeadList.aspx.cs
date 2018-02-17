using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BusinessLogic;
using System.Data;
using BusinessObjects;

public partial class UserLeadList : System.Web.UI.Page
{
    NewLeadBL newLeadBl = new NewLeadBL();
    DataSet ds = new DataSet();
    int id = 0;
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
                    divUserList.Visible = true;
                    divmessage.Visible = false;
                    GetGridData();

                }
            }
            else
            {
                Response.Redirect("index.aspx");
            }
        }
        catch
        {

        }
    }

    protected void GetGridData()
    {
        try
        {
            gvUserList.PageSize = int.Parse(ViewState["ps"].ToString());
            int CreatedBy = Convert.ToInt32(Session["LoginId"].ToString());
            ds = newLeadBl.GetLeadByUserId(CreatedBy);
            gvUserList.DataSource = ds;
            ViewState["dt"] = ds.Tables[0];
            gvUserList.DataBind();

        }
        catch
        {

        }
    }
    protected void gvUserList_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {
            if (e.CommandName == "EditUser")
            {
                int id = Convert.ToInt32(e.CommandArgument);
                GridViewRow row = gvUserList.Rows[id];
                int res = Convert.ToInt32(gvUserList.DataKeys[row.RowIndex].Values[0]);
                Response.Redirect("~/NewLead.aspx?id=" + Server.UrlEncode(res.ToString()) + "&isleadallocate=" + 0);
            }
        }
        catch { }
    }
    protected void gvUserList_RowEditing(object sender, GridViewEditEventArgs e)
    {
        try
        {
            gvUserList.EditIndex = e.NewEditIndex;
            GetGridData();
        }
        catch
        {

        }
    }
    protected void btnAdd_Click(object sender, EventArgs e)
    {
        try
        {
            Response.Redirect("~/LeadAllocation.aspx");
        }
        catch
        {

        }
        
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
            if (ViewState["dt"] != null)
            {
                DataTable dt = (DataTable)ViewState["dt"];
                DataRow[] dr = dt.Select(
                      "CLIENTREQID like '%" + instring +
                    "%' OR Convert(CREATEDDATE, 'System.String') LIKE '%" + instring +
                    "%' OR CREATEDBY LIKE '%" + instring +
                    "%' OR ASSIGNEDTO LIKE '%" + instring +
                    "%' OR LEADSTATUS LIKE '%" + instring + "%'");
                if (dr.Count() > 0)
                {
                    gvUserList.DataSource = dr.CopyToDataTable();
                    gvUserList.DataBind();
                }
            }
        }
        catch
        {

        }
    }
    protected void gvUserList_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        try
        {
            gvUserList.PageIndex = e.NewPageIndex;
            GetGridData();
        }
        catch { }
       
    }
    protected void imgbtnRefresh_Click(object sender, ImageClickEventArgs e)
    {
        try
        {
            Response.Redirect("UserLeadList.aspx");
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