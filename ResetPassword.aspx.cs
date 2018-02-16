using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BusinessObjects;
using BusinessLogic;
using System.Security.Cryptography;
using System.IO;
using System.Text;

public partial class ResetPassword : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["Name"] != null)
        {
            Label mastertxt = (Label)Master.FindControl("lblProfile");
            mastertxt.Text = Session["Name"].ToString();
        }
        else
        {
            Response.Redirect("index.aspx");
        }
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        int result = new UserBL().ResetPassword(Convert.ToInt32(Session["LoginId"].ToString()), Encrypt(txtPassword.Text));

        if (result > 0)
        {
            lblMessage.Text = "Password Reset Successfull!";          
            //Response.Redirect("index.aspx");
        }
        else
        {
            lblMessage.Text = "Please try again!";
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
}