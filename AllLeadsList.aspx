<%@ Page Title="" Language="C#" MasterPageFile="~/Layout.master" AutoEventWireup="true" CodeFile="AllLeadsList.aspx.cs" Inherits="AllLeadsList" %>

<%@ MasterType VirtualPath="~/Layout.Master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript">
        function SetTarget() {
            document.forms[0].target = "_blank";
        }
    </script>
    <style>
        #ContentPlaceHolder1_gvAllLeads {
            border-collapse: collapse;
            width: 100%;
        }

            #ContentPlaceHolder1_gvAllLeads td, #ContentPlaceHolder1_gvAllLeads th {
                border: 1px solid #ddd;
                padding: 1px 8px;
            }

            #ContentPlaceHolder1_gvAllLeads th {
                padding-top: 12px;
                padding-bottom: 12px;
                text-align: left;
                background-color: #006341;
                color: #FFF !important;
            }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div style="text-align: center; margin-top: 10px;" id="divmessage" runat="server">
        <asp:Label ID="lblpermissions" runat="server" Style="color: #006341; font-weight: bold; text-align: center"></asp:Label>
    </div>
    <div class="page-container" id="divAllLeadsList" runat="server">
        <!--/content-inner-->
        <div class="inner-content">
            <!--//outer-wp-->
            <div class="outter-wp">
                <!--/forms-->
                <div class="row">
                    <div class="col-lg-6">
                        <h4 class="inner-tittle" id="h5VerifyCustomer" runat="server" style="font-family: Open Sans, sans-serif; color: #006341; font-weight: bold; margin-top: 15px;">All Leads List</h4>
                    </div>
                    <div class="col-lg-2 form-group1">
                        <asp:TextBox ID="txtSearch" runat="server" placeholder="Search..." />
                        
                    </div>
                    <div class="col-lg-1" style="margin-top: 6px">
                        <asp:ImageButton ID="cmdSearch" ImageUrl="CustomScripts/images/search.png" runat="server" Height="30px"
                            ToolTip="Search..." OnClick="cmdSearch_Click" ValidationGroup="Search" />
                          <asp:ImageButton ID="imgbtnRefresh" ImageUrl="CustomScripts/images/icon-refresh.png" runat="server" Height="30px" style="margin-left:19px"
                            ToolTip="Refresh" OnClick="imgbtnRefresh_Click" />
                    </div>
                    <div class="col-lg-3 text-right">
                        <asp:Button ID="btnAdd" runat="server" Text="Add New Lead" class="btn btn-default" OnClick="btnAdd_Click" />
                    </div>
                    <div class="col-lg-12 ">
                        <asp:GridView ID="gvAllLeads" runat="server" Width="100%"
                            AutoGenerateColumns="False" DataKeyNames="SrNo"
                            EmptyDataText="There are no data records to display."
                            BorderStyle="Solid" BorderWidth="3px" AllowPaging="true" PageSize="10"
                            CellPadding="4" CellSpacing="2" Style="font-size: 100%;" ForeColor="Black"
                            OnRowCommand="gvAllLeads_RowCommand" OnRowEditing="gvAllLeads_RowEditing" OnPageIndexChanging="gvAllLeads_PageIndexChanging" OnRowDataBound="gvAllLeads_RowDataBound">
                            <Columns>
                                <asp:BoundField DataField="SRNO" HeaderText="Sl.No" ReadOnly="true" />
                                <asp:BoundField DataField="CLIENTREQID" HeaderText="Lead Ref No" ReadOnly="true" />
                                <asp:BoundField DataField="CREATEDDATE" HeaderText="Date & Time" ReadOnly="true" />
                                <asp:BoundField DataField="CREATEDBY" HeaderText="Lead Created By" ReadOnly="true" />
                                <asp:BoundField DataField="ASSIGNEDTO" HeaderText="Lead Allocated To" ReadOnly="true" />
                                <asp:BoundField DataField="STATUS" HeaderText="Lead Status" ReadOnly="true" />
                                <asp:TemplateField HeaderText="Update">
                                    <ItemTemplate>
                                        <%--<asp:Button ID="btnEdit" runat="server" Text="Edit" CommandName="Edit" CommandArgument="<%#((GridViewRow) Container).RowIndex %>" OnClientClick="SetTarget();" />--%>
                                        <asp:ImageButton ID="btnEdit" ImageUrl="~/CustomScripts/images/editicon.png" runat="server" Width="23px" Height="23px"
                                            CommandName="Edit" ToolTip="Edit" CommandArgument="<%#((GridViewRow) Container).RowIndex %>" OnClientClick="SetTarget();" />
                                       
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </div>
                </div>
                <!--//forms-->
            </div>
            <!--//outer-wp-->
        </div>
        <!--//content-inner-->
        <!--/sidebar-menu-->
    </div>
</asp:Content>

