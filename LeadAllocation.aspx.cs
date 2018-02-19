using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BusinessLogic;
using System.Data;
using BusinessObjects;

public partial class LeadAllocation : System.Web.UI.Page
{
    NewLeadBL newLeadBL = new NewLeadBL();
    DataSet ds = new DataSet();
    EncryptDecrypt encryptdecrypt = new EncryptDecrypt();
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
                    if (Session["UserType"].ToString() == "4" || Session["UserType"].ToString() == "5" || Session["UserType"].ToString() == "6")
                    {
                        lblpermissions.Text = "";
                        divLeadAllocation.Visible = true;
                        divmessage.Visible = false;
                        GetGridData();
                    }
                    else
                    {
                        lblpermissions.Text = "Invalid Permissions";
                        divLeadAllocation.Visible = false;
                        divmessage.Visible = true;
                    }
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
            gvLeadData.PageSize = int.Parse(ViewState["ps"].ToString());
            ds = newLeadBL.GetLeadData();
            gvLeadData.DataSource = ds;
            ViewState["dt"] = ds.Tables[0];
            gvLeadData.DataBind();
        }
        catch { }
    }   
   
    protected void gvLeadData_RowEditing1(object sender, GridViewEditEventArgs e)
    {
        try
        {
            gvLeadData.EditIndex = e.NewEditIndex;
            GetGridData();
        }
        catch { }
    }
    protected void gvLeadData_RowDataBound1(object sender, GridViewRowEventArgs e)
    {
        try
        {
            //if (e.Row.RowType == DataControlRowType.DataRow)
            //{
            //    e.Row.Cells[6].Text = e.Row.Cells[6].Text.TrimEnd(',');
            //    e.Row.Cells[7].Text = e.Row.Cells[7].Text.TrimEnd(',');
            //}
        }
        catch { }
    }
    protected void gvLeadData_RowCommand1(object sender, GridViewCommandEventArgs e)
    {
        try
        {
            if (e.CommandName == "Edit")
            {
                int id = Convert.ToInt32(e.CommandArgument);
                GridViewRow row = gvLeadData.Rows[id];
                int res = Convert.ToInt32(gvLeadData.DataKeys[row.RowIndex].Values[0]);
                string encryptedparam = encryptdecrypt.Encrypt(res.ToString());
                string url = "NewLead.aspx?id=" + Server.UrlEncode(encryptedparam) + "&isleadallocate=" + 1;
                string s = "window.open('" + url + "', '_blank');";
                ClientScript.RegisterStartupScript(this.GetType(), "script", s, true);
            }
        }
        catch { }
    }
    protected void btnAdd_Click1(object sender, EventArgs e)
    {
        try
        {
            Response.Redirect("NewCustomer.aspx");
        }
        catch { }
    }
    protected void gvLeadData_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        try
        {
            gvLeadData.PageIndex = e.NewPageIndex;
            GetGridData();
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
                    gvLeadData.DataSource = dr.CopyToDataTable();
                    gvLeadData.DataBind();
                }
            }
        }
        catch (Exception ex)
        {

        }
    }
    protected void imgbtnRefresh_Click(object sender, ImageClickEventArgs e)
    {
        try
        {
            Response.Redirect("LeadAllocation.aspx");
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