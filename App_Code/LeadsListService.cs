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
/// Summary description for LeadsListService
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
[System.Web.Script.Services.ScriptService]
public class LeadsListService : System.Web.Services.WebService
{

    public LeadsListService()
    {

        //Uncomment the following line if using designed components 
        //InitializeComponent(); 
    }

    [WebMethod]
    public void GetLeads()
    {
        List<NewLeadEntity> leadEntity = new List<NewLeadEntity>();
        DataUtilities dataUtilities = new DataUtilities();
        Hashtable hashtable = new Hashtable();
        hashtable.Add("@SrNo", 0);
        SqlDataReader reader = dataUtilities.ExecuteReader("uspGetClientRequest", hashtable);
        while (reader.Read())
        {
            NewLeadEntity lead = new NewLeadEntity();            
            lead.ClientReqId = reader["ClientReqId"].ToString();
            lead.Destination = reader["Destination"].ToString();
            lead.DepartingFrom = reader["DepartingFrom"].ToString();
            lead.AssignedName = reader["ASSIGNEDTO"].ToString();
            lead.Status = reader["STATUS"].ToString();
            lead.UpdatedUser = reader["UPDATEDBY"].ToString();
            lead.CreatedUser = reader["CREATEDBY"].ToString();
            lead.CustomerName = reader["CUSTOMERNAME"].ToString();
            lead.CreatedDate = reader["CREATEDDATE"].ToString();
            lead.SrNo = Convert.ToInt32(reader["SRNO"].ToString());           
            leadEntity.Add(lead);
        }
        JavaScriptSerializer js = new JavaScriptSerializer();
        Context.Response.Write(js.Serialize(leadEntity));
    }
}
