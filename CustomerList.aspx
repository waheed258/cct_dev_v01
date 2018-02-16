<%@ Page Title="" Language="C#" MasterPageFile="~/Layout.master" AutoEventWireup="true" CodeFile="CustomerList.aspx.cs" Inherits="CustomerList" %>

<%@ MasterType VirtualPath="~/Layout.Master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript" src="//cdn.datatables.net/1.10.16/js/jquery.dataTables.min.js"></script>
    <link rel="stylesheet" type="text/css" href="//cdn.datatables.net/1.10.16/css/jquery.dataTables.min.css" />
    <script src="//cdn.rawgit.com/rainabba/jquery-table2excel/1.1.0/dist/jquery.table2excel.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/0.9.0rc1/jspdf.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $.ajax({
                url: 'CustomerListService.asmx/GetCustomers',
                method: 'post',
                dataType: 'json',
                success: function (data) {
                    $('#customerlist').dataTable({
                        data: data,
                        columns: [
                            { 'data': 'CustomerName' },
                            { 'data': 'Surname' },
                            { 'data': 'MobileNum' },
                            { 'data': 'City' },
                            { 'data': 'EmailId' }
                        ]
                    });
                }
            });
            $("#excel").click(function () {
                $("#customerlist").table2excel({
                    filename: "CustomersList.xls"
                });
            });
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div style="text-align: center; margin-top: 10px;" id="divmessage" runat="server">
        <asp:Label ID="lblpermissions" runat="server" Style="color: #006341; font-weight: bold; text-align: center"></asp:Label>
    </div>
    <div class="page-container" id="divCustomerList" runat="server">
        <!--/content-inner-->
        <div class="inner-content">
            <!--//outer-wp-->
            <div class="outter-wp">
                <div class="graph">
                    <div class="tables">
                        <table class="table table-bordered" id="customerlist" style="font-size: 100%">
                            <thead>
                                <tr>
                                    <th>Customer Name</th>
                                    <th>Surname</th>
                                    <th>Mobile Number</th>
                                    <th>City</th>
                                    <th>Email ID</th>
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

