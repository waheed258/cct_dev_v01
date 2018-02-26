<%@ Page Title="" Language="C#" MasterPageFile="~/Layout.master" AutoEventWireup="true" CodeFile="OpenLeadList.aspx.cs" Inherits="OpenLeadList" %>

<%@ MasterType VirtualPath="~/Layout.Master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style>
        #ContentPlaceHolder1_gvOpenLeads {
            border-collapse: collapse;
            width: 100%;
        }

            #ContentPlaceHolder1_gvOpenLeads td, #ContentPlaceHolder1_gvOpenLeads th {
                border: 1px solid #ddd;
                padding: 1px 8px;
            }

            #ContentPlaceHolder1_gvOpenLeads th {
                padding-top: 12px;
                padding-bottom: 12px;
                text-align: left;
                background-color: #006341;
                color: #FFF !important;
            }

        .rounded-corners {
            -webkit-border-radius: 8px;
            -moz-border-radius: 8px;
            border-radius: 8px;
            overflow: hidden;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div style="text-align: center; margin-top: 10px;" id="divmessage" runat="server">
        <asp:Label ID="lblpermissions" runat="server" Style="color: #006341; font-weight: bold; text-align: center"></asp:Label>
    </div>
    <div class="page-container" id="divOpenLeads" runat="server">
        <!--/content-inner-->
        <div class="inner-content">
            <!--//outer-wp-->
            <div class="outter-wp">
                <!--/forms-->
                <div class="row">
                    <div class="col-lg-2">
                        <h4 class="inner-tittle" id="h5VerifyCustomer" runat="server" style="font-family: Open Sans, sans-serif; color: #006341; font-weight: bold; margin-top: 27px;">Open Leads</h4>
                    </div>
                    <div class="col-lg-2">
                        <asp:DropDownList ID="DropPage" runat="server" OnSelectedIndexChanged="DropPage_SelectedIndexChanged" Style="margin-top: 24px"
                            AutoPostBack="true">
                            <asp:ListItem Value="100" Selected="True">100</asp:ListItem>
                            <asp:ListItem Value="200">200</asp:ListItem>
                            <asp:ListItem Value="500">500</asp:ListItem>
                        </asp:DropDownList>
                        <label class="control-label">
                            Records per page</label>
                    </div>
                    <div class="col-lg-2 form-group1">
                        <asp:TextBox ID="txtSearch" runat="server" placeholder="Search..." Style="margin-top: 14px" />
                    </div>
                    <div class="col-lg-4" style="margin-top: 6px">
                        <asp:ImageButton ID="cmdSearch" ImageUrl="CustomScripts/images/search.png" runat="server" Height="30px" Style="margin-top: 10px"
                            ToolTip="Search" OnClick="cmdSearch_Click" />
                        <asp:ImageButton ID="imgbtnRefresh" ImageUrl="CustomScripts/images/icon-refresh.png" runat="server" Height="30px" Style="margin-left: 19px"
                            ToolTip="Refresh" OnClick="imgbtnRefresh_Click" />
                    </div>
                    <div class="col-lg-2 text-right">
                        <asp:ImageButton ID="imgbtnExcel" ImageUrl="CustomScripts/images/excel-icon.png" runat="server" Height="35px" Style="margin-left: 19px;margin-top: 15px"
                            ToolTip="Export To Excel" OnClick="imgbtnExcel_Click" />
                        <asp:ImageButton ID="imgpdf" ImageUrl="CustomScripts/images/pdf.png" runat="server" Height="35px" Style="margin-left: 19px;margin-top: 15px"
                            ToolTip="Export To PDf" OnClick="imgpdf_Click" />
                    </div>
                </div>
                <div class="row" style="margin-top: 10px">
                    <div class="col-lg-12 ">
                        <asp:GridView ID="gvOpenLeads" runat="server" Width="100%"
                            AutoGenerateColumns="False"
                            EmptyDataText="There are no data records to display." CssClass="rounded-corners"
                            BorderStyle="Solid" BorderWidth="0px" AllowPaging="true" PageSize="100"
                            CellPadding="4" CellSpacing="2" Style="font-size: 100%;" ForeColor="Black" OnPageIndexChanging="gvOpenLeads_PageIndexChanging" OnRowDataBound="gvOpenLeads_RowDataBound">
                            <Columns>
                                <asp:BoundField DataField="SRNO" HeaderText="Sl.No" ReadOnly="true" />
                                <asp:BoundField DataField="CLIENTREQID" HeaderText="Lead Ref No" ReadOnly="true" />
                                <asp:BoundField DataField="CUSTOMERNAME" HeaderText="Customer Name" ReadOnly="true" />
                                <asp:BoundField DataField="Destination" HeaderText="Destination" ReadOnly="true" />
                                <asp:BoundField DataField="CREATEDDATE" HeaderText="Date & Time" ReadOnly="true" />
                                <asp:BoundField DataField="CREATEDBY" HeaderText="Lead Created By" ReadOnly="true" />
                                <asp:BoundField DataField="ASSIGNEDTO" HeaderText="Lead Allocated To" ReadOnly="true" />
                                <asp:BoundField DataField="LeadStatus" HeaderText="Lead Status" ReadOnly="true" />
                                <asp:BoundField DataField="SERVICES" HeaderText="Services" ReadOnly="true" />
                                <asp:BoundField DataField="CLASS" HeaderText="Flight Class" ReadOnly="true" />
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

