<%@ Page Title="" Language="C#" MasterPageFile="~/Layout.master" AutoEventWireup="true" CodeFile="NewCustomer.aspx.cs" Inherits="NewCustomer" %>

<%@ MasterType VirtualPath="~/Layout.Master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript">
        $(document).ready(function (event) {
            $("#ContentPlaceHolder1_txtMobileNum").bind('keypress', function (e) {
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
            $("#ContentPlaceHolder1_txtMobileNum").bind('mouseenter', function (e) {
                var val = $(this).val();
                if (val != '0') {
                    val = val.replace(/[^0-9]+/g, "");
                    $(this).val(val);
                }
            });
            $('.Verify').on('input', function () {
                var nFilled = $('.Verify').filter(function () {
                    return $.trim(this.value) !== '';
                }).length;
                $('#ContentPlaceHolder1_btnValidate').prop('disabled', nFilled === 0);
            })
    .trigger('input');
            $(".onlyAlphabet").keypress(function (e) {
                var key = e.keyCode;
                if (key >= 48 && key <= 57) {
                    e.preventDefault();
                }
            });
            $("select").on('change', function () {
                var total = 0;
                $(".pax option:selected").each(function () {
                    total += parseInt($(this).val());
                });
                $("#ContentPlaceHolder1_txtNoOfPax").val(total);
            }).change();
            DatePickerSet();
            DatePickerSet1();
        });

        function DatePickerSet() {

            $("#ContentPlaceHolder1_txtDepartureDate").datepicker({
                startDate: 'today',
                minDate: 0,
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
        }
        function DatePickerSet1() {
            $("#ContentPlaceHolder1_txtReturnDate").datepicker({
                startDate: 'today',
                numberOfMonths: 1,
                dateFormat: 'dd-mm-yy',
                autoclose: true
            });
        }
    </script>
    <style type="text/css">
        .spaced {
            padding: 10px;
        }

            .spaced Label {
                padding: 10px;
            }
    </style>
    <script type="text/javascript">
        function ValidateCheckBoxList1(sender, args) {
            if ($("[id*=chbklstClass] input:checked").length > 0 || $("[id*=chbklstAdditionalInfo] input:checked").length > 0)
                args.IsValid = true;
            else
                args.IsValid = false;
        }
    </script>
    <script type="text/javascript">
        function doClick(btnValidate, e) {

            var key;

            if (window.event)
                key = window.event.keyCode;
            else
                key = e.which;

            if (key == 13) {

                var btn = document.getElementById(btnValidate);
                if (btn != null) {
                    btn.click();
                    event.keyCode = 0
                }
            }
        }
        function FormatIt(obj) {
            if (obj.value.length == 2) // Day
                obj.value = obj.value + "/";
            if (obj.value.length == 5) // month
                obj.value = obj.value + "/";
        }

        function ValidateClassList(source, args) {
            var chkListModules = document.getElementById('<%= chbkClass.ClientID %>');
            var chkListinputs = chkListModules.getElementsByTagName("input");
            for (var i = 0; i < chkListinputs.length; i++) {
                if (chkListinputs[i].checked) {
                    args.IsValid = true;
                    return;
                }
            }
            args.IsValid = false;
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="page-container" id="divCustomerInfoPage" runat="server">
        <!--/content-inner-->
        <div class="inner-content">
            <!--//outer-wp-->
            <div class="outter-wp">
                <div style="text-align: center; margin-bottom: 10px;">
                    <asp:Label ID="lblMessage" runat="server" Style="color: #006341; font-weight: bold; text-align: center"></asp:Label>
                </div>
                <!--/forms-->
                <div class="forms-main">
                    <div class="row">
                        <div class="col-lg-6">
                            <h5 class="inner-tittle" id="h5VerifyCustomer" runat="server" style="font-family: Open Sans, sans-serif; color: #006341; font-weight: bold; margin-bottom: 10px">Verify Customer</h5>
                        </div>
                        <%--<div class="col-lg-6 text-right">
                            <span class="countdown" style="color: #006341; font-weight: bold; margin-bottom: 10px"></span>
                        </div>--%>
                    </div>
                    <div class="graph-form" id="divVerify" runat="server">
                        <div class="validation-form">
                            <div class="vali-form">

                                <div class="col-md-2 form-group1">
                                    <label class="control-label" id="lblMobileNum">Mobile Number</label>
                                    <asp:TextBox ID="txtMobileNum" runat="server" MaxLength="10" CssClass="Verify"></asp:TextBox>
                                    <asp:RegularExpressionValidator ID="rgvMobile" runat="server" ErrorMessage="Please enter 10 digits" ValidationExpression="[0-9]{10}" Display="Dynamic"
                                        ControlToValidate="txtMobileNum" ForeColor="#d0582e" ValidationGroup="ValidateVerify"></asp:RegularExpressionValidator>
                                </div>
                                <div class="col-md-2 form-group1">
                                    <label class="control-label" id="lblEmailId">Email Id</label>
                                    <asp:TextBox ID="txtEmailId" runat="server" CssClass="Verify"></asp:TextBox>
                                    <asp:Label ID="lblValid1" runat="server" Text=""></asp:Label>
                                    <asp:RegularExpressionValidator ID="revEmail" runat="server" ForeColor="Red" Display="Dynamic" ErrorMessage="Please check Email Format"
                                        ControlToValidate="txtEmailId" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ValidationGroup="ValidateVerify">
                                    </asp:RegularExpressionValidator>
                                    <asp:RequiredFieldValidator ID="rfvEmailId" runat="server" ControlToValidate="txtEmailId" ForeColor="#d0582e"
                                        ErrorMessage="Please enter email id" ValidationGroup="SaveLead"></asp:RequiredFieldValidator>
                                </div>
                                <div class="col-md-1 form-group button-2">
                                    <asp:Button ID="btnValidate" runat="server" Text="Verify" Style="margin-top: 2em" CssClass="VerifyButton" ValidationGroup="ValidateVerify"
                                        OnClick="btnValidate_Click1" />
                                </div>
                                <div class="col-md-2 form-group1 group-mail">
                                    <label class="control-label" id="lblCustomerName">Customer Name<span style="color: #d0582e">*</span></label>
                                    <asp:TextBox ID="txtCustomerName" runat="server" CssClass="onlyAlphabet toupper"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvCustomerName" ControlToValidate="txtCustomerName" ForeColor="#d0582e" runat="server"
                                        ErrorMessage="Please enter Customer Name" ValidationGroup="SaveLead"></asp:RequiredFieldValidator>
                                </div>
                                <div class="col-md-2 form-group1">
                                    <label class="control-label" id="lblSurname">Surname<span style="color: #d0582e">*</span></label>
                                    <asp:TextBox ID="txtSurName" runat="server" CssClass="onlyAlphabet toupper"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvSurName" ControlToValidate="txtSurName" ForeColor="#d0582e" runat="server"
                                        ErrorMessage="Please enter Surname" ValidationGroup="SaveLead"></asp:RequiredFieldValidator>
                                </div>
                                <div class="col-md-2 form-group1 form-last">
                                    <label class="control-label" id="lblCity">City<span style="color: #d0582e">*</span></label>
                                    <asp:TextBox ID="txtCity" runat="server" CssClass="onlyAlphabet toupper"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvCity" ControlToValidate="txtCity" ForeColor="#d0582e" runat="server"
                                        ErrorMessage="Please enter City" ValidationGroup="SaveLead"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="clearfix"></div>
                        </div>
                    </div>
                    <h5 class="inner-tittle" id="h5CustomerInfo" runat="server" style="font-family: Open Sans, sans-serif; color: #006341; font-weight: bold; margin-bottom: 10px; margin-top: 10px">Customer and Lead Information</h5>
                    <div class="graph-form" id="divCustomerDetails" runat="server">
                        <div class="validation-form">
                            <div runat="server">
                                <div class="vali-form">
                                    <div class="row">
                                        <div class="col-md-2 form-group1">
                                            <label class="control-label" id="lblDestination">Destination<span style="color: #d0582e">*</span></label>
                                            <asp:TextBox ID="txtDestination" runat="server" CssClass="onlyAlphabet toupper"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="rfvDestination" ControlToValidate="txtDestination" ForeColor="#d0582e" runat="server"
                                                ErrorMessage="Please enter Destination" ValidationGroup="SaveLead"></asp:RequiredFieldValidator>
                                        </div>
                                        <div class="col-md-2 form-group1 form-last">
                                            <label class="control-label" id="lblDepartingFrom">Departing From<span style="color: #d0582e">*</span></label>
                                            <asp:TextBox ID="txtDepartingFrom" runat="server" CssClass="onlyAlphabet toupper"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="rfvDepartingFrom" ControlToValidate="txtDepartingFrom" ForeColor="#d0582e" runat="server"
                                                ErrorMessage="Please enter DepartingFrom" ValidationGroup="SaveLead"></asp:RequiredFieldValidator>
                                        </div>
                                        <div class="col-md-2 form-group1">
                                            <label class="control-label input-append date datepicker span12" id="lblDepartureDate">Departure Date<span style="color: #d0582e">*</span></label>

                                            <asp:TextBox ID="txtDepartureDate" onkeyup="FormatIt(this);" runat="server" MaxLength="10"></asp:TextBox>                                            
                                            <asp:RequiredFieldValidator ID="rfvDepartureDate" ControlToValidate="txtDepartureDate" ForeColor="#d0582e" runat="server"
                                                ErrorMessage="Please enter Departure Date" ValidationGroup="SaveLead"></asp:RequiredFieldValidator>
                                        </div>
                                        <div class="col-md-2 form-group1 form-last">
                                            <label class="control-label" id="lblReturnDate">Return Date</label>
                                            <asp:TextBox ID="txtReturnDate" runat="server" onkeyup="FormatIt(this);" runat="server" MaxLength="10"></asp:TextBox>                                            
                                            <asp:CustomValidator ID="cvReturnDate" runat="server"
                                                ClientValidationFunction="cvfReturnDate"></asp:CustomValidator>
                                        </div>
                                        <div class="col-md-1 form-group1 group-mail , col-md-3 form-group2 group-mail">
                                            <label class="control-label" id="lblNoOfAdults">Adults</label>
                                            <asp:DropDownList ID="ddlNoOfAdults" runat="server" CssClass="pax">
                                                <asp:ListItem Value="1" Text="1"></asp:ListItem>
                                                <asp:ListItem Value="2" Text="2"></asp:ListItem>
                                                <asp:ListItem Value="3" Text="3"></asp:ListItem>
                                                <asp:ListItem Value="4" Text="4"></asp:ListItem>
                                                <asp:ListItem Value="5" Text="5"></asp:ListItem>
                                                <asp:ListItem Value="6" Text="6"></asp:ListItem>
                                                <asp:ListItem Value="7" Text="7"></asp:ListItem>
                                                <asp:ListItem Value="8" Text="8"></asp:ListItem>
                                                <asp:ListItem Value="9" Text="9"></asp:ListItem>
                                            </asp:DropDownList>
                                        </div>
                                        <div class="col-md-1 form-group1,col-md-3 form-group2 group-mail">
                                            <label class="control-label" id="lblNoOfChilds">Children</label>
                                            <asp:DropDownList ID="ddlNoOfChilds" runat="server" CssClass="pax">
                                                <asp:ListItem Value="0" Text="0"></asp:ListItem>
                                                <asp:ListItem Value="1" Text="1"></asp:ListItem>
                                                <asp:ListItem Value="2" Text="2"></asp:ListItem>
                                                <asp:ListItem Value="3" Text="3"></asp:ListItem>
                                                <asp:ListItem Value="4" Text="4"></asp:ListItem>
                                                <asp:ListItem Value="5" Text="5"></asp:ListItem>
                                                <asp:ListItem Value="6" Text="6"></asp:ListItem>
                                            </asp:DropDownList>
                                        </div>
                                        <div class="col-md-1 form-group1 form-last,col-md-3 form-group2 group-mail">
                                            <label class="control-label" id="lblNoOfInfants">Infants</label>
                                            <asp:DropDownList ID="ddlNoOfInfants" runat="server" CssClass="pax">
                                                <asp:ListItem Value="0" Text="0"></asp:ListItem>
                                                <asp:ListItem Value="1" Text="1"></asp:ListItem>
                                                <asp:ListItem Value="2" Text="2"></asp:ListItem>
                                                <asp:ListItem Value="3" Text="3"></asp:ListItem>
                                                <asp:ListItem Value="4" Text="4"></asp:ListItem>
                                                <asp:ListItem Value="5" Text="5"></asp:ListItem>
                                                <asp:ListItem Value="6" Text="6"></asp:ListItem>
                                            </asp:DropDownList>
                                        </div>
                                        <div class="col-md-1 form-group1 group-mail">
                                            <label class="control-label" id="lblNoOfPax">Pax</label>
                                            <asp:TextBox ID="txtNoOfPax" runat="server" ReadOnly="true" Enabled="false"></asp:TextBox>
                                        </div>
                                        <div class="col-md-4 form-group1 group-mail" style="margin-top: 35px">
                                            <asp:Label ID="lblNoOfPass" runat="server" Text="" Visible="false" ForeColor="#d0582e"></asp:Label>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-6 form-group2">
                                            <div class="row">
                                                <div class="col-md-2 form-group2 group-mail,checkbox-inline">
                                                    <label class="control-label" id="lblAdditionalInfo">Services<span style="color: #d0582e">*</span></label>
                                                    <asp:CheckBoxList ID="chbklstAdditionalInfo" runat="server" CssClass="spaced" AutoPostBack="true"
                                                        RepeatDirection="Horizontal" OnSelectedIndexChanged="chbklstAdditionalInfo_SelectedIndexChanged">
                                                        <asp:ListItem Text="Flight" Value="0"></asp:ListItem>
                                                    </asp:CheckBoxList>
                                                </div>
                                                <div class="col-md-10 form-group2 group-mail,checkbox-inline" id="divClassItems" runat="server">
                                                    <label class="control-label" id="lblClass">Flight Class</label>
                                                    <asp:CheckBoxList ID="chbkClass" runat="server" CssClass="spaced"
                                                        RepeatDirection="Horizontal">
                                                        <asp:ListItem Text="Economy" Value="1"></asp:ListItem>
                                                        <asp:ListItem Text="Premium Economy" Value="2"></asp:ListItem>
                                                        <asp:ListItem Text="Business" Value="3"></asp:ListItem>
                                                        <asp:ListItem Text="First" Value="4"></asp:ListItem>
                                                        <asp:ListItem Text="Premium First" Value="5"></asp:ListItem>
                                                    </asp:CheckBoxList>
                                                    <asp:CustomValidator ID="cvFlightClass" runat="server" ErrorMessage="Please select at Least one class" Enabled="false"
                                                        ForeColor="#d0582e" ValidationGroup="SaveLead" ClientValidationFunction="ValidateClassList" Display="Dynamic"></asp:CustomValidator>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-12 form-group2 group-mail,checkbox-inline" runat="server">
                                                    <asp:CheckBoxList ID="chbklstClass" runat="server" RepeatDirection="Horizontal"
                                                        CssClass="spaced">
                                                        <asp:ListItem Text="Hotel" Value="1"></asp:ListItem>
                                                        <asp:ListItem Text="Car" Value="2"></asp:ListItem>
                                                        <asp:ListItem Text="Transfer" Value="3"></asp:ListItem>
                                                        <asp:ListItem Text="Visa" Value="4"></asp:ListItem>
                                                        <asp:ListItem Text="Insurance" Value="5"></asp:ListItem>
                                                        <asp:ListItem Text="Tours" Value="6"></asp:ListItem>
                                                    </asp:CheckBoxList>
                                                    <asp:CustomValidator ID="cvClass" runat="server" ErrorMessage="Please Select at Least One Service"
                                                        ForeColor="#d0582e" ValidationGroup="SaveLead" ClientValidationFunction="ValidateCheckBoxList1" Display="Dynamic"></asp:CustomValidator>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6 form-group2">
                                            <div class="row">
                                                <div class="col-md-6 form-group1">
                                                    <label class="control-label" id="lblAdditionalInformation">Additional Information</label>
                                                    <asp:TextBox ID="txtAdditionalInformation" runat="server" placeholder="Special services required" TextMode="MultiLine"></asp:TextBox>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-7 form-group button-2 text-right">
                                            <asp:Button ID="Button1" runat="server" Text="Submit" class="btn btn-default" ValidationGroup="SaveLead" OnClick="Button1_Click" />
                                            <asp:Button ID="Button2" runat="server" Text="Back" OnClick="Button2_Click" class="btn btn-default" />
                                        </div>
                                    </div>
                                </div>
                            </div>
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

