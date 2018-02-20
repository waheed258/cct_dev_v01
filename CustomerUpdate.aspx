<%@ Page Title="" Language="C#" MasterPageFile="~/Layout.master" AutoEventWireup="true" CodeFile="CustomerUpdate.aspx.cs" Inherits="CustomerUpdate" %>

<%@ MasterType VirtualPath="~/Layout.Master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript">
        $(document).ready(function () {
            $('.Verify').on('input', function () {
                var nFilled = $('.Verify').filter(function () {
                    return $.trim(this.value) !== '';
                }).length;
                $('#ContentPlaceHolder1_btnGetMobileNumber').prop('disabled', nFilled === 0);
            })
    .trigger('input');
        });
    </script>
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
                    <div class="graph-form" id="divCustomerDetails" runat="server">
                        <div class="validation-form">
                            <div runat="server">
                                <div class="vali-form">
                                    <div class="col-md-3 form-group1 group-mail">
                                        <label class="control-label" id="lblCustomerName">Customer Name<span style="color: #d0582e">*</span></label>
                                        <asp:TextBox ID="txtCustomerName" runat="server"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfvCustomerName" ControlToValidate="txtCustomerName" ForeColor="#d0582e" runat="server" ErrorMessage="Please enter Customer Name" ValidationGroup="Save"></asp:RequiredFieldValidator>
                                    </div>
                                    <div class="col-md-3 form-group1">
                                        <label class="control-label" id="lblSurname">Surname<span style="color: #d0582e">*</span></label>
                                        <asp:TextBox ID="txtSurName" runat="server"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfvSurName" ControlToValidate="txtSurName" ForeColor="#d0582e" runat="server" ErrorMessage="Please enter Surname" ValidationGroup="Save"></asp:RequiredFieldValidator>
                                    </div>
                                    <div class="col-md-3 form-group1 form-last">
                                        <label class="control-label">Mobile Number</label>
                                        <asp:TextBox ID="txtMobileNumber" runat="server" ReadOnly="true"></asp:TextBox>

                                    </div>
                                    <div class="col-md-3 form-group1 group-mail">
                                        <label class="control-label">Email</label>
                                        <asp:TextBox ID="txtEmail" runat="server"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfvEmail" ControlToValidate="txtEmail" ForeColor="#d0582e" runat="server" ErrorMessage="Please enter Email" ValidationGroup="Save"></asp:RequiredFieldValidator>
                                    </div>
                                    <div class="col-md-3 form-group1 form-last">
                                        <label class="control-label" id="lblCity">City<span style="color: #d0582e">*</span></label>
                                        <asp:TextBox ID="txtCity" runat="server"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfvCity" ControlToValidate="txtCity" ForeColor="#d0582e" runat="server" ErrorMessage="Please enter City" ValidationGroup="Save"></asp:RequiredFieldValidator>
                                    </div>

                                    <div class="col-md-12 form-group button-2" id="divSaveCancel" runat="server">
                                        <asp:Button ID="btnUpdate" runat="server" Text="Update" class="btn btn-default" ValidationGroup="Save" OnClick="btnUpdate_Click" />
                                        <asp:Button ID="btnCancel" runat="server" Text="Cancel" class="btn btn-default" OnClientClick="javascript:window.close();" />
                                    </div>

                                    <div class="clearfix"></div>

                                </div>
                            </div>

                            <div class="clearfix"></div>
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

