<%@ Page Title="" Language="C#" MasterPageFile="~/Layout.master" AutoEventWireup="true" CodeFile="UserProfile.aspx.cs" Inherits="UserProfile" %>

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
                <div class="forms-main" id="divProfile" runat="server">
                    <h2 class="inner-tittle"></h2>
                    <div class="graph-form">
                        <div class="validation-form">
                            <div class="vali-form">
                                <div class="col-md-3 form-group1">
                                    <label class="control-label">Firstname<span style="color: #d0582e">*</span></label>
                                    <asp:TextBox ID="txtFirstName" runat="server"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvFirstName" ControlToValidate="txtFirstName" ForeColor="#d0582e" runat="server" ErrorMessage="Please enter First Name" ValidationGroup="Save"></asp:RequiredFieldValidator>
                                </div>
                                <div class="col-md-3 form-group1 form-last">
                                    <label class="control-label">Lastname<span style="color: #d0582e">*</span></label>
                                    <asp:TextBox ID="txtLastName" runat="server"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvLastName" ControlToValidate="txtLastName" ForeColor="#d0582e" runat="server" ErrorMessage="Please enter Last Name" ValidationGroup="Save"></asp:RequiredFieldValidator>
                                </div>
                                <div class="col-md-3 form-group1">
                                    <label class="control-label">Phone Number<span style="color: #d0582e">*</span></label>
                                    <asp:TextBox ID="txtPhoneNumber" MaxLength="10" runat="server"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvPhoneNumber" ControlToValidate="txtPhoneNumber" ForeColor="#d0582e" runat="server" ErrorMessage="Please enter Phone Number" ValidationGroup="Save" Display="Dynamic"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="revtxtPhoneNumber" runat="server" ControlToValidate="txtPhoneNumber" ForeColor="#d0582e"
                                        Display="Dynamic" ErrorMessage="Enter Valid Phone Number" Text="Enter Valid Phone Number" ValidationGroup="Save" ValidationExpression="^[0-9]{10,20}$" />
                                </div>
                                <div class="col-md-3 form-group1 form-last">
                                    <label class="control-label">Mobile Number<span style="color: #d0582e">*</span></label>
                                    <asp:TextBox ID="txtMobileNumber" runat="server" MaxLength="10"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvMobileNumber" ControlToValidate="txtMobileNumber" ForeColor="#d0582e" runat="server" ErrorMessage="Please enter Mobile Number" ValidationGroup="Save" Display="Dynamic"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="revtxtMobileNumber" runat="server" ControlToValidate="txtMobileNumber" ForeColor="#d0582e"
                                        Display="Dynamic" ErrorMessage="Enter Valid Mobile Number" Text="Enter Valid Mobile Number" ValidationGroup="Save" ValidationExpression="^[0-9]{10,20}$" />
                                </div>
                            </div>
                            <div class="clearfix"></div>

                            <div class="vali-form">
                                <div class="col-md-3 form-group1 group-mail">
                                    <label class="control-label">Email<span style="color: #d0582e">*</span></label>
                                    <asp:TextBox ID="txtEmail" runat="server"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvEmail" ControlToValidate="txtEmail" ForeColor="#d0582e" runat="server" ErrorMessage="Please enter Email" ValidationGroup="Save"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="revEmail" runat="server" ForeColor="Red" ErrorMessage="Please check Email Format" ControlToValidate="txtEmail" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                                </div>
                                <div class="col-md-3 form-group1 group-mail">
                                    <label class="control-label">Login<span style="color: #d0582e">*</span></label>
                                    <asp:TextBox ID="txtLogin" runat="server" ReadOnly="true"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvLogin" ControlToValidate="txtLogin" ForeColor="#d0582e" runat="server" ErrorMessage="Please enter Login" ValidationGroup="Save"></asp:RequiredFieldValidator>
                                </div>
                                <div class="col-md-3 form-group1 group-mail">
                                    <label class="control-label">Location<span style="color: #d0582e">*</span></label>
                                    <asp:TextBox ID="txtLocation" runat="server"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvLocation" ControlToValidate="txtLocation" ForeColor="#d0582e" runat="server" ErrorMessage="Please enter Location" ValidationGroup="Save"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="clearfix"></div>

                            <div class="vali-form vali-form1">
                                <div class="col-md-3 form-group2 group-mail">
                                    <label class="control-label">User Type<span style="color: #d0582e">*</span></label>
                                    <asp:DropDownList ID="ddlUserType" runat="server">
                                        <asp:ListItem Value="-1" Text="Select"></asp:ListItem>
                                    </asp:DropDownList>
                                    <asp:RequiredFieldValidator ID="rfvUserType" ControlToValidate="ddlUserType" InitialValue="-1" ForeColor="#d0582e" runat="server" ErrorMessage="Please select User Type" ValidationGroup="Save"></asp:RequiredFieldValidator>
                                </div>
                                <div class="col-md-3 form-group2 group-mail">
                                    <label class="control-label">Status<span style="color: #d0582e">*</span></label>
                                    <asp:DropDownList ID="ddlStatus" runat="server">
                                        <asp:ListItem Value="-1" Text="Select"></asp:ListItem>
                                    </asp:DropDownList>
                                    <asp:RequiredFieldValidator ID="rfvStatus" ControlToValidate="ddlStatus" InitialValue="-1" ForeColor="#d0582e" runat="server" ErrorMessage="Please select Status" ValidationGroup="Save"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="clearfix"></div>

                            <div class="col-md-12 form-group button-2">
                                <asp:Button ID="btnSave" runat="server" Text="Update" class="btn btn-default" ValidationGroup="Save" OnClick="btnSave_Click" />
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

