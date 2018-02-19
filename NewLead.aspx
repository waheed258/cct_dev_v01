﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Layout.master" AutoEventWireup="true" CodeFile="NewLead.aspx.cs" Inherits="NewLead" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript">
        $(document).ready(function () {
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
            if ($("[id*=chbkClass] input:checked").length > 0)
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
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
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
                    <h5 class="inner-tittle" id="h5VerifyCustomer" runat="server" style="font-family: Open Sans, sans-serif; color: #006341; font-weight: bold; margin-bottom: 10px">Lead Reference:<asp:Label ID="lblrefno" runat="server"></asp:Label></h5>
                    <div class="graph-form">
                        <div class="validation-form">
                            <asp:UpdatePanel ID="updatePanel1" runat="server">
                                <ContentTemplate>
                                    <div class="vali-form">
                                        <div class="col-md-2 form-group1">
                                            <label class="control-label" id="lblDestination">Destination<span style="color: #d0582e">*</span></label>
                                            <asp:TextBox ID="txtDestination" runat="server" CssClass="onlyAlphabet toupper"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="rfvDestination" ControlToValidate="txtDestination" ForeColor="#d0582e" runat="server"
                                                ErrorMessage="Please enter Destination" ValidationGroup="Save"></asp:RequiredFieldValidator>
                                        </div>
                                        <div class="col-md-2 form-group1 form-last">
                                            <label class="control-label" id="lblDepartingFrom">Departing From</label>
                                            <asp:TextBox ID="txtDepartingFrom" runat="server" CssClass="onlyAlphabet toupper"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="rfvDepartingFrom" ControlToValidate="txtDepartingFrom" ForeColor="#d0582e" runat="server"
                                                ErrorMessage="Please enter DepartingFrom" ValidationGroup="Save"></asp:RequiredFieldValidator>
                                        </div>

                                        <div class="col-md-2 form-group1">
                                            <label class="control-label" id="lblDepartureDate">Departure Date</label>
                                            <asp:TextBox ID="txtDepartureDate" runat="server" OnTextChanged="txtDepartureDate_TextChanged" AutoPostBack="true"></asp:TextBox>
                                            <ajaxToolkit:CalendarExtender ID="clextDeparture" runat="server" TargetControlID="txtDepartureDate" Format="dd-MM-yyyy" />
                                            <asp:RequiredFieldValidator ID="rfvDepartureDate" ControlToValidate="txtDepartureDate" ForeColor="#d0582e" runat="server"
                                                ErrorMessage="Please enter Departure Date" ValidationGroup="Save"></asp:RequiredFieldValidator>
                                        </div>

                                        <div class="col-md-2 form-group1 form-last">
                                            <label class="control-label" id="lblReturnDate">Return Date</label>
                                            <asp:TextBox ID="txtReturnDate" runat="server"></asp:TextBox>
                                            <ajaxToolkit:CalendarExtender ID="clextReturn" runat="server" TargetControlID="txtReturnDate" Format="dd-MM-yyyy" />
                                            <asp:RequiredFieldValidator ID="rfvReturnDate" ControlToValidate="txtReturnDate" ForeColor="#d0582e" runat="server"
                                                ErrorMessage="Please enter Return Date" ValidationGroup="Save"></asp:RequiredFieldValidator>
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
                                            <asp:RequiredFieldValidator ID="rfvNoOfAdults" ControlToValidate="ddlNoOfAdults" ForeColor="#d0582e" runat="server"
                                                ErrorMessage="Please select No.of Adults" ValidationGroup="Save" InitialValue="0"></asp:RequiredFieldValidator>
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
                                            <asp:RequiredFieldValidator ID="rfvNoOfChilds" ControlToValidate="ddlNoOfChilds" ForeColor="#d0582e" runat="server"
                                                ErrorMessage="Please select No.of Chilldren" ValidationGroup="Save" InitialValue="-1"></asp:RequiredFieldValidator>
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
                                            <asp:RequiredFieldValidator ID="rfvNoOfInfants" ControlToValidate="ddlNoOfInfants" ForeColor="#d0582e" runat="server"
                                                ErrorMessage="Please select No.of Infants" ValidationGroup="Save" InitialValue="-1"></asp:RequiredFieldValidator>
                                        </div>
                                        <div class="col-md-1 form-group1 group-mail">
                                            <label class="control-label" id="lblNoOfPax">Pax</label>
                                            <asp:TextBox ID="txtNoOfPax" runat="server" ReadOnly="true"></asp:TextBox>
                                            <asp:Label ID="lblNoOfPass" runat="server" Text="" Visible="false" ForeColor="#d0582e"></asp:Label>
                                        </div>
                                    </div>
                                    <div class="clearfix"></div>

                                    <div class="vali-form vali-form1">

                                        <div class="col-md-1 form-group2 group-mail,checkbox-inline" id="divclass" runat="server">
                                            <label class="control-label" id="lblAdditionalInfo">Services</label>
                                            <asp:CheckBoxList ID="chbklstClass" runat="server" RepeatDirection="Horizontal" CssClass="spaced" OnSelectedIndexChanged="chbklstClass_SelectedIndexChanged" AutoPostBack="true">
                                                <asp:ListItem Text="Flight" Value="1"></asp:ListItem>
                                            </asp:CheckBoxList>
                                            <asp:CustomValidator ID="cvClass" runat="server" ErrorMessage="Please Select at Least One Value"
                                                ForeColor="#d0582e" ValidationGroup="Save" ClientValidationFunction="ValidateCheckBoxList1" Display="Dynamic"></asp:CustomValidator>
                                        </div>
                                        <div class="col-md-6 form-group2 group-mail,checkbox-inline" id="divClassItems" runat="server">
                                            <label class="control-label" id="lblClass" style="margin-left: 15px">Class</label>
                                            <asp:CheckBoxList ID="chbkClass" runat="server" CssClass="spaced"
                                                RepeatDirection="Horizontal">
                                                <asp:ListItem Text="Economy" Value="1"></asp:ListItem>
                                                <asp:ListItem Text="Premium Economy" Value="2"></asp:ListItem>
                                                <asp:ListItem Text="Business" Value="3"></asp:ListItem>
                                                <asp:ListItem Text="First" Value="4"></asp:ListItem>
                                                <asp:ListItem Text="Premium First" Value="5"></asp:ListItem>
                                            </asp:CheckBoxList>
                                        </div>

                                        <div class="col-md-12 form-group2 group-mail,checkbox-inline">
                                            <asp:CheckBoxList ID="chbklstAdditionalInfo" runat="server" RepeatDirection="Horizontal" CssClass="spaced">
                                                <asp:ListItem Text="Hotel" Value="1"></asp:ListItem>
                                                <asp:ListItem Text="Car" Value="2"></asp:ListItem>
                                                <asp:ListItem Text="Special Packages" Value="3"></asp:ListItem>
                                                <asp:ListItem Text="Insurance" Value="4"></asp:ListItem>
                                                <asp:ListItem Text="Visa" Value="5"></asp:ListItem>
                                                <asp:ListItem Text="Forex" Value="6"></asp:ListItem>
                                            </asp:CheckBoxList>                                            
                                        </div>
                                        <div class="clearfix"></div>

                                        <div class="vali-form vali-form1">

                                            <div id="isleadaalocate" runat="server">
                                                <div class="col-md-2 form-group2 group-mail">
                                                    <label class="control-label" id="lblLeadStatus">Lead Status</label>
                                                    <asp:DropDownList ID="ddlLeadStatus" runat="server" OnSelectedIndexChanged="ddlLeadStatus_SelectedIndexChanged" AutoPostBack="true"></asp:DropDownList>
                                                    <asp:RequiredFieldValidator ID="rfvLeadStatus" ControlToValidate="ddlLeadStatus" ForeColor="#d0582e" runat="server"
                                                        ErrorMessage="Please enter User Name" ValidationGroup="Save" InitialValue="-1"></asp:RequiredFieldValidator>
                                                </div>
                                                <div id="divfollowupdate" class="col-md-2 form-group1" runat="server">
                                                    <label class="control-label" id="lblFollowUpDate">Followup Date</label>
                                                    <asp:TextBox ID="txtFollowUpdate" runat="server"></asp:TextBox>
                                                    <ajaxToolkit:CalendarExtender ID="ccextFollowUpDate" runat="server" TargetControlID="txtFollowUpdate" Format="dd-MM-yyyy" />
                                                </div>
                                                <div id="divNotes" runat="server">
                                                    <div class="col-md-2 form-group2 group-mail" id="divOnlyAssigned" runat="server">
                                                        <label class="control-label" id="lblAssignedTo">AssignedTo</label>
                                                        <asp:DropDownList ID="ddlAssignedTo" runat="server"></asp:DropDownList>
                                                        <asp:RequiredFieldValidator ID="rfvAssignedTo" ControlToValidate="ddlAssignedTo" ForeColor="#d0582e" runat="server"
                                                            ErrorMessage="Please select User Name" ValidationGroup="Save" InitialValue="-1"></asp:RequiredFieldValidator>
                                                    </div>

                                                    <div class="col-md-5 form-group1" id="divOnlyNotes" runat="server">
                                                        <label class="control-label" id="lblNotes">Notes</label>
                                                        <asp:TextBox ID="txtNotes" runat="server" CssClass="toupper"></asp:TextBox>
                                                    </div>

                                                </div>
                                            </div>
                                        </div>
                                        <div class="clearfix"></div>

                                        <div class="vali-form vali-form1">
                                            <div class="col-md-5 form-group1">
                                                <label class="control-label" id="lblAdditionalInformation">Additional Info</label>
                                                <asp:TextBox ID="txtAdditionalInformation" runat="server" TextMode="MultiLine" placeholder="Specials services required"></asp:TextBox>
                                            </div>
                                            <div class="col-md-7 form-group button-2">
                                                <asp:Button ID="btnUpdate" runat="server" style="margin-top:55px" Text="Update" class="btn btn-default" ValidationGroup="Save" OnClick="btnUpdate_Click" />
                                                <asp:Button ID="btnCancel" runat="server" style="margin-top:55px"  Text="Cancel" class="btn btn-default" OnClick="btnCancel_Click" />
                                            </div>
                                        </div>
                                        <div class="clearfix"></div>                                       
                                        <!---->
                                </ContentTemplate>
                            </asp:UpdatePanel>
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

