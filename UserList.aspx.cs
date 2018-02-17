﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BusinessLogic;
using System.Data;
using BusinessObjects;
public partial class UserList : System.Web.UI.Page
{
    UserBL userBL = new UserBL();
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
                    if (Session["UserType"].ToString() == "4" || Session["UserType"].ToString() == "5" || Session["UserType"].ToString() == "6")
                    {
                        lblpermissions.Text = "";
                        divUserList.Visible = true;
                        divmessage.Visible = false;
                        GetGridData();
                    }
                    else
                    {
                        lblpermissions.Text = "Invalid Permissions";
                        divUserList.Visible = false;
                        divmessage.Visible = true;
                    }
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
            ds = ds = userBL.GetUsers(0);
            gvUserList.DataSource = ds;
            Session["dt"] = ds.Tables[0];
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
            if (e.CommandName == "Edit")
            {
                int id = Convert.ToInt32(e.CommandArgument);
                GridViewRow row = gvUserList.Rows[id];
                Response.Redirect("~/UpdateUser.aspx?id=" + row.Cells[0].Text);
            }
        }
        catch
        {

        }
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
            Response.Redirect("~/NewUser.aspx");
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
        catch
        {

        }
        
    }
    public void SearchFromList(string instring)
    {
        try
        {
            if (Session["dt"] != null)
            {
                DataTable dt = (DataTable)Session["dt"];
                DataRow[] dr = dt.Select(
                    "Convert(UserId, 'System.String') like '%" + instring +
                    "%' OR FirstName LIKE '%" + instring +
                    "%' OR LastName LIKE '%" + instring +
                    "%' OR MobileNumber LIKE '%" + instring +
                    "%' OR PhoneNumber LIKE '%" + instring +
                    "%' OR EmailId LIKE '%" + instring +
                    "%' OR Location LIKE '%" + instring +
                    "%' OR UType LIKE '%" + instring +
                    "%' OR Ustatus LIKE '%" + instring + "%'");
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

    protected void imgbtnRefresh_Click(object sender, ImageClickEventArgs e)
    {
        try
        {
            Response.Redirect("UserList.aspx");
        }
        catch
        {

        }
        
    }
}