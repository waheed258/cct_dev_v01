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
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["Name"] != null)
        {
            Label mastertxt = (Label)Master.FindControl("lblProfile");
            mastertxt.Text = Session["Name"].ToString();
            if (!IsPostBack)
            {
                divclass.Visible = false;
                Session["CustomerId"] = null;
                Session["id"] = Request.QueryString["id"].ToString();
                Session["isleadallocate"] = Request.QueryString["isleadallocate"].ToString();
                if (Convert.ToInt32(Session["isleadallocate"].ToString()) == 0)
                {
                    isleadaalocate.Visible = false;
                }
                else
                {
                    isleadaalocate.Visible = true;
                }
                GetClass();
                GetDetails();
                GetLeadStatus();
                GetAssignedTo();

                clextDeparture.StartDate = DateTime.Today;
            }
        }
        else
        {
            Response.Redirect("index.aspx");
        }
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
    }

    protected void GetDetails()
    {
        string id = Session["id"].ToString();
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
        if (ds.Tables[0].Rows[0]["AssignedTo"].ToString() != "")
        {
            ddlAssignedTo.SelectedValue = ds.Tables[0].Rows[0]["AssignedTo"].ToString();
        }

        ddlLeadStatus.SelectedValue = ds.Tables[0].Rows[0]["LeadStatus"].ToString();
        string Services = ds.Tables[0].Rows[0]["Services"].ToString().TrimEnd(',');
        GetServices();
        foreach (ListItem li in chbklstAdditionalInfo.Items)
        {
            if (Services.Contains(li.Text))
            {
                li.Selected = true;
            }
        }
        txtAdditionalInformation.Text = ds.Tables[0].Rows[0]["AdditionalInfo"].ToString();
        string classtype = ds.Tables[0].Rows[0]["Class"].ToString().TrimEnd(',');
        if (chbklstAdditionalInfo.SelectedIndex == 0)
        {
            GetClass();
            divclass.Visible = true;
            foreach (ListItem li in chbklstClass.Items)
            {
                if(classtype.Contains(li.Text))
                {
                    li.Selected = true;
                }
            }
        }

    }
    protected void btnUpdate_Click(object sender, EventArgs e)
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
                    string id = Session["id"].ToString();
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
                    ne.CreatedBy = 0;
                    ne.AdditionalInfo = txtAdditionalInformation.Text;
                    NewLead nl = new NewLead();
                    checkboxvalues();
                    ne.Services = status;
                    checkboxvalues1();
                    ne.Class = status;
                    int result = nlb.CRUDClientRequest(ne, 'u');
                    if (result == 1)
                    {
                        lblMessage.Text = "Details updated successfuly!";
                        if (Convert.ToInt32(Session["isleadallocate"].ToString()) == 0)
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

    protected void GetServices()
    {

        dt = nlb.GetSpecialServices();
        chbklstAdditionalInfo.DataSource = dt;
        chbklstAdditionalInfo.DataTextField = "Services";
        chbklstAdditionalInfo.DataValueField = "SpecialServicesId";
        chbklstAdditionalInfo.DataBind();
    }
    protected void GetClass()
    {
        dt = nlb.GetClass();
        chbklstClass.DataSource = dt;
        chbklstClass.DataTextField = "ClassType";
        chbklstClass.DataValueField = "ClassId";
        chbklstClass.DataBind();
    }


    protected void checkboxvalues()
    {
        foreach (ListItem item in this.chbklstAdditionalInfo.Items)
            if (item.Selected)
                status += item + ",";
    }

    protected void checkboxvalues1()
    {
        status = string.Empty;
        foreach (ListItem item in this.chbklstClass.Items)
            if (item.Selected)
                status += item + ",";
    }
    protected void passengers()
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

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/NewLead.aspx");
    }
    protected void chbklstAdditionalInfo_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (chbklstAdditionalInfo.SelectedValue == "1")
        {
            chbklstClass.ClearSelection();
            divclass.Visible = true;
        }
        else
        {
            chbklstClass.ClearSelection();
            divclass.Visible = false;
        }
    }
    protected void txtDepartureDate_TextChanged(object sender, EventArgs e)
    {
        txtReturnDate.Text = "";
        clextReturn.StartDate = Convert.ToDateTime(txtDepartureDate.Text, new CultureInfo("en-GB"));
    }
}