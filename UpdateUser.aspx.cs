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
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["Name"] != null)
        {
            if (!IsPostBack)
            {
                if (Session["UserType"].ToString() == "4" || Session["UserType"].ToString() == "5" || Session["UserType"].ToString() == "6")
                {
                    Session["id"] = Convert.ToInt32(Request.QueryString["id"].ToString());
                    //Session["loginid"] = null;
                    //Session["password"] = null;
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

    protected void getRows()
    {
        int id = Convert.ToInt32(Session["id"].ToString());
        DataSet dsData = new DataSet();
        dsData = userbl.GetUsers(id);
        txtFirstName.Text = dsData.Tables[0].Rows[0]["FirstName"].ToString();
        txtLastName.Text = dsData.Tables[0].Rows[0]["LastName"].ToString();
        string userid = dsData.Tables[0].Rows[0]["UserId"].ToString();
        txtMobileNumber.Text = dsData.Tables[0].Rows[0]["MobileNumber"].ToString();
        txtPhoneNumber.Text = dsData.Tables[0].Rows[0]["PhoneNumber"].ToString();
        txtLocation.Text = dsData.Tables[0].Rows[0]["Location"].ToString();
        txtLoginId.Text = dsData.Tables[0].Rows[0]["LoginId"].ToString();

        if (userid == "1" || userid == "2" || userid == "3")
        {
            txtPassword.Text = dsData.Tables[0].Rows[0]["Password"].ToString();
        }
        else
        {
            txtPassword.Text = Decrypt(dsData.Tables[0].Rows[0]["Password"].ToString());
        }
        txtEmail.Text = dsData.Tables[0].Rows[0]["EmailId"].ToString();
        GetStatus();
        GetUserType();
        ddlStatus.SelectedValue = dsData.Tables[0].Rows[0]["UserStatus"].ToString();
        ddlUserType.SelectedValue = dsData.Tables[0].Rows[0]["UserType"].ToString();
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
        catch (Exception ex)
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
        catch (Exception ex)
        {

        }
    }
    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        try
        {
            int id = Convert.ToInt32(Session["id"].ToString());
            UserInfoEntity userinfoentity = new UserInfoEntity();
            userinfoentity.UserId = id;
            userinfoentity.LoginID = Session["loginid"].ToString();
            userinfoentity.Password = Encrypt(txtPassword.Text);
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
        catch (Exception ex)
        {

        }
    }

    private string Encrypt(string clearText)
    {
        string EncryptionKey = "MAKV2SPBNI99212";
        byte[] clearBytes = Encoding.Unicode.GetBytes(clearText);
        using (Aes encryptor = Aes.Create())
        {
            Rfc2898DeriveBytes pdb = new Rfc2898DeriveBytes(EncryptionKey, new byte[] { 0x49, 0x76, 0x61, 0x6e, 0x20, 0x4d, 0x65, 0x64, 0x76, 0x65, 0x64, 0x65, 0x76 });
            encryptor.Key = pdb.GetBytes(32);
            encryptor.IV = pdb.GetBytes(16);
            using (MemoryStream ms = new MemoryStream())
            {
                using (CryptoStream cs = new CryptoStream(ms, encryptor.CreateEncryptor(), CryptoStreamMode.Write))
                {
                    cs.Write(clearBytes, 0, clearBytes.Length);
                    cs.Close();
                }
                clearText = Convert.ToBase64String(ms.ToArray());
            }
        }
        return clearText;
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        try
        {
            Clear();
        }
        catch (Exception ex)
        {

        }
    }
    private void Clear()
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

    private string Decrypt(string cipherText)
    {
        string EncryptionKey = "MAKV2SPBNI99212";
        byte[] cipherBytes = Convert.FromBase64String(cipherText);
        using (Aes encryptor = Aes.Create())
        {
            Rfc2898DeriveBytes pdb = new Rfc2898DeriveBytes(EncryptionKey, new byte[] { 0x49, 0x76, 0x61, 0x6e, 0x20, 0x4d, 0x65, 0x64, 0x76, 0x65, 0x64, 0x65, 0x76 });
            encryptor.Key = pdb.GetBytes(32);
            encryptor.IV = pdb.GetBytes(16);
            using (MemoryStream ms = new MemoryStream())
            {
                using (CryptoStream cs = new CryptoStream(ms, encryptor.CreateDecryptor(), CryptoStreamMode.Write))
                {
                    cs.Write(cipherBytes, 0, cipherBytes.Length);
                    cs.Close();
                }
                cipherText = Encoding.Unicode.GetString(ms.ToArray());
            }
        }
        return cipherText;
    }
}