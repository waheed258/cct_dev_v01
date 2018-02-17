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
                    Session["CustomerId"] = null;
                    divCustomerDetails.Visible = false;
                    divHolderOrNot.Visible = false;
                    h5CreateLead.Visible = false;
                    h5CustomerInfo.Visible = false;
                    divNewLead.Visible = false;
                    GetServices();
                    GetClass();
                    divClassChk.Visible = false;
                    clextDeparture.StartDate = DateTime.Today;
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
            txtMobileNumber.Text = "";

            DataSet ds = customerBL.ValidateMobileNum(validateEntity);
            if (ds.Tables[0].Rows.Count > 0)
            {
                ShowHideControlsVerifyOnSuccess();
                Session["CustomerId"] = ds.Tables[0].Rows[0]["CustomerId"].ToString();
                txtMobileNumber.Text = ds.Tables[0].Rows[0]["MobileNum"].ToString();
                txtEmail.Text = ds.Tables[0].Rows[0]["EmailId"].ToString();
                txtCustomerName.Text = ds.Tables[0].Rows[0]["CustomerName"].ToString();
                txtSurName.Text = ds.Tables[0].Rows[0]["Surname"].ToString();
                txtCity.Text = ds.Tables[0].Rows[0]["City"].ToString();
            }
            else
            {
                ShowHideControlsOnVerifyOnFailure();
            }
        }
        catch { }
    }

    protected void ShowHideControlsVerifyOnSuccess()
    {
        try
        {
            divVerify.Visible = false;
            h5VerifyCustomer.Visible = false;
            divCustomerDetails.Visible = true;
            h5CreateLead.Visible = true;
            divNewLead.Visible = true;
            h5CustomerInfo.Visible = true;
            divHolderOrNot.Visible = false;
            divSaveCancel.Visible = false;
            txtMobileNumber.Enabled = false;
            txtEmail.Enabled = false;
            txtCustomerName.Enabled = false;
            txtSurName.Enabled = false;
            txtCity.Enabled = false;
            lblMessage.Text = "";
        }
        catch { }
    }
    protected void ShowHideControlsOnVerifyOnFailure()
    {
        try
        {
            divHolderOrNot.Visible = true;
        }
        catch { }
    }
    protected void rdbtnYes_CheckedChanged(object sender, EventArgs e)
    {
        try
        {
            h5CustomerInfo.Visible = true;
            divCustomerDetails.Visible = true;
            divSaveCancel.Visible = true;
            txtMobileNumber.Enabled = true;
            txtEmail.Enabled = true;
            txtCustomerName.Enabled = true;
            txtSurName.Enabled = true;
            txtCity.Enabled = true;
            txtMobileNumber.Text = "";
            txtEmail.Text = "";
            txtCustomerName.Text = "";
            txtSurName.Text = "";
            txtCity.Text = "";
            txtMobileNumber.Text = txtMobileNum.Text;
            txtEmail.Text = txtEmailId.Text;
            txtMobileNumber.Enabled = false;
        }
        catch { }
    }
    protected void rdbtnNo_CheckedChanged(object sender, EventArgs e)
    {
        try
        {
            h5CustomerInfo.Visible = true;
            divCustomerDetails.Visible = true;
            divSaveCancel.Visible = true;
            txtMobileNumber.Enabled = true;
            txtEmail.Enabled = true;
            txtCustomerName.Enabled = true;
            txtSurName.Enabled = true;
            txtCity.Enabled = true;
            ShowHideControlsOnVerifyOnFailure();
            txtMobileNumber.Text = "";
            txtEmail.Text = "";
            txtCustomerName.Text = "";
            txtSurName.Text = "";
            txtCity.Text = "";
            txtMobileNumber.Text = txtMobileNum.Text;
            txtEmail.Text = txtEmailId.Text;
            txtMobileNumber.Enabled = false;
        }
        catch { }
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            customerEntity.MobileNum = txtMobileNum.Text;
            customerEntity.EmailId = txtEmailId.Text;
            if (rdbtnYes.Checked)
            {
                customerEntity.NedbankAccountHolder = 1;
            }
            else
            {
                customerEntity.NedbankAccountHolder = 0;
            }
            customerEntity.CustomerName = txtCustomerName.Text;
            customerEntity.EmailId = txtEmail.Text;
            customerEntity.Surname = txtSurName.Text;
            customerEntity.City = txtCity.Text;
            int result = customerBL.CUDCustomerInfo(customerEntity, 'i');
            Session["IdentityValue"] = result;
            if (result > 0)
            {
                lblMessage.Text = "Customer Details Saved Successfully, Please Create Lead!";
                divCustomerDetails.Visible = false;
                h5CustomerInfo.Visible = false;
                txtMobileNum.Text = "";
                txtEmailId.Text = "";
                h5CreateLead.Visible = true;
                divNewLead.Visible = true;
                divVerify.Visible = false;
                h5VerifyCustomer.Visible = false;
            }
            else
            {
                lblMessage.Text = "Please try again!";
                lblMessage.ForeColor = System.Drawing.Color.Red;
                divCustomerDetails.Visible = true;
                h5CustomerInfo.Visible = true;
                txtMobileNum.Text = "";
                txtEmailId.Text = "";
            }
        }
        catch { }
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        try
        {
            lblNoOfPass.Visible = true;
            int a = Convert.ToInt32(ddlNoOfAdults.SelectedValue);
            int c = Convert.ToInt32(ddlNoOfChilds.SelectedValue);
            int i = Convert.ToInt32(ddlNoOfInfants.SelectedValue);
            j = a + c + i;
            if (i <= a)
            {
                if (a == 9)
                {
                    if (ddlNoOfChilds.SelectedIndex != 0 || ddlNoOfInfants.SelectedIndex != 0)
                        lblNoOfPass.Text = "No of Pax should not exceed 9";
                }
                else
                {
                    if (j > 9)
                        lblNoOfPass.Text = "No of Pax should not exceed 9";
                    else
                    {
                        ne.Destination = txtDestination.Text;

                        if (Session["IdentityValue"] == null)
                        {
                            ne.CustomerId = Convert.ToInt32(Session["CustomerId"].ToString());
                        }
                        else
                        {
                            ne.CustomerId = Convert.ToInt32(Session["IdentityValue"].ToString());
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
                        checkboxvalues();
                        ne.Services = status;
                        ne.AdditionalInfo = txtAdditionalInformation.Text;
                        checkboxvalues1();
                        ne.Class = status;
                        int result = nlb.CRUDClientRequest(ne, 'i');
                        if (result == 1)
                        {
                            lblMessage.Text = "Lead Details Saved Successfully!";
                            Response.Redirect("UserLeadList.aspx");
                        }
                    }
                }
            }
            else
            {
                lblNoOfPass.Text = "No of infants should not exceed adults";
            }
        }
        catch { }
    }

    protected void checkboxvalues()
    {
        try
        {
            foreach (ListItem item in this.chbklstAdditionalInfo.Items)
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
            foreach (ListItem item in this.chbklstClass.Items)
                if (item.Selected)
                    status += item + ",";
        }
        catch { }
    }

    protected void passengers()
    {
        try
        {
            lblNoOfPass.Visible = true;
            int a = Convert.ToInt32(ddlNoOfAdults.SelectedValue);
            int c = Convert.ToInt32(ddlNoOfChilds.SelectedValue);
            int i = Convert.ToInt32(ddlNoOfInfants.SelectedValue);
            j = a + c + i;
            if (i <= a)
            {
                if (a == 9)
                {
                    if (ddlNoOfChilds.SelectedIndex != 0 || ddlNoOfInfants.SelectedIndex != 0)
                        lblNoOfPass.Text = "No of Pax should not exceed 9";
                }
                else
                {
                    if (j > 9)
                        lblNoOfPass.Text = "No of Pax should not exceed 9";
                    else
                        txtNoOfPax.Text = j.ToString();
                }
            }
            else
                lblNoOfPass.Text = "No of infants should not exceed adults";
        }
        catch { }
    }
    protected void chbklstAdditionalInfo_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            if (chbklstAdditionalInfo.SelectedValue == "1")
            {
                divClassChk.Visible = true;
            }
            else
            {
                divClassChk.Visible = false;
            }
        }
        catch { }
    }
    protected void txtDepartureDate_TextChanged(object sender, EventArgs e)
    {
        try
        {
            txtReturnDate.Text = "";
            clextReturn.StartDate = Convert.ToDateTime(txtDepartureDate.Text, new CultureInfo("en-GB"));
        }
        catch { }
    }
}