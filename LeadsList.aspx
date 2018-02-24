<%@ Page Title="" Language="C#" MasterPageFile="~/Layout.master" AutoEventWireup="true" CodeFile="LeadsList.aspx.cs" Inherits="LeadsList" EnableEventValidation = "false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style>
        #ContentPlaceHolder1_gvLeadsList {
            border-collapse: collapse;
            width: 100%;
        }

            #ContentPlaceHolder1_gvLeadsList td, #ContentPlaceHolder1_gvUserList th {
                border: 1px solid #ddd;
                padding: 1px 8px;
            }

            #ContentPlaceHolder1_gvLeadsList th {
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
    <div class="page-container" id="divCustomerUpdateList" runat="server">
        <div class="inner-content">
            <!--//outer-wp-->
            <div class="outter-wp">
                <div class="row">
                    <div class="col-lg-2">
                        <asp:DropDownList ID="DropPage" runat="server" OnSelectedIndexChanged="DropPage_SelectedIndexChanged1" Style="margin-top: 24px"
                            AutoPostBack="true">
                            <asp:ListItem Value="10" Selected="True">100</asp:ListItem>
                            <asp:ListItem Value="25">200</asp:ListItem>
                            <asp:ListItem Value="50">500</asp:ListItem>
                        </asp:DropDownList>
                        <label class="control-label">
                            Records per page</label>
                    </div>
                    <div class="col-lg-3">
                        <label class="control-label">Select Services</label>
                        <asp:DropDownList ID="ddlServices" runat="server" OnSelectedIndexChanged="ddlServices_SelectedIndexChanged1" Style="margin-top: 24px"
                            AutoPostBack="true">
                            <asp:ListItem Value="-1" Selected="True">- All -</asp:ListItem>
                            <asp:ListItem Value="Flight">Flight</asp:ListItem>
                            <asp:ListItem Value="Hotel">Hotel</asp:ListItem>
                            <asp:ListItem Value="Car">Car</asp:ListItem>
                            <asp:ListItem Value="Visa">Visa</asp:ListItem>
                            <asp:ListItem Value="Insurance">Insurance</asp:ListItem>
                            <asp:ListItem Value="Forex">Forex</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="col-lg-2 form-group1">
                        <asp:TextBox ID="txtSearch" runat="server" placeholder="Search..." Style="margin-top: 14px" />
                    </div>
                    <div class="col-lg-3" style="margin-top: 6px">
                        <asp:ImageButton ID="cmdSearch" ImageUrl="CustomScripts/images/search.png" runat="server" Height="30px" Style="margin-top: 10px"
                            ToolTip="Search" OnClick="cmdSearch_Click1" />
                        <asp:ImageButton ID="imgbtnRefresh" ImageUrl="CustomScripts/images/icon-refresh.png" runat="server" Height="30px" Style="margin-left: 19px"
                            ToolTip="Refresh" OnClick="imgbtnRefresh_Click1" />
                    </div>
                    <div class="col-lg-2 text-right">
                       <asp:ImageButton ID="imgbtnExcel" ImageUrl="CustomScripts/images/excel-icon.png" runat="server" Height="35px" Style="margin-left: 10px;margin-top: 15px"
                           ToolTip="Export To Excel" OnClick="imgbtnExcel_Click1" />
                        <asp:ImageButton ID="imgpdf" ImageUrl="CustomScripts/images/pdf.png" runat="server" Height="35px" Style="margin-left: 10px;margin-top: 15px"
                           ToolTip="Export To PDf" OnClick="imgpdf_Click1" />
                    </div>
                </div>
                <div class="row" style="margin-top:10px">
                    <div class="col-lg-12 ">
                        <asp:GridView ID="gvLeadsList" runat="server" Width="100%"
                            AutoGenerateColumns="False"
                            EmptyDataText="There are no data records to display." CssClass="rounded-corners"
                            BorderStyle="Solid" BorderWidth="0px" AllowPaging="true" PageSize="100"
                            CellPadding="4" CellSpacing="2" Style="font-size: 100%;" ForeColor="Black"
                            OnPageIndexChanging="gvLeadsList_PageIndexChanging1">
                            <Columns>
                                <asp:BoundField DataField="SRNO" HeaderText="Sl.No" ReadOnly="true" />
                                <asp:BoundField DataField="CLIENTREQID" HeaderText="Lead Ref No" ReadOnly="true" />
                                <asp:BoundField DataField="CUSTOMERNAME" HeaderText="Customer Name" ReadOnly="true" />
                                <asp:BoundField DataField="Destination" HeaderText="Destination" ReadOnly="true" />
                                <asp:BoundField DataField="CREATEDDATE" HeaderText="Date & Time" ReadOnly="true" />
                                <asp:BoundField DataField="CREATEDBY" HeaderText="Lead Created By" ReadOnly="true" />
                                <asp:BoundField DataField="ASSIGNEDTO" HeaderText="Lead Allocated To(TC)" ReadOnly="true" />
                                <asp:BoundField DataField="STATUS" HeaderText="Lead Status" ReadOnly="true" />
                                <asp:BoundField DataField="SERVICES" HeaderText="Services" ReadOnly="true" />
                                <asp:BoundField DataField="CLASS" HeaderText="Flight Class" ReadOnly="true" />
                            </Columns>
                        </asp:GridView>
                    </div>
                </div>
            </div>
            </div>
        </div>    
</asp:Content>

