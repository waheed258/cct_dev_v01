<%@ Page Title="" Language="C#" MasterPageFile="~/Layout.master" AutoEventWireup="true" CodeFile="CustomerInfoUpdateList.aspx.cs" Inherits="CustomerInfoUpdateList" %>
<%@ MasterType VirtualPath="~/Layout.Master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript">
        function SetTarget() {
            document.forms[0].target = "_blank";
        }
    </script>
    <style>
        #ContentPlaceHolder1_gvCustomerUpdate {
            border-collapse: collapse;
            width: 100%;
        }

            #ContentPlaceHolder1_gvCustomerUpdate td, #ContentPlaceHolder1_gvCustomerUpdate th {
                border: 1px solid #ddd;
                padding: 1px 8px;
            }

            #ContentPlaceHolder1_gvCustomerUpdate th {
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
    <div class="page-container" id="divCustomerUpdateList" runat="server">
        <!--/content-inner-->
        <div class="inner-content">
            <!--//outer-wp-->
            <div class="outter-wp">
                <!--/forms-->
                <div class="row">
                    <div class="col-lg-6">
                        <h4 class="inner-tittle" id="h5VerifyCustomer" runat="server" style="font-family: Open Sans, sans-serif; color: #006341; font-weight: bold; margin-top: 15px;">Customer List</h4>
                    </div>
                    <div class="col-lg-2 form-group1">
                        <asp:TextBox ID="txtSearch" runat="server" placeholder="Search..." ValidationGroup="Search" />
                    </div>
                    <div class="col-lg-1" style="margin-top: 6px">
                        <asp:ImageButton ID="cmdSearch" ImageUrl="CustomScripts/images/search.png" runat="server" Height="30px"
                            ToolTip="Search..." OnClick="cmdSearch_Click" ValidationGroup="Search" />
                    </div>
                    <div class="col-lg-3 text-right">
                        <asp:Button ID="btnAdd" runat="server" Text="Add New Customer" class="btn btn-default" OnClick="btnAdd_Click" />
                    </div>
                </div>


                <div class="col-lg-12 ">
                    <asp:GridView ID="gvCustomerUpdate" runat="server" Width="100%"
                        AutoGenerateColumns="False" DataKeyNames="CustomerId"
                        EmptyDataText="There are no data records to display."
                        BorderStyle="Solid" BorderWidth="3px" AllowPaging="true" PageSize="10"
                        CellPadding="4" CellSpacing="2" Style="font-size: 100%;" ForeColor="Black" OnRowCommand="gvCustomerUpdate_RowCommand" OnRowEditing="gvCustomerUpdate_RowEditing" OnPageIndexChanging="gvCustomerUpdate_PageIndexChanging">
                        <Columns>
                            <asp:BoundField DataField="CustomerId" HeaderText="ID" ReadOnly="true" />
                            <asp:BoundField DataField="CustomerName" HeaderText="Customer Name" ReadOnly="true" />
                            <asp:BoundField DataField="Surname" HeaderText="Surname" ReadOnly="true" />
                            <asp:BoundField DataField="MobileNum" HeaderText="Mobile Number" ReadOnly="true" DataFormatString="{0:dd/MM/yyyy}" />
                            <asp:BoundField DataField="City" HeaderText="City" ReadOnly="true" DataFormatString="{0:dd/MM/yyyy}" />
                            <asp:BoundField DataField="EmailId" HeaderText="Email Id" ReadOnly="true" />
                            <asp:TemplateField HeaderText="Update">
                                <ItemTemplate>
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

