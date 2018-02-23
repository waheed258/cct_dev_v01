using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BusinessObjects;
using BusinessLogic;
using System.Data.SqlClient;
using System.Data;
using System.Globalization;

public partial class NewLead : System.Web.UI.Page
{
    string status = string.Empty;
    int j = 0;
    NewLeadEntity ne = new NewLeadEntity();
    NewLeadBL nlb = new NewLeadBL();
    DataTable dt = new DataTable();
    DataSet dataset = new DataSet();
    UserBL userbl = new UserBL();
    CustomerBL customerBL = new CustomerBL();
    CustomerEntity customerEntity = new CustomerEntity();
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
                    Session["CustomerId"] = null;
                    string decryptedparam = encryptdecrypt.Decrypt(Request.QueryString["id"].ToString());
                    string decryptedrefno = encryptdecrypt.Decrypt(Request.QueryString["refno"].ToString());
                    lblrefno.Text = " " + decryptedrefno;
                    ViewState["id"] = decryptedparam;
                    ViewState["isleadallocate"] = Request.QueryString["isleadallocate"].ToString();
                    if (Convert.ToInt32(ViewState["isleadallocate"].ToString()) == 0)
                    {
                        isleadaalocate.Visible = false;
                    }
                    else
                    {
                        isleadaalocate.Visible = true;
                        divOnlyAssigned.Visible = false;
                        divOnlyNotes.Visible = true;
                        divfollowupdate.Visible = false;
                    }
                    //divClassItems.Visible = false;

