<%@ Page Title="" Language="C#" MasterPageFile="~/Layout.master" AutoEventWireup="true" CodeFile="LeadAllocation.aspx.cs" Inherits="LeadAllocation" %>

<%@ MasterType VirtualPath="~/Layout.Master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">    
    <style>
        #ContentPlaceHolder1_gvLeadData {
            border-collapse: collapse;
            width: 100%;
        }

            #ContentPlaceHolder1_gvLeadData td, #ContentPlaceHolder1_gvUserList th {
                border: 1px solid #ddd;
                padding: 1px 8px;
            }

            #ContentPlaceHolder1_gvLeadData th {
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
    <div class="page-container" id="divLeadAllocation" runat="server">
        <!--/content-inner-->
        <div class="inner-content">
            <!--//outer-wp-->
            <div class="outter-wp">
                <!--/forms-->
                <div class="row">
                    <div class="col-lg-2">
                        <h4 class="inner-tittle" id="h5VerifyCustomer" runat="server" style="font-family: Open Sans, sans-serif; color: #006341; font-weight: bold; margin-top: 27px;">Allocate Lead</h4>
                    </div>
                     <div class="col-lg-4">
                         <asp:DropDownList ID="DropPage" runat="server" OnSelectedIndexChanged="DropPage_SelectedIndexChanged" style="margin-top:24px"
                            AutoPostBack="true">
                            <asp:ListItem Value="10" Selected="True">10</asp:ListItem>
                            <asp:ListItem Value="25">25</asp:ListItem>
                            <asp:ListItem Value="50">50</asp:ListItem>
                            <asp:ListItem Value="100">100</asp:ListItem>
                        </asp:DropDownList>
                         <label class="control-label">
                            Records per page</label>
                    </div>
                    <div class="col-lg-2 form-group1">
                        <asp:TextBox ID="txtSearch" runat="server" placeholder="Search..." style="margin-top:14px" />
                    </div>
                    <div class="col-lg-1" style="margin-top: 6px">
                        <asp:ImageButton ID="cmdSearch" ImageUrl="CustomScripts/images/search.png" runat="server" Height="30px" style="margin-top:10px"
                            ToolTip="Search" OnClick="cmdSearch_Click" />
                         <asp:ImageButton ID="imgbtnRefresh" ImageUrl="CustomScripts/images/icon-refresh.png" runat="server" Height="30px" style="margin-left:19px"
                            ToolTip="Refresh" OnClick="imgbtnRefresh_Click" />
                    </div>
                    <div class="col-lg-3 text-right">
                        <asp:Button ID="btnAdd" runat="server" Text="Add New Lead" class="btn btn-default" OnClick="btnAdd_Click1" />
                    </div>
                
                <div class="col-lg-12 ">
                    <asp:GridView ID="gvLeadData" runat="server" Width="100%"
                        AutoGenerateColumns="False" DataKeyNames="SrNo"
                        EmptyDataText="There are no data records to display."
                        BorderStyle="Solid" BorderWidth="3px" AllowPaging="true" PageSize="10"
                        CellPadding="4" CellSpacing="2" Style="font-size: 100%;" ForeColor="Black" OnRowCommand="gvLeadData_RowCommand1" OnRowDataBound="gvLeadData_RowDataBound1" OnRowEditing="gvLeadData_RowEditing1" OnPageIndexChanging="gvLeadData_PageIndexChanging">
                        <Columns>
                            <asp:BoundField DataField="SRNO" HeaderText="Sl.No" ReadOnly="true" />
                            <asp:BoundField DataField="CLIENTREQID" HeaderText="Lead Ref No" ReadOnly="true" />
                            <asp:BoundField DataField="CREATEDDATE" HeaderText="Date & Time" ReadOnly="true" />
                            <asp:BoundField DataField="CREATEDBY" HeaderText="Lead Created By" ReadOnly="true" />
                            <asp:BoundField DataField="ASSIGNEDTO" HeaderText="Lead Allocated To" ReadOnly="true" />
                            <asp:BoundField DataField="STATUS" HeaderText="Lead Status" ReadOnly="true"/>                            
                            <asp:TemplateField HeaderText="Update">
                                <ItemTemplate>
                                    <asp:ImageButton ID="btnEdit" ImageUrl="~/CustomScripts/images/editicon.png" runat="server" Width="23px" Height="23px"
                                        CommandName="Edit" ToolTip="Edit" CommandArgument="<%#((GridViewRow) Container).RowIndex %>" />
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

