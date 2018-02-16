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
        if (Session["Name"] != null)
        {
            Label mastertxt = (Label)Master.FindControl("lblProfile");
            mastertxt.Text = Session["Name"].ToString();
            if (!IsPostBack)
            {
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

    protected void GetGridData()
    {
        try
        {
            int CreatedBy = Convert.ToInt32(Session["LoginId"].ToString());
            ds = newLeadBl.GetLeadByUserId(CreatedBy);
            gvUserList.DataSource = ds;
            gvUserList.DataBind();

        }
        catch (Exception ex)
        {

        }
    }
    protected void gvUserList_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "EditUser")
        {
            int id = Convert.ToInt32(e.CommandArgument);
            GridViewRow row = gvUserList.Rows[id];
            int res = Convert.ToInt32(gvUserList.DataKeys[row.RowIndex].Values[0]);
            Response.Redirect("~/NewLead.aspx?id=" + Server.UrlEncode(res.ToString()) + "&isleadallocate=" + 0);
        }
    }
    protected void gvUserList_RowEditing(object sender, GridViewEditEventArgs e)
    {
        gvUserList.EditIndex = e.NewEditIndex;
        GetGridData();
    }
    protected void btnAdd_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/LeadAllocation.aspx");
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
                    gvUserList.DataSource = dr.CopyToDataTable();
                    gvUserList.DataBind();
                }
            }
        }
        catch (Exception ex)
        {

        }
    }
    protected void gvUserList_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvUserList.PageIndex = e.NewPageIndex;
        GetGridData();
    }
}