<%@ Page Title="" Language="C#" MasterPageFile="~/Layout.master" AutoEventWireup="true" CodeFile="NewCustomer.aspx.cs" Inherits="NewCustomer" %>

<%@ MasterType VirtualPath="~/Layout.Master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript">
        $(document).ready(function () {
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


            var timer2 = "0:00";
            var interval = setInterval(function () {


                var timer = timer2.split(':');
                //by parsing integer, I avoid all extra string processing
                var minutes = parseInt(timer[0], 10);
                var seconds = parseInt(timer[1], 10);
                ++seconds;
                minutes = (seconds < 0) ? ++minutes : minutes;
                if (minutes < 0) clearInterval(interval);
                seconds = (seconds < 0) ? 59 : seconds;
                seconds = (seconds < 10) ? '0' + seconds : seconds;
                //minutes = (minutes < 10) ?  minutes : minutes;
                $('.countdown').html(minutes + ':' + seconds);
                timer2 = minutes + ':' + seconds;
            }, 1000);

        });
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
        function ValidateCheckBoxList(sender, args) {
            if ($("[id*=chbklstAdditionalInfo] input:checked").length > 0)
                args.IsValid = true;
            else
                args.IsValid = false;
        }
        function ValidateCheckBoxList1(sender, args) {
            if ($("[id*=chbklstClass] input:checked").length > 0)
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
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
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
                        <div class="col-lg-6 text-right">
                            <span class="countdown" style="color: #006341; font-weight: bold; margin-bottom: 10px"></span>
                        </div>
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
                                        ControlToValidate="txtEmailId" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ValidationGroup="ValidateVerify"></asp:RegularExpressionValidator>
                                </div>
                                <div class="col-md-1 form-group button-2">
                                    <asp:Button ID="btnValidate" runat="server" Text="Verify" Style="margin-top: 2em" CssClass="VerifyButton" ValidationGroup="ValidateVerify" OnClick="btnValidate_Click1" />
                                </div>

                                <div runat="server" id="divHolderOrNot">

                                    <div class="vali-form">
                                        <div class="col-md-3 form-group1 group-mail" style="margin-top: 2em">
                                            <label class="control-label" id="lblAccountHolder">Are you a Nedbank account holder?<span style="color: #d0582e">*</span></label>
                                        </div>
                                        <div class="col-md-1 form-group1" style="padding-top: 5px; margin-top: 2em">
                                            <asp:RadioButton ID="rdbtnYes" Text="Yes" GroupName="Nedbankaccountholder" runat="server" AutoPostBack="True" OnCheckedChanged="rdbtnYes_CheckedChanged" />
                                        </div>
                                        <div class="col-md-1 form-group1" style="padding-top: 5px; margin-top: 2em">
                                            <asp:RadioButton ID="rdbtnNo" Text="No" runat="server" GroupName="Nedbankaccountholder" AutoPostBack="True" OnCheckedChanged="rdbtnNo_CheckedChanged" />
                                        </div>
                                    </div>

                                </div>

                            </div>

                            <div class="clearfix"></div>
                        </div>
                    </div>
                    <h5 class="inner-tittle" id="h5CustomerInfo" runat="server" style="font-family: Open Sans, sans-serif; color: #006341; font-weight: bold; margin-bottom: 10px; margin-top: 10px">Customer Information</h5>
                    <div class="graph-form" id="divCustomerDetails" runat="server">
                        <div class="validation-form">
                            <div runat="server">
                                <div class="vali-form">
                                    <div class="col-md-2 form-group1 group-mail">
                                        <label class="control-label" id="lblCustomerName">Customer Name<span style="color: #d0582e">*</span></label>
                                        <asp:TextBox ID="txtCustomerName" runat="server" CssClass="onlyAlphabet toupper"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfvCustomerName" ControlToValidate="txtCustomerName" ForeColor="#d0582e" runat="server" ErrorMessage="Please enter Customer Name" ValidationGroup="Save"></asp:RequiredFieldValidator>
                                    </div>
                                    <div class="col-md-2 form-group1">
                                        <label class="control-label" id="lblSurname">Surname<span style="color: #d0582e">*</span></label>
                                        <asp:TextBox ID="txtSurName" runat="server" CssClass="onlyAlphabet toupper"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfvSurName" ControlToValidate="txtSurName" ForeColor="#d0582e" runat="server" ErrorMessage="Please enter Surname" ValidationGroup="Save"></asp:RequiredFieldValidator>
                                    </div>
                                    <div class="col-md-2 form-group1 form-last">
                                        <label class="control-label">Mobile Number</label>
                                        <asp:TextBox ID="txtMobileNumber" runat="server"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfvMobileNumber" ControlToValidate="txtMobileNumber" ForeColor="#d0582e" runat="server" ErrorMessage="Please enter Mobile Number" ValidationGroup="Save"></asp:RequiredFieldValidator>
                                    </div>
                                    <div class="col-md-2 form-group1 group-mail">
                                        <label class="control-label">Email</label>
                                        <asp:TextBox ID="txtEmail" runat="server"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfvEmail" ControlToValidate="txtEmail" ForeColor="#d0582e" runat="server" ErrorMessage="Please enter Email" ValidationGroup="Save"></asp:RequiredFieldValidator>
                                    </div>
                                    <div class="col-md-2 form-group1 form-last">
                                        <label class="control-label" id="lblCity">City<span style="color: #d0582e">*</span></label>
                                        <asp:TextBox ID="txtCity" runat="server" CssClass="onlyAlphabet toupper"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfvCity" ControlToValidate="txtCity" ForeColor="#d0582e" runat="server" ErrorMessage="Please enter City" ValidationGroup="Save"></asp:RequiredFieldValidator>
                                    </div>
                                    <div class="col-md-3 form-group button-2" id="divSaveCancel" runat="server" style="margin-top: 2em">
                                        <asp:Button ID="btnSave" runat="server" Text="Submit" class="btn btn-default" ValidationGroup="Save" OnClick="btnSave_Click" />
                                        <asp:Button ID="btnCancel" runat="server" Text="Cancel" class="btn btn-default" />
                                    </div>
                                    <div class="clearfix"></div>
                                </div>
                            </div>

                            <div class="clearfix"></div>
                        </div>
                    </div>
                    <h5 class="inner-tittle" id="h5CreateLead" runat="server" style="font-family: Open Sans, sans-serif; color: #006341; font-weight: bold; margin-bottom: 10px; margin-top: 10px">Create Lead</h5>
                    <div class="graph-form" id="divNewLead" runat="server">
                        <div class="validation-form">
                            <div class="vali-form">
                                <asp:UpdatePanel ID="updatePanel1" runat="server">
                                    <ContentTemplate>
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

                                            <asp:TextBox ID="txtDepartureDate" runat="server" OnTextChanged="txtDepartureDate_TextChanged" AutoPostBack="true"></asp:TextBox>
                                            <ajaxToolkit:CalendarExtender ID="clextDeparture" runat="server" TargetControlID="txtDepartureDate" Format="dd-MM-yyyy" />


                                            <asp:RequiredFieldValidator ID="rfvDepartureDate" ControlToValidate="txtDepartureDate" ForeColor="#d0582e" runat="server"
                                                ErrorMessage="Please enter Departure Date" ValidationGroup="SaveLead"></asp:RequiredFieldValidator>
                                        </div>
                                        <div class="col-md-2 form-group1 form-last">
                                            <label class="control-label" id="lblReturnDate">Return Date</label>
                                            <asp:TextBox ID="txtReturnDate" runat="server"></asp:TextBox>
                                            <ajaxToolkit:CalendarExtender ID="clextReturn" runat="server" TargetControlID="txtReturnDate" Format="dd-MM-yyyy" />
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
                                            <asp:TextBox ID="txtNoOfPax" runat="server" ReadOnly="true"></asp:TextBox>
                                            <asp:Label ID="lblNoOfPass" runat="server" Text="" Visible="false" ForeColor="#d0582e"></asp:Label>
                                        </div>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </div>
                            <div class="clearfix"></div>

                            <div class="vali-form vali-form1">
                                <asp:UpdatePanel ID="updatePanel2" runat="server">
                                    <ContentTemplate>
                                        <div class="col-md-1 form-group2 group-mail,checkbox-inline">
                                            <label class="control-label" id="lblAdditionalInfo">Services<span style="color: #d0582e">*</span></label>
                                            <asp:CheckBoxList ID="chbklstAdditionalInfo" runat="server" CssClass="spaced"
                                                RepeatDirection="Horizontal" OnSelectedIndexChanged="chbklstAdditionalInfo_SelectedIndexChanged" AutoPostBack="true">
                                                <asp:ListItem Text="Flight" Value="1"></asp:ListItem>
                                            </asp:CheckBoxList>
                                            <asp:CustomValidator ID="cvAdditionalInfo" runat="server" ErrorMessage="Please select at Least One Service"
                                                ForeColor="#d0582e" ValidationGroup="SaveLead" ClientValidationFunction="ValidateCheckBoxList" Display="Dynamic"></asp:CustomValidator>
                                        </div>
                                        <div class="col-md-11 form-group2 group-mail,checkbox-inline" id="divClassItems" runat="server">
                                            <label class="control-label" id="lblClass">Class</label>
                                            <asp:CheckBoxList ID="chbkClass" runat="server" CssClass="spaced"
                                                RepeatDirection="Horizontal">
                                                <asp:ListItem Text="Economy" Value="1"></asp:ListItem>
                                                <asp:ListItem Text="Premium Economy" Value="2"></asp:ListItem>
                                                <asp:ListItem Text="Business" Value="3"></asp:ListItem>
                                                <asp:ListItem Text="First" Value="4"></asp:ListItem>
                                                <asp:ListItem Text="Premium First" Value="5"></asp:ListItem>
                                            </asp:CheckBoxList>
                                        </div>
                                        <div class="col-md-12 form-group2 group-mail,checkbox-inline" runat="server">
                                            <asp:CheckBoxList ID="chbklstClass" runat="server" RepeatDirection="Horizontal"
                                                CssClass="spaced">
                                                <asp:ListItem Text="Hotel" Value="1"></asp:ListItem>
                                                <asp:ListItem Text="Car" Value="2"></asp:ListItem>
                                                <asp:ListItem Text="Special Packages" Value="3"></asp:ListItem>
                                                <asp:ListItem Text="Insurance" Value="4"></asp:ListItem>
                                                <asp:ListItem Text="Visa" Value="5"></asp:ListItem>
                                                <asp:ListItem Text="Forex" Value="6"></asp:ListItem>
                                            </asp:CheckBoxList>
                                            <asp:CustomValidator ID="cvClass" runat="server" ErrorMessage="Please Select at Least One Value"
                                                ForeColor="#d0582e" ValidationGroup="SaveLead" ClientValidationFunction="ValidateCheckBoxList1" Display="Dynamic"></asp:CustomValidator>
                                        </div>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </div>
                            <div class="clearfix"></div>
                            <div class="vali-form vali-form1">
                                <div class="col-md-2 form-group1">
                                    <label class="control-label" id="lblAdditionalInformation">Additional Information</label>
                                    <asp:TextBox ID="txtAdditionalInformation" runat="server" CssClass="onlyAlphabet toupper"></asp:TextBox>
                                </div>
                                <div class="col-md-4 form-group button-2" style="margin-top: 2em">
                                    <asp:Button ID="Button1" runat="server" Text="Submit" class="btn btn-default" ValidationGroup="SaveLead" OnClick="Button1_Click" />
                                    <asp:Button ID="Button2" runat="server" Text="Cancel" class="btn btn-default" />
                                </div>
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

