<%@ Page Title="" Language="C#" MasterPageFile="~/Layout.master" AutoEventWireup="true" CodeFile="NewUser.aspx.cs" Inherits="NewUser" %>

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
    <div class="page-container" id="divNewLead" runat="server">
        <!--/content-inner-->
        <div class="inner-content">
            <!--//outer-wp-->
            <div class="outter-wp">
                <div style="text-align: center; margin-bottom: 10px;">
                    <asp:Label ID="lblMessage" runat="server" Style="color: #006341; font-weight: bold; text-align: center"></asp:Label>
                </div>
                <!--/forms-->
                <div class="forms-main">
                    <h5 class="inner-tittle" style="font-family: Open Sans, sans-serif; color: #006341; font-weight: bold; margin-bottom: 10px">Create New User</h5>
                    <div class="graph-form">
                        <div class="validation-form">
                            <div class="vali-form">
                                <div class="col-md-3 form-group1">
                                    <label class="control-label">First Name<span style="color: #d0582e">*</span></label>
                                    <asp:TextBox ID="txtFirstName" runat="server" CssClass="onlyAlphabet toupper"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvFirstName" ControlToValidate="txtFirstName" ForeColor="#d0582e" Display="Dynamic" runat="server" ErrorMessage="Please enter First Name" ValidationGroup="Save"></asp:RequiredFieldValidator>
                                </div>
                                <div class="col-md-3 form-group1 form-last">
                                    <label class="control-label">Last Name<span style="color: #d0582e">*</span></label>
                                    <asp:TextBox ID="txtLastName" runat="server" CssClass="onlyAlphabet toupper"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvLastName" ControlToValidate="txtLastName" ForeColor="#d0582e" Display="Dynamic" runat="server" ErrorMessage="Please enter Last Name" ValidationGroup="Save"></asp:RequiredFieldValidator>
                                </div>
                                <div class="col-md-3 form-group1">
                                    <label class="control-label">Phone Number<span style="color: #d0582e">*</span></label>
                                    <asp:TextBox ID="txtPhoneNumber" runat="server" MaxLength="10" CssClass="mobileRestrict"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvPhoneNumber" ControlToValidate="txtPhoneNumber" ForeColor="#d0582e" Display="Dynamic" runat="server" ErrorMessage="Please enter Phone Number" ValidationGroup="Save"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="rgvPhone" runat="server" ErrorMessage="Please enter 10 digits" ValidationExpression="[0-9]{10}" Display="Dynamic" ControlToValidate="txtPhoneNumber" ForeColor="#d0582e" ValidationGroup="Save"></asp:RegularExpressionValidator>
                                </div>
                                <div class="col-md-3 form-group1 form-last">
                                    <label class="control-label">Mobile Number<span style="color: #d0582e">*</span></label>
                                    <asp:TextBox ID="txtMobileNumber" runat="server" MaxLength="10" CssClass="mobileRestrict"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvMobileNumber" ControlToValidate="txtMobileNumber" ForeColor="#d0582e" Display="Dynamic" runat="server" ErrorMessage="Please enter Mobile Number" ValidationGroup="Save"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="rgvMobile" runat="server" ErrorMessage="Please enter 10 digits" ValidationExpression="[0-9]{10}" Display="Dynamic" ControlToValidate="txtMobileNumber" ForeColor="#d0582e" ValidationGroup="Save"></asp:RegularExpressionValidator>
                                </div>
                            </div>
                            <div class="clearfix"></div>

                            <div class="vali-form">
                                <div class="col-md-3 form-group1 group-mail">
                                    <label class="control-label">Email<span style="color: #d0582e">*</span></label>
                                    <asp:TextBox ID="txtEmail" runat="server"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvEmail" ControlToValidate="txtEmail" ForeColor="#d0582e" Display="Dynamic" runat="server" ErrorMessage="Please enter Email" ValidationGroup="Save"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="revEmail" runat="server" ForeColor="Red" Display="Dynamic" ErrorMessage="Please check Email Format" ControlToValidate="txtEmail" ValidationGroup="Save" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                                </div>
                                <div class="col-md-3 form-group1 group-mail">
                                    <label class="control-label">Login Id<span style="color: #d0582e">*</span></label>
                                    <asp:TextBox ID="txtLogin" runat="server"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvLogin" ControlToValidate="txtLogin" Display="Dynamic" ForeColor="#d0582e" runat="server" ErrorMessage="Please enter Login" ValidationGroup="Save"></asp:RequiredFieldValidator>
                                </div>
                                <div class="col-md-3 form-group1">
                                    <label class="control-label">Password<span style="color: #d0582e">*</span></label>
                                    <asp:TextBox ID="txtPassword" runat="server" TextMode="Password"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvPassword" ControlToValidate="txtPassword" Display="Dynamic" ForeColor="#d0582e" runat="server" ErrorMessage="Please enter Password" ValidationGroup="Save"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="rgvPassword" runat="server"
                                        ErrorMessage="Must be between 7 to 10 characters"
                                        ControlToValidate="txtPassword"
                                        ValidationExpression="^[a-zA-Z0-9'@&#.\s]{7,10}$" Display="Dynamic" ForeColor="#d0582e" />
                                </div>
                                <div class="col-md-3 form-group1 form-last">
                                    <label class="control-label">Confirm password<span style="color: #d0582e">*</span></label>
                                    <asp:TextBox ID="txtConfirmPassword" runat="server" TextMode="Password"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvConfirmPassword" ControlToValidate="txtConfirmPassword" Display="Dynamic" ForeColor="#d0582e" runat="server" ErrorMessage="Please enter Confirm Password" ValidationGroup="Save"></asp:RequiredFieldValidator>
                                    <asp:CompareValidator ID="cvPassword" runat="server" ErrorMessage="Should be same as password" Display="Dynamic" ForeColor="Red" ControlToCompare="txtPassword" ControlToValidate="txtConfirmPassword" Type="String"></asp:CompareValidator>
                                    <asp:RegularExpressionValidator ID="rgvConfirmPassword" runat="server"
                                        ErrorMessage="Must be between 7 to 10 characters"
                                        ControlToValidate="txtConfirmPassword"
                                        ValidationExpression="^[a-zA-Z0-9'@&#.\s]{7,10}$" Display="Dynamic" ForeColor="#d0582e" />
                                </div>
                            </div>
                            <div class="clearfix"></div>
                            <div class="vali-form vali-form1">
                                <div class="col-md-3 form-group1 group-mail">
                                    <label class="control-label">Location</label>
                                    <asp:TextBox ID="txtLocation" runat="server" CssClass="onlyAlphabet toupper"></asp:TextBox>                                    
                                </div>
                                <div class="col-md-3 form-group2 group-mail">
                                    <label class="control-label">User Type<span style="color: #d0582e">*</span></label>
                                    <asp:DropDownList ID="ddlUserType" runat="server">
                                        <asp:ListItem Value="-1" Text="Select"></asp:ListItem>
                                    </asp:DropDownList>
                                    <asp:RequiredFieldValidator ID="rfvUserType" ControlToValidate="ddlUserType" InitialValue="-1" Display="Dynamic" ForeColor="#d0582e" runat="server" ErrorMessage="Please select User Type" ValidationGroup="Save"></asp:RequiredFieldValidator>
                                </div>
                                <div class="col-md-3 form-group2 group-mail">
                                    <label class="control-label">Status<span style="color: #d0582e">*</span></label>
                                    <asp:DropDownList ID="ddlStatus" runat="server">
                                        <asp:ListItem Value="-1" Text="Select"></asp:ListItem>
                                    </asp:DropDownList>
                                    <asp:RequiredFieldValidator ID="rfvStatus" ControlToValidate="ddlStatus" InitialValue="-1" Display="Dynamic" ForeColor="#d0582e" runat="server" ErrorMessage="Please select Status" ValidationGroup="Save"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="clearfix"></div>

                            <div class="col-md-12 form-group button-2">
                                <asp:Button ID="btnSave" runat="server" Text="Submit" class="btn btn-default" ValidationGroup="Save" OnClick="btnSave_Click" />
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

