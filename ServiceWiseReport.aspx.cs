using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BusinessLogic;
using BusinessObjects;
using System.IO;
using iTextSharp.text;
using iTextSharp.text.pdf;
using iTextSharp.text.html.simpleparser;

public partial class ServiceWiseReport : System.Web.UI.Page
{

    DataSet ds = new DataSet();
    NewLeadBL newLeadBL = new NewLeadBL();
    EncryptDecrypt encryptdecrypt = new EncryptDecrypt();

    protected void Page_Load(object sender, EventArgs e)
    {
        Label mastertxt = (Label)Master.FindControl("lblProfile");
        if (Session["Name"] != null)
            mastertxt.Text = Session["Name"].ToString();
        else
            Response.Redirect("index.aspx", true);
        if (!IsPostBack)
        {
            ViewState["ps"] = 100;
            GetGridData();
        }
    }
    protected void GetGridData()
    {
        try
        {
            gvServiceLeadsList.PageSize = int.Parse(ViewState["ps"].ToString());
            ds = newLeadBL.GetLeadData();
            gvServiceLeadsList.DataSource = ds;
            ViewState["dt"] = ds.Tables[0];
            gvServiceLeadsList.DataBind();
        }
        catch { }
    }

    public void SearchFromList(string instring)
    {
        try
        {
            if (ViewState["dt"] != null)
            {
                DataTable dt = (DataTable)ViewState["dt"];
                DataRow[] dr = dt.Select(
                    "CLIENTREQID like '%" + instring +
                    "%' OR Convert(CREATEDDATE, 'System.String') LIKE '%" + instring +
                    "%' OR CREATEDBY LIKE '%" + instring +
                    "%' OR ASSIGNEDTO LIKE '%" + instring +
                    "%' OR STATUS LIKE '%" + instring + "%'");
                if (dr.Count() > 0)
                {
                    gvServiceLeadsList.DataSource = dr.CopyToDataTable();
                    gvServiceLeadsList.DataBind();
                }
            }
        }
        catch (Exception ex)
        {

        }
    }

    public void SearchServices(string instring)
    {
        try
        {
            if (ViewState["dt"] != null)
            {
                DataTable dt = (DataTable)ViewState["dt"];
                DataRow[] dr = dt.Select(
                    "Services like '%" + instring + "%'");
                if (dr.Count() > 0)
                {
                    gvServiceLeadsList.DataSource = dr.CopyToDataTable();
                    gvServiceLeadsList.DataBind();
                }
                else
                {
                    gvServiceLeadsList.DataSource = null;
                    gvServiceLeadsList.DataBind();
                }
            }
        }
        catch (Exception ex)
        {

        }
    }
    public override void VerifyRenderingInServerForm(Control control)
    {
        try
        {

        }
        catch { }
        /* Verifies that the control is rendered */
    }

    protected void DropPage_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            ViewState["ps"] = DropPage.SelectedItem.ToString().Trim();
            GetGridData();
        }
        catch { }
    }
    protected void ddlServices_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            if (ddlServices.SelectedValue != "-1")
            {
                SearchServices(ddlServices.SelectedValue.Trim(','));
            }
            else
                GetGridData();
        }
        catch { }
    }
    protected void cmdSearch_Click(object sender, ImageClickEventArgs e)
    {
        try
        {
            SearchFromList(txtSearch.Text.Trim());
        }
        catch { }
    }
    protected void imgbtnRefresh_Click(object sender, ImageClickEventArgs e)
    {
        try
        {
            Response.Redirect("ServiceWiseReport.aspx");
        }
        catch { }
    }
    protected void imgbtnExcel_Click(object sender, ImageClickEventArgs e)
    {
        try
        {
            Response.Clear();
            Response.Buffer = true;
            Response.ClearContent();
            Response.ClearHeaders();
            Response.Charset = "";
            string datetime = DateTime.Now.ToString();
            string FileName = "ServiceWiseReport " + datetime + ".xls";
            StringWriter strwritter = new StringWriter();
            HtmlTextWriter htmltextwrtter = new HtmlTextWriter(strwritter);
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            Response.ContentType = "application/vnd.ms-excel";
            Response.AddHeader("Content-Disposition", "attachment;filename=" + FileName);
            gvServiceLeadsList.GridLines = GridLines.Both;
            gvServiceLeadsList.HeaderStyle.Font.Bold = true;
            gvServiceLeadsList.RenderControl(htmltextwrtter);
            Response.Write(strwritter.ToString());
            Response.End();
        }
        catch { }
    }
    protected void imgpdf_Click(object sender, ImageClickEventArgs e)
    {
        try
        {
            PdfPTable pdfptable = new PdfPTable(gvServiceLeadsList.HeaderRow.Cells.Count);
            foreach (TableCell headerCell in gvServiceLeadsList.HeaderRow.Cells)
            {

                Font font = new Font();
                font.Color = GrayColor.BLUE;
                PdfPCell pdfCell = new PdfPCell(new Phrase(headerCell.Text, font));
                pdfptable.AddCell(pdfCell);

            }
            foreach (GridViewRow gridviewrow in gvServiceLeadsList.Rows)
            {
                foreach (TableCell tableCell in gridviewrow.Cells)
                {

                    tableCell.BackColor = gvServiceLeadsList.HeaderStyle.BackColor;
                    PdfPCell pdfCell = new PdfPCell(new Phrase(tableCell.Text.Trim()));
                    pdfptable.AddCell(pdfCell);

                }

            }
            Document pdfDocument = new Document(PageSize.A4, 10f, 10f, 10f, 10f);
            PdfWriter.GetInstance(pdfDocument, Response.OutputStream);
            pdfDocument.Open();
            pdfDocument.Add(pdfptable);
            pdfDocument.Close();
            Response.ContentType = "application/pdf";
            Response.AppendHeader("content-disposition", "attachment;filename=ServiceWiseReport.pdf");
            Response.Write(pdfDocument);
            Response.Flush();
            Response.End();
        }
        catch { }
    }
    protected void gvServiceLeadsList_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        try
        {
            gvServiceLeadsList.PageIndex = e.NewPageIndex;
            this.GetGridData();
        }
        catch { }
    }
    protected void gvServiceLeadsList_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.Cells[8].Text = e.Row.Cells[8].Text.TrimEnd(',');
                e.Row.Cells[9].Text = e.Row.Cells[9].Text.TrimEnd(',');
            }
        }
        catch { }
    }
}