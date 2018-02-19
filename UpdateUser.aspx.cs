using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BusinessObjects;
using BusinessLogic;
using System.Data;
using System.Security.Cryptography;
using System.IO;
using System.Text;
public partial class UpdateUser : System.Web.UI.Page
{
    DataSet ds = new DataSet();
    UserBL userbl = new UserBL();
    EncryptDecrypt encryptdecrypt = new EncryptDecrypt();
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (Session["Name"] != null)
            {
                if (!IsPostBack)
                {
                    if (Session["UserType"].ToString() == "4" || Session["UserType"].ToString() == "5" || Session["UserType"].ToString() == "6")
                    {
                        string decryptedparam = encryptdecrypt.Decrypt(Request.QueryString["id"].ToString());
                        ViewState["id"] = Convert.ToInt32(decryptedparam);
                        getRows();
                        lblpermissions.Text = "";
                        divUsersList.Visible = true;
                        divmessage.Visible = false;
                    }
                    else
                    {
                        lblpermissions.Text = "Invalid Permissions";
                        divUsersList.Visible = false;
                        divmessage.Visible = true;
                    }
                    Label mastertxt = (Label)Master.FindControl("lblProfile");
                    mastertxt.Text = Session["Name"].ToString();

                }
            }
            else
            {
                Response.Redirect("index.aspx");
            }
        }
        catch { }
    }

    protected void getRows()
    {
        try
        {
            int id = Convert.ToInt32(ViewState["id"].ToString());
            DataSet dsData = new DataSet();
            dsData = userbl.GetUsers(id);
            txtFirstName.Text = dsData.Tables[0].Rows[0]["FirstName"].ToString();
            txtLastName.Text = dsData.Tables[0].Rows[0]["LastName"].ToString();
            string userid = dsData.Tables[0].Rows[0]["UserId"].ToString();
            txtMobileNumber.Text = dsData.Tables[0].Rows[0]["MobileNumber"].ToString();
            txtPhoneNumber.Text = dsData.Tables[0].Rows[0]["PhoneNumber"].ToString();
            txtLocation.Text = dsData.Tables[0].Rows[0]["Location"].ToString();
            txtLoginId.Text = dsData.Tables[0].Rows[0]["LoginId"].ToString();

            if (userid == "1")
            {
                txtPassword.Text = dsData.Tables[0].Rows[0]["Password"].ToString();
            }
            else
            {
                txtPassword.Text = encryptdecrypt.Decrypt(dsData.Tables[0].Rows[0]["Password"].ToString());
            }
            txtEmail.Text = dsData.Tables[0].Rows[0]["EmailId"].ToString();
            GetStatus();
            GetUserType();
            ddlStatus.SelectedValue = dsData.Tables[0].Rows[0]["UserStatus"].ToString();
            ddlUserType.SelectedValue = dsData.Tables[0].Rows[0]["UserType"].ToString();
        }
        catch { }
    }
    protected void GetStatus()
    {
        try
        {
            ds = userbl.GetStatus();
            ddlStatus.DataSource = ds;
            ddlStatus.DataTextField = "Status";
            ddlStatus.DataValueField = "StatusId";
            ddlStatus.DataBind();
            ddlStatus.Items.Insert(0, new ListItem("--Select Status--", "-1"));
        }
        catch
        {

        }
    }
    protected void GetUserType()
    {
        try
        {
            ds = userbl.GetUserType();
            ddlUserType.DataSource = ds;
            ddlUserType.DataTextField = "UserType";
            ddlUserType.DataValueField = "UserTypeId";
            ddlUserType.DataBind();
            ddlUserType.Items.Insert(0, new ListItem("--Select User Type--", "-1"));
        }
        catch
        {

        }
    }
    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        try
        {
            int id = Convert.ToInt32(ViewState["id"].ToString());
            UserInfoEntity userinfoentity = new UserInfoEntity();
            userinfoentity.UserId = id;
            userinfoentity.LoginID = "0";
            userinfoentity.Password = encryptdecrypt.Encrypt(txtPassword.Text);
            userinfoentity.Email = txtEmail.Text;
            userinfoentity.FirstName = txtFirstName.Text;
            userinfoentity.LastName = txtLastName.Text;
            userinfoentity.Location = txtLocation.Text;
            userinfoentity.MobileNumber = txtMobileNumber.Text;
            userinfoentity.PhoneNumber = txtPhoneNumber.Text;
            userinfoentity.Status = Convert.ToInt32(ddlStatus.SelectedValue);
            userinfoentity.UserType = Convert.ToInt32(ddlUserType.SelectedValue);
            int result = userbl.CUDUserInfo(userinfoentity, 'u');
            if (result == 1)
            {
                lblMessage.Text = "Details Updated Successfully!";
                Clear();
                Response.Redirect("UserList.aspx");
            }
            else
            {
                lblMessage.Text = "Please try again!";
            }
        }
        catch
        {

        }
    }    
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        try
        {
            Clear();
        }
        catch
        {

        }
    }
    private void Clear()
    {
        try
        {
            txtFirstName.Text = "";
            txtLastName.Text = "";
            txtEmail.Text = "";
            txtLocation.Text = "";
            txtMobileNumber.Text = "";
            txtPhoneNumber.Text = "";
            ddlStatus.SelectedValue = "-1";
            ddlUserType.SelectedValue = "-1";
            txtPassword.Text = "";
            txtLoginId.Text = "";
        }
        catch { }
    }
}