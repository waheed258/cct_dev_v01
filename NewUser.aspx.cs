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
using System.Text;
using System.IO;

public partial class NewUser : System.Web.UI.Page
{
    UserBL userBL = new UserBL();
    DataSet ds = new DataSet();
    UserInfoEntity userInfoEntity = new UserInfoEntity();
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
                    divNewLead.Visible = true;
                    divmessage.Visible = false;
                    GetUserType();
                    GetStatus();
                }
                else
                {
                    lblpermissions.Text = "Invalid Permissions";
                    divNewLead.Visible = false;
                    divmessage.Visible = true;
                }
            }
        }
        else
        {
            Response.Redirect("index.aspx");
        }
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            userInfoEntity.FirstName = txtFirstName.Text;
            userInfoEntity.LastName = txtLastName.Text;
            userInfoEntity.MobileNumber = txtMobileNumber.Text;
            userInfoEntity.PhoneNumber = txtPhoneNumber.Text;
            userInfoEntity.Email = txtEmail.Text;
            userInfoEntity.LoginID = txtLogin.Text;
            userInfoEntity.Password = Encrypt(txtPassword.Text.Trim());
            userInfoEntity.Location = txtLocation.Text;
            userInfoEntity.UserType = Convert.ToInt32(ddlUserType.SelectedValue);
            userInfoEntity.Status = Convert.ToInt32(ddlStatus.SelectedValue);
            int result = userBL.CUDUserInfo(userInfoEntity, 'i');
            if (result == 1)
            {
                lblMessage.Text = "New User Created Successfully!";
                Clear();
            }
            else
            {
                lblMessage.Text = "Please try again!";
                Clear();
            }
        }
        catch (Exception ex)
        {
            if (ex.Message.Contains("duplicate key"))
            {
                lblMessage.Text = "User already exists!";
                lblMessage.ForeColor = System.Drawing.Color.Red;
                txtLogin.Text = "";
            }
            else
            {
                lblMessage.Text = "Please try again!";
                lblMessage.ForeColor = System.Drawing.Color.Red;
                Clear();
            }
        }
    }
    protected void GetUserType()
    {
        try
        {
            ds = userBL.GetUserType();
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
    protected void GetStatus()
    {
        try
        {
            ds = userBL.GetStatus();
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
    private void Clear()
    {
        txtFirstName.Text = "";
        txtLastName.Text = "";
        txtMobileNumber.Text = "";
        txtPhoneNumber.Text = "";
        txtEmail.Text = "";
        txtLogin.Text = "";
        txtPassword.Text = "";
        txtLocation.Text = "";
        ddlUserType.SelectedValue = "-1";
        ddlStatus.SelectedValue = "-1";
    }
}