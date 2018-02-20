<%@ Page Title="" Language="C#" MasterPageFile="~/Layout.master" AutoEventWireup="true" CodeFile="UpdateUser.aspx.cs" Inherits="UpdateUser" %>

<%@ MasterType VirtualPath="~/Layout.Master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript">
        $(function () {
            $(".mobileRestrict").bind('keypress', function (e) {
                if (e.keyCode == '9' || e.keyCode == '16') {
                    return;
                }
                var code;
                if (e.keyCode) code = e.keyCode;
                else if (e.which) code = e.which;
                if (e.which == 46)
                    return false;
                if (code == 8 || code == 46)
                    return true;
                if (code < 48 || code > 57)
                    return false;
            });
            $(".mobileRestrict").bind('mouseenter', function (e) {
                var val = $(this).val();
                if (val != '0') {
                    val = val.replace(/[^0-9]+/g, "");
                    $(this).val(val);
                }
            });
            $(".onlyAlphabet").keypress(function (e) {
                var key = e.keyCode;
                if (key >= 48 && key <= 57) {
                    e.preventDefault();
                }
            });
        })
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div style="text-align: center; margin-top: 10px;" id="divmessage" runat="server">
        <asp:Label ID="lblpermissions" runat="server" Style="color: #006341; font-weight: bold; text-align: center"></asp:Label>
    </div>
    <div class="page-container" id="divUsersList" runat="server">
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
                    <h2 class="inner-tittle"></h2>
                    <div class="graph-form" id="divUserDetails" runat="server">
                        <div class="validation-form">
                            <div class="vali-form">
                                <div class="col-md-3 form-group1">
                                    <label class="control-label">First Name<span style="color: #d0582e">*</span></label>
                                    <asp:TextBox ID="txtFirstName" runat="server" CssClass="toupper onlyAlphabet"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvFirstName" ControlToValidate="txtFirstName" ForeColor="#d0582e" runat="server" ErrorMessage="Please enter First Name" ValidationGroup="Save"></asp:RequiredFieldValidator>
                                </div>
                                <div class="col-md-3 form-group1 form-last">
                                    <label class="control-label">Last Name</label>
                                    <asp:TextBox ID="txtLastName" runat="server" CssClass="toupper onlyAlphabet"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvLastName" ControlToValidate="txtLastName" ForeColor="#d0582e" runat="server" ErrorMessage="Please enter Last Name" ValidationGroup="Save"></asp:RequiredFieldValidator>
                                </div>
                                <div class="col-md-3 form-group1">
                                    <label class="control-label">Phone Number</label>
                                    <asp:TextBox ID="txtPhoneNumber" runat="server" MaxLength="10" CssClass="mobileRestrict"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvPhoneNumber" ControlToValidate="txtPhoneNumber" ForeColor="#d0582e" runat="server" ErrorMessage="Please enter Phone Number" ValidationGroup="Save"></asp:RequiredFieldValidator>
                                </div>
                                <div class="col-md-3 form-group1 form-last">
                                    <label class="control-label">Mobile Number</label>
                                    <asp:TextBox ID="txtMobileNumber" runat="server" MaxLength="10" CssClass="mobileRestrict"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvMobileNumber" ControlToValidate="txtMobileNumber" ForeColor="#d0582e" runat="server" ErrorMessage="Please enter Mobile Number" ValidationGroup="Save"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="clearfix"></div>
                            <div class="vali-form">
                                <div class="col-md-3 form-group1 group-mail">
                                    <label class="control-label">Email</label>
                                    <asp:TextBox ID="txtEmail" runat="server" ReadOnly="true"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvEmail" ControlToValidate="txtEmail" ForeColor="#d0582e" runat="server" ErrorMessage="Please enter Email" ValidationGroup="Save"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="revEmail" runat="server" ForeColor="Red" ErrorMessage="Please check Email Format" ControlToValidate="txtEmail" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                                </div>
                                <div class="col-md-3 form-group1 group-mail">
                                    <label class="control-label">Location</label>
                                    <asp:TextBox ID="txtLocation" runat="server" CssClass="toupper onlyAlphabet"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvLocation" ControlToValidate="txtLocation" ForeColor="#d0582e" runat="server" ErrorMessage="Please enter Location" ValidationGroup="Save"></asp:RequiredFieldValidator>
                                </div>
                                <div class="col-md-3 form-group2 group-mail">
                                    <label class="control-label">User Type</label>
                                    <asp:DropDownList ID="ddlUserType" runat="server">
                                        <asp:ListItem Value="-1" Text="Select"></asp:ListItem>
                                    </asp:DropDownList>
                                    <asp:RequiredFieldValidator ID="rfvUserType" ControlToValidate="ddlUserType" InitialValue="-1" ForeColor="#d0582e" runat="server" ErrorMessage="Please select User Type" ValidationGroup="Save"></asp:RequiredFieldValidator>
                                </div>
                                <div class="col-md-3 form-group2 group-mail">
                                    <label class="control-label">Status</label>
                                    <asp:DropDownList ID="ddlStatus" runat="server">
                                        <asp:ListItem Value="-1" Text="Select"></asp:ListItem>
                                    </asp:DropDownList>
                                    <asp:RequiredFieldValidator ID="rfvStatus" ControlToValidate="ddlStatus" InitialValue="-1" ForeColor="#d0582e" runat="server" ErrorMessage="Please select Status" ValidationGroup="Save"></asp:RequiredFieldValidator>
                                </div>


                            </div>
                            <div class="clearfix"></div>
                            <div class="vali-form">
                                <div class="col-md-3 form-group1 group-mail">
                                    <label class="control-label">Login Id</label>
                                    <asp:TextBox ID="txtLoginId" runat="server" ReadOnly="true" Enabled="false"></asp:TextBox>                                    
                                </div>
                                <div class="col-md-3 form-group1 group-mail">
                                    <label class="control-label">Password</label>
                                    <asp:TextBox ID="txtPassword" runat="server"></asp:TextBox>
                                </div>
                            </div>
                            <div class="clearfix"></div>

                            <div class="col-md-12 form-group button-2">
                                <asp:Button ID="btnUpdate" runat="server" Text="Update" class="btn btn-default" ValidationGroup="Save" OnClick="btnUpdate_Click" />
                                <asp:Button ID="btnCancel" runat="server" Text="Cancel" class="btn btn-default"  OnClientClick="javascript:window.close();"/>
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

