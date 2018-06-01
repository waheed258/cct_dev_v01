<%@ Page Title="" Language="C#" MasterPageFile="~/Layout.master" AutoEventWireup="true" CodeFile="LeadsList.aspx.cs" Inherits="LeadsList" EnableEventValidation="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript">
        $(document).ready(function (event) {
            $("#ContentPlaceHolder1_txtDepartureDate").datepicker({
                startDate: 'today',
                numberOfMonths: 1,
                autoclose: true,
                dateFormat: 'dd-mm-yy',
                onSelect: function (selected) {
                    $("#ContentPlaceHolder1_txtReturnDate").val('');
                    var date = $(this).datepicker('getDate');
                    if (date) {
                        date.setDate(date.getDate());
                    }
                    $("#ContentPlaceHolder1_txtReturnDate").datepicker("option", "minDate", date)
                }
            });
        });
        function FormatIt(obj) {
            if (obj.value.length == 2) // Day
                obj.value = obj.value + "/";
            if (obj.value.length == 5) // month
                obj.value = obj.value + "/";
        }
    </script>
    <style>
        #ContentPlaceHolder1_gvLeadsList {
            border-collapse: collapse;
            width: 100%;
        }

            #ContentPlaceHolder1_gvLeadsList td, #ContentPlaceHolder1_gvLeadsList th {
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
                        <h4 class="inner-tittle" id="h5VerifyCustomer" runat="server" style="font-family: Open Sans, sans-serif; color: #006341; font-weight: bold; margin-top: 27px;">All Leads List</h4>
                    </div>
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
                    <div class="col-lg-2 form-group1">
                        <asp:TextBox ID="txtSearch" runat="server" placeholder="Search..." Style="margin-top: 14px" />
                    </div>
                    <div class="col-lg-1" style="margin-top: 6px">
                        <asp:ImageButton ID="cmdSearch" ImageUrl="CustomScripts/images/search.png" runat="server" Height="30px" Style="margin-top: 10px"
                            ToolTip="Search" OnClick="cmdSearch_Click1" />
                        <asp:ImageButton ID="imgbtnRefresh" ImageUrl="CustomScripts/images/icon-refresh.png" runat="server" Height="30px"
                            ToolTip="Refresh" OnClick="imgbtnRefresh_Click1" />
                    </div>
                    <div class="col-lg-1 form-group1">
                        <label class="control-label" style="margin-top: 14px">
                            Lead Allocated to:</label>
                    </div>
                    <div class="col-lg-2 form-group2">
                        <asp:DropDownList runat="server" ID="ddlLeadAllocatedTo" AutoPostBack="true" OnSelectedIndexChanged="ddlLeadAllocatedTo_SelectedIndexChanged" Style="margin-top: 18px">
                        </asp:DropDownList>
                    </div>
                    <div class="col-lg-1">
                        <asp:ImageButton ID="imgbtnExcel" ImageUrl="CustomScripts/images/excel-icon.png" runat="server" Height="35px" Style="margin-top: 15px"
                            ToolTip="Export To Excel" OnClick="imgbtnExcel_Click1" />
                        <asp:ImageButton ID="imgpdf" ImageUrl="CustomScripts/images/pdf.png" runat="server" Height="35px" Style="margin-top: 15px"
                            ToolTip="Export To PDf" OnClick="imgpdf_Click1" />
                    </div>
                   <%-- <div class="col-lg-1 form-group1">
                        <label class="control-label" style="margin-top: 14px">
                            By Date:</label>
                    </div>
                    <div class="col-lg-2 form-group1">
                        <asp:TextBox ID="txtDepartureDate" onkeyup="FormatIt(this);" runat="server" MaxLength="10" Style="margin-top: 14px"></asp:TextBox>
                    </div>--%>
                </div>
                <div class="row" style="margin-top: 10px">
                    <div class="col-lg-12 ">
                        <asp:GridView ID="gvLeadsList" runat="server" Width="100%"
                            AutoGenerateColumns="False"
                            EmptyDataText="There are no data records to display." CssClass="rounded-corners"
                            BorderStyle="Solid" BorderWidth="0px" AllowPaging="true" PageSize="100"
                            CellPadding="4" CellSpacing="2" Style="font-size: 100%;" ForeColor="Black"
                            OnPageIndexChanging="gvLeadsList_PageIndexChanging1" OnRowDataBound="gvLeadsList_RowDataBound">
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

