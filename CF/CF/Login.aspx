<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="CF.Login" %>

<!DOCTYPE html>

<html xmlns="https://www.w3.org/1999/xhtml">
<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>Log in</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport" />
    <!-- Bootstrap 3.3.7 -->
    <link rel="stylesheet" href="bower_components/bootstrap/dist/css/bootstrap.min.css" />
    <!-- Font Awesome -->
    <link rel="stylesheet" href="bower_components/font-awesome/css/font-awesome.min.css" />
    <!-- Ionicons -->
    <link rel="stylesheet" href="bower_components/Ionicons/css/ionicons.min.css" />
    <!-- Theme style -->
    <link rel="stylesheet" href="dist/css/AdminLTE.min.css" />
    <!-- iCheck -->
    <link rel="stylesheet" href="plugins/iCheck/square/blue.css" />

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
  <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
  <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
  <![endif]-->

    <!-- Google Font -->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,600,700,300italic,400italic,600italic" />
    <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
    <style>
        .login-box .login-box-body {
            background: white;
            border: 1px solid rgba(147, 184, 189,0.8);
            -webkit-box-shadow: 0pt 2px 5px rgba(105, 108, 109, 0.7), 0px 0px 8px 5px rgba(208, 223, 226, 0.4) inset;
            -moz-box-shadow: 0pt 2px 5px rgba(105, 108, 109, 0.7), 0px 0px 8px 5px rgba(208, 223, 226, 0.4) inset;
            box-shadow: 0pt 2px 5px rgba(105, 108, 109, 0.7), 0px 0px 8px 5px rgba(208, 223, 226, 0.4) inset;
            -webkit-box-shadow: 5px;
            -moz-border-radius: 5px;
            border-radius: 5px;
        }

        body {
            background: url(Images/login-background.png) !important;
            background-size: cover !important;
        }
    </style>
    <script>
        function ShowAlert(msg, type) {
            debugger;
            swal("", msg, type);
        }
    </script>
</head>
<body class="hold-transition login-page">
    <div class="login-box">

        <!-- /.login-logo -->
        <div class="login-box-body">
            <p class="login-box-msg">Sign in to start your session</p>

            <form runat="server" method="post" style="padding: 5%">
                <div class="form-group has-feedback">
                    <label>User Name</label>
                    <asp:TextBox ID="txtUserId" runat="server" CssClass="form-control" placeholder="User Name" />
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="txtUserId" ErrorMessage="Please enter user id" Display="Dynamic" CssClass="text-danger"></asp:RequiredFieldValidator>
                    <span class="glyphicon glyphicon-envelope form-control-feedback"></span>
                </div>
                <div class="form-group has-feedback">
                    <label>Password</label>
                    <asp:TextBox ID="txtPassword" TextMode="Password" runat="server" CssClass="form-control" placeholder="Password" />
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="txtPassword" ErrorMessage="Please enter password" Display="Dynamic" CssClass="text-danger"></asp:RequiredFieldValidator>
                    <span class="glyphicon glyphicon-lock form-control-feedback"></span>
                </div>
                <div class="row">
                    <!-- /.col -->
                    <div class="col-xs-4" style="float: right">
                        <div class="form-group">
                            <asp:Button ID="btnLogin" runat="server" OnClick="btnLogin_Click" CssClass="btn btn-primary btn-block btn-flat" Text="Sign In" />
                        </div>
                    </div>
                    <!-- /.col -->
                </div>
            </form>
            <!-- /.social-auth-links -->

            <%--<a href="#">I forgot my password</a><br />--%>
            <%--<a href="#" class="text-center">Register a new membership</a>--%>
        </div>
        <!-- /.login-box-body -->
    </div>
    <!-- /.login-box -->

    <!-- jQuery 3 -->
    <script src="bower_components/jquery/dist/jquery.min.js"></script>
    <!-- Bootstrap 3.3.7 -->
    <script src="bower_components/bootstrap/dist/js/bootstrap.min.js"></script>
    <!-- iCheck -->
    <script src="plugins/iCheck/icheck.min.js"></script>
    <script>

        function login() {
            window.location.href = "CsoInfo.aspx";
        }
        //$(function () {
        //  $('input').iCheck({
        //    checkboxClass: 'icheckbox_square-blue',
        //    radioClass: 'iradio_square-blue',
        //    increaseArea: '20%' /* optional */
        //  });
        //});
    </script>
</body>
</html>
