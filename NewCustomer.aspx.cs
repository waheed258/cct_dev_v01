using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BusinessLogic;
using BusinessObjects;
using System.Data.SqlClient;
using System.Data;
using System.Globalization;

public partial class NewCustomer : System.Web.UI.Page
{
    CustomerBL customerBL = new CustomerBL();
    CustomerEntity customerEntity = new CustomerEntity();
    ValidateEntity validateEntity = new ValidateEntity();
    DataTable dt = new DataTable();
    NewLeadBL nlb = new NewLeadBL();
    NewLeadEntity ne = new NewLeadEntity();
    string status = string.Empty;
    int j = 0;
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
                    txtMobileNum.Attributes.Add("onKeyPress", "doClick('" + btnValidate.ClientID + "',event)");
                    Session["CustomerId"] = null;
                    divCustomerDetails.Visible = false;
                    h5CustomerInfo.Visible = false;
                    txtCustomerName.Enabled = false;
                    txtSurName.Enabled = false;
                    txtCity.Enabled = false;
                }
            }
            else
            {
                Response.Redirect("index.aspx");
            }
        }
        catch { }
    }
    protected void GetServices()
    {
        try
        {
            dt = nlb.GetSpecialServices();
            chbklstAdditionalInfo.DataSource = dt;
            chbklstAdditionalInfo.DataTextField = "Services";
            chbklstAdditionalInfo.DataValueField = "SpecialServicesId";
            chbklstAdditionalInfo.DataBind();
        }
        catch { }
    }
    protected void GetClass()
    {
        try
        {
            dt = nlb.GetClass();
            chbklstClass.DataSource = dt;
            chbklstClass.DataTextField = "ClassType";
            chbklstClass.DataValueField = "ClassId";
            chbklstClass.DataBind();
        }
        catch { }
    }
    protected void btnValidate_Click1(object sender, EventArgs e)
    {
        try
        {
            validateEntity.MobileNo = txtMobileNum.Text;
            validateEntity.Email = txtEmailId.Text;
            lblMessage.Text = "";
            //txtMobileNumber.Text = "";

            DataSet ds = customerBL.ValidateMobileNum(validateEntity);
            if (ds.Tables[0].Rows.Count > 0)
            {
                ViewState["IsCustomerData"] = ds;

                //divVerify.Visible = false;
                //h5VerifyCustomer.Visible = false;
                divCustomerDetails.Visible = true;
                h5CustomerInfo.Visible = true;
                txtMobileNum.Enabled = false;
                txtEmailId.Enabled = false;
                txtCustomerName.Enabled = false;
                txtSurName.Enabled = false;
                txtCity.Enabled = false;
                lblMessage.Text = "";

                Session["CustomerId"] = ds.Tables[0].Rows[0]["CustomerId"].ToString();
                txtMobileNum.Text = ds.Tables[0].Rows[0]["MobileNum"].ToString();
                txtEmailId.Text = ds.Tables[0].Rows[0]["EmailId"].ToString();
                txtCustomerName.Text = ds.Tables[0].Rows[0]["CustomerName"].ToString();
                txtSurName.Text = ds.Tables[0].Rows[0]["Surname"].ToString();
                txtCity.Text = ds.Tables[0].Rows[0]["City"].ToString();
            }
            else
            {
                txtCustomerName.Enabled = true;
                txtSurName.Enabled = true;
                txtCity.Enabled = false;
                divCustomerDetails.Visible = true;
                h5CustomerInfo.Visible = true;               
                txtCustomerName.Enabled = true;
                txtSurName.Enabled = true;
                txtCity.Enabled = true;
                lblMessage.Text = "";
            }
        }
        catch { }
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        try
        {
            if (ViewState["IsCustomerData"] == null)
            {
                customerEntity.MobileNum = txtMobileNum.Text;
                customerEntity.EmailId = txtEmailId.Text;
                customerEntity.NedbankAccountHolder = 1;
                customerEntity.CustomerName = txtCustomerName.Text;
                customerEntity.EmailId = txtEmailId.Text;
                customerEntity.Surname = txtSurName.Text;
                customerEntity.City = txtCity.Text;
                int result = customerBL.CUDCustomerInfo(customerEntity, 'i');
                ViewState["IdentityValue"] = result;
            }
            lblNoOfPass.Visible = true;
            //int a = Convert.ToInt32(ddlNoOfAdults.SelectedValue);
            //int c = Convert.ToInt32(ddlNoOfChilds.SelectedValue);
            //int i = Convert.ToInt32(ddlNoOfInfants.SelectedValue);
            //j = a + c + i;
            //if (i <= a)
            //{
            //    if (a == 9)
            //    {
            //        if (ddlNoOfChilds.SelectedIndex != 0 || ddlNoOfInfants.SelectedIndex != 0)
            //            lblNoOfPass.Text = "No of Pax should not exceed 9";
            //    }
            //    else
            //    {
            //        if (j > 9)
            //            lblNoOfPass.Text = "No of Pax should not exceed 9";
            //        else
            //        {
                        ne.Destination = txtDestination.Text;

                        if (ViewState["IdentityValue"] == null)
                        {
                            ne.CustomerId = Convert.ToInt32(Session["CustomerId"].ToString());
                        }
                        else
                        {
                            ne.CustomerId = Convert.ToInt32(ViewState["IdentityValue"].ToString());
                        }
                        ne.DepartingFrom = txtDepartingFrom.Text;
                        ne.DepartureDate = txtDepartureDate.Text;
                        ne.ReturnDate = txtReturnDate.Text;
                        ne.NoOfPax = j;
                        ne.NoOfAdults = Convert.ToInt32(ddlNoOfAdults.SelectedValue);
                        ne.NoOfChilds = Convert.ToInt32(ddlNoOfChilds.SelectedValue);
                        ne.NoOfInfants = Convert.ToInt32(ddlNoOfInfants.SelectedValue);
                        ne.CreatedBy = Convert.ToInt32(Session["LoginId"].ToString());
                        ne.UpdatedBy = 0;
                        ne.LeadStatus = 0;
                        ne.AssignedTo = 0;
                        ne.FollowupDate = "";
                        ne.Notes = "";
                        checkboxvalues();
                        ne.Services = status;
                        ne.AdditionalInfo = txtAdditionalInformation.Text;
                        checkboxvalues1();
                        ne.Class = status;
                        int leadresult = nlb.CRUDClientRequest(ne, 'i');
                        if (leadresult == 1)
                        {
                            lblMessage.Text = "Lead Details Saved Successfully!";
                            Response.Redirect("UserLeadList.aspx");
                        }
            //        }
            //    }
            //}
            //else
            //{
            //    lblNoOfPass.Text = "No of infants should not exceed adults";
            //}

        }
        catch { }
    }

    protected void checkboxvalues()
    {
        try
        {
            if (chbklstAdditionalInfo.SelectedValue == "0")
            {
                status += chbklstAdditionalInfo.SelectedItem.Text + ",";
            }
            foreach (ListItem item in this.chbklstClass.Items)
                if (item.Selected)
                    status += item + ",";
        }
        catch { }
    }

    protected void checkboxvalues1()
    {
        try
        {
            status = string.Empty;
            foreach (ListItem item in this.chbkClass.Items)
                if (item.Selected)
                    status += item + ",";
        }
        catch { }
    }
    protected void Button2_Click(object sender, EventArgs e)
    {
        Response.Redirect("NewCustomer.aspx");
    }
    protected void chbklstAdditionalInfo_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (chbklstAdditionalInfo.Items[0].Selected == true)
            cvFlightClass.Enabled = true;
        else
            cvFlightClass.Enabled = false;


    }
}