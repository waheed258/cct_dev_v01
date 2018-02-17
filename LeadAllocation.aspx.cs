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
    int id = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["Name"] != null)
        {
            Label mastertxt = (Label)Master.FindControl("lblProfile");
            mastertxt.Text = Session["Name"].ToString();
            if (!IsPostBack)
            {
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
    protected void GetGridData()
    {
        ds = newLeadBL.GetLeadData();
        gvLeadData.DataSource = ds;
        Session["dt"] = ds.Tables[0];
        gvLeadData.DataBind();
    }   
   
    protected void gvLeadData_RowEditing1(object sender, GridViewEditEventArgs e)
    {
        gvLeadData.EditIndex = e.NewEditIndex;
        GetGridData();
    }
    protected void gvLeadData_RowDataBound1(object sender, GridViewRowEventArgs e)
    {
        //if (e.Row.RowType == DataControlRowType.DataRow)
        //{
        //    e.Row.Cells[6].Text = e.Row.Cells[6].Text.TrimEnd(',');
        //    e.Row.Cells[7].Text = e.Row.Cells[7].Text.TrimEnd(',');
        //}
    }
    protected void gvLeadData_RowCommand1(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "Edit")
        {
            int id = Convert.ToInt32(e.CommandArgument);
            GridViewRow row = gvLeadData.Rows[id];
            int res = Convert.ToInt32(gvLeadData.DataKeys[row.RowIndex].Values[0]);
            Response.Redirect("~/NewLead.aspx?id=" + Server.UrlEncode(res.ToString()) + "&isleadallocate=" + 1);
        }
    }
    protected void btnAdd_Click1(object sender, EventArgs e)
    {
        Response.Redirect("NewCustomer.aspx");
    }
    protected void gvLeadData_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvLeadData.PageIndex = e.NewPageIndex;
        GetGridData();
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
        Response.Redirect("LeadAllocation.aspx");
    }
}