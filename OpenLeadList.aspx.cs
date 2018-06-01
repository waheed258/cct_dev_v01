using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BusinessLogic;
using System.Data;
using BusinessObjects;
using System.IO;
using iTextSharp.text;
using iTextSharp.text.pdf;
using iTextSharp.text.html.simpleparser;
using iTextSharp.tool.xml;

public partial class OpenLeadList : System.Web.UI.Page
{
    NewLeadBL newLeadBL = new NewLeadBL();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            try
            {
                ViewState["ps"] = 100;
                GetOpenLeads();
            }
            catch { }
        }
    }
    private void GetOpenLeads()
    {
        try
        {
            gvOpenLeads.PageSize = int.Parse(ViewState["ps"].ToString());
            DataSet ds = newLeadBL.GetOpenLeadsList();
            gvOpenLeads.DataSource = ds;
            ViewState["dt"] = ds.Tables[0];
            gvOpenLeads.DataBind();
        }
        catch
        {

        }
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
                    "%' OR LeadStatus LIKE '%" + instring + "%'");
                if (dr.Count() > 0)
                {
                    gvOpenLeads.DataSource = dr.CopyToDataTable();
                    gvOpenLeads.DataBind();
                }
            }
        }
        catch (Exception ex)
        {

        }
    }
    protected void DropPage_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            ViewState["ps"] = DropPage.SelectedItem.ToString().Trim();
            GetOpenLeads();
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
            Response.Redirect("OpenLeadList.aspx");
        }
        catch { }
    }
    public override void VerifyRenderingInServerForm(Control control)
    {
        /* Verifies that the control is rendered */
        try
        {

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
            string FileName = "OpenLeads" + DateTime.Now + ".xls";
            StringWriter strwritter = new StringWriter();
            HtmlTextWriter htmltextwrtter = new HtmlTextWriter(strwritter);
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            Response.ContentType = "application/vnd.ms-excel";
            Response.AddHeader("Content-Disposition", "attachment;filename=" + FileName);
            gvOpenLeads.GridLines = GridLines.Both;
            gvOpenLeads.HeaderStyle.Font.Bold = true;
            gvOpenLeads.RenderControl(htmltextwrtter);
            Response.Write(strwritter.ToString());
            Response.End();
        }
        catch { }
    }
    protected void imgpdf_Click(object sender, ImageClickEventArgs e)
    {
        try
        {
            PdfPTable pdfptable = new PdfPTable(gvOpenLeads.HeaderRow.Cells.Count);
            foreach (TableCell headerCell in gvOpenLeads.HeaderRow.Cells)
            {
                Font font = new Font();
                font.Color = GrayColor.BLUE;
                PdfPCell pdfCell = new PdfPCell(new Phrase(headerCell.Text, font));
                pdfptable.AddCell(pdfCell);
            }
            foreach (GridViewRow gridviewrow in gvOpenLeads.Rows)
            {
                foreach (TableCell tableCell in gridviewrow.Cells)
                {

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
            Response.AppendHeader("content-disposition", "attachment;filename=OpenLeads.pdf");
            Response.Write(pdfDocument);
            Response.Flush();
            Response.End();
        }
        catch { }
    }
    protected void gvOpenLeads_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        try
        {
            gvOpenLeads.PageIndex = e.NewPageIndex;
            GetOpenLeads();
        }
        catch { }
    }
    protected void gvOpenLeads_RowDataBound(object sender, GridViewRowEventArgs e)
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