using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BusinessLogic;
using BusinessObjects;
using System.Data;
public partial class UserProfile : System.Web.UI.Page
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
                GetUserType();
                GetStatus();
                GetUser(Convert.ToInt32(Session["LoginId"].ToString()));
                
            }
        }
        else
        {
            Response.Redirect("index.aspx");
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

    private void GetUser(int userid)
    {
        try
        {
            ds = userBL.GetUsers(userid);
            if (ds.Tables[0].Rows.Count > 0)
            {
                txtFirstName.Text = ds.Tables[0].Rows[0]["FirstName"].ToString();
                txtLastName.Text = ds.Tables[0].Rows[0]["LastName"].ToString();
                txtPhoneNumber.Text = ds.Tables[0].Rows[0]["PhoneNumber"].ToString();
                txtMobileNumber.Text = ds.Tables[0].Rows[0]["MobileNumber"].ToString();
                txtEmail.Text = ds.Tables[0].Rows[0]["EmailId"].ToString();
                txtLogin.Text = ds.Tables[0].Rows[0]["LoginId"].ToString();
                ViewState["Password"] = ds.Tables[0].Rows[0]["Password"].ToString();
                txtLocation.Text = ds.Tables[0].Rows[0]["Location"].ToString();
                ddlUserType.SelectedValue = ds.Tables[0].Rows[0]["UserType"].ToString();
                ddlStatus.SelectedValue = ds.Tables[0].Rows[0]["UserStatus"].ToString();
            }
        }
        catch (Exception ex)
        {

        }

    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            userInfoEntity.UserId = Convert.ToInt32(Session["LoginId"].ToString());
            userInfoEntity.FirstName = txtFirstName.Text;
            userInfoEntity.LastName = txtLastName.Text;
            userInfoEntity.MobileNumber = txtMobileNumber.Text;
            userInfoEntity.PhoneNumber = txtPhoneNumber.Text;
            userInfoEntity.Email = txtEmail.Text;
            userInfoEntity.LoginID = txtLogin.Text;
            userInfoEntity.Password = ViewState["Password"].ToString();
            userInfoEntity.Location = txtLocation.Text;
            userInfoEntity.UserType = Convert.ToInt32(ddlUserType.SelectedValue);
            userInfoEntity.Status = Convert.ToInt32(ddlStatus.SelectedValue);
            int result = userBL.CUDUserInfo(userInfoEntity, 'u');
            if (result == 1)
            {
                lblMessage.Text = "Details saved successfully!";
                Clear();
                divProfile.Visible = false;
            }
            else {
                lblMessage.Text = "Please try again";
            }
        }
        catch (Exception ex)
        {

        }
    }
    public void Clear()
    {
        txtFirstName.Text = "";
        txtLastName.Text = "";
        txtPhoneNumber.Text = "";
        txtMobileNumber.Text = "";
        txtEmail.Text = "";
        txtLogin.Text = "";
        txtLocation.Text = "";
        ddlUserType.SelectedValue = "-1";
        ddlStatus.SelectedValue = "-1";
    }
}