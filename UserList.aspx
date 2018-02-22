<%@ Page Title="" Language="C#" MasterPageFile="~/Layout.master" AutoEventWireup="true" CodeFile="UserList.aspx.cs" Inherits="UserList" %>

<%@ MasterType VirtualPath="~/Layout.Master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">    
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
             .rounded-corners {
            border: 1px solid black;
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
    <div class="page-container" id="divUserList" runat="server">
        <!--/content-inner-->
        <div class="inner-content">
            <!--//outer-wp-->
            <div class="outter-wp">
                <!--/forms-->
                <div class="row">
                    <div class="col-lg-2">
                        <h4 class="inner-tittle" id="h5VerifyCustomer" runat="server" style="font-family: Open Sans, sans-serif; color: #006341; font-weight: bold; margin-top: 27px;">User List</h4>
                    </div>
                     <div class="col-lg-3">
                         <asp:DropDownList ID="DropPage" runat="server" OnSelectedIndexChanged="DropPage_SelectedIndexChanged" style="margin-top:24px"
                            AutoPostBack="true">
                            <asp:ListItem Value="10" Selected="True">100</asp:ListItem>
                            <asp:ListItem Value="25">200</asp:ListItem>
                            <asp:ListItem Value="50">500</asp:ListItem>
                        </asp:DropDownList>
                         <label class="control-label">
                            Records per page</label>
                    </div>
                    <div class="col-lg-2 form-group1">
                        <asp:TextBox ID="txtSearch" runat="server" placeholder="Search..." style="margin-top:14px"/>                        
                    </div>
                    <div class="col-lg-2" style="margin-top:6px">
                        <asp:ImageButton ID="cmdSearch" ImageUrl="~/CustomScripts/images/search.png" runat="server" Height="30px" style="margin-top:10px"
                            ToolTip="Search..." OnClick="cmdSearch_Click" ValidationGroup="Search" />
                         <asp:ImageButton ID="imgbtnRefresh" ImageUrl="CustomScripts/images/icon-refresh.png" runat="server" Height="30px" style="margin-left:19px"
                            ToolTip="Refresh" OnClick="imgbtnRefresh_Click"/>
                    </div>
                    <div class="col-lg-3 text-right">
                        <asp:Button ID="btnAdd" runat="server" Text="Add New User" class="btn btn-default" OnClick="btnAdd_Click" />
                    </div>
                    <div class="col-lg-12 ">
                        <asp:GridView ID="gvUserList" runat="server" Width="100%"
                            AutoGenerateColumns="False" DataKeyNames="UserId" CssClass="rounded-corners"
                            EmptyDataText="There are no data records to display."
                            BorderStyle="Solid" BorderWidth="0px" AllowPaging="true" PageSize="100"
                            CellPadding="4" CellSpacing="2" Style="font-size: 100%;" ForeColor="Black" OnRowCommand="gvUserList_RowCommand" OnRowEditing="gvUserList_RowEditing" OnPageIndexChanging="gvUserList_PageIndexChanging">
                            <Columns>
                                <asp:BoundField DataField="UserId" HeaderText="ID" ReadOnly="true" />
                                <asp:BoundField DataField="FirstName" HeaderText="First Name" ReadOnly="true" />
                                <asp:BoundField DataField="LastName" HeaderText="Last Name" ReadOnly="true" />
                                <asp:BoundField DataField="MobileNumber" HeaderText="Mobile Number" ReadOnly="true" DataFormatString="{0:dd/MM/yyyy}" />
                                <asp:BoundField DataField="PhoneNumber" HeaderText="Phone Number" ReadOnly="true" DataFormatString="{0:dd/MM/yyyy}" />
                                <asp:BoundField DataField="EmailId" HeaderText="Email Id" ReadOnly="true" />
                                <asp:BoundField DataField="Location" HeaderText="Location" ReadOnly="true" />
                                <asp:BoundField DataField="UType" HeaderText="User Type" ReadOnly="true" />
                                <asp:BoundField DataField="Ustatus" HeaderText="User Status" ReadOnly="true" />

                                <asp:TemplateField HeaderText="Action">
                                    <ItemTemplate>
                                        <asp:ImageButton ID="btnEdit" ImageUrl="~/CustomScripts/images/editicon.png" runat="server" Width="23px" Height="23px"
                                            CommandName="Edit" ToolTip="Edit" CommandArgument="<%#((GridViewRow) Container).RowIndex %>"/>
                                        
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

