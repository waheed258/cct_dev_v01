<%@ Page Title="" Language="C#" MasterPageFile="~/Layout.master" AutoEventWireup="true" CodeFile="LeadsList.aspx.cs" Inherits="LeadsList" %>

<%@ MasterType VirtualPath="~/Layout.Master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript" src="//cdn.datatables.net/1.10.16/js/jquery.dataTables.min.js"></script>
    <script src="CustomScripts/js/datatableeditor.min.js"></script>
    <link rel="stylesheet" type="text/css" href="//cdn.datatables.net/1.10.16/css/jquery.dataTables.min.css" />
    <script src="//cdn.rawgit.com/rainabba/jquery-table2excel/1.1.0/dist/jquery.table2excel.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/0.9.0rc1/jspdf.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $.ajax({
                url: 'LeadsListService.asmx/GetLeads',
                method: 'post',
                dataType: 'json',
                success: function (data) {

                    $('#leadlist').dataTable({
                        data: data,
                        columns: [
                            { 'data': 'SrNo' },
                            { 'data': 'ClientReqId' },
                            { 'data': 'CustomerName' },
                             { 'data': 'Destination' },
                            { 'data': 'CreatedDate' },
                            { 'data': 'CreatedUser' },
                            { 'data': 'AssignedName' },
                            { 'data': 'Status' },
                            { 'data': 'Services' },
                            { 'data': 'Class' }
                            
                        ]
                    });
                }
            });
            $("#excel").click(function () {
                $("#leadlist").table2excel({
                    filename: "LeadsList.xls"
                });
            });
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div style="text-align: center; margin-top: 10px;" id="divmessage" runat="server">
        <asp:Label ID="lblpermissions" runat="server" Style="color: #006341; font-weight: bold; text-align: center"></asp:Label>
    </div>
    <div class="page-container" id="divLeadList" runat="server">
        <!--/content-inner-->
        <div class="inner-content">
            <!--//outer-wp-->
            <div class="outter-wp">
                <div class="graph">
                    <div class="tables">
                        <table class="table table-bordered" id="leadlist" style="font-size: 100%">
                            <thead>
                                <tr>
                                    <th>Sl.No</th>
                                    <th>Lead Ref No</th>
                                    <th>Customer Name</th>  
                                    <th>Destination</th>  
                                    <th>Date & Time</th>
                                    <th>Lead Created By</th>
                                    <th>Lead Allocated To(TC)</th>
                                    <th>Lead Staus</th>    
                                     <th>Services</th>
                                    <th>Flight CLass</th>                                      
                                </tr>
                            </thead>
                            <tbody></tbody>
                        </table>
                    </div>
                </div>
                <div class="clear-fix"></div>
                <div>
                    <button type="button" id="excel" class="btn btn-default">Export Excel</button>
                </div>
                <%-- <div>
                    <button type="button" id="pdf">Export Pdf</button>
                </div>--%>
            </div>
            <!--//outer-wp-->
        </div>
        <!--//content-inner-->
        <!--/sidebar-menu-->
    </div>
</asp:Content>

