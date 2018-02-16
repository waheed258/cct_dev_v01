<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Nedbank Call Center</title>
    <!-- custom-theme -->
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="keywords" content="Hauling Responsive web template, Bootstrap Web Templates, Flat Web Templates, Android Compatible web template,
Smartphone Compatible web template, free webdesigns for Nokia, Samsung, LG, SonyEricsson, Motorola web design" />
    <script type="application/x-javascript">
        addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false);
               function hideURLbar(){ window.scrollTo(0,1); } </script>
    <link rel="shortcut icon" type="image/png" href="CustomScripts/images/favicon.ico" />
    <!-- For Testimonials slider -->
    <link rel="stylesheet" href="CustomScripts/css/flexslider.css" type="text/css" media="all" />
    <!-- //For Testimonials slider -->
    <!-- //custom-theme files-->
    <link href="CustomScripts/css/bootstrap.css" rel="stylesheet" type="text/css" media="all" />
    <link href="CustomScripts/css/style.css" rel="stylesheet" type="text/css" media="all" />
    <!-- //custom-theme files-->
    <!-- font-awesome-icons -->
    <link href="CustomScripts/css/font-awesome.css" rel="stylesheet" />
    <!-- //font-awesome-icons -->
    <!-- googlefonts -->
    <link href="//fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i,800,800i&amp;subset=cyrillic,cyrillic-ext,greek,greek-ext,latin-ext,vietnamese" rel="stylesheet" />
    <link href="//fonts.googleapis.com/css?family=Montserrat:100,100i,200,200i,300,300i,400,400i,500,500i,600,600i,700,700i,800,800i,900,900i&amp;subset=latin-ext,vietnamese" rel="stylesheet" />
    <!-- //googlefonts -->
    <!-- Custom CSS -->
    <link href="CustomScripts/custom/css/style.css" rel='stylesheet' type='text/css' />
    <!-- Graph CSS -->

    <!-- lined-icons -->
    <link rel="stylesheet" href="CustomScripts/custom/css/icon-font.min.css" type='text/css' />
    <!-- //lined-icons -->
    <%--<script src="CustomScripts/custom/js/jquery-1.10.2.min.js"></script>--%>
    <script type="text/javascript" src="CustomScripts/js/jquery-2.1.4.min.js"></script>
    <!--clock init-->
    <script src="CustomScripts/custom/js/css3clock.js"></script>
    <!--Easy Pie Chart-->
    <!--skycons-icons-->
    <script src="CustomScripts/custom/js/skycons.js"></script>
    <style type="text/css">
        html, body {
            background: #006341;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <!--/login-->
        <div class="error_page">
            <!--/login-top-->
            <div class="error-top">
                <div>
                    <img src="CustomScripts/images/NEDBANK_logo_RGB_hr.png" width="150" height="150" />
                </div>
                <div class="login">
                    <asp:TextBox ID="txtUserName" runat="server" MaxLength="20" placeholder="Login Id"></asp:TextBox>
                    <asp:TextBox ID="txtPassword" TextMode="Password" runat="server" placeholder="Password"></asp:TextBox>

                    <div class="submit">
                        <asp:Button ID="btnLogin" runat="server" Text="Login" class="btn btn-default" ValidationGroup="Save" OnClick="btnLogin_Click" />
                        <div class="clearfix"></div>
                        <div class="new">
                            <p>
                                <label class="checkbox11">
                                    <input type="checkbox" name="checkbox" /><i></i>Forgot Password ?</label>
                            </p>
                            <p class="sign">
                                <asp:Label ID="lblError" runat="server" ForeColor="#d0582e"></asp:Label>
                            </p>
                            <div class="clearfix"></div>
                        </div>
                    </div>
                </div>
                <!--//login-top-->
            </div>
        </div>
        <script src="js/jquery.nicescroll.js"></script>
        <script src="js/scripts.js"></script>
        <!-- Bootstrap Core JavaScript -->
        <script src="js/bootstrap.min.js"></script>
    </form>
</body>
</html>
