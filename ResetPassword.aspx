<%@ Page Title="" Language="C#" MasterPageFile="~/Layout.master" AutoEventWireup="true" CodeFile="ResetPassword.aspx.cs" Inherits="ResetPassword" %>

<%@ MasterType VirtualPath="~/Layout.Master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="page-container">
        <!--/content-inner-->
        <div class="inner-content">
            <!--//outer-wp-->
            <div class="outter-wp">
                <div style="text-align: center; margin-bottom: 10px;">
                    <asp:Label ID="lblMessage" runat="server" Style="color: #006341; font-weight: bold; text-align: center"></asp:Label>
                </div>
                <!--/forms-->
                <div class="forms-main">
                    <h2 class="inner-tittle"></h2>
                    <div class="graph-form">
                        <div class="validation-form">

                            <div class="clearfix"></div>
                            <div class="vali-form">

                                <div class="col-md-4 form-group1">
                                    <label class="control-label">Create a New password</label>
                                    <asp:TextBox ID="txtPassword" runat="server" TextMode="Password"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvPassword" ControlToValidate="txtPassword" ForeColor="#d0582e" runat="server" ErrorMessage="Please enter Password" ValidationGroup="Save"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="rgvPassword" runat="server"
                                        ErrorMessage="Must be between 7 to 10 characters"
                                        ControlToValidate="txtPassword"
                                        ValidationExpression="^[a-zA-Z0-9'@&#.\s]{7,10}$" Display="Dynamic" ForeColor="#d0582e" />
                                </div>
                                <div class="col-md-4 form-group1 form-last">
                                    <label class="control-label">Confirm New password</label>
                                    <asp:TextBox ID="txtConfirmPassword" runat="server" TextMode="Password"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvConfirmPassword" ControlToValidate="txtConfirmPassword" ForeColor="#d0582e" runat="server" ErrorMessage="Please enter Confirm Password" ValidationGroup="Save" Display="Dynamic"></asp:RequiredFieldValidator>
                                    <asp:CompareValidator ID="cvPassword" runat="server" ErrorMessage="Should be same as password" ForeColor="#d0582e" ControlToCompare="txtConfirmPassword" ControlToValidate="txtPassword" Type="String" ValidationGroup="Save"></asp:CompareValidator>
                                    <asp:RegularExpressionValidator ID="rgvConfirmPassword" runat="server"
                                        ErrorMessage="Must be between 7 to 10 characters"
                                        ControlToValidate="txtConfirmPassword"
                                        ValidationExpression="^[a-zA-Z0-9'@&#.\s]{7,10}$" Display="Dynamic" ForeColor="#d0582e" />
                                </div>
                            </div>
                            <div class="clearfix"></div>
                            <div class="col-md-12 form-group button-2">
                                <asp:Button ID="btnSave" runat="server" Text="Set Password" class="btn btn-default" ValidationGroup="Save" OnClick="btnSave_Click" />
                                <asp:Button ID="btnCancel" runat="server" Text="Cancel" class="btn btn-default" />
                            </div>
                            <div class="clearfix"></div>
                            <!---->
                        </div>
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