                    GetLeadStatus();
                    GetAssignedTo();
                    GetDetails();

                }
            }
            else
            {
                Response.Redirect("index.aspx");
            }
        }
        catch { }
    }

    protected void GetAssignedTo()
    {
        try
        {
            dataset = userbl.GetUsers(0);
            ddlAssignedTo.DataSource = dataset;
            ddlAssignedTo.DataTextField = "FirstName";
            ddlAssignedTo.DataValueField = "UserId";
            ddlAssignedTo.DataBind();
            ddlAssignedTo.Items.Insert(0, new ListItem("--Select User --", "-1"));
        }
        catch (Exception ex)
        {

        }
    }
    protected void GetLeadStatus()
    {
        try
        {
            dataset = nlb.GetLeadStatus();
            ddlLeadStatus.DataSource = dataset;
            ddlLeadStatus.DataTextField = "LeadStatus";
            ddlLeadStatus.DataValueField = "ID";
            ddlLeadStatus.DataBind();
            ddlLeadStatus.Items.Insert(0, new ListItem("--Select Lead Status --", "-1"));
        }
        catch (Exception ex)
        {

        }
    }
    private void Clear()
    {
        try
        {
            txtDepartingFrom.Text = "";
            txtDestination.Text = "";
            txtNoOfPax.Text = "";
            txtReturnDate.Text = "";
            txtDepartureDate.Text = "";
            ddlNoOfAdults.SelectedValue = "";
            ddlNoOfChilds.SelectedValue = "";
            ddlNoOfInfants.SelectedValue = "";
            chbklstAdditionalInfo.Items.Clear();
            chbklstClass.Items.Clear();
            if (Convert.ToInt32(ViewState["isleadallocate"].ToString()) == 0)
            {
                isleadaalocate.Visible = false;
            }
            else
            {
                isleadaalocate.Visible = true;
            }
        }
        catch { }
    }

    protected void GetDetails()
    {
        try
        {
            string id = ViewState["id"].ToString();
            DataSet ds = nlb.GetLeadDataById(id);
            txtDepartingFrom.Text = ds.Tables[0].Rows[0]["DepartingFrom"].ToString();
            txtDestination.Text = ds.Tables[0].Rows[0]["Destination"].ToString();
            txtNoOfPax.Text = ds.Tables[0].Rows[0]["NoOfPax"].ToString();
            Session["CustomerId"] = ds.Tables[0].Rows[0]["CustomerId"].ToString();
            txtReturnDate.Text = Convert.ToDateTime(ds.Tables[0].Rows[0]["ReturnDate"].ToString()).Date.ToString("dd-MM-yyyy");
            txtDepartureDate.Text = Convert.ToDateTime(ds.Tables[0].Rows[0]["DepartureDate"].ToString()).Date.ToString("dd-MM-yyyy");
            ddlNoOfAdults.SelectedValue = ds.Tables[0].Rows[0]["NoOfAdults"].ToString();
            ddlNoOfChilds.SelectedValue = ds.Tables[0].Rows[0]["NoOfChilds"].ToString();
            ddlNoOfInfants.SelectedValue = ds.Tables[0].Rows[0]["NoOfInfants"].ToString();
            if (ds.Tables[0].Rows[0]["FollowupDate"].ToString() != "")
            {
                txtFollowUpdate.Text = Convert.ToDateTime(ds.Tables[0].Rows[0]["FollowupDate"].ToString()).Date.ToString("dd-MM-yyyy");
            }
            else
            {
                txtFollowUpdate.Text = "";
            }
            if (ds.Tables[0].Rows[0]["Notes"].ToString() != "")
            {
                txtNotes.Text = ds.Tables[0].Rows[0]["Notes"].ToString();
            }
            else
            {
                txtNotes.Text = "";
            }

            if (ds.Tables[0].Rows[0]["AssignedId"].ToString() != "")
            {
                ddlAssignedTo.SelectedValue = ds.Tables[0].Rows[0]["AssignedId"].ToString();
            }

            ddlLeadStatus.SelectedValue = ds.Tables[0].Rows[0]["LeadStatus"].ToString();
            if (ddlLeadStatus.SelectedValue == "4")
            {
                divfollowupdate.Visible = true;
                divOnlyAssigned.Visible = false;
            }
            if (ddlLeadStatus.SelectedValue == "2")
            {
                divOnlyAssigned.Visible = true;
                divfollowupdate.Visible = false;
            }
            string Services = ds.Tables[0].Rows[0]["Services"].ToString().TrimEnd(',');
            if (Services.Contains("Flight"))
            {
                chbklstClass.SelectedIndex = 0;
                //cvFlightClass.Enabled = true;
            }
            foreach (ListItem li in chbklstAdditionalInfo.Items)
            {
                if (Services.Contains(li.Text))
                {
                    li.Selected = true;
                }
            }
            txtAdditionalInformation.Text = ds.Tables[0].Rows[0]["AdditionalInfo"].ToString();
            string classtype = ds.Tables[0].Rows[0]["Class"].ToString().TrimEnd(',');
            string[] arrayClass = classtype.Split(',');
            if (chbklstClass.SelectedIndex == 0)
            {
                divClassItems.Visible = true;
                foreach (ListItem li in chbkClass.Items)
                {
                    foreach (string type in arrayClass)
                    {
                        if (li.Text == type)
                        {
                            li.Selected = true;
                        }
                    }
                }
            }

            int customerid = Convert.ToInt32(Session["CustomerId"].ToString());
            DataSet ds1 = customerBL.GetCustomerInLead(customerid);
            txtCustomerName.Text = ds1.Tables[0].Rows[0]["CustomerName"].ToString();
            txtSurName.Text = ds1.Tables[0].Rows[0]["Surname"].ToString();
            txtMobileNumber.Text = ds1.Tables[0].Rows[0]["MobileNum"].ToString();
            txtEmail.Text = ds1.Tables[0].Rows[0]["EmailId"].ToString();
            txtCity.Text = ds1.Tables[0].Rows[0]["City"].ToString();
        }
        catch { }
    }


    protected void checkboxvalues()
    {
        try
        {
            if (chbklstClass.SelectedValue == "1")
            {
                status += chbklstClass.SelectedItem.Text + ",";
            }
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
            foreach (ListItem item in this.chbkClass.Items)
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
    protected void btnUpdate_Click(object sender, EventArgs e)
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
                    {
                        lblNoOfPass.Text = "No of Pax should not exceed 9";
                    }
                    else
                    {
                        string id = ViewState["id"].ToString();
                        ne.ClientReqId = id;
                        ne.CustomerId = Convert.ToInt32(Session["CustomerId"].ToString());
                        ne.Destination = txtDestination.Text;
                        ne.DepartingFrom = txtDepartingFrom.Text;
                        ne.DepartureDate = txtDepartureDate.Text;
                        ne.ReturnDate = txtReturnDate.Text;
                        ne.NoOfPax = j;
                        ne.NoOfAdults = Convert.ToInt32(ddlNoOfAdults.SelectedValue);
                        ne.NoOfChilds = Convert.ToInt32(ddlNoOfChilds.SelectedValue);
                        ne.NoOfInfants = Convert.ToInt32(ddlNoOfInfants.SelectedValue);
                        ne.AssignedTo = Convert.ToInt32(ddlAssignedTo.SelectedValue);
                        ne.LeadStatus = Convert.ToInt32(ddlLeadStatus.SelectedValue);
                        ne.UpdatedBy = Convert.ToInt32(Session["LoginId"].ToString());
                        ne.FollowupDate = txtFollowUpdate.Text;
                        ne.Notes = txtNotes.Text;
                        ne.CreatedBy = 0;
                        ne.AdditionalInfo = txtAdditionalInformation.Text;                        
                        checkboxvalues();
                        ne.Services = status;
                        checkboxvalues1();
                        ne.Class = status;
                        int result = nlb.CRUDClientRequest(ne, 'u');
                        if (result == 1)
                        {
                            lblMessage.Text = "Details updated successfuly!";
                            if (Convert.ToInt32(ViewState["isleadallocate"].ToString()) == 0)
                            {
                                Response.Redirect("~/AllLeadsList.aspx");
                            }
                            else
                            {
                                Response.Redirect("~/LeadAllocation.aspx");
                            }
                            Clear();

                        }
                        else
                        {
                            lblMessage.Text = "Please try again!";
                        }

                    }
                }
            }
            else
                lblNoOfPass.Text = "No of infants should not exceed adults";
        }
        catch { }
    }

    protected void ddlLeadStatus_SelectedIndexChanged(object sender, EventArgs e)
    {
         if (ddlLeadStatus.SelectedValue == "2")
         {
             divOnlyNotes.Visible = true;
             divOnlyAssigned.Visible = true;
             divfollowupdate.Visible = false;
         }
         else if (ddlLeadStatus.SelectedValue == "4")
         {
             divOnlyNotes.Visible = true;
             divOnlyAssigned.Visible = false;
             divfollowupdate.Visible = true;
             txtFollowUpdate.Text = "";
         }
         else
         {
             divfollowupdate.Visible = false;
             divOnlyAssigned.Visible = false;
             divOnlyNotes.Visible = true;
         }
    }
    //protected void chbklstClass_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    if (chbklstClass.Items[0].Selected == true)
    //        cvFlightClass.Enabled = true;
    //    else
    //        cvFlightClass.Enabled = false;
    //}
    
}