﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BusinessLogic;
using BusinessObjects;
using System.Data.SqlClient;
using System.Data;
public partial class CustomerUpdate : System.Web.UI.Page
{
    CustomerBL customerBL = new CustomerBL();
    CustomerEntity customerEntity = new CustomerEntity();
    protected void Page_Load(object sender, EventArgs e)
    {
        Label mastertxt = (Label)Master.FindControl("lblProfile");
        mastertxt.Text = Session["Name"].ToString();
        if (!IsPostBack)
        {
            Session["id"] = Convert.ToInt32(Request.QueryString["id"].ToString());
            GetCustomerInfo();      
        }
    }
    private void GetCustomerInfo()
    {
        try
        {
            int customerid = Convert.ToInt32(Session["id"].ToString());
            DataSet ds = customerBL.GetCustomer(customerid);
            txtMobileNumber.Text = ds.Tables[0].Rows[0]["MobileNum"].ToString();
            txtCustomerName.Text = ds.Tables[0].Rows[0]["CustomerName"].ToString();
            txtSurName.Text = ds.Tables[0].Rows[0]["Surname"].ToString();
            txtEmail.Text = ds.Tables[0].Rows[0]["EmailId"].ToString();
            txtCity.Text = ds.Tables[0].Rows[0]["City"].ToString();
        }
        catch (Exception ex)
        {

        }
    }
    private void Clear()
    {
        txtMobileNumber.Text = "";
        txtCustomerName.Text = "";
        txtSurName.Text = "";
        txtEmail.Text = "";
        txtCity.Text = "";
    }
    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        customerEntity.CustomerId = Convert.ToInt32(Session["id"].ToString());
        customerEntity.MobileNum = txtMobileNumber.Text;
        customerEntity.CustomerName = txtCustomerName.Text;
        customerEntity.EmailId = txtEmail.Text;
        customerEntity.Surname = txtSurName.Text;
        customerEntity.City = txtCity.Text;
        customerEntity.NedbankAccountHolder = 1;
        int result = customerBL.CUDCustomerInfo(customerEntity, 'u');
        if (result > 0)
        {
            lblMessage.Text = "Details Updated Successfully!";
            Response.Redirect("CustomerInfoUpdateList.aspx");
        }
        else
        {
            lblMessage.Text = "Please try again!";
        }

        Clear();
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Clear();
    }
   
}