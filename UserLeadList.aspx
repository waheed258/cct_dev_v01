<%@ Page Title="" Language="C#" MasterPageFile="~/Layout.master" AutoEventWireup="true" CodeFile="UserLeadList.aspx.cs" Inherits="UserLeadList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript">
        function SetTarget() {
            document.forms[0].target = "_blank";
        }
    </script>
    <style>
        #ContentPlaceHolder1_gvUserList {
            border-collapse: collapse;
            width: 100%;
        }

            #ContentPlaceHolder1_gvUserList td, #ContentPlaceHolder1_gvUserList th {
                border: 1px solid #ddd;
                padding: 1px 8px;
            }

            #ContentPlaceHolder1_gvUserList th {
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
    <div class="page-container" id="divUserList" runat="server">
        <!--/content-inner-->
        <div class="inner-content">
            <!--//outer-wp-->
            <div class="outter-wp">
                <!--/forms-->
                <div class="row">
                    <div class="col-lg-6">
                        <h4 class="inner-tittle" id="h5VerifyCustomer" runat="server" style="font-family: Open Sans, sans-serif; color: #006341; font-weight: bold; margin-top: 15px;">Your Leads List</h4>
                    </div>
                    <div class="col-lg-2 form-group1">
                        <asp:TextBox ID="txtSearch" runat="server" placeholder="Search..." />
                    </div>
                    <div class="col-lg-1" style="margin-top: 6px">
                        <asp:ImageButton ID="cmdSearch" ImageUrl="CustomScripts/images/search.png" runat="server" Height="30px"
                            ToolTip="Search..." OnClick="cmdSearch_Click" ValidationGroup="Search" />
                    </div>
                    <div class="col-lg-3 text-right">
                        <asp:Button ID="btnAdd" runat="server" Text="Add New Lead" class="btn btn-default" OnClick="btnAdd_Click" />
                    </div>
                </div>

                <div class="col-lg-12 ">
                    <asp:GridView ID="gvUserList" runat="server" Width="100%"
                        AutoGenerateColumns="False" DataKeyNames="SRNO"
                        EmptyDataText="There are no data records to display."
                        BorderStyle="Solid" BorderWidth="3px"
                        CellPadding="4" CellSpacing="2" Style="font-size: 100%;" ForeColor="Black" OnRowCommand="gvUserList_RowCommand" OnRowEditing="gvUserList_RowEditing" OnPageIndexChanging="gvUserList_PageIndexChanging">
                        <Columns>
                            <asp:BoundField DataField="SRNO" HeaderText="Sl.No" ReadOnly="true" />
                            <asp:BoundField DataField="CLIENTREQID" HeaderText="Lead Ref No" ReadOnly="true" />
                            <asp:BoundField DataField="CREATEDDATE" HeaderText="Date & Time" ReadOnly="true" />
                            <asp:BoundField DataField="CREATEDBY" HeaderText="Lead Created By" ReadOnly="true" />
                            <asp:BoundField DataField="ASSIGNEDTO" HeaderText="Lead Allocated To" ReadOnly="true" />
                            <asp:BoundField DataField="LEADSTATUS" HeaderText="Lead Status" ReadOnly="true"/>               
                            <asp:TemplateField HeaderText="Action">
                                <ItemTemplate>
                                    <asp:ImageButton ID="btnEdit" ImageUrl="~/CustomScripts/images/editicon.png" runat="server" Width="23px" Height="23px"
                                        CommandName="EditUser" ToolTip="Edit" CommandArgument="<%#((GridViewRow) Container).RowIndex %>" OnClientClick="SetTarget();" />
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

