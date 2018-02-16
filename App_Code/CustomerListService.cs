using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.Script.Serialization;
using DataLogic;
using System.Collections;
using BusinessObjects;

/// <summary>
/// Summary description for CustomerListService
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
 [System.Web.Script.Services.ScriptService]
public class CustomerListService : System.Web.Services.WebService {

    public CustomerListService () {

        //Uncomment the following line if using designed components 
        //InitializeComponent(); 
    }

    [WebMethod]
    public void GetCustomers()
    {
        List<CustomerEntity> customerEntity = new List<CustomerEntity>();
        DataUtilities dataUtilities = new DataUtilities();
        Hashtable hashtable = new Hashtable();
        hashtable.Add("@CustomerId", 0);
        SqlDataReader reader = dataUtilities.ExecuteReader("uspGetCustomerInfo", hashtable);
        while (reader.Read())
        {
            CustomerEntity customer = new CustomerEntity();
            customer.CustomerId = Convert.ToInt32(reader["CustomerId"]);
            customer.CustomerName = reader["CustomerName"].ToString();
            customer.Surname = reader["Surname"].ToString();
            customer.MobileNum = reader["MobileNum"].ToString();
            customer.EmailId = reader["EmailId"].ToString();
            customerEntity.Add(customer);
        }
        JavaScriptSerializer js = new JavaScriptSerializer();
        Context.Response.Write(js.Serialize(customerEntity));
    }
    
}
